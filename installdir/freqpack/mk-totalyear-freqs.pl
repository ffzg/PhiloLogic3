#!/usr/bin/perl

while (<>) {
	chop;
	$inrecord = $_;
	($word, $year, $freq) = split(/ /, $inrecord);
	$outfreq{$year} = $outfreq{$year} + $freq;
	$century = $year;
	$century =~ s/(..).*/C $1 00 - $1 99/;
	$century =~ s/ //g;
	$outfreq{$century} = $outfreq{$century} + $freq;
	$decade = $year;
        $decade =~ s/(...).*/D $1 0 - $1 9/;
        $decade =~ s/ //g; 
	$outfreq{$decade} = $outfreq{$decade} + $freq;
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
	$outfreq{$quarter} = $outfreq{$quarter} + $freq;
	}

	foreach $outyear (sort keys(%outfreq)){
	    print $outyear . " " . $outfreq{$outyear} . "\n";
	}

