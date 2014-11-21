package Obliterator;
# gujarati
$isciis{GJR} = {
	"\xa1" => "ઁ",
	"\xa2" => "ં",
	"\xa3" => "ઃ",
	"\xa4" => "અ",
	"\xa5" => "આ",
	"\xa6" => "ઇ",
	"\xa7" => "ઈ",
	"\xa8" => "ઉ",
	"\xa9" => "ઊ",
	"\xaa" => "ઋ",
	"\xab" => "ઍ",
	"\xac" => "એ",
	"\xad" => "ઐ",
#	"\xae" => "ઑ",
	"\xaf" => "ઑ",
	"\xb0" => "ઓ",
	"\xb1" => "ઔ",
#	"\xb2" => "�",
	"\xb3" => "ક",
	"\xb4" => "ખ",
	"\xb5" => "ગ",
	"\xb6" => "ઘ",
	"\xb7" => "ઙ",
	"\xb8" => "ચ",
	"\xb9" => "છ",
	"\xba" => "જ",
	"\xbb" => "ઝ",
	"\xbc" => "ઞ",
	"\xbd" => "ટ",
	"\xbe" => "ઠ",
	"\xbf" => "ડ",
	"\xc0" => "ઢ",
	"\xc1" => "ણ",
	"\xc2" => "ત",
	"\xc3" => "થ",
	"\xc4" => "દ",
	"\xc5" => "ધ",
	"\xc6" => "ન",
#	"\xc7" => "઩",
	"\xc8" => "પ",
	"\xc9" => "ફ",
	"\xca" => "બ",
	"\xcb" => "ભ",
	"\xcc" => "મ",
	"\xcd" => "ય",
#	"\xce" => "
",   # I can't find the jya in unicode
	"\xcf" => "ર",
	"\xd1" => "લ",
	"\xd2" => "ળ",
#	"\xd3" => "઴",
	"\xd4" => "વ",
	"\xd5" => "શ",
	"\xd6" => "ષ",
	"\xd7" => "સ",
	"\xd8" => "હ",
	"\xe9" => "઼",
	"\xda" => "ા",
	"\xdb" => "િ",
	"\xdc" => "ી",
	"\xdd" => "ુ",
	"\xde" => "ૂ",
	"\xdf" => "ૃ",
#	"\x" => "ૄ",   # vocalic RR in ISCII?
	"\xe0" => "ૅ",
#	"\x" => "૆",
	"\xe1" => "ે",
	"\xe2" => "ૈ",
#	"\xe3" => "ૉ",
	"\xe4" => "ૉ",
	"\xe5" => "ો",
	"\xe6" => "ૌ",
#	"\xe7" => "\x{}",
#	"\xe8" => "\x{}",
#	"\xe9" => "\x{}",
	"\xea" => "્",
	"\xa1\xe9" => "ૐ",	# om
	"\xf1" => "૦",
	"\xf2" => "૧",
	"\xf3" => "૨",
	"\xf4" => "૩",
	"\xf5" => "૪",
	"\xf6" => "૫",
	"\xf7" => "૬",
	"\xf8" => "૭",
	"\xf9" => "૮",
	"\xfa" => "૯"
	};


$utf2sgml{"ઁ"} = "***CANDRABINDU***";# chandrabindu
$utf2sgml{"ં"} = "***ANUSVARA***"; # anuswar
$utf2sgml{"ઃ"} = "&htod;"; # visarg
$utf2sgml{"અ"} = "a";
$utf2sgml{"આ"} = "&amacr;";
$utf2sgml{"ઇ"} = "i";

$utf2sgml{"ઈ"} = "&imacr;";
$utf2sgml{"ઉ"} = "u";
$utf2sgml{"ઊ"} = "&umacr;";
$utf2sgml{"ઋ"} = "&rtod;";
$utf2sgml{"ઇ઼"} = ""; # &#2316; letter vocalic l
$utf2sgml{""} = "&ecirc;";
$utf2sgml{""} = "e";
$utf2sgml{"એ"} = "&emacr;";

$utf2sgml{"ઐ"} = "ai";
$utf2sgml{"ઑ"} = "o";
#$utf2sgml{""} = "o";
$utf2sgml{"ઓ"} = "&omacr;";
$utf2sgml{"ઔ"} = "au";
$utf2sgml{"ક"} = "k";
$utf2sgml{"ખ"} = "kh";
$utf2sgml{"ગ"} = "g";

$utf2sgml{"ઘ"} = "gh";
$utf2sgml{"ઙ"} = "&ndot;";
$utf2sgml{"ચ"} = "c";
$utf2sgml{"છ"} = "ch";
$utf2sgml{"જ"} = "j";
$utf2sgml{"જ઼"} = "z"; # &#2395; letter za
$utf2sgml{"ઝ"} = "jh";
$utf2sgml{"ઞ"} = "&ntilde;";
$utf2sgml{"ટ"} = "&ttod;";

$utf2sgml{"ઠ"} = "&ttod;h";
$utf2sgml{"ડ"} = "&dtod;";
$utf2sgml{"ઢ"} = "&dtod;h";
$utf2sgml{"ઢ઼"} = "&dcirc;h"; # &#2397; letter rha
$utf2sgml{"ણ"} = "&ntod;";
$utf2sgml{"ત"} = "t";
$utf2sgml{"થ"} = "th";
$utf2sgml{"દ"} = "d";
$utf2sgml{"ધ"} = "dh";

$utf2sgml{"ન"} = "n";
$utf2sgml{""} = "&nline;";
$utf2sgml{"પ"} = "p";
$utf2sgml{"ફ"} = "ph";
$utf2sgml{"ફ઼"} = "f"; # &#2398; letter fa
$utf2sgml{"બ"} = "b";
$utf2sgml{"ભ"} = "bh";
$utf2sgml{"મ"} = "m";
$utf2sgml{"ય"} = "y";

$utf2sgml{""} = "&ydot;";
$utf2sgml{"ર"} = "r";
$utf2sgml{""} = "&rtod;";
$utf2sgml{"લ"} = "l";
$utf2sgml{""} = "&ltod;";
$utf2sgml{""} = "&zline;";
$utf2sgml{""} = "v";
$utf2sgml{"શ"} = "&sacute;";
$utf2sgml{"ષ"} = "&stod;";

$utf2sgml{"સ"} = "s";
$utf2sgml{"હ"} = "h";
$utf2sgml{""} = ""; # ISCII INVisible -> Unicode ZWJ
$utf2sgml{"ા"} = "&amacr;";
$utf2sgml{"િ"} = "i";

$utf2sgml{"િ઼"} = ""; # &#2402; vowel sign vocalic l
$utf2sgml{"ી"} = "&imacr;";
$utf2sgml{"ી઼"} = ""; # &#2403; vowel sign vocalic ll
$utf2sgml{"ુ"} = "u";
$utf2sgml{"ૂ"} = "&umacr;";
$utf2sgml{"ૃ"} = "&rtod;";
$utf2sgml{"ૃ઼"} = ""; # &#2372; vowel sign vocalic rr
$utf2sgml{""} = "e";
$utf2sgml{"ે"} = "&emacr;";
$utf2sgml{"ૈ"} = "ai";
$utf2sgml{""} = "&ecirc;";
$utf2sgml{""} = "o";
$utf2sgml{"ો"} = "&omacr;";
$utf2sgml{"ૌ"} = "au";
$utf2sgml{""} = "&ocirc;";
$utf2sgml{"્"} = "obm***VIRAMA***obm"; # halant

$utf2sgml{"ઁ઼"} = "om"; # om

$utf2sgml{"ક઼"} = "k"; # &#2392 letter qa
$utf2sgml{"ખ઼"} = "&kline;&hline;"; # &#2393 letter khha
$utf2sgml{"ગ઼"} = "g&hline;"; # &#2394 letter ghha
$utf2sgml{"ડ઼"} = "&dcirc;"; # &#2396; letter dddha

$utf2sgml{"ઋ઼"} = ""; # &#2400; letter vocalic rr
$utf2sgml{"ઈ઼"} = ""; # &#2401; letter vocalic ll
$utf2sgml{""} = "."; # full stop / viram
$utf2sgml{""} = ""; # &#2405; double danda (ARD)

$utf2sgml{"઼"} = "&tod;"; # nukta
$utf2sgml{"઼"} = ""; # &#2365; sign avagraha

$utf2sgml{""} = ""; # &#2386; stress sign anudatta (uses EXT)
$utf2sgml{""} = ""; # &#2416; abbreviation sign (uses EXT)
$utf2sgml{"૦"} = "0";
$utf2sgml{"૧"} = "1";
$utf2sgml{"૨"} = "2";
$utf2sgml{"૩"} = "3";
$utf2sgml{"૪"} = "4";
$utf2sgml{"૫"} = "5";
$utf2sgml{"૬"} = "6";
$utf2sgml{"૭"} = "7";
$utf2sgml{"૮"} = "8";
$utf2sgml{"૯"} = "9";

## gujarati unicode section ends


# gujarati consonants
$indic_consonant{"ક"} = "yes"; ## k
$indic_consonant{"ખ"} = "yes"; ## kh
$indic_consonant{"ગ"} = "yes"; ## g
$indic_consonant{"ઘ"} = "yes"; ## gh
$indic_consonant{"ઙ"} = "yes"; ## &ndot;
$indic_consonant{"ચ"} = "yes"; ## c
$indic_consonant{"છ"} = "yes"; ## ch
$indic_consonant{"જ"} = "yes"; ## j
$indic_consonant{"જ઼"} = "yes"; ## z # &#2395; letter za
$indic_consonant{"ઝ"} = "yes"; ## jh
$indic_consonant{"ઞ"} = "yes"; ## &ntilde;
$indic_consonant{"ટ"} = "yes"; ## &ttod;
$indic_consonant{"ઠ"} = "yes"; ## &ttod;h
$indic_consonant{"ડ"} = "yes"; ## &dtod
$indic_consonant{"ઢ"} = "yes"; ## &dtod;h
$indic_consonant{"ઢ઼"} = "yes"; ## &dcirc;h # &#2397; letter rha
$indic_consonant{"ણ"} = "yes"; ## &ntod;
$indic_consonant{"ત"} = "yes"; ## t
$indic_consonant{"થ"} = "yes"; ## th
$indic_consonant{"દ"} = "yes"; ## d
$indic_consonant{"ધ"} = "yes"; ## dh
$indic_consonant{"ન"} = "yes"; ## n
$indic_consonant{""} = "yes"; ## &nline;
$indic_consonant{"પ"} = "yes"; ## p
$indic_consonant{"ફ"} = "yes"; ## ph
$indic_consonant{"ફ઼"} = "yes"; ## f # &#2398; letter fa
$indic_consonant{"બ"} = "yes"; ## b
$indic_consonant{"ભ"} = "yes"; ## bh
$indic_consonant{"મ"} = "yes"; ## m
$indic_consonant{"ય"} = "yes"; ## y
$indic_consonant{""} = "yes"; ## &ydot;
$indic_consonant{"ર"} = "yes"; ## r
$indic_consonant{""} = "yes"; ## &rtod;
$indic_consonant{"લ"} = "yes"; ## l
$indic_consonant{""} = "yes"; ## &ltod;
$indic_consonant{""} = "yes"; ## &zline;
$indic_consonant{""} = "yes"; ## v
$indic_consonant{"શ"} = "yes"; ## &sacute;
$indic_consonant{"ષ"} = "yes"; ## &stod
$indic_consonant{"સ"} = "yes"; ## s
$indic_consonant{"હ"} = "yes"; ## h
$indic_consonant{"ક઼"} = "yes"; ## k # &#2392 letter qa
$indic_consonant{"ખ઼"} = "yes"; ## &kline;&hline; # &#2393 letter khha
$indic_consonant{"ગ઼"} = "yes"; ## g&hline; # &#2394 letter ghha
$indic_consonant{"ડ઼"} = "yes"; ## &dcirc; # &#2396; letter dddha

# end gujarati consonants

# gutturals
$funnyaccents{anusvara}{"ક"} = "&ndot;"; # k
$funnyaccents{anusvara}{"ખ"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"ગ"} = "&ndot;"; # g
$funnyaccents{anusvara}{"ઘ"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ઙ"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"ક"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"ખ"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"ગ"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"ઘ"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ઙ"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"ચ"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"છ"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"જ"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"જ઼"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"ઝ"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ઞ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"ચ"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"છ"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"જ"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"જ઼"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"ઝ"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ઞ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ટ"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"ઠ"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"ડ"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"ઢ"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"ઢ઼"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ણ"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ટ"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"ઠ"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"ડ"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"ઢ"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"ઢ઼"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ણ"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"ત"} = "n"; # t
$funnyaccents{anusvara}{"થ"} = "n"; # th
$funnyaccents{anusvara}{"દ"} = "n"; # d
$funnyaccents{anusvara}{"ધ"} = "n"; # dh
$funnyaccents{anusvara}{"ન"} = "n"; # n

$funnyaccents{candrabindu}{"ત"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"થ"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"દ"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"ધ"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"ન"} = "n\x{0310}"; # n

#$funnyaccents{}{""} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"પ"} = "m"; # p
$funnyaccents{anusvara}{"ફ"} = "m"; # ph
#$funnyaccents{anusvara}{"ફ઼"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"બ"} = "m"; # b
$funnyaccents{anusvara}{"ભ"} = "m"; # bh
$funnyaccents{anusvara}{"મ"} = "m"; # m

$funnyaccents{anusvara}{"others"} = "ṃ"; # all others
$funnyaccents{candrabindu}{"others"} = "m\x{0310}"; # all others


1;
