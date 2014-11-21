#!/usr/bin/perl

use Obliterator;

$str = "¤µèÆèÎÝÂèÈÚÂ";
$myhw = Obliterator->new();
$myhw->iscii->bng("$str");

printf "INDUTF: %s ROMASCII: %s\n", $myhw->indutf, $myhw->romascii;
