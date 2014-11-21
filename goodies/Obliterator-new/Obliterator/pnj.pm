package Obliterator;
# punjabi/gurmukhi
$isciis{PNJ} = {
#	"\xa1" => "ਁ",	# chandrabindu
#	"\xa1\xe9" => "੐",	# om
	"\xa2" => "ਂ",	# anuswar
	"\xa3" => "ਃ",	# visarg
	"\xa4" => "ਅ",
	"\xa5" => "ਆ",
	"\xa6" => "ਇ",
	"\xa6\xe9" => "਌",	# &#2316; letter vocalic l
	"\xa7" => "ਈ",
	"\xa7\xe9" => "੡",	# &#2401; letter vocalic ll
	"\xa8" => "ਉ",
	"\xa9" => "ਊ",
	"\xaa" => "਋",
	"\xaa\xe9" => "੠",	# &#2400; letter vocalic rr
	"\xab" => "਎",
	"\xac" => "ਏ",
	"\xad" => "ਐ",
	"\xae" => "਍",
	"\xaf" => "਒",
	"\xb0" => "ਓ",
	"\xb1" => "ਔ",
	"\xb2" => "਑",
	"\xb3" => "ਕ",
	"\xb3\xe9" => "੘",	# &#2392 letter qa
	"\xb4" => "ਖ",
	"\xb4\xe9" => "ਖ਼",	# &#2393 letter khha
	"\xb5" => "ਗ",
	"\xb5\xe9" => "ਗ਼",	# &#2394 letter ghha
	"\xb6" => "ਘ",
	"\xb7" => "ਙ",
	"\xb8" => "ਚ",
	"\xb9" => "ਛ",
	"\xba" => "ਜ",
	"\xba\xe9" => "ਜ਼",	# &#2395; letter za
	"\xbb" => "ਝ",
	"\xbc" => "ਞ",
	"\xbd" => "ਟ",
	"\xbe" => "ਠ",
	"\xbf" => "ਡ",
	"\xbf\xe9" => "ੜ",	# &#2396; letter dddha
	"\xc0" => "ਢ",
	"\xc0\xe9" => "੝",	# &#2397; letter rha
	"\xc1" => "ਣ",
	"\xc2" => "ਤ",
	"\xc3" => "ਥ",
	"\xc4" => "ਦ",
	"\xc5" => "ਧ",
	"\xc6" => "ਨ",
#	"\xc7" => "਩",
	"\xc8" => "ਪ",
	"\xc9" => "ਫ",
	"\xc9\xe9" => "ਫ਼",	# &#2398; letter fa
	"\xca" => "ਬ",
	"\xcb" => "ਭ",
	"\xcc" => "ਮ",
	"\xcd" => "ਯ",
	"\xce" => "੟",
	"\xcf" => "ਰ",
#	"\xd0" => "਱",
	"\xd1" => "ਲ",
	"\xd2" => "ਲ਼",
#	"\xd3" => "਴",
	"\xd4" => "ਵ",
	"\xd5" => "ਸ਼",
#	"\xd6" => "਷",
	"\xd7" => "ਸ",
	"\xd8" => "ਹ",
	"\xd9" => "‍",	# ISCII INVisible -> Unicode ZWJ
	"\xda" => "ਾ",
	"\xdb" => "ਿ",
	"\xdb\xe9" => "੢",	# &#2402; vowel sign vocalic l
	"\xdc" => "ੀ",
	"\xdc\xe9" => "੣",	# &#2403; vowel sign vocalic ll
	"\xdd" => "ੁ",
	"\xde" => "ੂ",
	"\xdf" => "੃",
	"\xdf\xe9" => "੄",	# &#2372; vowel sign vocalic rr
	"\xe0" => "੆",
	"\xe1" => "ੇ",
	"\xe2" => "ੈ",
	"\xe3" => "੅",
	"\xe4" => "੊",
	"\xe5" => "ੋ",
	"\xe6" => "ੌ",
	"\xe7" => "੉",
	"\xe8" => "੍",	# halant
	"\xe9" => '\x{0a3c}',	# nukta
	"\xea" => "੍",	# full stop / viram
#	"\xea\xe9" => '\x{0a',	# &#2365; sign avagraha
#	"\xea\xea" => "੥",	# &#2405; double danda (ARD)
	"\xef" => '?',		# attribute
	#"\xf0" => '?',		# extension
	"\xf0\xb8" => "੒",	# &#2386; stress sign anudatta (uses EXT)
	"\xf0\xbf" => "ੰ",	# &#2416; abbreviation sign (uses EXT)
	"\xf1" => "੦",
	"\xf2" => "੧",
	"\xf3" => "੨",
	"\xf4" => "੩",
	"\xf5" => "੪",
	"\xf6" => "੫",
	"\xf7" => "੬",
	"\xf8" => "੭",
	"\xf9" => "੮",
	"\xfa" => "੯",
};

## punjabi/gurmukhi unicode section starts
$utf2sgml{"ਁ"} = "***CANDRABINDU***";# chandrabindu
$utf2sgml{"ਂ"} = "***ANUSVARA***"; # anuswar
$utf2sgml{"ਃ"} = "&htod;"; # visarg
$utf2sgml{"ਅ"} = "a";
$utf2sgml{"ਆ"} = "&amacr;";
$utf2sgml{"ਇ"} = "i";

$utf2sgml{"ਈ"} = "&imacr;";
$utf2sgml{"ਉ"} = "u";
$utf2sgml{"ਊ"} = "&umacr;";
$utf2sgml{"਋"} = "&rtod;";
$utf2sgml{"਌"} = ""; # &#2316; letter vocalic l
$utf2sgml{"਍"} = "&ecirc;";
$utf2sgml{"਎"} = "e";
$utf2sgml{"ਏ"} = "&emacr;";

$utf2sgml{"ਐ"} = "ai";
$utf2sgml{"਑"} = "&ocirc;";
$utf2sgml{"਒"} = "o";
$utf2sgml{"ਓ"} = "&omacr;";
$utf2sgml{"ਔ"} = "au";
$utf2sgml{"ਕ"} = "k";
$utf2sgml{"ਖ"} = "kh";
$utf2sgml{"ਗ"} = "g";

$utf2sgml{"ਘ"} = "gh";
$utf2sgml{"ਙ"} = "&ndot;";
$utf2sgml{"ਚ"} = "c";
$utf2sgml{"ਛ"} = "ch";
$utf2sgml{"ਜ"} = "j";
$utf2sgml{"ਜ਼"} = "z"; # &#2395; letter za
$utf2sgml{"ਝ"} = "jh";
$utf2sgml{"ਞ"} = "&ntilde;";
$utf2sgml{"ਟ"} = "&ttod;";

$utf2sgml{"ਠ"} = "&ttod;h";
$utf2sgml{"ਡ"} = "&dtod;";
$utf2sgml{"ਢ"} = "&dtod;h";
$utf2sgml{"੝"} = "&dcirc;h"; # &#2397; letter rha
$utf2sgml{"ਣ"} = "&ntod;";
$utf2sgml{"ਤ"} = "t";
$utf2sgml{"ਥ"} = "th";
$utf2sgml{"ਦ"} = "d";
$utf2sgml{"ਧ"} = "dh";

$utf2sgml{"ਨ"} = "n";
$utf2sgml{"਩"} = "&nline;";
$utf2sgml{"ਪ"} = "p";
$utf2sgml{"ਫ"} = "ph";
$utf2sgml{"ਫ਼"} = "f"; # &#2398; letter fa
$utf2sgml{"ਬ"} = "b";
$utf2sgml{"ਭ"} = "bh";
$utf2sgml{"ਮ"} = "m";
$utf2sgml{"ਯ"} = "y";

$utf2sgml{"੟"} = "&ydot;";
$utf2sgml{"ਰ"} = "r";
$utf2sgml{"਱"} = "&rtod;";
$utf2sgml{"ਲ"} = "l";
$utf2sgml{"ਲ਼"} = "&ltod;";
$utf2sgml{"਴"} = "&zline;";
$utf2sgml{"ਵ"} = "v";
$utf2sgml{"ਸ਼"} = "&sacute;";
$utf2sgml{"਷"} = "&stod;";

$utf2sgml{"ਸ"} = "s";
$utf2sgml{"ਹ"} = "h";
$utf2sgml{"‍"} = ""; # ISCII INVisible -> Unicode ZWJ
$utf2sgml{"ਾ"} = "&amacr;";
$utf2sgml{"ਿ"} = "i";

$utf2sgml{"੢"} = ""; # &#2402; vowel sign vocalic l
$utf2sgml{"ੀ"} = "&imacr;";
$utf2sgml{"੣"} = ""; # &#2403; vowel sign vocalic ll
$utf2sgml{"ੁ"} = "u";
$utf2sgml{"ੂ"} = "&umacr;";
$utf2sgml{"੃"} = "&rtod;";
$utf2sgml{"੄"} = ""; # &#2372; vowel sign vocalic rr
$utf2sgml{"੆"} = "e";
$utf2sgml{"ੇ"} = "&emacr;";
$utf2sgml{"ੈ"} = "ai";
$utf2sgml{"੅"} = "&ecirc;";
$utf2sgml{"੊"} = "o";
$utf2sgml{"ੋ"} = "&omacr;";
$utf2sgml{"ੌ"} = "au";
$utf2sgml{"੉"} = "&ocirc;";
$utf2sgml{"੍"} = "***VIRAMA***"; # halant

$utf2sgml{"੐"} = "om"; # om

$utf2sgml{"੘"} = "k"; # &#2392 letter qa
$utf2sgml{"ਖ਼"} = "&kline;&hline;"; # &#2393 letter khha
$utf2sgml{"ਗ਼"} = "g&hline;"; # &#2394 letter ghha
$utf2sgml{"ੜ"} = "&dcirc;"; # &#2396; letter dddha

$utf2sgml{"੠"} = ""; # &#2400; letter vocalic rr
$utf2sgml{"੡"} = ""; # &#2401; letter vocalic ll
$utf2sgml{"੤"} = "."; # full stop / viram
$utf2sgml{"੥"} = ""; # &#2405; double danda (ARD)

$utf2sgml{"਼"} = "&tod;"; # nukta
$utf2sgml{"਽"} = ""; # &#2365; sign avagraha

$utf2sgml{"੒"} = ""; # &#2386; stress sign anudatta (uses EXT)
$utf2sgml{"ੰ"} = ""; # &#2416; abbreviation sign (uses EXT)
$utf2sgml{"੦"} = "0";
$utf2sgml{"੧"} = "1";
$utf2sgml{"੨"} = "2";
$utf2sgml{"੩"} = "3";
$utf2sgml{"੪"} = "4";
$utf2sgml{"੫"} = "5";
$utf2sgml{"੬"} = "6";
$utf2sgml{"੭"} = "7";
$utf2sgml{"੮"} = "8";
$utf2sgml{"੯"} = "9";
## punjabi/gurmukhi unicode section ends

# punjabi/gurmukhi consonants
#$indic_consonant{"ਂ"} = "yes"; # anuswar
$indic_consonant{"ਕ"} = "yes"; ## k
$indic_consonant{"ਖ"} = "yes"; ## kh
$indic_consonant{"ਗ"} = "yes"; ## g
$indic_consonant{"ਘ"} = "yes"; ## gh
$indic_consonant{"ਙ"} = "yes"; ## &ndot;
$indic_consonant{"ਚ"} = "yes"; ## c
$indic_consonant{"ਛ"} = "yes"; ## ch
$indic_consonant{"ਜ"} = "yes"; ## j
$indic_consonant{"ਜ਼"} = "yes"; ## z # &#2395; letter za
$indic_consonant{"ਝ"} = "yes"; ## jh
$indic_consonant{"ਞ"} = "yes"; ## &ntilde;
$indic_consonant{"ਟ"} = "yes"; ## &ttod;
$indic_consonant{"ਠ"} = "yes"; ## &ttod;h
$indic_consonant{"ਡ"} = "yes"; ## &dtod
$indic_consonant{"ਢ"} = "yes"; ## &dtod;h
$indic_consonant{"੝"} = "yes"; ## &dcirc;h # &#2397; letter rha
$indic_consonant{"ਣ"} = "yes"; ## &ntod;
$indic_consonant{"ਤ"} = "yes"; ## t
$indic_consonant{"ਥ"} = "yes"; ## th
$indic_consonant{"ਦ"} = "yes"; ## d
$indic_consonant{"ਧ"} = "yes"; ## dh
$indic_consonant{"ਨ"} = "yes"; ## n
$indic_consonant{"਩"} = "yes"; ## &nline;
$indic_consonant{"ਪ"} = "yes"; ## p
$indic_consonant{"ਫ"} = "yes"; ## ph
$indic_consonant{"ਫ਼"} = "yes"; ## f # &#2398; letter fa
$indic_consonant{"ਬ"} = "yes"; ## b
$indic_consonant{"ਭ"} = "yes"; ## bh
$indic_consonant{"ਮ"} = "yes"; ## m
$indic_consonant{"ਯ"} = "yes"; ## y
$indic_consonant{"੟"} = "yes"; ## &ydot;
$indic_consonant{"ਰ"} = "yes"; ## r
$indic_consonant{"਱"} = "yes"; ## &rtod;
$indic_consonant{"ਲ"} = "yes"; ## l
$indic_consonant{"ਲ਼"} = "yes"; ## &ltod;
$indic_consonant{"਴"} = "yes"; ## &zline;
$indic_consonant{"ਵ"} = "yes"; ## v
$indic_consonant{"ਸ਼"} = "yes"; ## &sacute;
$indic_consonant{"਷"} = "yes"; ## &stod
$indic_consonant{"ਸ"} = "yes"; ## s
$indic_consonant{"ਹ"} = "yes"; ## h
$indic_consonant{"੘"} = "yes"; ## k # &#2392 letter qa
$indic_consonant{"ਖ਼"} = "yes"; ## &kline;&hline; # &#2393 letter khha
$indic_consonant{"ਗ਼"} = "yes"; ## g&hline; # &#2394 letter ghha
$indic_consonant{"ੜ"} = "yes"; ## &dcirc; # &#2396; letter dddha
# end punjabi/gurmukhi consonants

# gutturals
$funnyaccents{anusvara}{"ਕ"} = "&ndot;"; # k
$funnyaccents{anusvara}{"ਖ"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"ਗ"} = "&ndot;"; # g
$funnyaccents{anusvara}{"ਘ"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ਙ"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"ਕ"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"ਖ"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"ਗ"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"ਘ"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ਙ"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"ਚ"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"ਛ"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"ਜ"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"ਜ਼"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"ਝ"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ਞ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"ਚ"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"ਛ"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"ਜ"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"ਜ਼"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"ਝ"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ਞ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ਟ"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"ਠ"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"ਡ"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"ਢ"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"੝"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ਣ"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ਟ"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"ਠ"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"ਡ"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"ਢ"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"੝"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ਣ"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"ਤ"} = "n"; # t
$funnyaccents{anusvara}{"ਥ"} = "n"; # th
$funnyaccents{anusvara}{"ਦ"} = "n"; # d
$funnyaccents{anusvara}{"ਧ"} = "n"; # dh
$funnyaccents{anusvara}{"ਨ"} = "n"; # n

$funnyaccents{candrabindu}{"ਤ"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"ਥ"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"ਦ"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"ਧ"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"ਨ"} = "n\x{0310}"; # n

#$funnyaccents{}{"਩"} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"ਪ"} = "m"; # p
$funnyaccents{anusvara}{"ਫ"} = "m"; # ph
#$funnyaccents{anusvara}{"ਫ਼"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"ਬ"} = "m"; # b
$funnyaccents{anusvara}{"ਭ"} = "m"; # bh
$funnyaccents{anusvara}{"ਮ"} = "m"; # m

$funnyaccents{anusvara}{others} = "ṃ"; # all others
$funnyaccents{candrabindu}{others} = "m\x{0310}"; # all others

1;
