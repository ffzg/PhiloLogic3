#!/usr/bin/perl

open (BIBLIO, "./bibliography");
while ($inbib = <BIBLIO>) {
	$inbib =~ s/\n//;
	@results = split(/\t/, $inbib);
	$date = $results[2];
	$doc = $results[20];
	$docyear{$doc} = $date;
	}
close (BIBLIO);
		
while (<>) {
        chop;
        $inrecord = $_;
        ($word, $freq, $doc) = split(/ /, $inrecord);
	print "$word $docyear{$doc} $freq\n";
	}
