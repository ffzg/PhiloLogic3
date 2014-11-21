#! /usr/bin/perl
print "Content-type: text/html; charset=UTF-8";
# Use the perl DBI interfacing package.  This is fully documented
# in Paul DuBois, MySQL (New Riders, 2000).

use DBI;

$PHILOSITECFG = "/etc/philologic";

do "$PHILOSITECFG/dbnames";
do "$PHILOSITECFG/philologic.cfg";


# Tinker with the query string coming from WWW.  And then set the variables
# in perl, for say $author = SOMEAUTHOR

$QS = $ENV{'QUERY_STRING'};
$wehavebib = 0;
@argbuffer = split ("&", $QS);
@argbuffer = grep (/^[a-zA-Z_1]*=.+$/, @argbuffer);
@argbuffer = grep (!/^[a-zA-Z_1]*=ALL$/, @argbuffer);

foreach $arg (@argbuffer)

{
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
       ($mvoarg1,$mvoarg2) = split(/=/,$mvoarg);
       @queryhash{$mvoarg1} = $mvoarg2;

# Store Bibliodata in hash ... evaluate other variables...

       if ($mvoarg1 eq "dbname") {
           eval $arg;
           $SYSTEM_DIR=$dbnames{"$dbname"};
           unshift (@INC, $SYSTEM_DIR . "lib");
           require $SYSTEM_DIR . "lib/philosubs.pl";     
           require $SYSTEM_DIR . "lib/philo-db.cfg";
           print "dbdone";
       } elsif ($BIBOPS{$mvoarg1}) {
                $wehavebib = 1;
       } elsif ($mvoarg1 =~ /xxbrowse/) {
                $fieldtobrowse = $mvoarg1;
                $fieldtobrowse =~ s/xxbrowse//;
       } else {
            eval $arg;
       }
   }


# These set the database, machine, user and "table" which is
# for all intents and purposes the database we are talking to.
# If we find that all say bibliographic databases are the same
# we could simply have one WWW->SQL script to handle them and
# set these args from the search form  

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

# Character Mappings

%ACCENTS = ( 'A',       "[a\340-\345]",
             'C',       "[c\347]",
             'E',       "[e\350-\353]",
             'I',       "[i\354-\357]",
             'N',       "[n\361]",
             'O',       "[o\362-\366]",
             'U',       "[u\371-\374]",
             'Y',       "[y\375\377]");

print &mkTitle;


&loaddocfreqs();

#$wehavebib = 0;

# Sort Order Mapping
	    $sortorder =~ s/Year/date/;
	    $sortorder =~ s/Author/author/;
	    $sortorder =~ s/Title/title/;

# Check for all blank queries.  Of course, you *can* search for
# a blank space and get LOTS of results.  :-)  It runs properly.
# Should we put an output limiter on it?  It will dutifully run
# and spit 22,000+ hits out until the WWW browser bombs...

$selector = "*";

if ($fieldtobrowse) {
	$selector = $fieldtobrowse;
	$BROWSEFIELD=1;
	$BROWSETITLE = $fieldtobrowse;
	}


if ($wehavebib eq 0) {

	$query1 = "select $selector from $TABLE ";

# Sort Order

    if (!$sortorder) {
        $sortorder = "philodocid";
    }


    if ($BROWSEFIELD) {
       $query1 .= " order by $selector";
    } else {
    	$query1 .= "order by $sortorder;";
    }	
	$GETALLFLAG = 1;
}

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

# Two subroutines, which should be split into a couple more
# the first to build the query and the second to push a search
# and format results.

if (!$GETALLFLAG) {
	&get_query;
	}

    if ($showsqlquery) {
    	print $query1 . "<p>\n";
        }
if (!$BROWSEFIELD) { 
	&go;
	$philodocarg =~ s/OR *$/)/;

#HACKING HERE
#print $WORDEXPLODER;
#print $THEWORDSFILE;

	print "Word Pattern: $word<br>";
	
	$word =~ s/^  *//;
	$word =~ s/  *$//;
	$word =~ s/  */|/g;
        $word =~ s/([^\.])\*/$1\.\*/g;
	
	system ("echo \"" . $word . "\" > " . $THEWORDFILE);
	$exres = system ($WORDEXPLODER . " < " . $THEWORDFILE . " > " . $THEWORDSFILE );	
	$openres = open (WORDVECTOR, $THEWORDSFILE);

	$word2search = " ( ";
	while ($readword = <WORDVECTOR>) {

		$words2display .= $readword . " ";
		$readword =~ s/\n//;
		$word2search .= "theword = \"" . $readword . "\" OR "; 
		}
       
	system ("rm " . $THEWORDFILE);
	system ("rm " . $THEWORDSFILE);

        if ($words2display) {
           print "<br>Words to Search: 	$words2display <p>";

	   $word2search =~ s/ OR *$/ ) /;

	    if ($showsqlquery) {
               print "<hr>";
	       print $word2search;
	       print "<hr>";
	       }
       if ($philodocarg eq "" ) {
	   $philodocarg = "(1 =1)";
       }
	     $query2 = "select * from $FREQTABLE where ";
	     $query2 .= $word2search . " AND " . $philodocarg;
	     $query2 .= " order by theword;";

             if ($showsqlquery) {
	         print "<hr>q2: $query2<hr>";
	     }



   if ($sth = $dbh->prepare($query2)) {
       $sth->execute();
     while (@results = $sth->fetchrow ) {
	$restheword = @results[0];
	$resfreq = @results[1];

	$outfreq{$restheword} = $outfreq{$restheword} + $resfreq;
        #print "<br>" . @results[0] . " " . @results[1] . " " . $outfreq{$restheword} . "<br><br>";

        $xxcount = 1;
        }

  if ($xxcount) {
	print "<table border>\n";
	print "<tr><td>Word</td><td>Frequency</td><td>Rate/10000</td></tr>\n";
        foreach $outword (sort(keys(%outfreq))){
	   print "<tr><td>" . $outword . "</td><td align=right>";
	   $rateper10 = ($outfreq{$outword} / $TOTALDOCFREQS) * 10000;
	   $rateper10 =~ s/(\....).*/$1/; 
           print $outfreq{$outword} . "</td>";
           print "<td align=right>$rateper10</td></tr>\n";
	   $totalfoundwords = $totalfoundwords + $outfreq{$outword};
	   }
	print "<tr><td>Total</td>";
	print "<td align=right>$totalfoundwords</td>";
	$rateper10 = ($totalfoundwords  / $TOTALDOCFREQS) * 10000;
	$rateper10 =~ s/(\....).*/$1/;
	print "<td align=right>$rateper10</td></tr>\n";
	print "</table>";
      }
     else {
	print "No words matching in your subcorpus";
	     }
     
	  }
	}
      else {
	print "No words matching in the database";
   }
        if ($showbiblio) {
        print "<hr><p><center><font size=+1>Bibliography</font></center><p>\n";
        print $outbuffer;
   }

}
else { 
	print "<p>List of available <b>$BROWSETITLE</b> terms";
	print " with current search parameters set.<p>";
        print "With the terms you have entered on the search form, you have the 
               following choices available for searching in this field.  
               Copy individual term(s) from this page using the mouse, 
               then use the Back button on your Browser to return to the 
               search form, and paste the term(s) into the field.  Then 
               click SEARCH to execute a search.  ";
	&browse;
	}

print &concfooter;

# and that is the end of the program.... Now, lets talk subroutines.

# Get query simply builds the SQL query.  Each and every search
# function will require crafting.  So, let's say we want to search
# date as numbers and then built = >= <=, you should be able to do this.
# Note: the variables like author, title, and date are so named
# in the SQL database.  This is a handy convention.
# Also note that searching and sorting for some fields are performed
# on merged fields, such as ssauthor.  
# Question to ask.  I am passing the null queries along to the engine.
# This seems to work OK.  Maybe I should not bother.  

sub get_query {

    $query1 = "select $selector from $TABLE where ";

     foreach $arg10 (@Biblio_Fields) {
        if (length(@queryhash{$arg10}) gt 0) {

	   $qnam = $arg10;
	   $qval = @queryhash{$arg10};
           $qop = @BIBOPS{$arg10};

# Regular Expression operator

	   if ($qop eq "regexp") {	
                if ($turnonand eq 1) {
	           $query1 .= " AND ";
	           } 
                if ($qval =~ / AND / || $qval =~ / OR / || $qval =~ / NOT /) {
                   $qval = &expand_query($qval, "$qnam", "regexp");
                   $query1 .= " " . $qval . "  ";
                   }
		elsif ($qval =~ /^NOT/) {
		     $qval =~ s/^NOT //g;
		     $qval =~ s/[ACEINOUY]/$ACCENTS{$&}/ge;
		     $query1 .= " $qnam NOT regexp \"$qval\" ";
		     }
                else {
	           $qval =~ s/[ACEINOUY]/$ACCENTS{$&}/ge;
                   $query1 .= " $qnam regexp \"$qval\" ";
                   }
               $turnonand = 1;
	    }

# Numeric Operator 
            if ($qop eq "numeric") {
                if ($turnonand eq 1) {
                   $query1 .= " AND ";     
                   }
                if ($qval =~ / OR /) {
                   $qval = &expand_query($qval, "$qnam", "=");
                   $query1 .=  $qval . " ";
                   }
                elsif ($qval =~ /\-/) {
                       if ($qval =~ /-$/) {
			   $qval .= "9998";
		           }
                       if ($qval =~ /^-/) {
                           $qval = "0" . $qval;
                           }

                   ($d1, $d2) = split(/-/,$qval);
                   $qval = "($qnam >= \"".$d1."\" AND $qnam <= \"".$d2."\") ";
                   $query1 .= $qval;
                   }
                else {
                   $query1 .= "$qnam = \"$qval\" ";
                   }
             $turnonand = 1;
             }
# Exact match
            if ($qop eq "exact") {
                   $query1 .= "$qnam = \"$qval\" ";
                   $turnonand = 1;
             }


	}
    }

# Sort Order
    if (!$sortorder) {
    	$sortorder = "philodocid";
	}
    if ($BROWSEFIELD) {
       $query1 .= "order by $selector";
        }
    else {
        $query1 .= "order by $sortorder;";
        }
     }

# Run the search and format the results.  First important think to 
# notice.  We only have THREE LINES actually talking to the server.
# The rest is simple perl to format results.  The second is that
# we have searching, sorting for some fields based on distinct,
# usually merged fields, and results based on the standard fields.

sub go {
   $count = 0;

   $philodocarg = "(";

   if ($sth = $dbh->prepare($query1)) {
       $sth->execute();
       while ($results = $sth->fetchrow_hashref) { 
        $count++;
        $resphilodocid = $results->{"philodocid"};
	$TOTALDOCFREQS = $TOTALDOCFREQS + $totaldocfreq{$resphilodocid};
	$philodocarg .= "philodocid = \"" . $resphilodocid . "\" OR ";
   }

# Finished getting results.  This should probably be a subroutine, since
# I am running a condition here.  Let's leave it for now.

        if ($count > 0) {
                  print "<p><b>$count</b> Documents containing ";
		  print "$TOTALDOCFREQS words<p>\n";
		        $outbuffer = iso2html($outbuffer);
#			print $outbuffer;
		  }
                else { 
                   print "<p>No records found matching specified bibliographic criteria <p>";
                     } 
	}
     }

# Expand query is not finished.  It takes the individual query argument,
# the field to query, and the operator as arguments from the general
# query processor.  It expands AND, NOT, OR operators as required.
# I have not yet implemented this to handle any operator other than
# SQL "like", the default string search.  Note that I am adding the
# substring operator "%" to every term.  In a full implementation,
# this will need to be made conditional.

sub expand_query {
         local ($q, @qq, $qt, $outq, $qq, $q2, $op, $nextnot);
	 $nextnot = 0;
         $q = $_[0];
         $qt = $_[1];
         $op = $_[2];
	 $q =~ s/  */\_/g;
	 $q =~ s/\_OR\_/ OR /g;
	 $q =~ s/\_AND\_/ AND /g;
	 $q =~ s/\_NOT\_/ NOT /g;
         @qq = split(/ /,$q);
         $outq = "(";
         foreach $q2 (@qq) {
		if ($q2 ne "OR" && $q2 ne "AND" && $q2 ne "NOT") {
			$q2 =~ s/[ACEINOUY]/$ACCENTS{$&}/ge;
			}
                if ($q2 eq "OR" || $q2 eq "AND") {
                            $outq .= " $q2 ";
                     }
		elsif ($q2 eq "NOT") { 
			$nextnot = 1;
			}
                else {
			$q2 =~ s/\_/ /g;
			if ($nextnot eq 1){ 
                            $outq .= " AND (".$qt." NOT ".$op." \"". $q2."\")";
			    $nextnot = 0;
			    }
			else {
			    $outq .= "(".$qt." ".$op." \"". $q2."\")";	
			    }
                     }
         }
         $outq .= ")";
	 if ($outq =~ / AND / && $outq =~ / OR /) {
		$outq =~ s/ AND /) AND (/g;
		$outq = "(" . $outq . ")";
		}
         return $outq;
}

# Print the footer.  A subroutine because we want to print it from
# various locations.

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

sub browse() {
   local ($freq);
   $freq = 0;
   if ($sth = $dbh->prepare($query1)) {
       $sth->execute();
         print "<ul>\n";
         while (@results = $sth->fetchrow ) {
             if ($results[0]) { 
		$results[0] = iso2html($results[0]);
		$results[0] =~ s/  */ /g;
                $freq = 1;
                if ($lastresults eq $results[0]) {
                        }
                else { 
                   print "<li> $results[0]\n";
                   $lastresults = $results[0];
                        }
                   }
             }
        }
   if ($freq eq 0) {
        print "</ul>\nNo terms found.  You may want to press the\n";
        print "CLEAR button on the search-form and start over.";
        }
        print "</ul><hr>\n";
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

