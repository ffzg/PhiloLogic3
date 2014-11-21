package Obliterator;
# oriya
$isciis{ORI} = {
	"\xa1" => "ଁ",	# chandrabindu
	"\xa1\xe9" => "୐",	# om
	"\xa2" => "ଂ",	# anuswar
	"\xa3" => "ଃ",	# visarg
	"\xa4" => "ଅ",
	"\xa5" => "ଆ",
	"\xa6" => "ଇ",
	"\xa6\xe9" => "ଌ",	# &#2316; letter vocalic l
	"\xa7" => "ଈ",
	"\xa7\xe9" => "ୡ",	# &#2401; letter vocalic ll
	"\xa8" => "ଉ",
	"\xa9" => "ଊ",
	"\xaa" => "ଋ",
	"\xaa\xe9" => "ୠ",	# &#2400; letter vocalic rr
#	"\xab" => "଎",
	"\xac" => "ଏ",
	"\xad" => "ଐ",
#	"\xae" => "଍",
#	"\xaf" => "଒",
	"\xb0" => "ଓ",
	"\xb1" => "ଔ",
#	"\xb2" => "଑",
	"\xb3" => "କ",
	"\xb3\xe9" => "୘",	# &#2392 letter qa
	"\xb4" => "ଖ",
	"\xb4\xe9" => "୙",	# &#2393 letter khha
	"\xb5" => "ଗ",
	"\xb5\xe9" => "୚",	# &#2394 letter ghha
	"\xb6" => "ଘ",
	"\xb7" => "ଙ",
	"\xb8" => "ଚ",
	"\xb9" => "ଛ",
	"\xba" => "ଜ",
	"\xba\xe9" => "୛",	# &#2395; letter za
	"\xbb" => "ଝ",
	"\xbc" => "ଞ",
	"\xbd" => "ଟ",
	"\xbe" => "ଠ",
	"\xbf" => "ଡ",
	"\xbf\xe9" => "ଡ଼",	# &#2396; letter dddha
	"\xc0" => "ଢ",
	"\xc0\xe9" => "ଢ଼",	# &#2397; letter rha
	"\xc1" => "ଣ",
	"\xc2" => "ତ",
	"\xc3" => "ଥ",
	"\xc4" => "ଦ",
	"\xc5" => "ଧ",
	"\xc6" => "ନ",
#	"\xc7" => "଩",
	"\xc8" => "ପ",
	"\xc9" => "ଫ",
	"\xc9\xe9" => "୞",	# &#2398; letter fa
	"\xca" => "ବ",
	"\xcb" => "ଭ",
	"\xcc" => "ମ",
	"\xcd" => "ଯ",
	"\xce" => "ୟ",
	"\xcf" => "ର",
#	"\xd0" => "଱",
	"\xd1" => "ଲ",
	"\xd2" => "ଳ",
#	"\xd3" => "଴",
	"\xd4" => "ବ", # porter check this: should it be ..35 (no for oriya)
	"\xd5" => "ଶ",
	"\xd6" => "ଷ",
	"\xd7" => "ସ",
	"\xd8" => "ହ",
	"\xd9" => "‍",	# ISCII INVisible -> Unicode ZWJ
	"\xda" => "ା",
	"\xdb" => "ି",
	"\xdb\xe9" => "ୢ",	# &#2402; vowel sign vocalic l
	"\xdc" => "ୀ",
	"\xdc\xe9" => "ୣ",	# &#2403; vowel sign vocalic ll
	"\xdd" => "ୁ",
	"\xde" => "ୂ",
	"\xdf" => "ୃ",
#	"\xdf\xe9" => "ୄ",	# &#2372; vowel sign vocalic rr
#	"\xe0" => "୆",
	"\xe1" => "େ",
	"\xe2" => "ୈ",
#	"\xe3" => "୅",
#	"\xe4" => "୊",
	"\xe5" => "ୋ",
	"\xe6" => "ୌ",
	"\xe7" => "୉",
	"\xe8" => "୍",	# halant
	"\xe9" => '\x{0b3c}',	# nukta
#	"\xea" => "୤",	# full stop / viram
	"\xea\xe9" => '\x{0b3d}',	# &#2365; sign avagraha
#	"\xea\xea" => "୥",	# &#2405; double danda (ARD)
	"\xef" => '?',		# attribute
	#"\xf0" => '?',		# extension
#	"\xf0\xb8" => "୒",	# &#2386; stress sign anudatta (uses EXT)
	"\xf0\xbf" => "୰",	# &#2416; abbreviation sign (uses EXT)
	"\xf1" => "୦",
	"\xf2" => "୧",
	"\xf3" => "୨",
	"\xf4" => "୩",
	"\xf5" => "୪",
	"\xf6" => "୫",
	"\xf7" => "୬",
	"\xf8" => "୭",
	"\xf9" => "୮",
	"\xfa" => "୯",
};

## oriya unicode section starts
$utf2sgml{"ଁ"} = "***CANDRABINDU***";# chandrabindu
$utf2sgml{"ଂ"} = "***ANUSVARA***"; # anuswar
$utf2sgml{"ଃ"} = "&htod;"; # visarg
$utf2sgml{"ଅ"} = "a";
$utf2sgml{"ଆ"} = "&amacr;";
$utf2sgml{"ଇ"} = "i";

$utf2sgml{"ଈ"} = "&imacr;";
$utf2sgml{"ଉ"} = "u";
$utf2sgml{"ଊ"} = "&umacr;";
$utf2sgml{"ଋ"} = "&rtod;";
$utf2sgml{"ଌ"} = ""; # &#2316; letter vocalic l
$utf2sgml{"଍"} = "&ecirc;";
$utf2sgml{"଎"} = "e";
$utf2sgml{"ଏ"} = "&emacr;";

$utf2sgml{"ଐ"} = "ai";
$utf2sgml{"଑"} = "&ocirc;";
$utf2sgml{"଒"} = "o";
$utf2sgml{"ଓ"} = "&omacr;";
$utf2sgml{"ଔ"} = "au";
$utf2sgml{"କ"} = "k";
$utf2sgml{"ଖ"} = "kh";
$utf2sgml{"ଗ"} = "g";

$utf2sgml{"ଘ"} = "gh";
$utf2sgml{"ଙ"} = "&ndot;";
$utf2sgml{"ଚ"} = "c";
$utf2sgml{"ଛ"} = "ch";
$utf2sgml{"ଜ"} = "j";
$utf2sgml{"୛"} = "z"; # &#2395; letter za
$utf2sgml{"ଝ"} = "jh";
$utf2sgml{"ଞ"} = "&ntilde;";
$utf2sgml{"ଟ"} = "&ttod;";

$utf2sgml{"ଠ"} = "&ttod;h";
$utf2sgml{"ଡ"} = "&dtod;";
$utf2sgml{"ଢ"} = "&dtod;h";
$utf2sgml{"ଢ଼"} = "&dcirc;h"; # &#2397; letter rha
$utf2sgml{"ଣ"} = "&ntod;";
$utf2sgml{"ତ"} = "t";
$utf2sgml{"ଥ"} = "th";
$utf2sgml{"ଦ"} = "d";
$utf2sgml{"ଧ"} = "dh";

$utf2sgml{"ନ"} = "n";
$utf2sgml{"଩"} = "&nline;";
$utf2sgml{"ପ"} = "p";
$utf2sgml{"ଫ"} = "ph";
$utf2sgml{"୞"} = "f"; # &#2398; letter fa
$utf2sgml{"ବ"} = "b";
$utf2sgml{"ଭ"} = "bh";
$utf2sgml{"ମ"} = "m";
$utf2sgml{"ଯ"} = "y";

$utf2sgml{"ୟ"} = "&ydot;";
$utf2sgml{"ର"} = "r";
$utf2sgml{"଱"} = "&rtod;";
$utf2sgml{"ଲ"} = "l";
$utf2sgml{"ଳ"} = "&ltod;";
$utf2sgml{"଴"} = "&zline;";
$utf2sgml{"ଵ"} = "v";
$utf2sgml{"ଶ"} = "&sacute;";
$utf2sgml{"ଷ"} = "&stod;";

$utf2sgml{"ସ"} = "s";
$utf2sgml{"ହ"} = "h";
$utf2sgml{"‍"} = ""; # ISCII INVisible -> Unicode ZWJ
$utf2sgml{"ା"} = "&amacr;";
$utf2sgml{"ି"} = "i";

$utf2sgml{"ୢ"} = ""; # &#2402; vowel sign vocalic l
$utf2sgml{"ୀ"} = "&imacr;";
$utf2sgml{"ୣ"} = ""; # &#2403; vowel sign vocalic ll
$utf2sgml{"ୁ"} = "u";
$utf2sgml{"ୂ"} = "&umacr;";
$utf2sgml{"ୃ"} = "&rtod;";
$utf2sgml{"ୄ"} = ""; # &#2372; vowel sign vocalic rr
$utf2sgml{"୆"} = "e";
$utf2sgml{"େ"} = "&emacr;";
$utf2sgml{"ୈ"} = "ai";
$utf2sgml{"୅"} = "&ecirc;";
$utf2sgml{"୊"} = "o";
$utf2sgml{"ୋ"} = "&omacr;";
$utf2sgml{"ୌ"} = "au";
$utf2sgml{"୉"} = "&ocirc;";
$utf2sgml{"୍"} = "***VIRAMA***"; # halant

$utf2sgml{"୐"} = "om"; # om

$utf2sgml{"୘"} = "k"; # &#2392 letter qa
$utf2sgml{"୙"} = "&kline;&hline;"; # &#2393 letter khha
$utf2sgml{"୚"} = "g&hline;"; # &#2394 letter ghha
$utf2sgml{"ଡ଼"} = "&dcirc;"; # &#2396; letter dddha

$utf2sgml{"ୠ"} = ""; # &#2400; letter vocalic rr
$utf2sgml{"ୡ"} = ""; # &#2401; letter vocalic ll
$utf2sgml{"୤"} = "."; # full stop / viram
$utf2sgml{"୥"} = ""; # &#2405; double danda (ARD)

$utf2sgml{"଼"} = "&tod;"; # nukta
$utf2sgml{"ଽ"} = ""; # &#2365; sign avagraha

$utf2sgml{"୒"} = ""; # &#2386; stress sign anudatta (uses EXT)
$utf2sgml{"୰"} = ""; # &#2416; abbreviation sign (uses EXT)
$utf2sgml{"୦"} = "0";
$utf2sgml{"୧"} = "1";
$utf2sgml{"୨"} = "2";
$utf2sgml{"୩"} = "3";
$utf2sgml{"୪"} = "4";
$utf2sgml{"୫"} = "5";
$utf2sgml{"୬"} = "6";
$utf2sgml{"୭"} = "7";
$utf2sgml{"୮"} = "8";
$utf2sgml{"୯"} = "9";
## oriya unicode section ends

# oriya consonants
#$indic_consonant{"ଂ"} = "yes"; # anuswar
$indic_consonant{"କ"} = "yes"; ## k
$indic_consonant{"ଖ"} = "yes"; ## kh
$indic_consonant{"ଗ"} = "yes"; ## g
$indic_consonant{"ଘ"} = "yes"; ## gh
$indic_consonant{"ଙ"} = "yes"; ## &ndot;
$indic_consonant{"ଚ"} = "yes"; ## c
$indic_consonant{"ଛ"} = "yes"; ## ch
$indic_consonant{"ଜ"} = "yes"; ## j
$indic_consonant{"୛"} = "yes"; ## z # &#2395; letter za
$indic_consonant{"ଝ"} = "yes"; ## jh
$indic_consonant{"ଞ"} = "yes"; ## &ntilde;
$indic_consonant{"ଟ"} = "yes"; ## &ttod;
$indic_consonant{"ଠ"} = "yes"; ## &ttod;h
$indic_consonant{"ଡ"} = "yes"; ## &dtod
$indic_consonant{"ଢ"} = "yes"; ## &dtod;h
$indic_consonant{"ଢ଼"} = "yes"; ## &dcirc;h # &#2397; letter rha
$indic_consonant{"ଣ"} = "yes"; ## &ntod;
$indic_consonant{"ତ"} = "yes"; ## t
$indic_consonant{"ଥ"} = "yes"; ## th
$indic_consonant{"ଦ"} = "yes"; ## d
$indic_consonant{"ଧ"} = "yes"; ## dh
$indic_consonant{"ନ"} = "yes"; ## n
$indic_consonant{"଩"} = "yes"; ## &nline;
$indic_consonant{"ପ"} = "yes"; ## p
$indic_consonant{"ଫ"} = "yes"; ## ph
$indic_consonant{"୞"} = "yes"; ## f # &#2398; letter fa
$indic_consonant{"ବ"} = "yes"; ## b
$indic_consonant{"ଭ"} = "yes"; ## bh
$indic_consonant{"ମ"} = "yes"; ## m
$indic_consonant{"ଯ"} = "yes"; ## y
$indic_consonant{"ୟ"} = "yes"; ## &ydot;
$indic_consonant{"ର"} = "yes"; ## r
$indic_consonant{"଱"} = "yes"; ## &rtod;
$indic_consonant{"ଲ"} = "yes"; ## l
$indic_consonant{"ଳ"} = "yes"; ## &ltod;
$indic_consonant{"଴"} = "yes"; ## &zline;
$indic_consonant{"ଵ"} = "yes"; ## v
$indic_consonant{"ଶ"} = "yes"; ## &sacute;
$indic_consonant{"ଷ"} = "yes"; ## &stod
$indic_consonant{"ସ"} = "yes"; ## s
$indic_consonant{"ହ"} = "yes"; ## h
$indic_consonant{"୘"} = "yes"; ## k # &#2392 letter qa
$indic_consonant{"୙"} = "yes"; ## &kline;&hline; # &#2393 letter khha
$indic_consonant{"୚"} = "yes"; ## g&hline; # &#2394 letter ghha
$indic_consonant{"ଡ଼"} = "yes"; ## &dcirc; # &#2396; letter dddha
# end oriya consonants

# gutturals
$funnyaccents{anusvara}{"କ"} = "&ndot;"; # k
$funnyaccents{anusvara}{"ଖ"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"ଗ"} = "&ndot;"; # g
$funnyaccents{anusvara}{"ଘ"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ଙ"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"କ"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"ଖ"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"ଗ"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"ଘ"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ଙ"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"ଚ"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"ଛ"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"ଜ"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"୛"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"ଝ"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ଞ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"ଚ"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"ଛ"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"ଜ"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"୛"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"ଝ"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ଞ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ଟ"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"ଠ"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"ଡ"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"ଢ"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"ଢ଼"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ଣ"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ଟ"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"ଠ"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"ଡ"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"ଢ"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"ଢ଼"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ଣ"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"ତ"} = "n"; # t
$funnyaccents{anusvara}{"ଥ"} = "n"; # th
$funnyaccents{anusvara}{"ଦ"} = "n"; # d
$funnyaccents{anusvara}{"ଧ"} = "n"; # dh
$funnyaccents{anusvara}{"ନ"} = "n"; # n

$funnyaccents{candrabindu}{"ତ"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"ଥ"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"ଦ"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"ଧ"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"ନ"} = "n\x{0310}"; # n

#$funnyaccents{}{"଩"} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"ପ"} = "m"; # p
$funnyaccents{anusvara}{"ଫ"} = "m"; # ph
#$funnyaccents{anusvara}{"୞"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"ବ"} = "m"; # b
$funnyaccents{anusvara}{"ଭ"} = "m"; # bh
$funnyaccents{anusvara}{"ମ"} = "m"; # m

$funnyaccents{anusvara}{others} = "ṃ"; # all others
$funnyaccents{candrabindu}{others} = "m\x{0310}"; # all others

1;
