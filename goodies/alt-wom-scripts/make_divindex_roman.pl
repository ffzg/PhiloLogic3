#! /usr/bin/perl

require('characters.pl');

while (<>) {
    chop;
    @parts = split(/\t/, $_);
    
    $search_form = $parts[1];
    $romsearchform = utf2rom($search_form);

    foreach $foo (@parts) {
	print $foo . "\t";
    }
    print $romsearchform . "\n";
}
