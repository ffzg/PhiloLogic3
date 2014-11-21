#!/usr/bin/perl


while (<>){
	chop;
	$linein = $_;
	($word, $year, $freq) = split(/ /,$linein);
	$sortword = &iso2html($word);
	print "$word $year $freq $sortword\n";
}

sub iso2html {
local ($tt);
$tt = $_[0];
$tt =~ s/\306/&AElig;/g;
$tt =~ s/\301/&Aacute;/g;
$tt =~ s/\302/&Acirc;/g;
$tt =~ s/\300/&Agrave;/g;
$tt =~ s/\305/&Aring;/g;
$tt =~ s/\303/&Atilde;/g;
$tt =~ s/\304/&Auml;/g;
$tt =~ s/\307/&Ccedil;/g;
$tt =~ s/\320/&ETH;/g;
$tt =~ s/\311/&Eacute;/g;
$tt =~ s/\312/&Ecirc;/g;
$tt =~ s/\310/&Egrave;/g;
$tt =~ s/\313/&Euml;/g;
$tt =~ s/\315/&Iacute;/g;
$tt =~ s/\316/&Icirc;/g;
$tt =~ s/\314/&Igrave;/g;
$tt =~ s/\317/&Iuml;/g;
$tt =~ s/\321/&Ntilde;/g;
$tt =~ s/\323/&Oacute;/g;
$tt =~ s/\324/&Ocirc;/g;
$tt =~ s/\322/&Ograve;/g;
$tt =~ s/\330/&Oslash;/g;
$tt =~ s/\325/&Otilde;/g;
$tt =~ s/\326/&Ouml;/g;
$tt =~ s/\336/&THORN;/g;
$tt =~ s/\332/&Uacute;/g;
$tt =~ s/\333/&Ucirc;/g;
$tt =~ s/\331/&Ugrave;/g;
$tt =~ s/\334/&Uuml;/g;
$tt =~ s/\335/&Yacute;/g;
$tt =~ s/\341/&aacute;/g;
$tt =~ s/\342/&acirc;/g;
$tt =~ s/\346/&aelig;/g;
$tt =~ s/\340/&agrave;/g;
$tt =~ s/\345/&aring;/g;
$tt =~ s/\343/&atilde;/g;
$tt =~ s/\344/&auml;/g;
$tt =~ s/\347/&ccedil;/g;
$tt =~ s/\351/&eacute;/g;
$tt =~ s/\352/&ecirc;/g;
$tt =~ s/\350/&egrave;/g;
$tt =~ s/\360/&eth;/g;
$tt =~ s/\353/&euml;/g;
$tt =~ s/\355/&iacute;/g;
$tt =~ s/\356/&icirc;/g;
$tt =~ s/\354/&igrave;/g;
$tt =~ s/\357/&iuml;/g;
$tt =~ s/\361/&ntilde;/g;
$tt =~ s/\363/&oacute;/g;
$tt =~ s/\364/&ocirc;/g;
$tt =~ s/\362/&ograve;/g;
$tt =~ s/\370/&oslash;/g;
$tt =~ s/\365/&otilde;/g;
$tt =~ s/\366/&ouml;/g;
$tt =~ s/\337/&szlig;/g;
$tt =~ s/\376/&thorn;/g;
$tt =~ s/\372/&uacute;/g;
$tt =~ s/\373/&ucirc;/g;
$tt =~ s/\371/&ugrave;/g;
$tt =~ s/\374/&uuml;/g;
$tt =~ s/\375/&yacute;/g;
$tt =~ s/\377/&yuml;/g;
$tt =~ s/\247/&#167;/g;
$tt =~ s/\253/&#171;/g;
$tt =~ s/\260/&#176;/g;
$tt =~ s/\267/&#183;/g;
$tt =~ s/\273/&#187;/g;
$tt =~ s/\274/&#188;/g;
$tt =~ s/\275/&#189;/g;
$tt =~ s/\367/&#247;/g;

$tt =~ s/\&([a-zA-Z])/$1\&$1/;

return $tt;

}

