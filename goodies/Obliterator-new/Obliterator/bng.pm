package Obliterator;
# bengali
$isciis{BNG} = {
	"\xa1" => "ঁ",
	"\xa2" => "ং",
	"\xa3" => "ঃ",
	"\xa4" => "অ",
	"\xa5" => "আ",
	"\xa6" => "ই",
	"\xa7" => "ঈ",
	"\xa8" => "উ",
	"\xa9" => "ঊ",
	"\xaa" => "ঋ",
#	"\xa6\xe9" => "ঌ",	# &#2316; letter vocalic l
#	"\xab" => "঎",
	"\xac" => "এ",
	"\xad" => "ঐ",
#	"\xae" => "঑",
#	"\xaf" => "঒",
	"\xb0" => "ও",
	"\xb1" => "ঔ",
#	"\xb2" => "�",
	"\xb3" => "ক",
	"\xb4" => "খ",
	"\xb5" => "গ",
	"\xb6" => "ঘ",
	"\xb7" => "ঙ",
	"\xb8" => "চ",
	"\xb9" => "ছ",
	"\xba" => "জ",
	"\xbb" => "ঝ",
	"\xbc" => "ঞ",
	"\xbd" => "ট",
	"\xbe" => "ঠ",
	"\xbf" => "ড",
	"\xc0" => "ঢ",
	"\xc1" => "ণ",
	"\xc2" => "ত",
	"\xc3" => "থ",
	"\xc4" => "দ",
	"\xc5" => "ধ",
	"\xc6" => "ন",
#	"\xc7" => "঩",
	"\xc8" => "প",
	"\xc9" => "ফ",
	"\xca" => "ব",
	"\xcb" => "ভ",
	"\xcc" => "ম",
	"\xcd" => "য়",
	"\xce" => "য",
	"\xcf" => "র",
	"\xd1" => "ল",
#	"\xd2" => "঳",
#	"\xd3" => "঴",
	"\xd4" => "ব",
	"\xd5" => "শ",
	"\xd6" => "ষ",
	"\xd7" => "স",
	"\xd8" => "হ",
#	"\xd9" => "\x{}",
	"\xda" => "া",
	"\xdb" => "ি",
	"\xdc" => "ী",
	"\xdd" => "ু",
	"\xde" => "ূ",
	"\xdf" => "ৃ",
#	"\x?" => "ৄ",	how is long vocalic r encoded in ISCII?
	"\xe1" => "ে",
	"\xe2" => "ৈ",
#	"\xe3" => "৉",
#	"\xe4" => "৊",
	"\xe5" => "ো",
	"\xe6" => "ৌ",
#	"\xe7" => "\x{}",
	"\xe8" => "্",
	"\xe9" => "়",
	"\xea" => "।",	# unicode danda from Devanagari sequence

#	following may be required - 09ce and 09e0 through 09e3

	"\xf1" => "০",
	"\xf2" => "১",
	"\xf3" => "২",
	"\xf4" => "৩",
	"\xf5" => "৪",
	"\xf6" => "৫",
	"\xf7" => "৬",
	"\xf8" => "৭",
	"\xf9" => "৮",
	"\xfa" => "৯"
	};


$utf2sgml{"ঁ"} = "***CANDRABINDU***";# chandrabindu
$utf2sgml{"ং"} = "***ANUSVARA***"; # anuswar
$utf2sgml{"ঃ"} = "&htod;"; # visarg
$utf2sgml{"অ"} = "a";
$utf2sgml{"আ"} = "&amacr;";
$utf2sgml{"ই"} = "i";

$utf2sgml{"ঈ"} = "&imacr;";
$utf2sgml{"উ"} = "u";
$utf2sgml{"ঊ"} = "&umacr;";
$utf2sgml{"ঋ"} = "&rtod;";
$utf2sgml{"ই়"} = ""; # &#2316; letter vocalic l
$utf2sgml{""} = "&ecirc;";
$utf2sgml{""} = "e";
$utf2sgml{"এ"} = "&emacr;";

$utf2sgml{"ঐ"} = "ai";
$utf2sgml{""} = "&ocirc;";
$utf2sgml{""} = "o";
$utf2sgml{"ও"} = "&omacr;";
$utf2sgml{"ঔ"} = "au";
$utf2sgml{"ক"} = "k";
$utf2sgml{"খ"} = "kh";
$utf2sgml{"গ"} = "g";

$utf2sgml{"ঘ"} = "gh";
$utf2sgml{"ঙ"} = "&ndot;";
$utf2sgml{"চ"} = "c";
$utf2sgml{"ছ"} = "ch";
$utf2sgml{"জ"} = "j";
$utf2sgml{"জ়"} = "z"; # &#2395; letter za
$utf2sgml{"ঝ"} = "jh";
$utf2sgml{"ঞ"} = "&ntilde;";
$utf2sgml{"ট"} = "&ttod;";

$utf2sgml{"ঠ"} = "&ttod;h";
$utf2sgml{"ড"} = "&dtod;";
$utf2sgml{"ঢ"} = "&dtod;h";
$utf2sgml{"ঢ়"} = "&dcirc;h"; # &#2397; letter rha
$utf2sgml{"ণ"} = "&ntod;";
$utf2sgml{"ত"} = "t";
$utf2sgml{"থ"} = "th";
$utf2sgml{"দ"} = "d";
$utf2sgml{"ধ"} = "dh";

$utf2sgml{"ন"} = "n";
$utf2sgml{""} = "&nline;";
$utf2sgml{"প"} = "p";
$utf2sgml{"ফ"} = "ph";
$utf2sgml{"ফ়"} = "f"; # &#2398; letter fa
$utf2sgml{"ব"} = "b";
$utf2sgml{"ভ"} = "bh";
$utf2sgml{"ম"} = "m";
$utf2sgml{"য"} = "y";
$utf2sgml{"য়"} = "&#x1e8f;";

$utf2sgml{""} = "&ydot;";
$utf2sgml{"র"} = "r";
$utf2sgml{""} = "&rtod;";
$utf2sgml{"ল"} = "l";
$utf2sgml{""} = "&ltod;";
$utf2sgml{""} = "&zline;";
$utf2sgml{""} = "v";
$utf2sgml{"শ"} = "&sacute;";
$utf2sgml{"ষ"} = "&stod;";

$utf2sgml{"স"} = "s";
$utf2sgml{"হ"} = "h";
$utf2sgml{""} = ""; # ISCII INVisible -> Unicode ZWJ
$utf2sgml{"া"} = "&amacr;";
$utf2sgml{"ি"} = "i";

$utf2sgml{"ি়"} = ""; # &#2402; vowel sign vocalic l
$utf2sgml{"ী"} = "&imacr;";
$utf2sgml{"ী়"} = ""; # &#2403; vowel sign vocalic ll
$utf2sgml{"ু"} = "u";
$utf2sgml{"ূ"} = "&umacr;";
$utf2sgml{"ৃ"} = "&rtod;";
$utf2sgml{"ৃ়"} = ""; # &#2372; vowel sign vocalic rr
$utf2sgml{""} = "e";
$utf2sgml{"ে"} = "&emacr;";
$utf2sgml{"ৈ"} = "ai";
$utf2sgml{""} = "&ecirc;";
$utf2sgml{""} = "o";
$utf2sgml{"ো"} = "&omacr;";
$utf2sgml{"ৌ"} = "au";
$utf2sgml{""} = "&ocirc;";
$utf2sgml{"্"} = "obm***VIRAMA***obm"; # halant

$utf2sgml{"ঁ়"} = "om"; # om

$utf2sgml{"ক়"} = "k"; # &#2392 letter qa
$utf2sgml{"খ়"} = "&kline;&hline;"; # &#2393 letter khha
$utf2sgml{"গ়"} = "g&hline;"; # &#2394 letter ghha
$utf2sgml{"ড়"} = "&dcirc;"; # &#2396; letter dddha

$utf2sgml{"ঋ়"} = ""; # &#2400; letter vocalic rr
$utf2sgml{"ঈ়"} = ""; # &#2401; letter vocalic ll
$utf2sgml{""} = "."; # full stop / viram
$utf2sgml{""} = ""; # &#2405; double danda (ARD)

$utf2sgml{"়"} = "&tod;"; # nukta
$utf2sgml{"়"} = ""; # &#2365; sign avagraha

$utf2sgml{""} = ""; # &#2386; stress sign anudatta (uses EXT)
$utf2sgml{""} = ""; # &#2416; abbreviation sign (uses EXT)
$utf2sgml{"০"} = "0";
$utf2sgml{"১"} = "1";
$utf2sgml{"২"} = "2";
$utf2sgml{"৩"} = "3";
$utf2sgml{"৪"} = "4";
$utf2sgml{"৫"} = "5";
$utf2sgml{"৬"} = "6";
$utf2sgml{"৭"} = "7";
$utf2sgml{"৮"} = "8";
$utf2sgml{"৯"} = "9";

## target-language unicode section ends


# target-language consonants
$indic_consonant{"ক"} = "yes"; ## k
$indic_consonant{"খ"} = "yes"; ## kh
$indic_consonant{"গ"} = "yes"; ## g
$indic_consonant{"ঘ"} = "yes"; ## gh
$indic_consonant{"ঙ"} = "yes"; ## &ndot;
$indic_consonant{"চ"} = "yes"; ## c
$indic_consonant{"ছ"} = "yes"; ## ch
$indic_consonant{"জ"} = "yes"; ## j
$indic_consonant{"জ়"} = "yes"; ## z # &#2395; letter za
$indic_consonant{"ঝ"} = "yes"; ## jh
$indic_consonant{"ঞ"} = "yes"; ## &ntilde;
$indic_consonant{"ট"} = "yes"; ## &ttod;
$indic_consonant{"ঠ"} = "yes"; ## &ttod;h
$indic_consonant{"ড"} = "yes"; ## &dtod
$indic_consonant{"ঢ"} = "yes"; ## &dtod;h
$indic_consonant{"ঢ়"} = "yes"; ## &dcirc;h # &#2397; letter rha
$indic_consonant{"ণ"} = "yes"; ## &ntod;
$indic_consonant{"ত"} = "yes"; ## t
$indic_consonant{"থ"} = "yes"; ## th
$indic_consonant{"দ"} = "yes"; ## d
$indic_consonant{"ধ"} = "yes"; ## dh
$indic_consonant{"ন"} = "yes"; ## n
$indic_consonant{""} = "yes"; ## &nline;
$indic_consonant{"প"} = "yes"; ## p
$indic_consonant{"ফ"} = "yes"; ## ph
$indic_consonant{"ফ়"} = "yes"; ## f # &#2398; letter fa
$indic_consonant{"ব"} = "yes"; ## b
$indic_consonant{"ভ"} = "yes"; ## bh
$indic_consonant{"ম"} = "yes"; ## m
$indic_consonant{"য"} = "yes"; ## y
$indic_consonant{"য়"} = "yes"; ## y with dot above
$indic_consonant{""} = "yes"; ## &ydot;
$indic_consonant{"র"} = "yes"; ## r
$indic_consonant{""} = "yes"; ## &rtod;
$indic_consonant{"ল"} = "yes"; ## l
$indic_consonant{""} = "yes"; ## &ltod;
$indic_consonant{""} = "yes"; ## &zline;
$indic_consonant{""} = "yes"; ## v
$indic_consonant{"শ"} = "yes"; ## &sacute;
$indic_consonant{"ষ"} = "yes"; ## &stod;
$indic_consonant{"স"} = "yes"; ## s
$indic_consonant{"হ"} = "yes"; ## h
$indic_consonant{"ক়"} = "yes"; ## k # &#2392; letter qa
$indic_consonant{"খ়"} = "yes"; ## &kline;&hline; # &#2393; letter khha
$indic_consonant{"গ়"} = "yes"; ## g&hline; # &#2394; letter ghha
$indic_consonant{"ড়"} = "yes"; ## &dcirc; # &#2396; letter dddha

# end target-language consonants

# gutturals
$funnyaccents{anusvara}{"ক"} = "&ndot;"; # k
$funnyaccents{anusvara}{"খ"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"গ"} = "&ndot;"; # g
$funnyaccents{anusvara}{"ঘ"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ঙ"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"ক"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"খ"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"গ"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"ঘ"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ঙ"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"চ"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"ছ"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"জ"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"জ়"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"ঝ"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ঞ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"চ"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"ছ"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"জ"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"জ়"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"ঝ"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ঞ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ট"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"ঠ"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"ড"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"ঢ"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"ঢ়"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ণ"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ট"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"ঠ"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"ড"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"ঢ"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"ঢ়"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ণ"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"ত"} = "n"; # t
$funnyaccents{anusvara}{"থ"} = "n"; # th
$funnyaccents{anusvara}{"দ"} = "n"; # d
$funnyaccents{anusvara}{"ধ"} = "n"; # dh
$funnyaccents{anusvara}{"ন"} = "n"; # n

$funnyaccents{candrabindu}{"ত"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"থ"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"দ"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"ধ"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"ন"} = "n\x{0310}"; # n

#$funnyaccents{}{""} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"প"} = "m"; # p
$funnyaccents{anusvara}{"ফ"} = "m"; # ph
#$funnyaccents{anusvara}{"ফ়"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"ব"} = "m"; # b
$funnyaccents{anusvara}{"ভ"} = "m"; # bh
$funnyaccents{anusvara}{"ম"} = "m"; # m

$funnyaccents{anusvara}{"others"} = "ṃ"; # all others
$funnyaccents{candrabindu}{"others"} = "m\x{0310}"; # all others


1;
