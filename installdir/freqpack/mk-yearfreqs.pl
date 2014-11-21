#!/usr/bin/perl

$thisword = "";
$thiswordfreq = 0;
$inital = 0;

while (<>) {
	chop;
	$inrecord = $_;
	($word, $year, $freq) = split(/ /, $inrecord);
	if ($word eq $lastword) {
		if ($year eq $lastyear) {
			$thiswordfreq = $thiswordfreq + $freq;
			$lastyear = $year;
			}
		else {
			print "$word $lastyear $thiswordfreq\n";
			$lastyear = $year;
			$thiswordfreq = $freq;
			$lastword = $word;
			}
		}
	else {
		if ($inital) {
		    print "$lastword $lastyear $thiswordfreq\n";
		    $lastword = $word;
		    $lastyear = $year;
		    $thiswordfreq = $freq;
		    }
		else {
		    $inital = 1;
                    $lastword = $word;
                    $lastyear = $year;
                    $thiswordfreq = $freq;
		    }
	        }
	}

print "$lastword $lastyear $thiswordfreq\n";
