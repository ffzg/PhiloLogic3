#! /usr/bin/perl

require('characters.pl');

while (<>) {
    chop;
    $index_form = $_;
    $search_form = $_;

    $romsearchform = utf2rom($search_form);

    $lineout = $romsearchform . "\t" . $index_form . "\n";
    print $lineout;
}
