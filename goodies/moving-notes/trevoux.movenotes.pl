#! /usr/bin/perl
# FOR XML
while (<>) {
	$thewholething .= $_;
	}

$thewholething =~ s/\n/<NEWLINE>/g;
$thewholething =~ s/</\n</g;
$thewholething =~ s/>/>\n/g;
# Split it into a list on newlines.
@INSTREAM = split(/\n/, $thewholething);  
$thewholething = ""; 

foreach $inline (@INSTREAM) {
	$inline =~ s/<NEWLINE>/\n/g;
	if ($inline =~ /^</) {
		&taghandler($inline);
		}
	else {
		if ($innote) {
			$NOTETEXT .= $inline;
			}
		else {
			print $inline;
			}
	}
}

sub taghandler {
	local ($thistag);
	$thistag = $_[0];
# REF tag
# I have: <ref type="foot" n="67" id="(*)"/>	
# I want <ref type="note" id="ref1" target="n1" n="1"/>
	if ($thistag =~ /<ref/i) {
		$refid = "";
		if ($thistag =~ / id=/i) {
			$thistag =~ m/ id="([^"]*)"/i;
			$refid = $1;
			}
		$refn = "";
		if ($thistag =~ / n=/i) {
			$thistag =~ m/ n="([^"]*)"/i;
			$refn = $1;
			}
		$newref = "<ref type=\"footnote\" id=\"ref" . $refn . "\" ";
		$newref .= "target=\"n" . $refn . "\" ";
		$newref .= "n=\"" . $refid . "\"/>";
		$thistag = $newref;
		}


# NOTE Tag
# I have <note type="foot" n="66">
# I want <note id="n1" place="foot" target="ref1" resp="Author">
	if ($thistag =~ /<note/i) {
		$noten = "";
                if ($thistag =~ / n=/i) {
                        $thistag =~ m/ n="([^"]*)"/i;
                        $noten = $1;
                        }
		$newnote = "<note id=\"n" . $noten . "\" place=\"foot\" ";
		$newnote .= "target=\"ref" . $noten . "\" resp=\"Author\"";
		$newnote .= ">";
		$thistag = $newnote;
		$innote = 1;
		$NOTETEXT .= $thistag;
		$thistag = "";
		}
	if ($thistag =~ /<\/note/i) {
		$NOTETEXT .= $thistag . "\n";
		$thistag = "";
		$innote = 0;
		}
	if ($thistag =~ /<\/div/i) {
		$thistag =~ m/<\/div(.)/i;
		$closedivlevel = $1;
                if ($NOTETEXT) {
                        $ntdl = $closedivlevel + 1;
                        if ($ntdl > 3) {
                                $ntdl = 3;
                                }
                        print "\n<div" . $ntdl . " type=\"notes\">\n";
                        print "<head>Notes</head>\n";
                        print "<pb n=\"nts\"/>\n";
			$NOTETEXT =~ s/<p>/ /gi;
			$NOTETEXT =~ s/<\/p>/ /gi;
                        print $NOTETEXT;
                        $NOTETEXT = "";
                        print "</div" . $ntdl . ">\n";
                        }

		}

	if ($thistag) {
		if ($innote) {
			$NOTETEXT .= $thistag;
			}
		else {
			print $thistag;
			}
		}
}
	
