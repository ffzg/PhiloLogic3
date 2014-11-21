#! /usr/bin/perl

# If your philologic config directory is not in /etc/philologic, edit the below
# to point to its location. Theoretically this is the only edit you will need
# to make to this script.

$PHILOSITECFG = "/etc/philologic";


# Use the perl DBI interfacing package.  This is fully documented
# in Paul DuBois, MySQL (New Riders, 2000).  

use DBI;

# Tinker with the query string coming from WWW.  And then set the variables
# in perl, for say $author = SOMEAUTHOR

$QS = $ENV{'QUERY_STRING'};

@argbuffer = split ("&", $QS);
@argbuffer = grep (/^[a-zA-Z_1]*=.+$/, @argbuffer);
@argbuffer = grep (!/^[a-zA-Z_1]*=ALL$/, @argbuffer);

foreach $arg (@argbuffer) {
       $arg = '$' . $arg;
       $arg =~ s/\%3A/:/g;
       $arg =~ s/\%2C/,/g;
       $arg =~ s:\%2F:/:g;
       $arg =~ s/\%26/\&/g;
       $arg =~ s/\+/ /g;
       $arg =~ s/%../pack("H2", substr($&,1))/ge;
       $arg = &postfix2iso($arg);
       $mvoarg = $arg;
       $arg =~ s/^(.[^=]*=)(.*$)/$1'$2'/;
       $mvoarg =~ s/\$//;
       eval $arg;
}

# These set the database, machine, user and "table" which is
# for all intents and purposes the database we are talking to.
# If we find that all say bibliographic databases are the same
# we could simply have one WWW->SQL script to handle them and
# set these args from the search form  
#
# If you build a database on dsal ... you could modify DATABASE
# and TABLE and you should be able to talk to your database.
# header file = $HEADERS/search.header.html
# footer file = $HEADERS/search.footer.html

do "$PHILOSITECFG/dbnames";
do "$PHILOSITECFG/philologic.cfg";

$SYSTEM_DIR=$dbnames{"$dbname"};

unshift (@INC, $SYSTEM_DIR . "lib");
require $SYSTEM_DIR . "lib/philosubs.pl";
require $SYSTEM_DIR . "lib/philo-db.cfg";

$SORTARG = " +1rn -0 ";
$SORTTEMPFILE = $PHILOTMP . "/philosorttemp." . "$$";
$PHILOGETWORDCOUNT = $PHILOCGI . "/getwordcount.pl";

$ENV{'SYSTEM_DIR'} = $SYSTEM_DIR;
$FREQ_DIR= $SYSTEM_DIR . "frequencies/";
$ENV{'FREQ_DIR'} = $FREQ_DIR;
$WORDEXPLODER = $SYSTEM_DIR . "crapser";
$THEWORDSFILE = "/tmp/freqwords.$$";
$THEWORDFILE = "/tmp/freqword.$$";
$docfreqfile = $FREQ_DIR . "doc.freq";

require 5.002;

$FREQTABLE = $TABLE . "freqs";
$YEARFREQTABLE = $TABLE . "yearfreqs";

$RATEPERN = 10000;

$docfreqfile = $FREQ_DIR . "year.freq";

unshift (@INC, $SYSTEM_DIR . "lib");

require 5.002;

$TABLE = $TABLE . "freqs";

# Character Mappings

%ACCENTS = ( 'A',       "[a\340-\345]",
             'C',       "[c\347]",
             'E',       "[e\350-\353]",
             'I',       "[i\354-\357]",
             'N',       "[n\361]",
             'O',       "[o\362-\366]",
             'U',       "[u\371-\374]",
             'Y',       "[y\375\377]");

# Print some standard header for WWW interfacing  In a full production
# scheme, we might want to put this into a databases specific header
# like we do for Philo and dico stuff.

print &mkTitle;

&loaddocfreqs();
&setinitial();

print "<center><font size=+1>$labels[$DATERANGE]</center></font><p>\n";

# The perl DBI method uses a connection in the format: 
# "DBI:servertype:database:hostname:port" (the hostname and port are optional)
# the ;mysql_socket=/usr/lib/mysql/mysql.sock was used because by 
# default it looks in /var/lib/mysql/mysql.sock

my $dbh = DBI->connect ('DBI:mysql:' . $USER . ':' . $HOST . $SOCKETARG , $USER, $PASSWD)
  or
  $MVOERROR = $DBI::errstr;

# If I get something in the error string, I'm going to assume that
# I did not connect, leave a message, and exit.  We should have
# a administrator contact here as well.  This works properly, as
# I have tested it.

if ($MVOERROR) { 
	print "<b>Internal Error.  Database handle not defined. <p>"; 
	print "Error Message: $MVOERROR ";
 	print "<p>";
	print "Please contact DSAL and include the Error Message";
	&printfooter;
	exit;
   }

# Set the Range to Search:
$philodocarg = $sqldaterange[$DATERANGE];

#Get the Word Pattern
print "Word Pattern: $word<br>";

&getwordpattern ();

if ($words2display) {
    print "<br>Words to Search: $words2display <p>";
    }
else {
    print "<p>No matching word pattern in selected date range";
    &printfooter;
    exit;
    }
 
$word2search =~ s/ OR *$/ ) /;
if ($showsqlquery) {
     print "<hr>";
     print $word2search;
     print "<hr>";
    }

# Construct Query

     $query2 = "select * from $YEARFREQTABLE where ";
     $query2 .= $word2search . " AND " . $philodocarg;
     $query2 .= " order by thesortword, theyear;";



     if ($showsqlquery) {
         print "<hr>$query2<hr>";
     }

# Run the Query

     $accumlatetype = $freqreduct[$DATERANGE];
     $inital = 0;

	print "<table border>";
	print $labelrow[$DATERANGE];

     if ($sth = $dbh->prepare($query2)) {
        $sth->execute();
        while (@results = $sth->fetchrow ) {
	     $restheword = @results[0];
	     $restheyear = @results[1];
	     $resfreq = @results[2];
	     if ($inital == 0) {
		$thelastword = $restheword;
		$inital = 1;
	        }
        &getperiods();
	if ($restheword eq $thelastword) {
	     if ($accumlatetype eq "century") {
	 	  $thiswordfreq{$century} = $thiswordfreq{$century} + $resfreq;
	 	  $ALLwordfreq{$century} = $ALLwordfreq{$century} + $resfreq;
		  }
	     elsif ($accumlatetype eq "quarter") {
                  $thiswordfreq{$quarter} = $thiswordfreq{$quarter} + $resfreq;
                  $ALLwordfreq{$quarter} = $ALLwordfreq{$quarter} + $resfreq;
                  }
             else {
                   $thiswordfreq{$decade} = $thiswordfreq{$decade} + $resfreq;
                   $ALLwordfreq{$decade} = $ALLwordfreq{$decade} + $resfreq;
                   }
	     $thelastword = $restheword;
	     }
	else {
	    &rowtotal();
             if ($accumlatetype eq "century") {
                  $thiswordfreq{$century} = $thiswordfreq{$century} + $resfreq;
                  $ALLwordfreq{$century} = $ALLwordfreq{$century} + $resfreq;
                  }
             elsif ($accumlatetype eq "quarter") {
                  $thiswordfreq{$quarter} = $thiswordfreq{$quarter} + $resfreq;
                  $ALLwordfreq{$quarter} = $ALLwordfreq{$quarter} + $resfreq;
                  }
             else {
                   $thiswordfreq{$decade} = $thiswordfreq{$decade} + $resfreq;
                   $ALLwordfreq{$decade} = $ALLwordfreq{$decade} + $resfreq;
                   }
            $thelastword = $restheword;

		}
	   
        }
	&rowtotal();
	&finalrowtotal();
	print "</table>";
   if ($CNOTDISPLAYED) {
        print "<font size=-1>";
        print "Row total display filter set to " . $minrowtotal . " resulting ";
        print "in $CNOTDISPLAYED words not shown in the table but ";
        print "included in frequency counts: ";
        print $NOTDISPLAYED . ".";
        print "</font><br>"
        }

      }
     

&printfooter;
exit;
# ============================ END OF MAIN ========================
# and that is the end of the program.... Now, lets talk subroutines.

sub finalrowtotal() {
    print "<tr><td align=left><b>Word<br>Totals</b></td>";
    $wordtotal = 0;
    $linebuffer = "<tr><td align=left>Period Freqs</td>";
    foreach $outyear (sort keys(%ALLwordfreq)){
          print "<td align=right><b>" . $ALLwordfreq{$outyear} . "</b></td>";
          $wordtotal = $wordtotal + $ALLwordfreq{$outyear};
          $therate = 0;
	  
          if ($ALLwordfreq{$outyear} > 0 && $totaldocfreq{$outyear} > 0) {
             $therate = $ALLwordfreq{$outyear} / $totaldocfreq{$outyear};
             $therate = $therate * $RATEPERN;
             $therate =~ s/\.(...).*/\.$1/;
             }
          print "<td align=right><b>" . $therate . "</b></td>";
          $ALLwordfreq{$outyear} = 0;
	  $linebuffer .= "<td align=right>" . $totaldocfreq{$outyear};
	  $linebuffer .= "</td><td>&nbsp;</td>";
          }
    print "<td align=right><b>$wordtotal</b></td>\n";
    $therate = 0;
    if ($wordtotal > 0) {
        $therate = ($wordtotal / $periodtotal[$DATERANGE]) * $RATEPERN;
        $therate =~ s/\.(...).*/\.$1/;
        }
    print "<td align=right><b>$therate</b></td>";
    print "</tr>\n";
    $PPTOT = $periodtotal[$DATERANGE];
    $linebuffer .= "<td align=right>" . $PPTOT;
    $linebuffer .= "</td><td>&nbsp;</td>";
    print $linebuffer;
    print "</tr>\n";
}

sub printfooter {

open (FOOTERFILE, $HEADERS . "search.footer.html");
while ($linein = <FOOTERFILE>) {
        print $linein;
        }
close FOOTERFILE;

}

sub iso2html {
local ($tt);
$tt = $_[0];
$tt =~ s/\306/&AElig;/g;
$tt =~ s/\301/&Aacute;/g;
$tt =~ s/\302/&Acirc;/g;
$tt =~ s/\300/&Agrave;/g;
$tt =~ s/\305/&Aring;/g;
$tt =~ s/\303/&Atilde;/g;
$tt =~ s/\304/&Auml;/g;
$tt =~ s/\307/&Ccedil;/g;
$tt =~ s/\320/&ETH;/g;
$tt =~ s/\311/&Eacute;/g;
$tt =~ s/\312/&Ecirc;/g;
$tt =~ s/\310/&Egrave;/g;
$tt =~ s/\313/&Euml;/g;
$tt =~ s/\315/&Iacute;/g;
$tt =~ s/\316/&Icirc;/g;
$tt =~ s/\314/&Igrave;/g;
$tt =~ s/\317/&Iuml;/g;
$tt =~ s/\321/&Ntilde;/g;
$tt =~ s/\323/&Oacute;/g;
$tt =~ s/\324/&Ocirc;/g;
$tt =~ s/\322/&Ograve;/g;
$tt =~ s/\330/&Oslash;/g;
$tt =~ s/\325/&Otilde;/g;
$tt =~ s/\326/&Ouml;/g;
$tt =~ s/\336/&THORN;/g;
$tt =~ s/\332/&Uacute;/g;
$tt =~ s/\333/&Ucirc;/g;
$tt =~ s/\331/&Ugrave;/g;
$tt =~ s/\334/&Uuml;/g;
$tt =~ s/\335/&Yacute;/g;
$tt =~ s/\341/&aacute;/g;
$tt =~ s/\342/&acirc;/g;
$tt =~ s/\346/&aelig;/g;
$tt =~ s/\340/&agrave;/g;
$tt =~ s/\345/&aring;/g;
$tt =~ s/\343/&atilde;/g;
$tt =~ s/\344/&auml;/g;
$tt =~ s/\347/&ccedil;/g;
$tt =~ s/\351/&eacute;/g;
$tt =~ s/\352/&ecirc;/g;
$tt =~ s/\350/&egrave;/g;
$tt =~ s/\360/&eth;/g;
$tt =~ s/\353/&euml;/g;
$tt =~ s/\355/&iacute;/g;
$tt =~ s/\356/&icirc;/g;
$tt =~ s/\354/&igrave;/g;
$tt =~ s/\357/&iuml;/g;
$tt =~ s/\361/&ntilde;/g;
$tt =~ s/\363/&oacute;/g;
$tt =~ s/\364/&ocirc;/g;
$tt =~ s/\362/&ograve;/g;
$tt =~ s/\370/&oslash;/g;
$tt =~ s/\365/&otilde;/g;
$tt =~ s/\366/&ouml;/g;
$tt =~ s/\337/&szlig;/g;
$tt =~ s/\376/&thorn;/g;
$tt =~ s/\372/&uacute;/g;
$tt =~ s/\373/&ucirc;/g;
$tt =~ s/\371/&ugrave;/g;
$tt =~ s/\374/&uuml;/g;
$tt =~ s/\375/&yacute;/g;
$tt =~ s/\377/&yuml;/g;
$tt =~ s/\247/&#167;/g;
$tt =~ s/\253/&#171;/g;
$tt =~ s/\260/&#176;/g;
$tt =~ s/\267/&#183;/g;
$tt =~ s/\273/&#187;/g;
$tt =~ s/\274/&#188;/g;
$tt =~ s/\275/&#189;/g;
$tt =~ s/\367/&#247;/g;

return $tt;

}

sub postfix2iso {
    local ($l) = $_[0];

    $l =~ s/a\\/\340/g;
    $l =~ s/a\//\341/g;
    $l =~ s/a\^/\342/g;
    $l =~ s/a\~/\343/g;
    $l =~ s/a\"/\344/g;

# have to be able to get "c, " as in Balzac, H
    $l =~ s/c\,([^ ])/\347$1/g;

    $l =~ s/d\^/\360/g;  # MVO added 4-23-99 eth

    $l =~ s/e\\/\350/g;
    $l =~ s/e\//\351/g;
    $l =~ s/e\^/\352/g;
    $l =~ s/e\"/\353/g;

    $l =~ s/i\\/\354/g;
    $l =~ s/i\//\355/g;
    $l =~ s/i\^/\356/g;
    $l =~ s/i\"/\357/g;
    $l =~ s/n\~/\361/g;

    $l =~ s/o\\/\362/g;
    $l =~ s/o\//\363/g;
    $l =~ s/o\^/\364/g;
    $l =~ s/o\~/\365/g;
    $l =~ s/o\"/\366/g;

    $l =~ s/p\^/\376/g;  # MVO added 4-23-99 thorn
    $l =~ s/P\^/\336/g;  # MVO added 4-23-99 THORN

    $l =~ s/s\^/\337/g;  # MVO added 4-23-99 szlig

    $l =~ s/u\\/\371/g;
    $l =~ s/u\//\372/g;
    $l =~ s/u\^/\373/g;
    $l =~ s/u\"/\374/g;

    $l =~ s/y\//\375/g;
    $l =~ s/y\"/\377/g;


return $l;

}

sub loaddocfreqs() {
local ($zfq, $d, $f);
open (DOCFREQ, "$docfreqfile");
while ($zfq = <DOCFREQ>) {
        $zfq =~ s/\n//;
	($d, $f) = split(/ /,$zfq);
	$totaldocfreq{$d} = $f;

	}
close (DOCFREQ);
}

sub getwordpattern() {

$word =~ s/^  *//;
$word =~ s/  *$//;
$word =~ s/  */|/g;
$word =~ s/([^\.])\*/$1\.\*/g;

system ("echo \"" . $word . "\" > " . $THEWORDFILE);
system ($WORDEXPLODER . " < " . $THEWORDFILE . " > " . $THEWORDSFILE );
open (WORDVECTOR, $THEWORDSFILE);
$word2search = " ( ";
while ($readword = <WORDVECTOR>) {
        $words2display .= $readword . " ";
        $readword =~ s/\n//;
        $word2search .= "theword = \"" . $readword . "\" OR ";
        }
system ("rm " . $THEWORDFILE);
system ("rm " . $THEWORDSFILE);
}

sub getperiods() {
	$year = $restheyear;
        $century = $year;
        $century =~ s/(..).*/C $1 00 - $1 99/;
        $century =~ s/ //g;
        $decade = $year;
        $decade =~ s/(...).*/D $1 0 - $1 9/;
        $decade =~ s/ //g; 
        $quarter = $year;
        $q1 = $quarter;
        $q1 =~ s/(..).*/$1/;
        $q2 = $quarter;
        $q2 =~ s/..(..).*/$1/;  
        if ($q2 >= 0 && $q2 <= 24) {
                $quarter = "Q" . $q1 . "00-" . $q1 . "24";
                }
        if ($q2 >= 25 && $q2 <= 49) {
                $quarter = "Q" . $q1 . "25-" . $q1 . "49";
                }
        if ($q2 >= 50 && $q2 <= 74) {
                $quarter = "Q" . $q1 . "50-" . $q1 . "74";
                }
        if ($q2 >= 75 && $q2 <= 99) {
                $quarter = "Q" . $q1 . "75-" . $q1 . "99";
                }
}

sub rowtotal() {;
    local ($outbuffer);
    $wordtotal = $totalwordtotal = 0;
    $outbuffer = "<tr>\n";
    $outbuffer .= "<td>$thelastword</td>\n";
    foreach $outyear (sort keys(%thiswordfreq)){

	if ($totaldocfreq{$outyear} > 0) {
          $outbuffer .= "<td align=right>" . $thiswordfreq{$outyear} . "</td>";
          $wordtotal = $wordtotal + $thiswordfreq{$outyear};
          $therate = 0;
          if ($thiswordfreq{$outyear} > 0) {
             $therate = $thiswordfreq{$outyear} / $totaldocfreq{$outyear};
             $therate = $therate * $RATEPERN;
             $therate =~ s/\.(...).*/\.$1/;
             }
          $outbuffer .= "<td align=right>" . $therate . "</td>";
          $thiswordfreq{$outyear} = 0;
      } else {
	  $outbuffer .= "<td align=right>0</td>";
          $outbuffer .= "<td align=right>0</td>";
      }
    }

    $totalwordtotal = $wordtotal + $totalwordtotal;
	
    $outbuffer .= "<td align=right>$wordtotal</td>\n";
    $therate = 0;
    if ($wordtotal > 0) {
        $therate = ($wordtotal / $periodtotal[$DATERANGE]) * $RATEPERN;
        $therate =~ s/\.(...).*/\.$1/;
        }

    $outbuffer .= "<td align=right>$therate</td>";
    $outbuffer .= "</tr>\n";

    if ($totalwordtotal >= $minrowtotal) {
        print $outbuffer;
        }
    else {
        $NOTDISPLAYED .= $thelastword . " [" . $wordtotal . "] ";
        $CNOTDISPLAYED = $CNOTDISPLAYED + 1;
        }
}

sub setinitial() {

$sqldaterange[1] = "(theyear >= \"1700\" AND theyear <= \"1999\")";
$sqldaterange[2] = "(theyear >= \"1500\" AND theyear <= \"1599\")";
$sqldaterange[3] = "(theyear >= \"1600\" AND theyear <= \"1699\")";
$sqldaterange[4] = "(theyear >= \"1700\" AND theyear <= \"1799\")";
$sqldaterange[5] = "(theyear >= \"1800\" AND theyear <= \"1899\")";
$sqldaterange[6] = "(theyear >= \"1900\" AND theyear <= \"1999\")";

$periodtotal[2] = $totaldocfreq{"C1500-1599"};
$periodtotal[3] = $totaldocfreq{"C1600-1699"};
$periodtotal[4] = $totaldocfreq{"C1700-1799"};
$periodtotal[5] = $totaldocfreq{"C1800-1899"};
$periodtotal[6] = $totaldocfreq{"C1900-1999"};

$periodtotal[1] = $periodtotal[2] + $periodtotal[3] + $periodtotal[4];
$periodtotal[1] = $periodtotal[1] + $periodtotal[5] + $periodtotal[6];

$labels[1] = "Time Series: 1700-1999";
$labels[2] = "Time Series: 1500-1699";
$labels[3] = "Time Series: 1600-1699";
$labels[4] = "Time Series: 1700-1799";
$labels[5] = "Time Series: 1800-1899";
$labels[6] = "Time Series: 1900-1999";

$freqreduct[1] = "century";
$freqreduct[2] = "quarter";
$freqreduct[3] = "quarter";
$freqreduct[4] = "quarter";
$freqreduct[5] = "quarter";
$freqreduct[6] = "quarter";

$labelrow[1] = "<tr><td>Word</td>\n";
# $labelrow[1] .= "<td>1500-99</td><td>Rate</td><td>1600-99</td><td>Rate</td>";
$labelrow[1] .= "<td>1700-99</td><td>Rate</td><td>1800-99</td><td>Rate</td>";
$labelrow[1] .= "<td>1900-99</td><td>Rate</td><td>Total</td><td>Rate</td></tr>";

$labelrow[2] = "<tr><td>Word</td>\n";
$labelrow[2] .= "<td>1500-24</td><td>Rate</td><td>1525-49</td><td>Rate</td>";
$labelrow[2] .= "<td>1550-74</td><td>Rate</td><td>1575-99</td><td>Rate</td>";
$labelrow[2] .= "<td>Total</td><td>Rate</td></tr>";

$labelrow[3] = "<tr><td>Word</td>\n";
$labelrow[3] .= "<td>1600-24</td><td>Rate</td><td>1625-49</td><td>Rate</td>";
$labelrow[3] .= "<td>1650-74</td><td>Rate</td><td>1675-99</td><td>Rate</td>";
$labelrow[3] .= "<td>Total</td><td>Rate</td></tr>";

$labelrow[4] = "<tr><td>Word</td>\n";
$labelrow[4] .= "<td>1700-24</td><td>Rate</td><td>1725-49</td><td>Rate</td>";
$labelrow[4] .= "<td>1750-74</td><td>Rate</td><td>1775-99</td><td>Rate</td>";
$labelrow[4] .= "<td>Total</td><td>Rate</td></tr>";

$labelrow[5] = "<tr><td>Word</td>\n";
$labelrow[5] .= "<td>1800-24</td><td>Rate</td><td>1825-49</td><td>Rate</td>";
$labelrow[5] .= "<td>1850-74</td><td>Rate</td><td>1875-99</td><td>Rate</td>";
$labelrow[5] .= "<td>Total</td><td>Rate</td></tr>";

$labelrow[6] = "<tr><td>Word</td>\n";
$labelrow[6] .= "<td>1900-24</td><td>Rate</td><td>1925-49</td><td>Rate</td>";
$labelrow[6] .= "<td>1950-74</td><td>Rate</td><td>1975-99</td><td>Rate</td>";
$labelrow[6] .= "<td>Total</td><td>Rate</td></tr>";

#Initalize Associative Array:
if ($DATERANGE eq "1") {
#	$thiswordfreq{"C1500-1599"} = 0;
#	$thiswordfreq{"C1600-1699"} = 0;
	$thiswordfreq{"C1700-1799"} = 0;
	$thiswordfreq{"C1800-1899"} = 0;
	$thiswordfreq{"C1900-1999"} = 0;
}
if ($DATERANGE eq "2") {
	$thiswordfreq{"Q1500-1524"} = 0;
	$thiswordfreq{"Q1525-1549"} = 0;
	$thiswordfreq{"Q1550-1574"} = 0;
	$thiswordfreq{"Q1575-1599"} = 0;
}
if ($DATERANGE eq "3") {
	$thiswordfreq{"Q1600-1624"} = 0;
	$thiswordfreq{"Q1625-1649"} = 0;
	$thiswordfreq{"Q1650-1674"} = 0;
	$thiswordfreq{"Q1675-1699"} = 0;
}
if ($DATERANGE eq "4") {
	$thiswordfreq{"Q1700-1724"} = 0;
	$thiswordfreq{"Q1725-1749"} = 0;
	$thiswordfreq{"Q1750-1774"} = 0;
	$thiswordfreq{"Q1775-1799"} = 0;
}
if ($DATERANGE eq "5") {
	$thiswordfreq{"Q1800-1824"} = 0;
	$thiswordfreq{"Q1825-1849"} = 0;
	$thiswordfreq{"Q1850-1874"} = 0;
	$thiswordfreq{"Q1875-1899"} = 0;
	}
if ($DATERANGE eq "6") {
	$thiswordfreq{"Q1900-1924"} = 0;
	$thiswordfreq{"Q1925-1949"} = 0;
	$thiswordfreq{"Q1950-1974"} = 0;
	$thiswordfreq{"Q1975-1999"} = 0;
}

if ($DATERANGE eq "1") {
#        $ALLwordfreq{"C1500-1599"} = 0;
#        $ALLwordfreq{"C1600-1699"} = 0;
        $ALLwordfreq{"C1700-1799"} = 0;
        $ALLwordfreq{"C1800-1899"} = 0;
        $ALLwordfreq{"C1900-1999"} = 0;
}
if ($DATERANGE eq "2") {
        $ALLwordfreq{"Q1500-1524"} = 0;
        $ALLwordfreq{"Q1525-1549"} = 0;
        $ALLwordfreq{"Q1550-1574"} = 0;
        $ALLwordfreq{"Q1575-1599"} = 0;
}
if ($DATERANGE eq "3") {
        $ALLwordfreq{"Q1600-1624"} = 0;
        $ALLwordfreq{"Q1625-1649"} = 0;
        $ALLwordfreq{"Q1650-1674"} = 0;
        $ALLwordfreq{"Q1675-1699"} = 0;
}
if ($DATERANGE eq "4") {
        $ALLwordfreq{"Q1700-1724"} = 0;
        $ALLwordfreq{"Q1725-1749"} = 0;
        $ALLwordfreq{"Q1750-1774"} = 0;
        $ALLwordfreq{"Q1775-1799"} = 0;
}
if ($DATERANGE eq "5") {
        $ALLwordfreq{"Q1800-1824"} = 0;
        $ALLwordfreq{"Q1825-1849"} = 0;
        $ALLwordfreq{"Q1850-1874"} = 0;
        $ALLwordfreq{"Q1875-1899"} = 0;
        }
if ($DATERANGE eq "6") {
        $ALLwordfreq{"Q1900-1924"} = 0;
        $ALLwordfreq{"Q1925-1949"} = 0;
        $ALLwordfreq{"Q1950-1974"} = 0;
        $ALLwordfreq{"Q1975-1999"} = 0;
}

}

