#! /depot/perl/arch/bin/perl
#
# This is an example of a routine to allow users to "login" to a
# PhiloLogic database.  It reads a very simple passwd file, without
# encryption and, if you get a match, writes the IP of the requesting
# computer to the specified file.  This is not particularly secure,
# but it is an easy way to manage the relatively few cases where
# we need passwd authentication.  Passwd file entry (no comment)
# guest27:visitor13:A Guest User
# Not secure, but easy.  I have also not really integrated this
# with the main system.  Easy enough to do if required.

# Configuration.....
$PRODPW = "/DIRS/FILENAME";             # PATH and FILENAME to passwd file
$PRODTEMPIPS = "/tmp/FILENAME";         # PATH and FILENAME to temp ip file
$PRODLOGFORM = "http://DIRS/FILENAME";  # URL to a login form
$PRODHOMEPAGE = "http://DIRS/FILENAME"; # URL to a database home
$PRODTITLE = "DATABASE NAME";           # Name of the database
# And check below to add a few other messages....

print "Content-type: text/html\n\n";
print "<BODY>\n";

$host = $ENV{'REMOTE_HOST'};
$ip  =  $ENV{'REMOTE_ADDR'};
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
   eval $arg;
}

open (PWFILE, $PRODPW);
while ($linein = <PWFILE>) {
      ($user, $passwd, $name) = split(":", $linein);
      if ($user eq $userid && $passwd eq $aspmagicword) {
	  $foundit = 1;
          $theuser = $name;
	}
     }
close (PWFILE);

if ($foundit) {
        print "<br><br><center><font size=+2><b>";
	$theuser =~ s/\n//;
        print "Authorization for \"$theuser\" successful. ";
	print "<p>Return to <a href=\"" . $PRODHOMEPAGE . "\">" ;
	print $PRODTITLE . "</a>\n";
	open (TMPIPS, ">>" . $PRODTEMPIPS);
	print TMPIPS "$ip\n";
	close (TMPIPS);
	}
else {
	print "<br><br><center><font size=+2><b>";
	print "Authorization failed.</b>";
	print "  <a href=\"" . $PRODLOGFORM . "\">Retry?</a>\n";
	print "<p>For information, please consult YOUR INFO HERE.";
	print "</font></b></center>";
}

