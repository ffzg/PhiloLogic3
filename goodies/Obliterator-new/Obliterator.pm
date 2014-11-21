package Obliterator;

use strict;
use vars qw($VERSION @ISA);
use Carp;

use bytes;

$VERSION = '0.10.0';  # devel - all iscii - preliminary

#use Unicode::String qw(utf8);
#$testchar = "à®¤";

my $Debugging = 0;

# Obliterator: objectified Unicode transliterator with a focus on indic
# 
# notes 17 April: working on adding devanagari support to Iscii
# package I guess I should have the romanization based on the ISCII
# since that will save steps in the future.  Hmm.  Right?  Oh, but
# that will depend later on reliable UTF2ISCII.  But that's okay,
# isn't it?
#
# obliterator should initialized with a utf or iscii string 
# but really a transliteration should do eventually.
#
# attributes/methods:
# $mystring = Obliterator->new();
# you should be able to transliterate starting from any of these:

# $mystring->iscii->tam("ooga");
# $mystring->indutf("booga");
# etc.

# and then call their transliterations with
# print "$mystring->indutf"; or
# print "$mystring->romutf";

# $mystring->aform shouldn't be used by users -- it's got "a"s added
# for those indic consonants pairs that want them, and is used for
# outputting the romanizations romutf and romascii.  does it have
# anything to offer the iscii/indutf versions?  if we are initialized
# with a romutf form we should strip these extra a's -- oh, that's the
# trouble with platts perso-arabic, I see.  We won't do things like
# this:
# mystring->romutf("mooga");  # no not this yet if ever
# mystring->romascii("dumb"); # nor this
# yet, then.

our (%isciis, %utf2isc, %utf2sgml, %sgml2utf, %sgml2roman, %indic_consonant, %utf82iscii, @scripts, %funnyaccents);

@scripts = qw(asm bng dev gjr knd mlm ori pnj tam tlg);

foreach my $lng (@scripts) {
	eval "require Obliterator::$lng";
	require Obliterator::sgml2utf;
	require Obliterator::sgml2roman;
}

sub new
{
    if ($Debugging == 8) { print "creating new Obliterator\n" }
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my $self = {};
    $self->{ISCII}    = Iscii->new();
    $self->{TO_ISCII}    = undef;
    $self->{INDUTF}   = undef;
    $self->{INDUTFSGML}   = undef;
    $self->{ROMUTF}   = undef;
    $self->{ROMASCII} = undef;
    $self->{SGMLROM} = undef;
    $self->{AFORM} = undef;
    bless($self, $class);
    if ($Debugging == 8) { print "done creating new Obliterator\n" }
    return $self;
}

sub romutf {
	my $self = shift;
	my $utf;
	unless (defined $self->{ROMUTF}) {
		if (defined $self->{SGMLROM}) {
			$utf = $self->{SGMLROM};
		}
		else {
			$utf = $self->sgmlrom;
		}
		$utf =~ s/(&[^;]*;)/&rndsgmlutf($1)/ge;
		$self->{ROMUTF} = $utf;
	}
	return $self->{ROMUTF}
}

sub romascii {
	my $self = shift;
	my $ascii;
	unless (defined $self->{ROMASCII}) {
		if (defined $self->{SGMLROM}) {
			$ascii = $self->{SGMLROM};
		}
		else {
			$ascii = $self->sgmlrom;
		}
		$ascii =~ s/(&[^;]*;)/&rndsgmlrom($1)/ge;
		$self->{ROMASCII} = $ascii;
	}
	return $self->{ROMASCII}
}

sub rndsgmlutf {
    my ($romanent, $ucchar, $rtnstring);
	
    $romanent = $_[0];
    $ucchar = $sgml2utf{$romanent};
    if ($ucchar) {
        $rtnstring = $ucchar;
	}
    else {
        $rtnstring = $romanent;
	}
	return $rtnstring;
}

sub rndsgmlrom {
    my ($sgmlent, $romchar, $rtnstring);
	
    $sgmlent = $_[0];
    $romchar = $sgml2roman{$sgmlent};
    if ($romchar) {
		unless ($romchar =~ /NULL/) {
			$rtnstring = $romchar;
		}
	}
    else {
        $rtnstring = $sgmlent;
	}
#	return $romchar;
	return $rtnstring;
}


sub sgmlrom {
	my $self = shift;
	if (@_) { 
 		$self->{SGMLROM} = shift;
# 		if ($Debugging == 1) { print "sgmlrom inited to value: $self->{SGMLROM}\n" }
	}
	
	unless ($self->{SGMLROM}) {
		my ($sgmax, @sgtamil, $i, $inc, $thischar, $sgchar, $sgstring, $lastchar);
		
		# so we have to check for a's because our $sgtamil[$n] could
		# be either a byte or a uchar.
		
		@sgtamil = split //, $self->aform; 
		if ($Debugging == 8) { printf "sgmlrom's aform is %s \n", $self->aform; }
		$sgmax = scalar(@sgtamil);
		$inc = 0;
		for ($i = 0; $i < $sgmax; $i += $inc) {

			for ($i = 0; $i <= ($sgmax + 1); $i += $inc) {
				# aha, before I was only checking whether it was an
				# "a" but in order to catch mixed strings it should
				# check the whole lower 128 (though this whole thing
				# is too simplistic for full UTFism)
				if (($sgtamil[$i]) && (ord($sgtamil[$i]) < 128)) {
					$inc = 1;
					$sgstring .= $sgtamil[$i];
				}
				else {
					$inc = 3;
# 3/1 changes:
#					$inc = 1;
					$thischar = $sgtamil[$i] . $sgtamil[$i+1] . $sgtamil[$i+2];
#					$thischar = $sgtamil[$i];

					$sgchar = $utf2sgml{$thischar};
					if ($sgchar) {
						unless ($sgchar =~ /\*\*\*(ANUSVARA|VIRAMA|CANDRABINDU)\*\*\*/) {
							if (($lastchar) && ($lastchar =~ /\*\*\*ANUSVARA\*\*\*/)) {
								if ($funnyaccents{anusvara}{$thischar}) {
									$sgstring .= "$funnyaccents{anusvara}{$thischar}";
								}
								# else tilde over vowel
								else {
									$sgstring .= "$funnyaccents{anusvara}{others}";
								}
							}
							if (($lastchar) && ($lastchar =~ /\*\*\*CANDRABINDU\*\*\*/)) {
								if ($funnyaccents{candrabindu}{$thischar}) {
									$sgstring .= "$funnyaccents{candrabindu}{$thischar}";
								}
								# else tilde over preceding vowel
								else {
									$sgstring .= "$funnyaccents{candrabindu}{others}";
								}
							}
							
							$sgstring .= $sgchar;
						}
						# we need a 
						elsif ($sgchar =~ /\*\*\*(ANUSVARA|CANDRABINDU)\*\*\*/) {
							$thischar = "***$1***";
							if ($indic_consonant{$lastchar}) {
								$sgstring .= "a";
							}
						}
					}
					else{
						$sgstring .= $thischar;
#                       print "had to use $thischar";
					}
				}
				$lastchar = $thischar;
			}
			$self->{SGMLROM} = $sgstring;
		}
		return $self->{SGMLROM};
	}
}


sub aform {
	my (@asplit, $amax, $asplitme, @usearray, $i, $inc);
    if ($Debugging == 3) { print "entering Obliterator::aform\n" }
    my $self = shift;
	if (@_) { 
 		$self->{AFORM} = shift;
 		if ($Debugging == 1) { print "aform inited to value: $self->{AFORM}\n" }
	}
	unless (defined $self->{AFORM}) {
		if ($Debugging == 3) { print "no AFORM, entering 'unless defined self->{AFORM...'\n" }
		if ($Debugging == 3) { printf "self->indutfsgml is %s\n", $self->indutfsgml }
		if ($self->{INDUTFSGML}) {
			$asplitme = $self->{INDUTFSGML};
		}
		else {
			$asplitme = $self->indutfsgml;
		}
		if ($Debugging == 6) { printf "indutfsgml is %s\n", $self->indutfsgml; }
		@asplit = split //, $asplitme;
		$amax = scalar(@asplit);
		for ($i = 0; $i < $amax; $i += $inc) {
			if (ord($asplit[$i]) < 128) {
				push @usearray, "$asplit[$i]";
				$inc = 1;
			}
			else {
				push @usearray, "$asplit[$i]$asplit[$i+1]$asplit[$i+2]";
				$inc = 3;
			}
		}

		my $usemax = scalar(@usearray);
		if ($Debugging == 3) { print "amax is $amax\n" }
		my $astring = "";
		my $lastchar = "";
		my $thischar = "";

		for (my $i = 0; $i < $usemax; $i++) {
			# put in short-a\'s if appropriate
			$thischar = $usearray[$i];
			if ($Debugging == 6) { print "thischar is $thischar\n" }
			# pass < 128 ascii text untouched (that should speed things up!)
			if ((ord($thischar) < 128) && (ord($lastchar) < 128)) {
				$astring .= "$thischar";
				if ($Debugging == 6) {print "passing $thischar thru: in ascii\n" }
			}

			# act on upper-128 (and so unicode)
			elsif ($lastchar) {
				if ($Debugging == 6) {print "testing $thischar, $lastchar for indic consonantness: $indic_consonant{$thischar}, $indic_consonant{$lastchar}\n" }
				if (($indic_consonant{$thischar}) && ($indic_consonant{$lastchar})) {
					if ($Debugging == 6) { print "adding a: between consonants\n" }
					$astring .= "a" . $thischar;
				}
				elsif ((ord($thischar) < 128) && ($indic_consonant{$lastchar})) {
					$astring .= "a" . $thischar;
				}
				else {
					$astring .= $thischar;
				}
				if ($i == ($usemax - 1) && ($indic_consonant{$thischar})) {
					$astring .= "a";
				}

			}
			elsif ($thischar) {
				if ($Debugging == 6) { print "not adding a: at beginning of string\n"; }
				$astring .= "$thischar";
			}
			else {
				print "I don't know how i got to this case\n";
				$astring .= "$thischar";
			}
			$lastchar = $thischar;
			if ($Debugging == 6) { print "astring is $astring when i is $i\n";}
		}
		
		$self->{AFORM} = $astring;
	}
	return $self->{AFORM};
}


sub iscii {
    if ($Debugging == 8) { print "entering Obliterator::iscii\n" }
    my $self = shift;
    if ($Debugging == 8) { print "self->{ISCII} is $self->{ISCII}\n" }
    return $self->{ISCII}
}

sub indutfsgml {
    if ($Debugging == 8) { print "entering Obliterator::indutfsgml\n" }
    my $self = shift;
    if (@_) { 
		$self->{INDUTFSGML} = shift;
		if ($Debugging == 1) { print "indutfsgml inited to value: $self->{INDUTFSGML}\n" }
    }
    elsif ((defined $self->iscii->{$self->iscii->{lang}}) && (!$self->{INDUTFSGML})) {
		if ($Debugging == 8) { print "Ob::indutfsgml's elsif\n" }
		$self->{INDUTFSGML} = $self->iscii->to_indutf;
    }
    if ($Debugging == 8) { print "leaving Ob::indutfsgml\n" }
    return $self->{INDUTFSGML};
}

sub indutf {
	my $self = shift;
	if (@_) {
		$self->{INDUTFSGML} = shift;
		if ($Debugging == 1) { print "indutf inited to value: $self->{INDUTF}\n" }
    }
    elsif ((defined $self->iscii->{$self->iscii->{lang}}) && (!$self->{INDUTF})) {
		if ($Debugging == 8) { print "Ob::indutf's elsif\n" }
		$self->{INDUTF} = $self->indutfsgml;
		$self->{INDUTF} =~ s/(&[^;]*;)/&rndsgmlutf($1)/ge; 
    }
    if ($Debugging == 8) { print "leaving Ob::indutf\n" }
    return $self->{INDUTF} || $self->{INDUTFSGML};


}

sub debug {
    my $self = shift;
    confess "usage: thing->debug(level)"    unless @_ == 1||8;
    my $level = shift;
    if (ref($self))  {
		$self->{"_DEBUG"} = $level;         # just myself
    } else {
		$Debugging        = $level;         # whole class
    }
}

sub to_iscii {
	my $self = shift;
	unless($self->{TO_ISCII}) {
		if ($self->indutf) {
			my ($isc, $u, $o);
			unless (%utf2isc) {
#				print "initing utf2isc\n";
				my ($base, $key, $v);
				foreach my $lng (@scripts) {
					my $LNG = uc $lng;
					foreach my $key (sort keys %{$isciis{$LNG}}){
						my $v = $isciis{$LNG}{$key};
						$utf2isc{$v} = $key;
#					print "$v\t$key\n";
					}
				}

			}
			my @chars = split "", $self->indutf;
			my $max = scalar(@chars);
			my ($state, $len, $c, $inc);
			for (my $i = 0; $i < $max; $i+=$inc) {
				if (ord($chars[$i]) < 128) {
					$c = $chars[$i];
					$inc = 1;
				}
				else {
					$u = $chars[$i] . $chars[$i+1] . $chars[$i+2];
					$inc = 3;
					$isc = $utf2isc{$u};
					if ($isc) {
						$self->{TO_ISCII} .= "$isc";
					} else {
						$self->{TO_ISCII} .= "$u";
					}
				}
			}
		}
	}
	return $self->{TO_ISCII};;
}

package Iscii;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
	my $self;
	foreach my $lng (@scripts) {
		my $LNG = uc $lng;
		eval "$self->{$LNG} = undef";
	}
	$self->{lang} = undef;
#     if (@_) { $self->{lang} = shift }
    bless ($self, $class);
    return $self;
}

foreach my $lng (@scripts) {
	my $LNG = uc $lng;
	eval
		"sub $lng {
	my \$self = shift;
	if (\@_) { \$self->{$LNG} = shift }
    \$self->{lang} = \"$LNG\";
    return \$self->{$LNG};
}
";
}

sub as_string {
    my $self = shift;
    if (defined $self->{$self->{lang}}) {
		return $self->{$self->{lang}};
    }
}
sub to_indutf {
# begin code derived from Andrew Dunbar
	my ($b, $c);
    my $self = shift;
    $b = undef;
	my $lang = $self->{lang};
    my $stash = '';
    my $out = '';
    my $toreturn = '';
    my @chars = split //, $self->as_string;
    my $max = scalar(@chars);
    my $i = 0;
    while ($i <= ($max)) {
		$c = $chars[$i];
		my $utf8 = undef;
		
		# nukta combines with previous character
		if (($c) && ($c eq "\xe9")) {
			$out = $isciis{$lang}{$b.$c};
			$out = $stash . $isciis{$lang}{$c} unless $out;
			$stash = '';
			# combind two ASCII dandas into a Unicode double danda
		} elsif (($c) && ($b) && ($c eq "\xea") && ($b eq "\xea")) {
			$out = $isciis{$lang}{$b.$c};
			$stash = '';
			# EXT combines with next character
		} elsif (($c) && ($c eq "\xf0")) {
			$out = $stash;
			$stash = '';
			# regular ISCII range
		} elsif (($c) && ($c =~ /[\xa1-\xfe]/)) {
			if (($b) && ($b eq "\xf0")) {
				$out = $isciis{$lang}{$b.$c};
			} else {
				$out = $stash;
				$stash = $isciis{$lang}{$c};
			}
			# ASCII range etc
		} else {
			if ($Debugging == 1) { print "out: $out stash: $stash c: $c b: $b\n" }
			if ($c) {
				$out = $stash . $c;
			}
			else {
				$out = $stash;
			}
			$stash = '';
		}
		
		($out) && ($toreturn .= $out);
		$b = $c;
		$i++;
    }
    
    $self->{INDUTFSGML} = "$toreturn";
}
# end code derived from Andrew Dunbar    

1;

__END__

	=head1 NAME

	Obliterator  -A transliterator and transcoder for Indic languages
	focussed especially on Iscii/Unicode

	=head1 SYNOPSIS

	use Obliterator;

my $deva = Obliterator->new();
$deva->iscii->dev("¿å¢Ê³ÚÔÒÚ");
printf "iscii is %s \n", $deva->iscii->dev;
printf "indutf is %s \n", $deva->indutf;
printf "romutf is %s \n", $deva->romutf;
printf "romascii is %s \n", $deva->romascii;

my $tam = Obliterator->new();
$tam->iscii->tam("ÂÛÏÝ¸è¸ÛÐèÐÌèÈÑ");

my $utf = Obliterator->new();
$utf->indutf("à®¤à®¤à®¤à®¿à®°à¯à®šà¯à®šà®¿à®±à¯à®±à®®à¯à®ªà®²à®®à¯");
printf "romutf is %s \n", $deva->romutf;
printf "romascii is %s \n", $deva->romascii;
printf "iscii is %s \n", $deva->to_iscii;

=head1 INDIC SCRIPT OPTIONS

All scripts described in the ISCII91 standard are covered.  When
initializing with an ISCII string, specify the script with the
three-character mnemonic from Annex A of the standard:

Assamese:   asm
Bengali:    bng 
Devanagari: dev
Gujarati:   gjr
Kannada:    knd
Malayalam:  mlm
Oriya:      ori
Punjabi     pnj  (AKA Gurmukhi)
Tamil:      tam
Telugu:     tlg

=head1 DIAGNOSTICS

	Setting Obliterator->debug(n) where 1 <= n <= 8 will generate 
	debugging output according to no particular plan.  (I'm working
	on a plan).

	=head1 AUTHOR

	Orion Montoya <orion@diderot.uchicago.edu>

	=head1 COPYRIGHT

	Copyright (C) 2003 Orion Montoya <orion@diderot.uchicago.edu>
	All Rights Reserved.

	This module is free software. It may be used, redistributed
	and/or modified under the terms of the Perl Artistic License
	(see http://www.perl.com/perl/misc/Artistic.html)

	the indutf subroutine contains code from iscii2utf8.pl, copyright
	(c) Andrew Dunbar, 2001,
