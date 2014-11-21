#! /usr/bin/perl

$mapfile = "MappedSpellings.txt";
$philofile = "words.R.wom";
$outfile = "new.words.R.wom";
$testfile = "showwhich.html";

open(MAPPED, $mapfile);

while (<MAPPED>) {
	chop;
	$inline = $_;
	@words = split("\t", $inline);
	$words[0] =~ s/\~//g;
	$words[0] =~ s/\+//g;
	$words[0] =~ s/\_//g;
	$NORMAL{$words[0]} = $words[1];
	$POS{$words[0]} = $words[2];
	$count++;
	}
close (MAPPED);
print "Loaded $count words from $mapfile\n";

open (NEWFILE, ">$outfile");
open (ANALYSIS, ">$testfile");

open(PHILO, $philofile);
while (<PHILO>){ 
        chop;
        $inline = $_;
        @words = split("\t", $inline);
	$mappednorm = "";
	$mappednorm = $NORMAL{$words[1]};
	$posnorm = "";
	$posnorm = $POS{$words[1]};
	$thishit = "";
	if ($mappednorm) {
		print ANALYSIS "FOUND $words[1] MAPPED to $mappednorm <br>\n";
		$thishit = $mappednorm . "\t" . $words[1];
		if ($posnorm) {
			$thishit .= "\t" . $posnorm;
			}
                $thishit .= "\n";
		print NEWFILE $thishit;
		}
	else {
		print ANALYSIS "NO MAP FOR $words[1] <br>\n";
		$thishit = $inline . "\t" . $words[1] . "\n";
		print NEWFILE $thishit;
		}
	}
close (PHILO);



