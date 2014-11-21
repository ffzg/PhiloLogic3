#!/usr/bin/perl -w

use strict;
my $linect = 0;
while (<>) {
    s,\&\#x([0-9a-fA-F]{4});,hex2utf8($1),ges;
    s,\&\#([0-9a-fA-F]{4});,num2utf8($1),ges;

    $linect++;
    
    print;
    print STDERR "$linect lines processesd\n" if (( $linect % 10000 ) == 0 );
}


sub hex2utf8 {
    num2utf8( hex( $_[0] ) );
}

sub num2utf8 {
    my ( $t ) = @_;
    my ( $trail, $firstbits, @result );

    if    ($t<0x00000080) { $firstbits=0x00; $trail=0; }
    elsif ($t<0x00000800) { $firstbits=0xC0; $trail=1; }
    elsif ($t<0x00010000) { $firstbits=0xE0; $trail=2; }
    elsif ($t<0x00200000) { $firstbits=0xF0; $trail=3; }
    elsif ($t<0x04000000) { $firstbits=0xF8; $trail=4; }
    elsif ($t<0x80000000) { $firstbits=0xFC; $trail=5; }
    else {
        die "Too large scalar value, cannot be converted to UTF-8.\n";
    }
    for (1 .. $trail) {
        unshift (@result, ($t & 0x3F) | 0x80);
        $t >>= 6;         # slight danger of non-portability
    }
    unshift (@result, $t | $firstbits);
    pack ("C*", @result);
}

