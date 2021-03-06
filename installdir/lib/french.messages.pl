#!/usr/bin/perl

$philomessage[0] = "Veuillez vous addresser à $ERRORCONTACT";
$philomessage[1] = "Attention: Accès aux recherches passées n'est pas configuré.";
$philomessage[2] = "Attention: Le dossier de recherches récentes ne se trouve pas.";
$philomessage[3] = "L'opérateur <b>BUTNOT</b> doit se suivre d'un mot ou d'une expression.";
$philomessage[4] = "L'opérateur <b>NOT</b> n'est pas configuré en ce moment. L'opérateur <b>NOT</b> est utilisé pour les recherches avec un nombre de mots limité.";
$philomessage[5] = "Syntaxe invalide: %s";
$philomessage[6] = "L'opérateur <b>!</b> ne peut se suivre d'une espace.";
$philomessage[7] = "Si vous sélectionnez le format d'affichage Collocation, vous devez rechercher un mot et un seul. Vous ne pouvez rechercher ni une expression, ni un groupe de mots.";
$philomessage[8] = "Si vous sélectionnez le format d'affichage KWIC, vous devez rechercher un mot et un seul. Vous ne pouvez rechercher ni une expression, ni un groupe de mots.";
$philomessage[9] = "Si vous sélectionnez le format d'affichage Clause Position, vous devez rechercher un mot et un seul. Vous ne pouvez rechercher ni une expression, ni un groupe de mots.";
$philomessage[10] = "Des résultats trouvés pour recherches de divindex et subdivindex.";
$philomessage[11] = "Cela n'est pas possible en ce moment.";
$philomessage[12] = "Veuillez reformuler votre recherche pour un seul niveau.";
$philomessage[13] = "Les opérateurs NOT et AND ne sont pas valables pour des recherches au niveau SubDiv."; 
$philomessage[14] = "Veuillez ne pas mettre <b>not</b> et <b>and</b> en majuscules si vous voulez les chercher directement.";
$philomessage[15]  = "si vous voudriez voir cela inclu comme fonctionnement.";
$philomessage[16] = "Les opérateurs NOT et AND ne sont pas valables pour des recherches au niveau Div.";
$philomessage[17] = "Caractère invalide dans docid: %d";
$philomessage[18] = "Corpus installé sans SQL.";
$philomessage[19] = "Parcourage de termes de recherche n'est pas configuré.";
$philomessage[20] = "Recherche au niveau DIV n'est pas configurée.";
$philomessage[21] = "Recherche au niveau SubDIV n'est pas configurée.";
$philomessage[22] = "Chercher <b>%s</b> dans tout le corpus.";
$philomessage[23] = "%d objet(s) trouvé(s).";
$philomessage[24] = "Aucun objet trouvé.";
$philomessage[25] = "Chercher <b>%s</b> dans les documents sélectionnés.";
$philomessage[26] = "<tt>%d</tt> document(s) trouvé(s). ";
$philomessage[27] = "Aucun document ne correspond à vos critères de recherche.";
$philomessage[28] = "<strong>Remarque</strong>: assurez-vous que vous n'avez saisi ni espace superflue, ni tiret ou caractère accentué.";
$philomessage[29] = "Il faut au moins un critère de recherche.";
$philomessage[30] = "Critères de recherche: <b>%d</b> documents; mot-clé:  <b>%s</b>.";
$philomessage[31] = "Chercher";
$philomessage[32] = "dans les parties specifiées de";
$philomessage[33] = "Chercher tout le corpus";
$philomessage[34] = "Chercher <b>%s</b> dans tout le corpus";
$philomessage[35] = "Chercher les objets specifiés: <b>%s</b>.";
$philomessage[36] = "Erreur interne";
$philomessage[37] = "divindex.raw ne se trouve pas.";
$philomessage[38] = "subdivindex.raw ne se trouve pas.";
$philomessage[39] = "Aucun SUBDIV trouvé...";
$philomessage[40] = "Aucun mot trouvé pour vos critères.";
$philomessage[41] = "<b>Attention:</b> veuillez vous assurer que votre recherche ne contient aucune ponctuation.";
$philomessage[42] = "Veuillez prendre en compte les accents. (E5)";
$philomessage[43] = "La liste des mots dépasse la limite de %d mots.";
$philomessage[44] = "Cette limite est nécessaire pour arrêter une recherche qui peut prendre trop de temps. La limite peut être changée par le responsable du site. Veuillez vous addresser à $ERRORCONTACT pour faire un tel changement.";
$philomessage[45] = "Votre expression s'augmente à <tt>%d</tt> critères de recherche:";
$philomessage[46] = "Erreur PhiloLogic Nserver: %s";
$philomessage[47] = "Le Daemon Recherche PhiloLogic s'est peut-être arrêté ou ne s'était pas bien demarré.";
$philomessage[48] = "connexion: %s";
$philomessage[49] = "Vous vouliez peut-être dire:";
$philomessage[50] = "Recherche de similarités n'est pas installée (agrep).";
$philomessage[51] = "Veuillez taper un mot dans le champ 'Chercher dans les Textes' pour faire une recherche de similarités.";
$philomessage[52] = "Un mot doit contenir au moins 5 lettres pour une recherche de similarités.";
$philomessage[53] = "Veuillez utiliser un seul mot pour une recherche de similarités.";
$philomessage[54] = "Veuillez utiliser seulement des lettres pour une recherche de similarités (ça veut dire pas de chiffres, de ponctuation, etc).";
$philomessage[55] = "<b>%d resultat(s) trouvé(s)</b>, affiché(s) selon la fréquence dans tous les documents.";
$philomessage[56] = "<p>Veuillez choisir des mots pour faire une recherche dans tous les documents.";
$philomessage[57] = "Veuillez choisir les options d'affichage et des critères bibliographiques ci-dessous.";
$philomessage[58] = "Aucun résultat de similarité pour %s";
$philomessage[59] = "Option invalide: cette installation n'a pas été configurée avec SQL.";
$philomessage[60] = "Liste des termes de recherche disponsibles pour %s";
$philomessage[61] = "avec les critères bibliographiques suivants: %s.";
$philomessage[62] = "dans tous les documents.";
$philomessage[63] = "La liste donne la fréquence de chaque terme.";
$philomessage[64] = "Aucun terme de recherche ne correspond à vos critères.";
$philomessage[65] = "Impossible d'ouvrir le fichier histoire de recherche.";
$philomessage[66] = "Veuillez vous addresser au responsible du site.";
$philomessage[67] = "genre";
$philomessage[68] = "nombre de mots";
$philomessage[69] = "Note";
$philomessage[70] = "retourner à";
$philomessage[71] = "Erreur de lien";
$philomessage[72] = "Article";
$philomessage[73] = "SubSect";
$philomessage[74] = "Sub2Sect";
$philomessage[75] = "page";
$philomessage[76] = "Table de Matières";
$philomessage[77] = "Chercher";
$philomessage[78] = "Choisir les parties du document dans lesquelles vous voulez faire votre recherche";
$philomessage[79] = "Faire une recherche dans ces documents pour";
$philomessage[80] = "profondeur";
$philomessage[81] = "e.g.";
$philomessage[82] = "Vous pouvez limiter votre recherche par les champs suivants";
$philomessage[83] = "Auteur";
$philomessage[84] = "zola";
$philomessage[85] = "Titre";
$philomessage[86] = "histoire";
$philomessage[87] = "Date";
$philomessage[88] = "sélectionner un format de résultats";
$philomessage[89] = "Résultats de recherche raffinée";
$philomessage[90] = "Occurrences en contexte ";
$philomessage[91] = "le défaut";
$philomessage[92] = "Appuyer";
$philomessage[93] = "pour enlever les titres";
$philomessage[94] = "Table de collocation";
$philomessage[95] = "A Travers";
$philomessage[96] = "mots";
$philomessage[97] = "Enlever le filtre";
$philomessage[98] = "Position de mot dans la phrase";
$philomessage[99] = "Theme-Rheme";
$philomessage[100] = "Options d'affichage";
$philomessage[101] = "Uniquement début de la phrase";
$philomessage[102] = "Début et fin";
$philomessage[103] = "Début, fin, milieu";
$philomessage[104] = "Rapport complet";
$philomessage[105] = "Similarités de mot";
$philomessage[106] = "Si vous tapez <i>Charlemagne</i>, vous trouverez Charlemange, Charlamagne, etc.";
$philomessage[107] = "Le mot doit conentir au moins 5 caractères";
$philomessage[108] = "Faire une recherche dans les documents pour";
$philomessage[109] = "Faire une recherche dans les documents sélectionnés.";
$philomessage[110] = "Les résultats de recherche raffiné sont disponibles en bas de la page.";
$philomessage[111] = "Occurrences";
$philomessage[112] = "sélectionner une option de recherche";
$philomessage[113] = "Terme de recherche unique et phrase";
$philomessage[114] = "Phrase séparée par";
$philomessage[115] = "ou moins";
$philomessage[116] = "exactement";
$philomessage[117] = "recherche de proximité dans la même phrase ou";
$philomessage[118] = "dans le même paragraphe";
$philomessage[119] = "Dernier";
$philomessage[120] = "Premier";
$philomessage[121] = "Pour chercher un mot dans un dictionnaire, veuillez sélectionner le mot avec le souris et appuyer sur la lettre 'd' sur votre clavier.";
$philomessage[122] = "Contexte";
$philomessage[123] = "Option invalide: ce site n'a pas été installé avec SQL pour les SubDocument.";
$philomessage[124] = "La liste des termes de recherche disponibles pour";
$philomessage[125] = "avec les critères bibiographiques";
$philomessage[126] = "La liste donne la fréquence de chaque terme.";
$philomessage[127] = "Mot-clé";
$philomessage[128] = "Droite";
$philomessage[129] = "Gauche";
$philomessage[130] = "PubPlace";
$philomessage[131] = "Assortir les résultats par";
$philomessage[132] = "Note prise de la page";
$philomessage[133] = "ERREUR";
$philomessage[134] = "pas de reftable";
$philomessage[135] = "en train de lire le reftable";
$philomessage[136] = "pas de lien";
# end robert, begin russ
# latest messages for philohistory.pl

$philomessage[137] = "sélectionner une option de recherche";
$philomessage[138] = "Terme de recherche unique et phrase (le défaut)";
$philomessage[139] = "Phrase séparée par";
$philomessage[140] = "Recherche de proximité dans la même phrase ou ";
$philomessage[141] = "dans le même paragraphe";
$philomessage[142] = "Sélectionner un format de résultats";
$philomessage[143] = "Occurrences en contexte (le défaut)";
$philomessage[144] = "Occurrences ligne-par-ligne";
$philomessage[145] = "Fréquence par titre";
$philomessage[146] = "Fréquence par titre sur 10,000";
$philomessage[147] = "Fréquence par auteur";
$philomessage[148] = "Fréquence par auteur sur 10,000";
$philomessage[149] = "Appuyer %s pour enlever les titres";
$philomessage[150] = "Fréquence par an";
$philomessage[151] = "Fréquence par an sur 10,000";
$philomessage[152] = "sélectionner une période";
$philomessage[153] = "An";
$philomessage[154] = "Décennie";
$philomessage[155] = "Quart de siècle";
$philomessage[156] = "Demi-siècle";
$philomessage[157] = "Sìecle";
$philomessage[158] = "Appuyer %s pour enlever les titres";
$philomessage[159] = "Table de collocation à travers %s mots";
$philomessage[160] = "Enlever le filtre";
$philomessage[161] = "Position de mot dans la phrase (Theme-Rheme)";
$philomessage[162] = "Uniquement début de la phrase";
$philomessage[163] = "Début et fin";
$philomessage[164] = "Début, fin, milieu";
$philomessage[165] = "Rapport complet";
$philomessage[166] = "Options d'affichage";
$philomessage[167] = "Histoire de recherche PhiloLogic";
$philomessage[168] = "Retourner à %s formulaire de recherche";
$philomessage[169] = "Site actionné par PhiloLogic";

# russ's original messages

$philomessage[170] = "<p><b>Erreur Interne Possible</b>: La recherche a surpassé la limite du temps: %s seconds.  Veuillez refaire la recherche. Si le problème persiste, veuillez vous addresser à $ERRORCONTACT avec les détails de la recherche.";
$philomessage[171] = "Erreur Interne";
$philomessage[172] = "Veuillez refaire votre recherche avec des limites bibliographiques ou avec moins de mots très fréquents. Ce problème sera corrigé dans la version prochaine de Philologic.";
$philomessage[173] = "<h2>Rien trouvé qui comporte aux critères de recherche</h2> <b>Attention:</b> soyez sûr de ne pas utiliser la ponctuation dans vos critères de recherche. Rappellez-vous que les accents doivent être pris en compte.";
$philomessage[174] = "Limite de memoire excédée. Le logiciel va s'arrêter.";
$philomessage[175] = "Faute de segmentation.";
$philomessage[176] = "Votre recherche a trouvé <b>%s</b> occurrence(s)<p>\n";
$philomessage[177] = "Appuyer ici pour un rapport \u%s\l ";
$philomessage[178] = "<b>Cette page ne liste que le premier 25 occurrences. Veuillez suivre les liens ci-dessous pour voir les autres résultats.</b>";
$philomessage[179] = "<hr>La recherche est toujours en cours. <b>%s</b> occurrences sont déjà trouvées (veuillez suivre les liens ci-dessous pour voir le progrès).<p>\n";	    
$philomessage[180] = "résultats additionnels (en groupes de %s)";
$philomessage[181] = "Obtenir toutes les occurrences";
$philomessage[182] = " (Ça peut prendre un peu de temps pour télélcharger)";
$philomessage[183] = "progrès de recherche";
$philomessage[184] = "Nombre de formes uniques: %s";
$philomessage[185] = "<b>Critères de recherche: </b>%s";
$philomessage[186] = "En train de produire une table de collocation. Ca va prendre %s seconds, à peu près.";
$philomessage[187] = "Le rapport entier va prendre %s seconds, à peu près.";
$philomessage[188] = "Votre recherche a obtenu plus de 20,000 occurrences.";
$philomessage[189] = "Un rapport ligne par ligne (KWIC) ne peut être assorti quand il y a plus de 20,000 occurrences. Veuillez raffiner votre recherche.  Veuillez vous addresser à $ERRORCONTACT pour élever cette limite.";
$philomessage[190] = "<b>Rapport ligne par ligne (KWIC)</b><br> Assorti par mot-clé et les mots à %s.";
$philomessage[191] = "Erreur en lisant le nombre de mots.";
$philomessage[192] = "<b>résultats de recherche assortis par %s</b>";
$philomessage[193] = "Fréquence par titre en ordre numérique descendant avec fréquence en gras et [nombre sur 10,000] entre parenthèses:";
$philomessage[194] ="Fréquence par auteur en ordre descendant de nombre sur 10,000 avec [fréquence] entre parenthèses (e.g., 4.72 [4] veut dire 4.72 occurrences sur 10,000 mots avec un total de 4 occurrences dans ce titre.):";               
$philomessage[195] = "Fréquence par auteur";
$philomessage[196] = "en ordre numérique descendant avec fréquence en gras et [nombre sur 10,000] entre parenthèses";
$philomessage[197] = "en ordre descendant de nombre sur 10,000 avec [fréquence] entre parenthèses  (e.g., 4.72 [4] veut dire 4.72 occurrences sur 10,000 mots avec un total de 4 occurrences dans l'oeuvre de cet auteur.): ";
$philomessage[198] = "Fréquence par an en ordre descendant de nombre sur 10,000 avec [fréquence] entre parenthèses (e.g., 3.09 [8] veut dire 3.09 occurrences sur 10,000 mots avec un total de 8 occurrences pour cette période.): ";
$philomessage[199] = "Fréquence par an en ordre numérique descendant avec fréquence en gras et [nombre sur 10,000] entre parenthèses.";
$philomessage[200] = "<b>Attention</b>: Dans quelques installations de PhiloLogic, quelques mots très fréquents comme <b>%s</b> ne marchent pas dans une recherche de proximité. Veuillez refaire cette recherche avec des mots moins fréquents. Cette erreur sera corrigée dans une version prochaine de Philologic.";
$philomessage[201] = "Erruer interne: mauvais arguments dans recherche subdoctable. Veuillez vous addresser à $ERRORCONTACT.";
$philomessage[202] = " <br>%s objets trouvés à une profondeur de %s dans tous les documents.";                        
$philomessage[203] = "<b>Aucun objet trouvé</b>.";
$philomessage[204] = "%s objets trouvés dans les documents sélectionnés.";
$philomessage[205] = "<b>Aucun objet trouvé dans les documents sélectionnés.</b>.";
$philomessage[206] = "%s objets trouvés dans les documents sélectionnés.";
$philomessage[207] = "<b>Aucun objet trouvé dans les documents sélectionnés.</b>.";
$philomessage[208] = "Le module Perl Unicode::String n'est pas installé. Le format de rapport ligne-par-ligne n'est pas assuré. Veuillez vous addresser à $ERRORCONTACT.";
$philomessage[209] = "Bibliographie de résultats";
$philomessage[210] = "<b>Mots-clés (aves des occurences)</b>: ";
$philomessage[211] = "Les %s mots les plus fréquents sont exclus. Pour inclure les mots exclus, sélectionnez \"Enlever les Filtres\" sur la forme.";
$philomessage[212] = "Les Filtres de rapport ne sont pas actifs";
$philomessage[213] = "Ordre";
$philomessage[214] = "Dans %s mots<br>à chaque côté";
$philomessage[215] = "Dans %s mots<br>à la gauche";
$philomessage[216] = "Dans %s mots<br>à droite";
$philomessage[217] = "Les %s premiers de %s résultats sont affichés.";
$philomessage[218] = "Requête invalide.";
$philomessage[219] = "La liste de résultats n'a pas été trouvée. Veuillez refaire votre recherche.";
$philomessage[220] = "Requête invalide.";
$philomessage[221] = "Précédent(e)";
$philomessage[222] = "Suivant(e)";
$philomessage[223] = "ERREUR: aucun fichier trouvé";
$philomessage[224] = "dbname ne peut contenir que lettres et chiffres";
$philomessage[225] = "Le chargeur pour %s";
$philomessage[226] = "La version courante des fichiers cgi";
$philomessage[227] = "Nombre de mots";
$philomessage[228] = "Erreur: Fichier du nombre de mots non-trouvé pour docid <b>%s</b>. Veuillez vous addresser à $ERRORCONTACT.<p>";
$philomessage[229] = "Le nombre de mots:";
$philomessage[230] = "Le nombre de mots uniques:";
$philomessage[231] = "Assorti par mot";
$philomessage[232] = "assortir %s par fréquence";
$philomessage[233] = "Assorti par fréquence descendante";
$philomessage[234] = "assortir %s par mot";
$philomessage[235] = "Nom de base de données invalide: %s. Veuillez vous addresser à $ERRORCONTACT.";
$philomessage[236] = "Nom de base de données non-enregistré: %s. Veuillez vous addresser à $ERRORCONTACT.";
$philomessage[237] = "Impossible de trouver philosubs.pl pour %s. Veuillez vous addresser à $ERRORCONTACT.";
$philomessage[238] = "La liste des résultats n'a pas été trouvée.<p> <i>Les fichiers des résultats s'effacent au bout de 3 heures. Veuillez refaire votre recherche.</i>";
$philomessage[239] = "Table de matières";
$philomessage[240] = "Appuyer <A HREF=\"%s/select.pl?%s\">ici</A> pour faire une recherche dans les sections du document(s) sélectionée(s).";
$philomessage[241] = "Actuellement, accès à l'historique n'est pas configuré.";
$philomessage[242] = "Erreur: Objet %s non-trouvé dans l'historique";
$philomessage[243] = "L'Historique a été effacé";
$philomessage[244] = "Erruer Interne: Impossible de trouver la bibliothèque des fonctions pour %s. Veuillez vous addresser au responsable du site.";
$philomessage[245] = "Function pour editer la requête";
$philomessage[246] = "Appuyer ici pour <input type=\"submit\" value=\"DELETE\"> les objets séléctionés ci-dessous ou pour éffacer <a href=\"%s?DELETEALL=ON&HISTORYFILE=%s&REFER_QS=%s\">TOUS LES OBJETS</a>";
$philomessage[247] = "Effacer";
$philomessage[248] = "Date (GMT)";
$philomessage[249] = "Les Paramètres de recherche";
$philomessage[250] = "Selectionner une action";
$philomessage[251] = "Refaire&nbsp;la&nbsp;recherche";
$philomessage[252] = "Changer la recherche";
$philomessage[253] = "Recherche des similarités";
$philomessage[254] = "Erreur: l'information sur la navigation de ce document n'était pas trouvée.\nVeuillez vous addresser à $ERRORCONTACT avec les détails de la recherche.";
$philomessage[255] = "Critère de recherche";
$philomessage[256] = "Encore des résultats";
$philomessage[257] = "en groupes de %s";
$philomessage[258] = "Trouver toutes les occurrences";
$philomessage[259] = "Ça peut prendre un peu de temps pour télécharger.";
$philomessage[260] = "La recherche est toujours en cours (veuillez refraîchir cette page ou suivre les liens ci-dessous pour voir le progrès).";
$philomessage[261] = "Concordance";
$philomessage[262] = "KWIC";
$philomessage[263] = "Occurrences";
$philomessage[264] = "La recherche est toujours en cours. <b>%s</b> occurrences ont été déjà trouvées ";
$philomessage[265] = "(veuillez refraîchir cette page ou suivre les liens ci-dessous pour voir le progrès)";
$philomessage[266] = "(veuillez refraîchir cette page pour voir le progrès)";
$philomessage[267] = "Les positions dans la phrase sonts calculeés dans la manière suivante: Début de la clause (le premier 35%); Fin (le dernier 10%), Le reste (le 55% au centre), Trop Court (moins de 4 mots dan la phrase).  Les mots de moins de 3 caractères et les chiffres sont jettés avant de calculer la longueur de la phrase. Les phrases sont indentifiées par la ponctuation en général.";
$philomessage[268] = "Allez au sommaire statistique ci-dessous";
$philomessage[269] = "Allez au début de la clause";
$philomessage[270] = "résultats";
$philomessage[271] = "Fin de la clause";
$philomessage[272] = "Centre de la clause";
$philomessage[273] = "Trop court";
$philomessage[274] = "Début";
$philomessage[275] = "Début de la clause (Thème)";
$philomessage[276] = "Centre";
$philomessage[277] = "Fin";
$philomessage[278] = "Fin de la clause: %s de %s";
$philomessage[279] = "Centre de la clause: $rheme de $mvocounter";
$philomessage[280] = "Trop court: %s de %s";
$philomessage[281] = "Sommaire statistique";
$philomessage[282] = "Début de la clause: %s de %s [%s\%]";
$philomessage[283] = "Longeur moyenne des clauses: %s";
$philomessage[284] = "mot-clé";
$philomessage[285] = "Allez";
$philomessage[286] = "Pas affiché";
$philomessage[287] = "Au centre de la clause: %s de %s [%s\%]";
$philomessage[288] = "Fin de la phrase: %s de %s [%s\%]";
$philomessage[289] = "Trop court: %s de %s [%s\%]";
$philomessage[290] = "Des documents avec une fréquence de thème plus grande que %s%% et avec plus de 10 occurrences.";
$philomessage[291] = "Bibliographie des résultats affichés";
$philomessage[292] = "%s objets trouvés.";
$philomessage[293] = "";
$philomessage[294] = "document(s)";
$philomessage[295] = "Critères bibliographiques";
$philomessage[296] = "Analyse de Position Clausale";
$philomessage[297] = "EFFACER";
$philomessage[298] = "CHERCHER";
$philomessage[299] = "ou";
$philomessage[300] = "aucun";
$philomessage[301] = "Tous les";
$philomessage[302] = "Documents sélectionnés par utilisateur";
$philomessage[303] = "Chercher <b>%s</b>";
$philomessage[304] = "Chercher dans les parties specifiées";
$philomessage[305] = "dans";
$philomessage[306] = "%s précédent(e)";
$philomessage[307] = "%s suivant(e)";
$philomessage[308] = "<b>Rapport Ligne par Ligne (KWIC) <br></b> Rangé par %s";
