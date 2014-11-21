# tamil
$Obliterator::isciis{TAM} = {
	"\xa3" => "ஃ",	# visarg
	"\xa4" => "அ",
	"\xa5" => "ஆ",
	"\xa6" => "இ",
	"\xa7" => "ஈ",
	"\xa8" => "உ",
	"\xa9" => "ஊ",
	"\xab" => "எ",
	"\xac" => "ஏ",
	"\xad" => "ஐ",
	"\xaf" => "ஒ",
	"\xb0" => "ஓ",
	"\xb1" => "ஔ",
	"\xb3" => "க",
	"\xb7" => "ங",
	"\xb8" => "ச",
	"\xba" => "ஜ",
	"\xbc" => "ஞ",
	"\xbd" => "ட",
	"\xc1" => "ண",
	"\xc2" => "த",
	"\xc6" => "ந",
	"\xc7" => "ன",
	"\xc8" => "ப",
	"\xcc" => "ம",
	"\xcd" => "ய",
	"\xcf" => "ர",
	"\xd0" => "ற",
	"\xd1" => "ல",
	"\xd2" => "ள",
	"\xd3" => "ழ",
	"\xd4" => "வ",
	"\xd6" => "ஷ",
	"\xd7" => "ஸ",
	"\xd8" => "ஹ",
	"\xda" => "ா",
	"\xdb" => "ி",
	
	"\xdc" => "ீ",
	"\xdd" => "ு",
	"\xde" => "ூ",
	
	"\xe0" => "ெ",
	"\xe1" => "ே",
	"\xe2" => "ை",
	
	"\xe4" => "ொ",
	"\xe5" => "ோ",
	"\xe6" => "ௌ",
	"\xe8" => "்",

	"\xf1" => "௦",
	"\xf2" => "௧",
	"\xf3" => "௨",
	"\xf4" => "௩",
	"\xf5" => "௪",
	"\xf6" => "௫",
	"\xf7" => "௬",
	"\xf8" => "௭",
	"\xf9" => "௮",
	"\xfa" => "௯"
};
# no iscii equivalent for 0x0bf0-0x0bf2 (tamil 10/100/10000)
## tamil unicode section starts
$Obliterator::utf2sgml{"ஂ"} = "obm***ANUSVARA***obm"; # anusvara
$Obliterator::utf2sgml{"ஃ"} = "&htod;"; # visarga
$Obliterator::utf2sgml{"அ"} = "a"; # a
$Obliterator::utf2sgml{"ஆ"} = "&amacr;"; # aa
$Obliterator::utf2sgml{"இ"} = "i"; # i
$Obliterator::utf2sgml{"ஈ"} = "&imacr;"; # ii
$Obliterator::utf2sgml{"உ"} = "u"; # u
$Obliterator::utf2sgml{"ஊ"} = "&umacr;"; # uu
$Obliterator::utf2sgml{"எ"} = "e"; # e
$Obliterator::utf2sgml{"ஏ"} = "&emacr;"; # ee
$Obliterator::utf2sgml{"ஐ"} = "ai"; # ai
$Obliterator::utf2sgml{"ஒ"} = "o"; # o
$Obliterator::utf2sgml{"ஓ"} = "&omacr;"; # oo
$Obliterator::utf2sgml{"ஔ"} = "au"; # au
# these are consonants and I've removed their trailing A's
# (I add the A's later if they're appropriate)
$Obliterator::utf2sgml{"க"} = "k"; # ka
$Obliterator::utf2sgml{"ங"} = "ng"; # nga
$Obliterator::utf2sgml{"ச"} = "c"; # ca
$Obliterator::utf2sgml{"ஜ"} = "j"; # ja
$Obliterator::utf2sgml{"ஞ"} = "&ntilde;"; # nya
$Obliterator::utf2sgml{"ட"} = "&ttod;"; # tta
$Obliterator::utf2sgml{"ண"} = "&ntod;"; # nna
$Obliterator::utf2sgml{"த"} = "t"; # ta
$Obliterator::utf2sgml{"ந"} = "n"; # na
$Obliterator::utf2sgml{"ன"} = "&nline;"; # nnna
$Obliterator::utf2sgml{"ப"} = "p"; # pa
$Obliterator::utf2sgml{"ம"} = "m"; # ma
$Obliterator::utf2sgml{"ய"} = "y"; # ya
$Obliterator::utf2sgml{"ர"} = "r"; # ra
$Obliterator::utf2sgml{"ற"} = "&rline;"; # rra
$Obliterator::utf2sgml{"ல"} = "l"; # la
$Obliterator::utf2sgml{"ள"} = "&ltod;"; # lla
$Obliterator::utf2sgml{"ழ"} = "&zline;"; # llla
$Obliterator::utf2sgml{"வ"} = "v"; # va
$Obliterator::utf2sgml{"ஷ"} = "&stod;"; # ssa
$Obliterator::utf2sgml{"ஸ"} = "s"; # sa
$Obliterator::utf2sgml{"ஹ"} = "h"; # ha
# dependent vowel signs
$Obliterator::utf2sgml{"ா"} = "&amacr;"; # aa
$Obliterator::utf2sgml{"ி"} = "i"; # i
$Obliterator::utf2sgml{"ீ"} = "&imacr;"; # ii
$Obliterator::utf2sgml{"ு"} = "u"; # u
$Obliterator::utf2sgml{"ூ"} = "&umacr;"; # uu
$Obliterator::utf2sgml{"ெ"} = "e"; # e
$Obliterator::utf2sgml{"ே"} = "&emacr;"; # ee
$Obliterator::utf2sgml{"ை"} = "ai"; # ai
$Obliterator::utf2sgml{"ொ"} = "o"; # o
$Obliterator::utf2sgml{"ோ"} = "&omacr;"; # oo
$Obliterator::utf2sgml{"ௌ"} = "au"; # au
$Obliterator::utf2sgml{"்"} = "obm***VIRAMA***obm"; # virama
$Obliterator::utf2sgml{'a'} = "a"; # since I substitute
## tamil unicode section ends


# tamil consonants
$Obliterator::indic_consonant{"க"} = "yes"; # ka
$Obliterator::indic_consonant{"ங"} = "yes"; # nga
$Obliterator::indic_consonant{"ச"} = "yes"; # ca
$Obliterator::indic_consonant{"ஜ"} = "yes"; # ja
$Obliterator::indic_consonant{"ஞ"} = "yes"; # nya
$Obliterator::indic_consonant{"ட"} = "yes"; # tta
$Obliterator::indic_consonant{"ண"} = "yes"; # nna
$Obliterator::indic_consonant{"த"} = "yes"; # ta
$Obliterator::indic_consonant{"ந"} = "yes"; # na
$Obliterator::indic_consonant{"ன"} = "yes"; # nnna
$Obliterator::indic_consonant{"ப"} = "yes"; # pa
$Obliterator::indic_consonant{"ம"} = "yes"; # ma
$Obliterator::indic_consonant{"ய"} = "yes"; # ya
$Obliterator::indic_consonant{"ர"} = "yes"; # ra
$Obliterator::indic_consonant{"ற"} = "yes"; # rra
$Obliterator::indic_consonant{"ல"} = "yes"; # la
$Obliterator::indic_consonant{"ள"} = "yes"; # lla
$Obliterator::indic_consonant{"ழ"} = "yes"; # llla
$Obliterator::indic_consonant{"வ"} = "yes"; # va
$Obliterator::indic_consonant{"ஷ"} = "yes"; # ssa
$Obliterator::indic_consonant{"ஸ"} = "yes"; # sa
$Obliterator::indic_consonant{"ஹ"} = "yes"; # ha
# end tamil consonants


# gutturals
$funnyaccents{anusvara}{"க"} = "&ndot;"; # k
$funnyaccents{anusvara}{"஖"} = "&ndot;"; # kh
$funnyaccents{anusvara}{"஗"} = "&ndot;"; # g
$funnyaccents{anusvara}{"஘"} = "&ndot;"; # gh
$funnyaccents{anusvara}{"ங"} = "&ndot;"; # &ndot;

$funnyaccents{candrabindu}{"க"} = "n\x{0310}"; # k
$funnyaccents{candrabindu}{"஖"} = "n\x{0310}"; # kh
$funnyaccents{candrabindu}{"஗"} = "n\x{0310}"; # g
$funnyaccents{candrabindu}{"஘"} = "n\x{0310}"; # gh
$funnyaccents{candrabindu}{"ங"} = "n\x{0310}"; # &ndot;

# palatals
$funnyaccents{anusvara}{"ச"} = "&ntilde;"; # c
$funnyaccents{anusvara}{"஛"} = "&ntilde;"; # ch
$funnyaccents{anusvara}{"ஜ"} = "&ntilde;"; # j
#$funnyaccents{anusvara}{"ஜ஼"} = "&ntilde;"; # z # &#2395; letter za
$funnyaccents{anusvara}{"஝"} = "&ntilde;"; # jh
$funnyaccents{anusvara}{"ஞ"} = "&ntilde;"; # &ntilde;

$funnyaccents{candrabindu}{"ச"} = "n\x{0310}"; # c
$funnyaccents{candrabindu}{"஛"} = "n\x{0310}"; # ch
$funnyaccents{candrabindu}{"ஜ"} = "n\x{0310}"; # j
#$funnyaccents{candrabindu}{"ஜ஼"} = "n\x{0310}"; # z # &#2395; letter za
$funnyaccents{candrabindu}{"஝"} = "n\x{0310}"; # jh
$funnyaccents{candrabindu}{"ஞ"} = "n\x{0310}"; # &ntilde;

# cerebrals
$funnyaccents{anusvara}{"ட"} = "&ntod;"; # &ttod;
$funnyaccents{anusvara}{"஠"} = "&ntod;"; # &ttod;h
$funnyaccents{anusvara}{"஡"} = "&ntod;"; # &dtod;
$funnyaccents{anusvara}{"஢"} = "&ntod;"; # &dtod;h
#$funnyaccents{anusvara}{"஢஼"} = "&ntod;"; # &dcirc;h # &#2397; letter rha
$funnyaccents{anusvara}{"ண"} = "&ntod;"; # &ntod;

$funnyaccents{candrabindu}{"ட"} = "n\x{0310}"; # &ttod;
$funnyaccents{candrabindu}{"஠"} = "n\x{0310}"; # &ttod;h
$funnyaccents{candrabindu}{"஡"} = "n\x{0310}"; # &dtod;
$funnyaccents{candrabindu}{"஢"} = "n\x{0310}"; # &dtod;h
#$funnyaccents{candrabindu}{"஢஼"} = "n\x{0310}"; # &dcirc;h # &#2397; letter rha
$funnyaccents{candrabindu}{"ண"} = "n\x{0310}"; # &ntod;

# dentals
$funnyaccents{anusvara}{"த"} = "n"; # t
$funnyaccents{anusvara}{"஥"} = "n"; # th
$funnyaccents{anusvara}{"஦"} = "n"; # d
$funnyaccents{anusvara}{"஧"} = "n"; # dh
$funnyaccents{anusvara}{"ந"} = "n"; # n

$funnyaccents{candrabindu}{"த"} = "n\x{0310}"; # t
$funnyaccents{candrabindu}{"஥"} = "n\x{0310}"; # th
$funnyaccents{candrabindu}{"஦"} = "n\x{0310}"; # d
$funnyaccents{candrabindu}{"஧"} = "n\x{0310}"; # dh
$funnyaccents{candrabindu}{"ந"} = "n\x{0310}"; # n

#$funnyaccents{}{""} = "n"; # &nline;

# labials
$funnyaccents{anusvara}{"ப"} = "m"; # p
$funnyaccents{anusvara}{"஫"} = "m"; # ph
#$funnyaccents{anusvara}{"஫஼"} = "m"; # f # &#2398; letter fa
$funnyaccents{anusvara}{"஬"} = "m"; # b
$funnyaccents{anusvara}{"஭"} = "m"; # bh
$funnyaccents{anusvara}{"ம"} = "m"; # m

$funnyaccents{anusvara}{"others"} = "ṃ"; # all others
$funnyaccents{candrabindu}{"others"} = "m\x{0310}"; # all others



1;
