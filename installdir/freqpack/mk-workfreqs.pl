#! /usr/bin/perl

while (<>) {
	chop;
	$inrecord = $_;
	($word, $freq, $doc) = split(/ /, $inrecord);
	$outfreq{$doc} = $outfreq{$doc} + $freq;
	}
	foreach $outdoc (sort keys(%outfreq)){
	    print $outdoc . " " . $outfreq{$outdoc} . "\n";
	}

