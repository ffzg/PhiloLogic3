#!/usr/bin/perl

use Obliterator;

$str = "������������";
$myhw = Obliterator->new();
$myhw->iscii->bng("$str");

printf "INDUTF: %s ROMASCII: %s\n", $myhw->indutf, $myhw->romascii;
