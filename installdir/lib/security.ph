# security.ph: is the standard way that we provide access control 
# at ARTFL and other projects.  This provides the subroutine 
# called security_check and a default $REJECT_MESSAGE to print 
# on exit if the search request is not accepted

if (!$REJECT_MESSAGE) {
    $REJECT_MESSAGE = "<h1>Access Restricted</h1>
                       <p>This is a default message. Please contact
                       the database adminstrator.";
	}

sub security_check {
$host = $ENV{'REMOTE_HOST'};
$ip  =  $ENV{'REMOTE_ADDR'};
$match = 0;
$blocked = 0;

# Check to see if it's a name and match on the list below,
# LEGAL_DOMAINS_BY_NAME.
if ($host =~ /[A-Za-z]/) {
      $host =~ tr/A-Z/a-z/;
      foreach $valid_location (@LEGAL_DOMAINS_BY_NAME) {
	     $match++ if $host =~ /$valid_location$/;
	 }
   }

# If you don't have a match and then check IP numbers again
# from the list below: LEGAL_DOMAINS_BY_ADDR
if (!$match) {
	foreach $valid_ipnum (@LEGAL_DOMAINS_BY_ADDR) {
	       $valid_ipnum =~ s/\./\\\./g;
	       $match++ if $ip =~ /^$valid_ipnum/;
	   }
	}

# If you still don't have a match, check to see if you have an
# exact match by IP number in a spill file defined in philo-db.cfg
# Contact ARTFL for the script that we use to populate this list.
if (!$match && $TEMPIPS) {
	if (-e $TEMPIPS) {
        	open (TMPIPS, $TEMPIPS);          
        	while ($tmplinin = <TMPIPS>) {
                	$tmplinin =~ s/\n//;
                		if ($tmplinin eq $ip) {
                        	$match = 1;
                        	}
                	}       
		close(TMPIPS);
		}
	}

# If you have a match from any of these sources, check to see if 
# it's a BLOCKED IP number.  

if ($match) {
        foreach $blockedip (@BLOCKED_IP_NUMBERS) {
		$blocked++ if ($ip =~ /^$blockedip/);
	    }
    }

# Set the final return code.  

$ret = $match ? $blocked ? 0 : 1 : 0;
return $ret;
}

# ======================================================================
# These are lists of strings to be looped thru compared against
# the host name provided by the server.  These are perl lists.  By
# convention, we have comments for each institution for management
# ease.  Numeric addresses must be fully expanded, as this 
# simple mechanism does not handle ranges, e.g. 128.132.129-150.*
# We looked at numeric matching, but it got rather complicated.
# Please let us know if you write something smarter.  
# ======================================================================

# =========================VALID ADDRESSES BY NAME =====================
# This only works if you have the http name resolver on.  It is by
# far the easiest way to proceed since most institutions have identifiable
# names and most machines from these institutions are assigned names.
# Matching is anchored at the end of the string.
# ======================================================================
@LEGAL_DOMAINS_BY_NAME = (
"brown.edu",                      # Brown University
"uchicago.edu",                   # University of Chicago
"DUMMY.DUMMY"                     # A Dummy to hold the end of the list
);

# =========================VALID ADDRESSES BY NUMBER ===================
# If you don't get a name match, the we check for matches by IP number
# Matches are anchored at the beginning of the string.  This list must 
# be fully expanded.   
# ======================================================================
@LEGAL_DOMAINS_BY_ADDR = (
"128.135.",                       # University of Chicago
"128.148.",                       # Brown University
"138.16.",                        # Brown University
"999.999.999.999"                 # A Dummy to hold the end of the list
);

# =========================BLOCKED IP ADDRESSES ========================
# This is a list of blocked IP addresses which is checked only if
# there is a match.  Some institutions have some public access servers
# that they want block.  Not too many in my experience.
# ======================================================================

@BLOCKED_IP_NUMBERS = (
"130.108.1.20",                   # Institution Name
"132.162.32.99",                  # Institution Name
"999.999.999.999"                 # A Dummy to hold the end of the list
);


1;
