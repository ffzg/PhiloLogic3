package Obliterator;
# kannada
$isciis{KND} = {
#	"\xa1" => "ಁ",
	"\xa2" => "ಂ",
	"\xa3" => "ಃ",
	"\xa4" => "ಅ",
	"\xa5" => "ಆ",
	"\xa6" => "ಇ",
	"\xa7" => "ಈ",
	"\xa8" => "ಉ",
	"\xa9" => "ಊ",
	"\xaa" => "ಋ",
#	"\xab" => "಍",
	"\xac" => "ಏ",
	"\xad" => "ಐ",
	"\xae" => "಑",
	"\xaf" => "಑",
	"\xb0" => "ಓ",
	"\xb1" => "ಔ",
#	"\xb2" => "\x{}",
	"\xb3" => "ಕ",
	"\xb4" => "ಖ",
	"\xb5" => "ಗ",
	"\xb6" => "ಘ",
	"\xb7" => "ಙ",
	"\xb8" => "ಚ",
	"\xb9" => "ಛ",
	"\xba" => "ಜ",
	"\xbb" => "ಝ",
	"\xbc" => "ಞ",
	"\xbd" => "ಟ",
	"\xbe" => "ಠ",
	"\xbf" => "ಡ",
	"\xc0" => "ಢ",
	"\xc1" => "ಣ",
	"\xc2" => "ತ",
	"\xc3" => "ಥ",
	"\xc4" => "ದ",
	"\xc5" => "ಧ",
	"\xc6" => "ನ",
#	"\xc7" => "಩",
	"\xc8" => "ಪ",
	"\xc9" => "ಫ",
	"\xca" => "ಬ",
	"\xcb" => "ಭ",
	"\xcc" => "ಮ",
	"\xcd" => "ಯ",
#	"\xce" => "",   # I can't find the jya in unicode
	"\xcf" => "ರ",
	"\xd1" => "ಲ",
	"\xd2" => "ಳ",
#	"\xd3" => "಴",
	"\xd4" => "ವ",
	"\xd5" => "ಶ",
	"\xd6" => "ಷ",
	"\xd7" => "ಸ",
	"\xd8" => "ಹ",

#	"\xe9" => "಼",
	"\xda" => "ಾ",
	"\xdb" => "ಿ",
	"\xdc" => "ೀ",
	"\xdd" => "ು",
	"\xde" => "ೂ",
	"\xdf" => "ೃ",
#	"\x" => "ೄ",   # vocalic RR in ISCII?
#	"\xe0" => "೅",
	"\xe0" => "ೆ",
	"\xe1" => "ೇ",
	"\xe2" => "ೈ",
#	"\xe3" => "೉",
	"\xe4" => "೉",
	"\xe5" => "ೋ",
	"\xe6" => "ೌ",
#	"\xe7" => "\x{}",
#	"\xe8" => "\x{}",
#	"\xe9" => "\x{}",
	"\xea" => "್",

	"\xf1" => "0",
	"\xf2" => "೧",
	"\xf3" => "೨",
	"\xf4" => "೩",
	"\xf5" => "೪",
	"\xf6" => "೫",
	"\xf7" => "೬",
	"\xf8" => "೭",
	"\xf9" => "೮",
	"\xfa" => "೯"
	};


$utf2sgml{"ಁ"} = "***CANDRABINDU***";# chandrabindu
$utf2sgml{"ಂ"} = "***ANUSVARA***"; # anuswar
$utf2sgml{"ಃ"} = "&htod;"; # visarg
$utf2sgml{"ಅ"} = "a";
$utf2sgml{"ಆ"} = "&amacr;";
$utf2sgml{"ಇ"} = "i";

$utf2sgml{"ಈ"} = "&imacr;";
$utf2sgml{"ಉ"} = "u";
$utf2sgml{"ಊ"} = "&umacr;";
$utf2sgml{"ಋ"} = "&rtod;";
$utf2sgml{"ಇ಼"} = ""; # &#2316; letter vocalic l
$utf2sgml{""} = "&ecirc;";
$utf2sgml{""} = "e";
$utf2sgml{"ಏ"} = "&emacr;";

$utf2sgml{"ಐ"} = "ai";
$utf2sgml{"಑"} = "o";
#$utf2sgml{""} = "o";
$utf2sgml{"ಓ"} = "&omacr;";
$utf2sgml{"ಔ"} = "au";
$utf2sgml{"ಕ"} = "k";
$utf2sgml{"ಖ"} = "kh";
$utf2sgml{"ಗ"} = "g";

$utf2sgml{"ಘ"} = "gh";
$utf2sgml{"ಙ"} = "&ndot;";
$utf2sgml{"ಚ"} = "c";
$utf2sgml{"ಛ"} = "ch";
$utf2sgml{"ಜ"} = "j";
$utf2sgml{"ಜ಼"} = "z"; # &#2395; letter za
$utf2sgml{"ಝ"} = "jh";
$utf2sgml{"ಞ"} = "&ntilde;";
$utf2sgml{"ಟ"} = "&ttod;";

$utf2sgml{"ಠ"} = "&ttod;h";
$utf2sgml{"ಡ"} = "&dtod;";
$utf2sgml{"ಢ"} = "&dtod;h";
$utf2sgml{"ಢ಼"} = "&dcirc;h"; # &#2397; letter rha
$utf2sgml{"ಣ"} = "&ntod;";
$utf2sgml{"ತ"} = "t";
$utf2sgml{"ಥ"} = "th";
$utf2sgml{"ದ"} = "d";
$utf2sgml{"ಧ"} = "dh";

$utf2sgml{"ನ"} = "n";
$utf2sgml{""} = "&nline;";
$utf2sgml{"ಪ"} = "p";
$utf2sgml{"ಫ"} = "ph";
$utf2sgml{"ಫ಼"} = "f"; # &#2398; letter fa
$utf2sgml{"ಬ"} = "b";
$utf2sgml{"ಭ"} = "bh";
$utf2sgml{"ಮ"} = "m";
$utf2sgml{"ಯ"} = "y";

$utf2sgml{""} = "&ydot;";
$utf2sgml{"ರ"} = "r";
$utf2sgml{""} = "&rtod;";
$utf2sgml{"ಲ"} = "l";
$utf2sgml{""} = "&ltod;";
$utf2sgml{""} = "&zline;";
$utf2sgml{""} = "v";
$utf2sgml{"ಶ"} = "&sacute;";
$utf2sgml{"ಷ"} = "&stod;";

$utf2sgml{"ಸ"} = "s";
$utf2sgml{"ಹ"} = "h";
$utf2sgml{""} = ""; # ISCII INVisible -> Unicode ZWJ
$utf2sgml{"ಾ"} = "&amacr;";
$utf2sgml{"ಿ"} = "i";

$utf2sgml{"ಿ಼"} = ""; # &#2402; vowel sign vocalic l
$utf2sgml{"ೀ"} = "&imacr;";
$utf2sgml{"ೀ಼"} = ""; # &#2403; vowel sign vocalic ll
$utf2sgml{"ು"} = "u";
$utf2sgml{"ೂ"} = "&umacr;";
$utf2sgml{"ೃ"} = "&rtod;";
$utf2sgml{"ೃ಼"} = ""; # &#2372; vowel sign vocalic rr
$utf2sgml{""} = "e";
$utf2sgml{"ೇ"} = "&emacr;";
$utf2sgml{"ೈ"} = "ai";
$utf2sgml{""} = "&ecirc;";
$utf2sgml{""} = "o";
$utf2sgml{"ೋ"} = "&omacr;";
$utf2sgml{"ೌ"} = "au";
$utf2sgml{""} = "&ocirc;";
$utf2sgml{"್"} = "obm***VIRAMA***obm"; # halant

$utf2sgml{"ಁ಼"} = "om"; # om

$utf2sgml{"ಕ಼"} = "k"; # &#2392 letter qa
$utf2sgml{"ಖ಼"} = "&kline;&hline;"; # &#2393 letter khha
$utf2sgml{"ಗ಼"} = "g&hline;"; # &#2394 letter ghha
$utf2sgml{"ಡ಼"} = "&dcirc;"; # &#2396; letter dddha

$utf2sgml{"ಋ಼"} = ""; # &#2400; letter vocalic rr
$utf2sgml{"ಈ಼"} = ""; # &#2401; letter vocalic ll
$utf2sgml{""} = "."; # full stop / viram
$utf2sgml{""} = ""; # &#2405; double danda (ARD)

$utf2sgml{"಼"} = "&tod;"; # nukta
$utf2sgml{"಼"} = ""; # &#2365; sign avagraha

$utf2sgml{""} = ""; # &#2386; stress sign anudatta (uses EXT)
$utf2sgml{""} = ""; # &#2416; abbreviation sign (uses EXT)
$utf2sgml{"೦"} = "0";
$utf2sgml{"೧"} = "1";
$utf2sgml{"೨"} = "2";
$utf2sgml{"೩"} = "3";
$utf2sgml{"೪"} = "4";
$utf2sgml{"೫"} = "5";
$utf2sgml{"೬"} = "6";
$utf2sgml{"೭"} = "7";
$utf2sgml{"೮"} = "8";
$utf2sgml{"೯"} = "9";

## kannada unicode section ends


# kannada consonants
$indic_consonant{"ಕ"} = "yes"; ## k
$indic_consonant{"ಖ"} = "yes"; ## kh
$indic_consonant{"ಗ"} = "yes"; ## g
$indic_consonant{"ಘ"} = "yes"; ## gh
$indic_consonant{"ಙ"} = "yes"; ## &ndot;
$indic_consonant{"ಚ"} = "yes"; ## c
$indic_consonant{"ಛ"} = "yes"; ## ch
$indic_consonant{"ಜ"} = "yes"; ## j
$indic_consonant{"ಜ಼"} = "yes"; ## z # &#2395; letter za
$indic_consonant{"ಝ"} = "yes"; ## jh
$indic_consonant{"ಞ"} = "yes"; ## &ntilde;
$indic_consonant{"ಟ"} = "yes"; ## &ttod;
$indic_consonant{"ಠ"} = "yes"; ## &ttod;h
$indic_consonant{"ಡ"} = "yes"; ## &dtod
$indic_consonant{"ಢ"} = "yes"; ## &dtod;h
$indic_consonant{"ಢ಼"} = "yes"; ## &dcirc;h # &#2397; letter rha
$indic_consonant{"ಣ"} = "yes"; ## &ntod;
$indic_consonant{"ತ"} = "yes"; ## t
$indic_consonant{"ಥ"} = "yes"; ## th
$indic_consonant{"ದ"} = "yes"; ## d
$indic_consonant{"ಧ"} = "yes"; ## dh
$indic_consonant{"ನ"} = "yes"; ## n
$indic_consonant{""} = "yes"; ## &nline;
$indic_consonant{"ಪ"} = "yes"; ## p
$indic_consonant{"ಫ"} = "yes"; ## ph
$indic_consonant{"ಫ಼"} = "yes"; ## f # &#2398; letter fa
$indic_consonant{"ಬ"} = "yes"; ## b
$indic_consonant{"ಭ"} = "yes"; ## bh
$indic_consonant{"ಮ"} = "yes"; ## m
$indic_consonant{"ಯ"} = "yes"; ## y
$indic_consonant{""} = "yes"; ## &ydot;
$indic_consonant{"ರ"} = "yes"; ## r
$indic_consonant{""} = "yes"; ## &rtod;
$indic_consonant{"ಲ"} = "yes"; ## l
$indic_consonant{""} = "yes"; ## &ltod;
$indic_consonant{""} = "yes"; ## &zline;
$indic_consonant{""} = "yes"; ## v
$indic_consonant{"ಶ"} = "yes"; ## &sacute;
$indic_consonant{"ಷ"} = "yes"; ## &stod
$indic_consonant{"ಸ"} = "yes"; ## s
$indic_consonant{"ಹ"} = "yes"; ## h
$indic_consonant{"ಕ಼"} = "yes"; ## k # &#2392 letter qa
$indic_consonant{"ಖ಼"} = "yes"; ## &kline;&hline; # &#2393 letter khha
$indic_consonant{"ಗ಼"} = "yes"; ## g&hline; # &#2394 letter ghha
$indic_consonant{"ಡ಼"} = "yes"; ## &dcirc; # &#2396; letter dddha

# end kannada consonants

# gutturals
$funnyaccents{anusvara}{"ಕ"} = "&ndot;"; # k
$funnyaccents{anusvara}{"ಖ"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"ಗ"} = "&ndot;"; # g
$funnyaccents{anusvara}{"ಘ"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ಙ"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"ಕ"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"ಖ"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"ಗ"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"ಘ"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ಙ"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"ಚ"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"ಛ"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"ಜ"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"ಜ಼"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"ಝ"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ಞ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"ಚ"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"ಛ"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"ಜ"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"ಜ಼"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"ಝ"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ಞ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ಟ"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"ಠ"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"ಡ"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"ಢ"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"ಢ಼"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ಣ"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ಟ"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"ಠ"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"ಡ"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"ಢ"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"ಢ಼"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ಣ"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"ತ"} = "n"; # t
$funnyaccents{anusvara}{"ಥ"} = "n"; # th
$funnyaccents{anusvara}{"ದ"} = "n"; # d
$funnyaccents{anusvara}{"ಧ"} = "n"; # dh
$funnyaccents{anusvara}{"ನ"} = "n"; # n

$funnyaccents{candrabindu}{"ತ"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"ಥ"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"ದ"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"ಧ"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"ನ"} = "n\x{0310}"; # n

#$funnyaccents{}{""} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"ಪ"} = "m"; # p
$funnyaccents{anusvara}{"ಫ"} = "m"; # ph
#$funnyaccents{anusvara}{"ಫ಼"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"ಬ"} = "m"; # b
$funnyaccents{anusvara}{"ಭ"} = "m"; # bh
$funnyaccents{anusvara}{"ಮ"} = "m"; # m

$funnyaccents{anusvara}{"others"} = "ṃ"; # all others
$funnyaccents{candrabindu}{"others"} = "m\x{0310}"; # all others


1;
