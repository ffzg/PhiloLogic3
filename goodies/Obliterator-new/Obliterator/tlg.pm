package Obliterator;
# telugu
$isciis{TLG} = {
	"\xa1" => "ఁ",	# chandrabindu
#	"\xa1\xe9" => "౐",	# om
	"\xa2" => "ం",	# anuswar
	"\xa3" => "ః",	# visarg
	"\xa4" => "అ",
	"\xa5" => "ఆ",
	"\xa6" => "ఇ",
	"\xa6\xe9" => "ఌ",	# &#2316; letter vocalic l
	"\xa7" => "ఈ",
	"\xa7\xe9" => "ౡ",	# &#2401; letter vocalic ll
	"\xa8" => "ఉ",
	"\xa9" => "ఊ",
	"\xaa" => "ఋ",
	"\xaa\xe9" => "ౠ",	# &#2400; letter vocalic rr
	"\xab" => "ఎ",
	"\xac" => "ఏ",
	"\xad" => "ఐ",
#	"\xae" => "఍",
	"\xaf" => "ఒ",
	"\xb0" => "ఓ",
	"\xb1" => "ఔ",
#	"\xb2" => "఑",
	"\xb3" => "క",
	"\xb3\xe9" => "ౘ",	# &#2392 letter qa
	"\xb4" => "ఖ",
	"\xb4\xe9" => "ౙ",	# &#2393 letter khha
	"\xb5" => "గ",
	"\xb5\xe9" => "ౚ",	# &#2394 letter ghha
	"\xb6" => "ఘ",
	"\xb7" => "ఙ",
	"\xb8" => "చ",
	"\xb9" => "ఛ",
	"\xba" => "జ",
	"\xba\xe9" => "౛",	# &#2395; letter za
	"\xbb" => "ఝ",
	"\xbc" => "ఞ",
	"\xbd" => "ట",
	"\xbe" => "ఠ",
	"\xbf" => "డ",
	"\xbf\xe9" => "౜",	# &#2396; letter dddha
	"\xc0" => "ఢ",
	"\xc0\xe9" => "ౝ",	# &#2397; letter rha
	"\xc1" => "ణ",
	"\xc2" => "త",
	"\xc3" => "థ",
	"\xc4" => "ద",
	"\xc5" => "ధ",
	"\xc6" => "న",
#	"\xc7" => "఩",
	"\xc8" => "ప",
	"\xc9" => "ఫ",
	"\xc9\xe9" => "౞",	# &#2398; letter fa
	"\xca" => "బ",
	"\xcb" => "భ",
	"\xcc" => "మ",
	"\xcd" => "య",
	"\xce" => "౟",
	"\xcf" => "ర",
	"\xd0" => "ఱ",
	"\xd1" => "ల",
	"\xd2" => "ళ",
#	"\xd3" => "ఴ",
	"\xd4" => "వ",
	"\xd5" => "శ",
	"\xd6" => "ష",
	"\xd7" => "స",
	"\xd8" => "హ",
	"\xd9" => "‍",	# ISCII INVisible -> Unicode ZWJ
	"\xda" => "ా",
	"\xdb" => "ి",
	"\xdb\xe9" => "ౢ",	# &#2402; vowel sign vocalic l
	"\xdc" => "ీ",
	"\xdc\xe9" => "ౣ",	# &#2403; vowel sign vocalic ll
	"\xdd" => "ు",
	"\xde" => "ూ",
	"\xdf" => "ృ",
	"\xdf\xe9" => "ౄ",	# &#2372; vowel sign vocalic rr
	"\xe0" => "ె",
	"\xe1" => "ే",
	"\xe2" => "ై",
#	"\xe3" => "౅",
	"\xe4" => "ొ",
	"\xe5" => "ో",
	"\xe6" => "ౌ",
#	"\xe7" => "౉",
	"\xe8" => "్",	# halant
#	"\xe9" => '\x{0c3c}',	# nukta
#	"\xea" => "౤",	# full stop / viram
#	"\xea\xe9" => '\x{0c3d}',	# &#2365; sign avagraha
#	"\xea\xea" => "౥",	# &#2405; double danda (ARD)
	"\xef" => '?',		# attribute
	#"\xf0" => '?',		# extension
#	"\xf0\xb8" => "౒",	# &#2386; stress sign anudatta (uses EXT)
#	"\xf0\xbf" => "౰",	# &#2416; abbreviation sign (uses EXT)
	"\xf1" => "౦",
	"\xf2" => "౧",
	"\xf3" => "౨",
	"\xf4" => "౩",
	"\xf5" => "౪",
	"\xf6" => "౫",
	"\xf7" => "౬",
	"\xf8" => "౭",
	"\xf9" => "౮",
	"\xfa" => "౯",
};

## telugu unicode section starts
$utf2sgml{"ఁ"} = "***CANDRABINDU***";# chandrabindu
$utf2sgml{"ం"} = "***ANUSVARA***"; # anuswar
$utf2sgml{"ః"} = "&htod;"; # visarg
$utf2sgml{"అ"} = "a";
$utf2sgml{"ఆ"} = "&amacr;";
$utf2sgml{"ఇ"} = "i";

$utf2sgml{"ఈ"} = "&imacr;";
$utf2sgml{"ఉ"} = "u";
$utf2sgml{"ఊ"} = "&umacr;";
$utf2sgml{"ఋ"} = "&rtod;";
$utf2sgml{"ఌ"} = ""; # &#2316; letter vocalic l
$utf2sgml{"఍"} = "&ecirc;";
$utf2sgml{"ఎ"} = "e";
$utf2sgml{"ఏ"} = "&emacr;";

$utf2sgml{"ఐ"} = "ai";
$utf2sgml{"఑"} = "&ocirc;";
$utf2sgml{"ఒ"} = "o";
$utf2sgml{"ఓ"} = "&omacr;";
$utf2sgml{"ఔ"} = "au";
$utf2sgml{"క"} = "k";
$utf2sgml{"ఖ"} = "kh";
$utf2sgml{"గ"} = "g";

$utf2sgml{"ఘ"} = "gh";
$utf2sgml{"ఙ"} = "&ndot;";
$utf2sgml{"చ"} = "c";
$utf2sgml{"ఛ"} = "ch";
$utf2sgml{"జ"} = "j";
$utf2sgml{"౛"} = "z"; # &#2395; letter za
$utf2sgml{"ఝ"} = "jh";
$utf2sgml{"ఞ"} = "&ntilde;";
$utf2sgml{"ట"} = "&ttod;";

$utf2sgml{"ఠ"} = "&ttod;h";
$utf2sgml{"డ"} = "&dtod;";
$utf2sgml{"ఢ"} = "&dtod;h";
$utf2sgml{"ౝ"} = "&dcirc;h"; # &#2397; letter rha
$utf2sgml{"ణ"} = "&ntod;";
$utf2sgml{"త"} = "t";
$utf2sgml{"థ"} = "th";
$utf2sgml{"ద"} = "d";
$utf2sgml{"ధ"} = "dh";

$utf2sgml{"న"} = "n";
$utf2sgml{"఩"} = "&nline;";
$utf2sgml{"ప"} = "p";
$utf2sgml{"ఫ"} = "ph";
$utf2sgml{"౞"} = "f"; # &#2398; letter fa
$utf2sgml{"బ"} = "b";
$utf2sgml{"భ"} = "bh";
$utf2sgml{"మ"} = "m";
$utf2sgml{"య"} = "y";

$utf2sgml{"౟"} = "&ydot;";
$utf2sgml{"ర"} = "r";
$utf2sgml{"ఱ"} = "&rtod;";
$utf2sgml{"ల"} = "l";
$utf2sgml{"ళ"} = "&ltod;";
$utf2sgml{"ఴ"} = "&zline;";
$utf2sgml{"వ"} = "v";
$utf2sgml{"శ"} = "&sacute;";
$utf2sgml{"ష"} = "&stod;";

$utf2sgml{"స"} = "s";
$utf2sgml{"హ"} = "h";
$utf2sgml{"‍"} = ""; # ISCII INVisible -> Unicode ZWJ
$utf2sgml{"ా"} = "&amacr;";
$utf2sgml{"ి"} = "i";

$utf2sgml{"ౢ"} = ""; # &#2402; vowel sign vocalic l
$utf2sgml{"ీ"} = "&imacr;";
$utf2sgml{"ౣ"} = ""; # &#2403; vowel sign vocalic ll
$utf2sgml{"ు"} = "u";
$utf2sgml{"ూ"} = "&umacr;";
$utf2sgml{"ృ"} = "&rtod;";
$utf2sgml{"ౄ"} = ""; # &#2372; vowel sign vocalic rr
$utf2sgml{"ె"} = "e";
$utf2sgml{"ే"} = "&emacr;";
$utf2sgml{"ై"} = "ai";
$utf2sgml{"౅"} = "&ecirc;";
$utf2sgml{"ొ"} = "o";
$utf2sgml{"ో"} = "&omacr;";
$utf2sgml{"ౌ"} = "au";
$utf2sgml{"౉"} = "&ocirc;";
$utf2sgml{"్"} = "***VIRAMA***"; # halant

$utf2sgml{"౐"} = "om"; # om

$utf2sgml{"ౘ"} = "k"; # &#2392 letter qa
$utf2sgml{"ౙ"} = "&kline;&hline;"; # &#2393 letter khha
$utf2sgml{"ౚ"} = "g&hline;"; # &#2394 letter ghha
$utf2sgml{"౜"} = "&dcirc;"; # &#2396; letter dddha

$utf2sgml{"ౠ"} = ""; # &#2400; letter vocalic rr
$utf2sgml{"ౡ"} = ""; # &#2401; letter vocalic ll
$utf2sgml{"౤"} = "."; # full stop / viram
$utf2sgml{"౥"} = ""; # &#2405; double danda (ARD)

$utf2sgml{"఼"} = "&tod;"; # nukta
$utf2sgml{"ఽ"} = ""; # &#2365; sign avagraha

$utf2sgml{"౒"} = ""; # &#2386; stress sign anudatta (uses EXT)
$utf2sgml{"౰"} = ""; # &#2416; abbreviation sign (uses EXT)
$utf2sgml{"౦"} = "0";
$utf2sgml{"౧"} = "1";
$utf2sgml{"౨"} = "2";
$utf2sgml{"౩"} = "3";
$utf2sgml{"౪"} = "4";
$utf2sgml{"౫"} = "5";
$utf2sgml{"౬"} = "6";
$utf2sgml{"౭"} = "7";
$utf2sgml{"౮"} = "8";
$utf2sgml{"౯"} = "9";
## telugu unicode section ends

# telugu consonants
#$indic_consonant{"ం"} = "yes"; # anuswar
$indic_consonant{"క"} = "yes"; ## k
$indic_consonant{"ఖ"} = "yes"; ## kh
$indic_consonant{"గ"} = "yes"; ## g
$indic_consonant{"ఘ"} = "yes"; ## gh
$indic_consonant{"ఙ"} = "yes"; ## &ndot;
$indic_consonant{"చ"} = "yes"; ## c
$indic_consonant{"ఛ"} = "yes"; ## ch
$indic_consonant{"జ"} = "yes"; ## j
$indic_consonant{"౛"} = "yes"; ## z # &#2395; letter za
$indic_consonant{"ఝ"} = "yes"; ## jh
$indic_consonant{"ఞ"} = "yes"; ## &ntilde;
$indic_consonant{"ట"} = "yes"; ## &ttod;
$indic_consonant{"ఠ"} = "yes"; ## &ttod;h
$indic_consonant{"డ"} = "yes"; ## &dtod
$indic_consonant{"ఢ"} = "yes"; ## &dtod;h
$indic_consonant{"ౝ"} = "yes"; ## &dcirc;h # &#2397; letter rha
$indic_consonant{"ణ"} = "yes"; ## &ntod;
$indic_consonant{"త"} = "yes"; ## t
$indic_consonant{"థ"} = "yes"; ## th
$indic_consonant{"ద"} = "yes"; ## d
$indic_consonant{"ధ"} = "yes"; ## dh
$indic_consonant{"న"} = "yes"; ## n
$indic_consonant{"఩"} = "yes"; ## &nline;
$indic_consonant{"ప"} = "yes"; ## p
$indic_consonant{"ఫ"} = "yes"; ## ph
$indic_consonant{"౞"} = "yes"; ## f # &#2398; letter fa
$indic_consonant{"బ"} = "yes"; ## b
$indic_consonant{"భ"} = "yes"; ## bh
$indic_consonant{"మ"} = "yes"; ## m
$indic_consonant{"య"} = "yes"; ## y
$indic_consonant{"౟"} = "yes"; ## &ydot;
$indic_consonant{"ర"} = "yes"; ## r
$indic_consonant{"ఱ"} = "yes"; ## &rtod;
$indic_consonant{"ల"} = "yes"; ## l
$indic_consonant{"ళ"} = "yes"; ## &ltod;
$indic_consonant{"ఴ"} = "yes"; ## &zline;
$indic_consonant{"వ"} = "yes"; ## v
$indic_consonant{"శ"} = "yes"; ## &sacute;
$indic_consonant{"ష"} = "yes"; ## &stod
$indic_consonant{"స"} = "yes"; ## s
$indic_consonant{"హ"} = "yes"; ## h
$indic_consonant{"ౘ"} = "yes"; ## k # &#2392 letter qa
$indic_consonant{"ౙ"} = "yes"; ## &kline;&hline; # &#2393 letter khha
$indic_consonant{"ౚ"} = "yes"; ## g&hline; # &#2394 letter ghha
$indic_consonant{"౜"} = "yes"; ## &dcirc; # &#2396; letter dddha
# end telugu consonants

# gutturals
$funnyaccents{anusvara}{"క"} = "&ndot;"; # k
$funnyaccents{anusvara}{"ఖ"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"గ"} = "&ndot;"; # g
$funnyaccents{anusvara}{"ఘ"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ఙ"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"క"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"ఖ"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"గ"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"ఘ"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ఙ"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"చ"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"ఛ"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"జ"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"౛"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"ఝ"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ఞ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"చ"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"ఛ"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"జ"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"౛"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"ఝ"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ఞ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ట"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"ఠ"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"డ"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"ఢ"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"ౝ"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ణ"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ట"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"ఠ"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"డ"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"ఢ"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"ౝ"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ణ"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"త"} = "n"; # t
$funnyaccents{anusvara}{"థ"} = "n"; # th
$funnyaccents{anusvara}{"ద"} = "n"; # d
$funnyaccents{anusvara}{"ధ"} = "n"; # dh
$funnyaccents{anusvara}{"న"} = "n"; # n

$funnyaccents{candrabindu}{"త"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"థ"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"ద"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"ధ"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"న"} = "n\x{0310}"; # n

#$funnyaccents{}{"఩"} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"ప"} = "m"; # p
$funnyaccents{anusvara}{"ఫ"} = "m"; # ph
#$funnyaccents{anusvara}{"౞"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"బ"} = "m"; # b
$funnyaccents{anusvara}{"భ"} = "m"; # bh
$funnyaccents{anusvara}{"మ"} = "m"; # m

$funnyaccents{anusvara}{others} = "ṃ"; # all others
$funnyaccents{candrabindu}{others} = "m\x{0310}"; # all others

1;
