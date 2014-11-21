package Obliterator;
# devanagari
$isciis{DEV} = {
	"\xa1" => "ँ",	# chandrabindu
	"\xa1\xe9" => "ॐ",	# om
	"\xa2" => "ं",	# anuswar
	"\xa3" => "ः",	# visarg
	"\xa4" => "अ",
	"\xa5" => "आ",
	"\xa6" => "इ",
	"\xa6\xe9" => "ऌ",	# &#2316; letter vocalic l
	"\xa7" => "ई",
	"\xa7\xe9" => "ॡ",	# &#2401; letter vocalic ll
	"\xa8" => "उ",
	"\xa9" => "ऊ",
	"\xaa" => "ऋ",
	"\xaa\xe9" => "ॠ",	# &#2400; letter vocalic rr
	"\xab" => "ऎ",
	"\xac" => "ए",
	"\xad" => "ऐ",
	"\xae" => "ऍ",
	"\xaf" => "ऒ",
	"\xb0" => "ओ",
	"\xb1" => "औ",
	"\xb2" => "ऑ",
	"\xb3" => "क",
	"\xb3\xe9" => "क़",	# &#2392 letter qa
	"\xb4" => "ख",
	"\xb4\xe9" => "ख़",	# &#2393 letter khha
	"\xb5" => "ग",
	"\xb5\xe9" => "ग़",	# &#2394 letter ghha
	"\xb6" => "घ",
	"\xb7" => "ङ",
	"\xb8" => "च",
	"\xb9" => "छ",
	"\xba" => "ज",
	"\xba\xe9" => "ज़",	# &#2395; letter za
	"\xbb" => "झ",
	"\xbc" => "ञ",
	"\xbd" => "ट",
	"\xbe" => "ठ",
	"\xbf" => "ड",
	"\xbf\xe9" => "ड़",	# &#2396; letter dddha
	"\xc0" => "ढ",
	"\xc0\xe9" => "ढ़",	# &#2397; letter rha
	"\xc1" => "ण",
	"\xc2" => "त",
	"\xc3" => "थ",
	"\xc4" => "द",
	"\xc5" => "ध",
	"\xc6" => "न",
	"\xc7" => "ऩ",
	"\xc8" => "प",
	"\xc9" => "फ",
	"\xc9\xe9" => "फ़",	# &#2398; letter fa
	"\xca" => "ब",
	"\xcb" => "भ",
	"\xcc" => "म",
	"\xcd" => "य",
	"\xce" => "य़",
	"\xcf" => "र",
	"\xd0" => "ऱ",
	"\xd1" => "ल",
	"\xd2" => "ळ",
	"\xd3" => "ऴ",
	"\xd4" => "व",
	"\xd5" => "श",
	"\xd6" => "ष",
	"\xd7" => "स",
	"\xd8" => "ह",
	"\xd9" => "‍",	# ISCII INVisible -> Unicode ZWJ
	"\xda" => "ा",
	"\xdb" => "ि",
	"\xdb\xe9" => "ॢ",	# &#2402; vowel sign vocalic l
	"\xdc" => "ी",
	"\xdc\xe9" => "ॣ",	# &#2403; vowel sign vocalic ll
	"\xdd" => "ु",
	"\xde" => "ू",
	"\xdf" => "ृ",
	"\xdf\xe9" => "ॄ",	# &#2372; vowel sign vocalic rr
	"\xe0" => "ॆ",
	"\xe1" => "े",
	"\xe2" => "ै",
	"\xe3" => "ॅ",
	"\xe4" => "ॊ",
	"\xe5" => "ो",
	"\xe6" => "ौ",
	"\xe7" => "ॉ",
	"\xe8" => "्",	# halant
	"\xe9" => "़",	# nukta
	"\xea" => "।",	# full stop / viram
	"\xea\xe9" => "ऽ",	# &#2365; sign avagraha
	"\xea\xea" => "॥",	# &#2405; double danda (ARD)
	"\xef" => '?',		# attribute
	#"\xf0" => '?',		# extension
	"\xf0\xb8" => "॒",	# &#2386; stress sign anudatta (uses EXT)
	"\xf0\xbf" => "॰",	# &#2416; abbreviation sign (uses EXT)
	"\xf1" => "०",
	"\xf2" => "१",
	"\xf3" => "२",
	"\xf4" => "३",
	"\xf5" => "४",
	"\xf6" => "५",
	"\xf7" => "६",
	"\xf8" => "७",
	"\xf9" => "८",
	"\xfa" => "९",
};

## devanagari unicode section starts
$utf2sgml{"ँ"} = "***CANDRABINDU***";# chandrabindu
$utf2sgml{"ं"} = "***ANUSVARA***"; # anuswar
$utf2sgml{"ः"} = "&htod;"; # visarg
$utf2sgml{"अ"} = "a";
$utf2sgml{"आ"} = "&amacr;";
$utf2sgml{"इ"} = "i";

$utf2sgml{"ई"} = "&imacr;";
$utf2sgml{"उ"} = "u";
$utf2sgml{"ऊ"} = "&umacr;";
$utf2sgml{"ऋ"} = "&rtod;";
$utf2sgml{"ऌ"} = ""; # &#2316; letter vocalic l
$utf2sgml{"ऍ"} = "&ecirc;";
$utf2sgml{"ऎ"} = "e";
$utf2sgml{"ए"} = "&emacr;";

$utf2sgml{"ऐ"} = "ai";
$utf2sgml{"ऑ"} = "&ocirc;";
$utf2sgml{"ऒ"} = "o";
$utf2sgml{"ओ"} = "&omacr;";
$utf2sgml{"औ"} = "au";
$utf2sgml{"क"} = "k";
$utf2sgml{"ख"} = "kh";
$utf2sgml{"ग"} = "g";

$utf2sgml{"घ"} = "gh";
$utf2sgml{"ङ"} = "&ndot;";
$utf2sgml{"च"} = "c";
$utf2sgml{"छ"} = "ch";
$utf2sgml{"ज"} = "j";
$utf2sgml{"ज़"} = "z"; # &#2395; letter za
$utf2sgml{"झ"} = "jh";
$utf2sgml{"ञ"} = "&ntilde;";
$utf2sgml{"ट"} = "&ttod;";

$utf2sgml{"ठ"} = "&ttod;h";
$utf2sgml{"ड"} = "&dtod;";
$utf2sgml{"ढ"} = "&dtod;h";
$utf2sgml{"ढ़"} = "&dcirc;h"; # &#2397; letter rha
$utf2sgml{"ण"} = "&ntod;";
$utf2sgml{"त"} = "t";
$utf2sgml{"थ"} = "th";
$utf2sgml{"द"} = "d";
$utf2sgml{"ध"} = "dh";

$utf2sgml{"न"} = "n";
$utf2sgml{"ऩ"} = "&nline;";
$utf2sgml{"प"} = "p";
$utf2sgml{"फ"} = "ph";
$utf2sgml{"फ़"} = "f"; # &#2398; letter fa
$utf2sgml{"ब"} = "b";
$utf2sgml{"भ"} = "bh";
$utf2sgml{"म"} = "m";
$utf2sgml{"य"} = "y";

$utf2sgml{"य़"} = "&ydot;";
$utf2sgml{"र"} = "r";
$utf2sgml{"ऱ"} = "&rtod;";
$utf2sgml{"ल"} = "l";
$utf2sgml{"ळ"} = "&ltod;";
$utf2sgml{"ऴ"} = "&zline;";
$utf2sgml{"व"} = "v";
$utf2sgml{"श"} = "&sacute;";
$utf2sgml{"ष"} = "&stod;";

$utf2sgml{"स"} = "s";
$utf2sgml{"ह"} = "h";
$utf2sgml{"‍"} = ""; # ISCII INVisible -> Unicode ZWJ
$utf2sgml{"ा"} = "&amacr;";
$utf2sgml{"ि"} = "i";

$utf2sgml{"ॢ"} = ""; # &#2402; vowel sign vocalic l
$utf2sgml{"ी"} = "&imacr;";
$utf2sgml{"ॣ"} = ""; # &#2403; vowel sign vocalic ll
$utf2sgml{"ु"} = "u";
$utf2sgml{"ू"} = "&umacr;";
$utf2sgml{"ृ"} = "&rtod;";
$utf2sgml{"ॄ"} = ""; # &#2372; vowel sign vocalic rr
$utf2sgml{"ॆ"} = "e";
$utf2sgml{"े"} = "&emacr;";
$utf2sgml{"ै"} = "ai";
$utf2sgml{"ॅ"} = "&ecirc;";
$utf2sgml{"ॊ"} = "o";
$utf2sgml{"ो"} = "&omacr;";
$utf2sgml{"ौ"} = "au";
$utf2sgml{"ॉ"} = "&ocirc;";
$utf2sgml{"्"} = "***VIRAMA***"; # halant

$utf2sgml{"ॐ"} = "om"; # om

$utf2sgml{"क़"} = "k"; # &#2392 letter qa
$utf2sgml{"ख़"} = "&kline;&hline;"; # &#2393 letter khha
$utf2sgml{"ग़"} = "g&hline;"; # &#2394 letter ghha
$utf2sgml{"ड़"} = "&dcirc;"; # &#2396; letter dddha

$utf2sgml{"ॠ"} = ""; # &#2400; letter vocalic rr
$utf2sgml{"ॡ"} = ""; # &#2401; letter vocalic ll
$utf2sgml{"।"} = "."; # full stop / viram
$utf2sgml{"॥"} = ""; # &#2405; double danda (ARD)

$utf2sgml{"़"} = "&tod;"; # nukta
$utf2sgml{"ऽ"} = ""; # &#2365; sign avagraha

$utf2sgml{"॒"} = ""; # &#2386; stress sign anudatta (uses EXT)
$utf2sgml{"॰"} = ""; # &#2416; abbreviation sign (uses EXT)
$utf2sgml{"०"} = "0";
$utf2sgml{"१"} = "1";
$utf2sgml{"२"} = "2";
$utf2sgml{"३"} = "3";
$utf2sgml{"४"} = "4";
$utf2sgml{"५"} = "5";
$utf2sgml{"६"} = "6";
$utf2sgml{"७"} = "7";
$utf2sgml{"८"} = "8";
$utf2sgml{"९"} = "9";
## devanagari unicode section ends

# devanagari consonants
#$indic_consonant{"ं"} = "yes"; # anuswar
$indic_consonant{"क"} = "yes"; ## k
$indic_consonant{"ख"} = "yes"; ## kh
$indic_consonant{"ग"} = "yes"; ## g
$indic_consonant{"घ"} = "yes"; ## gh
$indic_consonant{"ङ"} = "yes"; ## &ndot;
$indic_consonant{"च"} = "yes"; ## c
$indic_consonant{"छ"} = "yes"; ## ch
$indic_consonant{"ज"} = "yes"; ## j
$indic_consonant{"ज़"} = "yes"; ## z # &#2395; letter za
$indic_consonant{"झ"} = "yes"; ## jh
$indic_consonant{"ञ"} = "yes"; ## &ntilde;
$indic_consonant{"ट"} = "yes"; ## &ttod;
$indic_consonant{"ठ"} = "yes"; ## &ttod;h
$indic_consonant{"ड"} = "yes"; ## &dtod
$indic_consonant{"ढ"} = "yes"; ## &dtod;h
$indic_consonant{"ढ़"} = "yes"; ## &dcirc;h # &#2397; letter rha
$indic_consonant{"ण"} = "yes"; ## &ntod;
$indic_consonant{"त"} = "yes"; ## t
$indic_consonant{"थ"} = "yes"; ## th
$indic_consonant{"द"} = "yes"; ## d
$indic_consonant{"ध"} = "yes"; ## dh
$indic_consonant{"न"} = "yes"; ## n
$indic_consonant{"ऩ"} = "yes"; ## &nline;
$indic_consonant{"प"} = "yes"; ## p
$indic_consonant{"फ"} = "yes"; ## ph
$indic_consonant{"फ़"} = "yes"; ## f # &#2398; letter fa
$indic_consonant{"ब"} = "yes"; ## b
$indic_consonant{"भ"} = "yes"; ## bh
$indic_consonant{"म"} = "yes"; ## m
$indic_consonant{"य"} = "yes"; ## y
$indic_consonant{"य़"} = "yes"; ## &ydot;
$indic_consonant{"र"} = "yes"; ## r
$indic_consonant{"ऱ"} = "yes"; ## &rtod;
$indic_consonant{"ल"} = "yes"; ## l
$indic_consonant{"ळ"} = "yes"; ## &ltod;
$indic_consonant{"ऴ"} = "yes"; ## &zline;
$indic_consonant{"व"} = "yes"; ## v
$indic_consonant{"श"} = "yes"; ## &sacute;
$indic_consonant{"ष"} = "yes"; ## &stod
$indic_consonant{"स"} = "yes"; ## s
$indic_consonant{"ह"} = "yes"; ## h
$indic_consonant{"क़"} = "yes"; ## k # &#2392 letter qa
$indic_consonant{"ख़"} = "yes"; ## &kline;&hline; # &#2393 letter khha
$indic_consonant{"ग़"} = "yes"; ## g&hline; # &#2394 letter ghha
$indic_consonant{"ड़"} = "yes"; ## &dcirc; # &#2396; letter dddha
# end devanagari consonants

# gutturals
$funnyaccents{anusvara}{"क"} = "&ndot;"; # k
$funnyaccents{anusvara}{"ख"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"ग"} = "&ndot;"; # g
$funnyaccents{anusvara}{"घ"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ङ"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"क"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"ख"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"ग"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"घ"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ङ"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"च"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"छ"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"ज"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"ज़"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"झ"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ञ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"च"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"छ"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"ज"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"ज़"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"झ"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ञ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ट"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"ठ"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"ड"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"ढ"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"ढ़"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ण"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ट"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"ठ"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"ड"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"ढ"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"ढ़"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ण"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"त"} = "n"; # t
$funnyaccents{anusvara}{"थ"} = "n"; # th
$funnyaccents{anusvara}{"द"} = "n"; # d
$funnyaccents{anusvara}{"ध"} = "n"; # dh
$funnyaccents{anusvara}{"न"} = "n"; # n

$funnyaccents{candrabindu}{"त"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"थ"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"द"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"ध"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"न"} = "n\x{0310}"; # n

#$funnyaccents{}{"ऩ"} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"प"} = "m"; # p
$funnyaccents{anusvara}{"फ"} = "m"; # ph
#$funnyaccents{anusvara}{"फ़"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"ब"} = "m"; # b
$funnyaccents{anusvara}{"भ"} = "m"; # bh
$funnyaccents{anusvara}{"म"} = "m"; # m

$funnyaccents{anusvara}{others} = "ṃ"; # all others
$funnyaccents{candrabindu}{others} = "m\x{0310}"; # all others

1;
