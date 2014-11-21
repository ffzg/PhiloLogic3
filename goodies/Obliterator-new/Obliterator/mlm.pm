package Obliterator;
# malayalam
$isciis{MLM} = {
#	"\xa1" => "ഁ",	# chandrabindu
	"\xa1\xe9" => "൐",	# om
	"\xa2" => "ം",	# anuswar
	"\xa3" => "ഃ",	# visarg
	"\xa4" => "അ",
	"\xa5" => "ആ",
	"\xa6" => "ഇ",
	"\xa6\xe9" => "ഌ",	# &#2316; letter vocalic l
	"\xa7" => "ഈ",
	"\xa7\xe9" => "ൡ",	# &#2401; letter vocalic ll
	"\xa8" => "ഉ",
	"\xa9" => "ഊ",
	"\xaa" => "ഋ",
	"\xaa\xe9" => "ൠ",	# &#2400; letter vocalic rr
	"\xab" => "എ",
	"\xac" => "ഏ",
	"\xad" => "ഐ",
#	"\xae" => "഍",
	"\xaf" => "ഒ",
	"\xb0" => "ഓ",
	"\xb1" => "ഔ",
#	"\xb2" => "഑",
	"\xb3" => "ക",
	"\xb3\xe9" => "൘",	# &#2392 letter qa
	"\xb4" => "ഖ",
	"\xb4\xe9" => "൙",	# &#2393 letter khha
	"\xb5" => "ഗ",
	"\xb5\xe9" => "൚",	# &#2394 letter ghha
	"\xb6" => "ഘ",
	"\xb7" => "ങ",
	"\xb8" => "ച",
	"\xb9" => "ഛ",
	"\xba" => "ജ",
	"\xba\xe9" => "൛",	# &#2395; letter za
	"\xbb" => "ഝ",
	"\xbc" => "ഞ",
	"\xbd" => "ട",
	"\xbe" => "ഠ",
	"\xbf" => "ഡ",
	"\xbf\xe9" => "൜",	# &#2396; letter dddha
	"\xc0" => "ഢ",
	"\xc0\xe9" => "൝",	# &#2397; letter rha
	"\xc1" => "ണ",
	"\xc2" => "ത",
	"\xc3" => "ഥ",
	"\xc4" => "ദ",
	"\xc5" => "ധ",
	"\xc6" => "ന",
#	"\xc7" => "ഩ",
	"\xc8" => "പ",
	"\xc9" => "ഫ",
	"\xc9\xe9" => "൞",	# &#2398; letter fa
	"\xca" => "ബ",
	"\xcb" => "ഭ",
	"\xcc" => "മ",
	"\xcd" => "യ",
	"\xce" => "ൟ",
	"\xcf" => "ര",
	"\xd0" => "റ",
	"\xd1" => "ല",
	"\xd2" => "ള",
	"\xd3" => "ഴ",
	"\xd4" => "ബ", # porter check this: should it be ..35 (no for oriya)
	"\xd5" => "ശ",
	"\xd6" => "ഷ",
	"\xd7" => "സ",
	"\xd8" => "ഹ",
	"\xd9" => "‍",	# ISCII INVisible -> Unicode ZWJ
	"\xda" => "ാ",
	"\xdb" => "ി",
	"\xdb\xe9" => "ൢ",	# &#2402; vowel sign vocalic l
	"\xdc" => "ീ",
	"\xdc\xe9" => "ൣ",	# &#2403; vowel sign vocalic ll
	"\xdd" => "ു",
	"\xde" => "ൂ",
	"\xdf" => "ൃ",
#	"\xdf\xe9" => "ൄ",	# &#2372; vowel sign vocalic rr
	"\xe0" => "െ",
	"\xe1" => "േ",
	"\xe2" => "ൈ",
#	"\xe3" => "൅",
	"\xe4" => "ൊ",
	"\xe5" => "ോ",
	"\xe6" => "ൌ",
#	"\xe7" => "൉",
	"\xe8" => "്",	# halant
#	"\xe9" => '\x{0d3c}',	# nukta
#	"\xea" => "൤",	# full stop / viram
#	"\xea\xe9" => '\x{0d3d}',	# &#2365; sign avagraha
#	"\xea\xea" => "൥",	# &#2405; double danda (ARD)
	"\xef" => '?',		# attribute
	#"\xf0" => '?',		# extension
#	"\xf0\xb8" => "൒",	# &#2386; stress sign anudatta (uses EXT)
#	"\xf0\xbf" => "൰",	# &#2416; abbreviation sign (uses EXT)

	"\xf1" => "൦",
	"\xf2" => "൧",
	"\xf3" => "൨",
	"\xf4" => "൩",
	"\xf5" => "൪",
	"\xf6" => "൫",
	"\xf7" => "൬",
	"\xf8" => "൭",
	"\xf9" => "൮",
	"\xfa" => "൯",
};

## malayalam unicode section starts
#$utf2sgml{"ഁ"} = "***CANDRABINDU***";# chandrabindu
$utf2sgml{"ം"} = "***ANUSVARA***"; # anuswar
$utf2sgml{"ഃ"} = "&htod;"; # visarg
$utf2sgml{"അ"} = "a";
$utf2sgml{"ആ"} = "&amacr;";
$utf2sgml{"ഇ"} = "i";

$utf2sgml{"ഈ"} = "&imacr;";
$utf2sgml{"ഉ"} = "u";
$utf2sgml{"ഊ"} = "&umacr;";
$utf2sgml{"ഋ"} = "&rtod;";
$utf2sgml{"ഌ"} = ""; # &#2316; letter vocalic l
$utf2sgml{"഍"} = "&ecirc;";
$utf2sgml{"എ"} = "e";
$utf2sgml{"ഏ"} = "&emacr;";

$utf2sgml{"ഐ"} = "ai";
$utf2sgml{"഑"} = "&ocirc;";
$utf2sgml{"ഒ"} = "o";
$utf2sgml{"ഓ"} = "&omacr;";
$utf2sgml{"ഔ"} = "au";
$utf2sgml{"ക"} = "k";
$utf2sgml{"ഖ"} = "kh";
$utf2sgml{"ഗ"} = "g";

$utf2sgml{"ഘ"} = "gh";
$utf2sgml{"ങ"} = "&ndot;";
$utf2sgml{"ച"} = "c";
$utf2sgml{"ഛ"} = "ch";
$utf2sgml{"ജ"} = "j";
$utf2sgml{"൛"} = "z"; # &#2395; letter za
$utf2sgml{"ഝ"} = "jh";
$utf2sgml{"ഞ"} = "&ntilde;";
$utf2sgml{"ട"} = "&ttod;";

$utf2sgml{"ഠ"} = "&ttod;h";
$utf2sgml{"ഡ"} = "&dtod;";
$utf2sgml{"ഢ"} = "&dtod;h";
$utf2sgml{"൝"} = "&dcirc;h"; # &#2397; letter rha
$utf2sgml{"ണ"} = "&ntod;";
$utf2sgml{"ത"} = "t";
$utf2sgml{"ഥ"} = "th";
$utf2sgml{"ദ"} = "d";
$utf2sgml{"ധ"} = "dh";

$utf2sgml{"ന"} = "n";
$utf2sgml{"ഩ"} = "&nline;";
$utf2sgml{"പ"} = "p";
$utf2sgml{"ഫ"} = "ph";
$utf2sgml{"൞"} = "f"; # &#2398; letter fa
$utf2sgml{"ബ"} = "b";
$utf2sgml{"ഭ"} = "bh";
$utf2sgml{"മ"} = "m";
$utf2sgml{"യ"} = "y";

$utf2sgml{"ൟ"} = "&ydot;";
$utf2sgml{"ര"} = "r";
$utf2sgml{"റ"} = "&rtod;";
$utf2sgml{"ല"} = "l";
$utf2sgml{"ള"} = "&ltod;";
$utf2sgml{"ഴ"} = "&zline;";
$utf2sgml{"വ"} = "v";
$utf2sgml{"ശ"} = "&sacute;";
$utf2sgml{"ഷ"} = "&stod;";

$utf2sgml{"സ"} = "s";
$utf2sgml{"ഹ"} = "h";
$utf2sgml{"‍"} = ""; # ISCII INVisible -> Unicode ZWJ
$utf2sgml{"ാ"} = "&amacr;";
$utf2sgml{"ി"} = "i";

$utf2sgml{"ൢ"} = ""; # &#2402; vowel sign vocalic l
$utf2sgml{"ീ"} = "&imacr;";
$utf2sgml{"ൣ"} = ""; # &#2403; vowel sign vocalic ll
$utf2sgml{"ു"} = "u";
$utf2sgml{"ൂ"} = "&umacr;";
$utf2sgml{"ൃ"} = "&rtod;";
$utf2sgml{"ൄ"} = ""; # &#2372; vowel sign vocalic rr
$utf2sgml{"െ"} = "e";
$utf2sgml{"േ"} = "&emacr;";
$utf2sgml{"ൈ"} = "ai";
$utf2sgml{"൅"} = "&ecirc;";
$utf2sgml{"ൊ"} = "o";
$utf2sgml{"ോ"} = "&omacr;";
$utf2sgml{"ൌ"} = "au";
$utf2sgml{"൉"} = "&ocirc;";
$utf2sgml{"്"} = "***VIRAMA***"; # halant

$utf2sgml{"൐"} = "om"; # om

$utf2sgml{"൘"} = "k"; # &#2392 letter qa
$utf2sgml{"൙"} = "&kline;&hline;"; # &#2393 letter khha
$utf2sgml{"൚"} = "g&hline;"; # &#2394 letter ghha
$utf2sgml{"൜"} = "&dcirc;"; # &#2396; letter dddha

$utf2sgml{"ൠ"} = ""; # &#2400; letter vocalic rr
$utf2sgml{"ൡ"} = ""; # &#2401; letter vocalic ll
$utf2sgml{"൤"} = "."; # full stop / viram
$utf2sgml{"൥"} = ""; # &#2405; double danda (ARD)

$utf2sgml{"഼"} = "&tod;"; # nukta
$utf2sgml{"ഽ"} = ""; # &#2365; sign avagraha

$utf2sgml{"൒"} = ""; # &#2386; stress sign anudatta (uses EXT)
$utf2sgml{"൰"} = ""; # &#2416; abbreviation sign (uses EXT)
$utf2sgml{"൦"} = "0";
$utf2sgml{"൧"} = "1";
$utf2sgml{"൨"} = "2";
$utf2sgml{"൩"} = "3";
$utf2sgml{"൪"} = "4";
$utf2sgml{"൫"} = "5";
$utf2sgml{"൬"} = "6";
$utf2sgml{"൭"} = "7";
$utf2sgml{"൮"} = "8";
$utf2sgml{"൯"} = "9";
## malayalam unicode section ends

# malayalam consonants
#$indic_consonant{"ം"} = "yes"; # anuswar
$indic_consonant{"ക"} = "yes"; ## k
$indic_consonant{"ഖ"} = "yes"; ## kh
$indic_consonant{"ഗ"} = "yes"; ## g
$indic_consonant{"ഘ"} = "yes"; ## gh
$indic_consonant{"ങ"} = "yes"; ## &ndot;
$indic_consonant{"ച"} = "yes"; ## c
$indic_consonant{"ഛ"} = "yes"; ## ch
$indic_consonant{"ജ"} = "yes"; ## j
$indic_consonant{"൛"} = "yes"; ## z # &#2395; letter za
$indic_consonant{"ഝ"} = "yes"; ## jh
$indic_consonant{"ഞ"} = "yes"; ## &ntilde;
$indic_consonant{"ട"} = "yes"; ## &ttod;
$indic_consonant{"ഠ"} = "yes"; ## &ttod;h
$indic_consonant{"ഡ"} = "yes"; ## &dtod
$indic_consonant{"ഢ"} = "yes"; ## &dtod;h
$indic_consonant{"൝"} = "yes"; ## &dcirc;h # &#2397; letter rha
$indic_consonant{"ണ"} = "yes"; ## &ntod;
$indic_consonant{"ത"} = "yes"; ## t
$indic_consonant{"ഥ"} = "yes"; ## th
$indic_consonant{"ദ"} = "yes"; ## d
$indic_consonant{"ധ"} = "yes"; ## dh
$indic_consonant{"ന"} = "yes"; ## n
$indic_consonant{"ഩ"} = "yes"; ## &nline;
$indic_consonant{"പ"} = "yes"; ## p
$indic_consonant{"ഫ"} = "yes"; ## ph
$indic_consonant{"൞"} = "yes"; ## f # &#2398; letter fa
$indic_consonant{"ബ"} = "yes"; ## b
$indic_consonant{"ഭ"} = "yes"; ## bh
$indic_consonant{"മ"} = "yes"; ## m
$indic_consonant{"യ"} = "yes"; ## y
$indic_consonant{"ൟ"} = "yes"; ## &ydot;
$indic_consonant{"ര"} = "yes"; ## r
$indic_consonant{"റ"} = "yes"; ## &rtod;
$indic_consonant{"ല"} = "yes"; ## l
$indic_consonant{"ള"} = "yes"; ## &ltod;
$indic_consonant{"ഴ"} = "yes"; ## &zline;
$indic_consonant{"വ"} = "yes"; ## v
$indic_consonant{"ശ"} = "yes"; ## &sacute;
$indic_consonant{"ഷ"} = "yes"; ## &stod
$indic_consonant{"സ"} = "yes"; ## s
$indic_consonant{"ഹ"} = "yes"; ## h
$indic_consonant{"൘"} = "yes"; ## k # &#2392 letter qa
$indic_consonant{"൙"} = "yes"; ## &kline;&hline; # &#2393 letter khha
$indic_consonant{"൚"} = "yes"; ## g&hline; # &#2394 letter ghha
$indic_consonant{"൜"} = "yes"; ## &dcirc; # &#2396; letter dddha
# end malayalam consonants

# gutturals
$funnyaccents{anusvara}{"ക"} = "&ndot;"; # k
$funnyaccents{anusvara}{"ഖ"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"ഗ"} = "&ndot;"; # g
$funnyaccents{anusvara}{"ഘ"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ങ"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"ക"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"ഖ"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"ഗ"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"ഘ"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ങ"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"ച"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"ഛ"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"ജ"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"൛"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"ഝ"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ഞ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"ച"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"ഛ"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"ജ"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"൛"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"ഝ"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ഞ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ട"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"ഠ"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"ഡ"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"ഢ"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"൝"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ണ"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ട"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"ഠ"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"ഡ"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"ഢ"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"൝"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ണ"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"ത"} = "n"; # t
$funnyaccents{anusvara}{"ഥ"} = "n"; # th
$funnyaccents{anusvara}{"ദ"} = "n"; # d
$funnyaccents{anusvara}{"ധ"} = "n"; # dh
$funnyaccents{anusvara}{"ന"} = "n"; # n

$funnyaccents{candrabindu}{"ത"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"ഥ"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"ദ"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"ധ"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"ന"} = "n\x{0310}"; # n

#$funnyaccents{}{"ഩ"} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"പ"} = "m"; # p
$funnyaccents{anusvara}{"ഫ"} = "m"; # ph
#$funnyaccents{anusvara}{"൞"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"ബ"} = "m"; # b
$funnyaccents{anusvara}{"ഭ"} = "m"; # bh
$funnyaccents{anusvara}{"മ"} = "m"; # m

$funnyaccents{anusvara}{others} = "ṃ"; # all others
$funnyaccents{candrabindu}{others} = "m\x{0310}"; # all others

1;
