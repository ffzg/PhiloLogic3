#!/usr/bin/perl

$philomessage[0] = "Please contact $ERRORCONTACT";
$philomessage[1] = "Warning: PhiloLogic Search history not enabled by configuration.";
$philomessage[2] = "Warning: PhiloLogic Search history folder not found.";
$philomessage[3] = "The BUTNOT operator must be followed by a word or pattern.";
$philomessage[4] = "The logical <b>NOT</b> operator is not enabled for proximity searches (within the same sentence or paragraph) at this time. You may use the <b>NOT</b> operator for searches with a selected number of words.";
$philomessage[5] = "Invalid syntax: %s";
$philomessage[6] = "The <b>!</b> operator may not be followed by a space.";
$philomessage[7] = "A Collocation Table can only be generated for a single word or word pattern (e.g., concord*).";
$philomessage[8] = "A Sorted Line by Line (KWIC) Report can only be generated for a single word or word pattern (e.g., concord*).";
$philomessage[9] = "A Word in Clause Position Report can only be generated for a single word or word pattern (e.g., concord*).";
$philomessage[10] = "Found values for both divindex and subdivindex searching.";
$philomessage[11] = "This is not permitted at this time.";
$philomessage[12] = "Please respecify your search to include only one level.";
$philomessage[13] = "The logical operators NOT and AND are unavailable for SubDiv level searching in this database installation."; 
$philomessage[14] = "Please use lower case <b>not</b> and <b>and</b> as search terms.";
$philomessage[15]  = "if you think this should be added to the database.";
$philomessage[16] = "The logical operators NOT and AND are unavailable for Div level searching in this database installation.";
$philomessage[17] = "Invalid character in docid: %d";
$philomessage[18] = "This database installed without SQL support.";
$philomessage[19] = "Terms browsing unavailable.";
$philomessage[20] = "This database installed without DIV level SQL support.";
$philomessage[21] = "This database installed without SUBDIV level SQL support.";
$philomessage[22] = "Searching for <b>%s</b> in the whole database.";
$philomessage[23] = "Found %d objects.";
$philomessage[24] = "No objects found.";
$philomessage[25] = "Searching for <b>%s</b> in the selected documents.";
$philomessage[26] = "Found <tt>%d</tt> document(s). ";
$philomessage[27] = "No documents found matching specified bibliographic criteria.";
$philomessage[28] = "<b>Note:</b> make sure that your bibliographic entries include appropriate spacing, punctuation, and accents. (E1)";
$philomessage[29] = "Search on selected document parts requires a word to find.";
$philomessage[30] = "Searching <b>%d</b> documents for <b>%s</b>.";
$philomessage[31] = "Searching on";
$philomessage[32] = "in selected parts from";
$philomessage[33] = "Searching <b>Entire Database</b>";
$philomessage[34] = "Searching <b>Entire Database</b> for <b>%s</b>";
$philomessage[35] = "Searching selected objects: <b>%s</b>.";
$philomessage[36] = "Internal Error";
$philomessage[37] = "divindex.raw not found.";
$philomessage[38] = "subdivindex.raw not found.";
$philomessage[39] = "No SUBDIVS Found, exiting...";
$philomessage[40] = "No words matching specified search term(s).";
$philomessage[41] = "<b>Note:</b> make sure that your search entries do not include textual punctuation.";
$philomessage[42] = "Remember that accents must be taken into account. (E5)";
$philomessage[43] = "Word list exceeds the set limit of %d words.";
$philomessage[44] = "This limit is designed to prevent runaway searches. It can be raised by the database administrator. Contact $ERRORCONTACT to arrange for this.";
$philomessage[45] = "Your pattern expanded to <tt>%d</tt> terms:";
$philomessage[46] = "PhiloLogic Nserver Error: %s";
$philomessage[47] = "PhiloLogic search deamon may have halted or not started properly.";
$philomessage[48] = "connect: %s";
$philomessage[49] = "Did you mean?";
$philomessage[50] = "Similarity Search not installed (agrep).";
$philomessage[51] = "Enter a word in the Search in Texts box for a Similarity Search.";
$philomessage[52] = "A word must be of 5 characters of more for a Similarity Search.";
$philomessage[53] = "Enter only one word for a Similarity Search.";
$philomessage[54] = "Enter letters only for a Similarity Search (e.g., no numbers, punctuation, or wild cards).";
$philomessage[55] = "<b>Found %d matches</b>, shown with frequencies in entire database.";
$philomessage[56] = "<p>Select words to search in the entire database.";
$philomessage[57] = "Select output options and bibliographic criteria below.";
$philomessage[58] = "No Similarity matches for $w";
$philomessage[59] = "Invalid option: this database does not have SQL metadata management enabled.";
$philomessage[60] = "List of available search terms for %s";
$philomessage[61] = "with bibliographic limits set to %s.";
$philomessage[62] = "in the whole database.";
$philomessage[63] = "List shows frequency of each term.";
$philomessage[64] = "No matching search terms.";
$philomessage[65] = "Could not open search history file.";
$philomessage[66] = "Contact Database Administrator.";
$philomessage[67] = "genre";
$philomessage[68] = "word count";
$philomessage[69] = "Note";
$philomessage[70] = "return to";
$philomessage[71] = "Link Error";
$philomessage[72] = "Article";
$philomessage[73] = "SubSect";
$philomessage[74] = "Sub2Sect";
$philomessage[75] = "page";
$philomessage[76] = "Table of Contents";
$philomessage[77] = "Search for";
$philomessage[78] = "Select document parts on which you want to run your search";
$philomessage[79] = "Search these documents for";
$philomessage[80] = "darkness";
$philomessage[81] = "e.g.";
$philomessage[82] = "Limit your search by the following fields";
$philomessage[83] = "Author";
$philomessage[84] = "zola";
$philomessage[85] = "Title";
$philomessage[86] = "histoire";
$philomessage[87] = "Date";
$philomessage[88] = "Select a Results Format";
$philomessage[89] = "Refined Search Results";
$philomessage[90] = "Occurrences with Context";
$philomessage[91] = "default";

$philomessage[92] = "Check";
$philomessage[93] = "to hide titles";

$philomessage[94] = "Collocation Table";
$philomessage[95] = "Spanning";
$philomessage[96] = "words";
$philomessage[97] = "Turn Filter Off";
$philomessage[98] = "Word in Clause Position";
$philomessage[99] = "Theme-Rheme";
$philomessage[100] = "Display Options";
$philomessage[101] = "Front of Clause Only";
$philomessage[102] = "Front and Last Only";
$philomessage[103] = "Front, Last, Middle";
$philomessage[104] = "Full Report";
$philomessage[105] = "Word Similarity";
$philomessage[106] = "Entering <i>mystery</i> finds mysterye, mystory, etc.";
$philomessage[107] = "A word must be of 5 characters or more.";
$philomessage[108] = "Search in Texts for";
$philomessage[109] = "Search in Selected Works.";
$philomessage[110] = "Refined Results Options are available at the bottom of this page.";
$philomessage[111] = "Occurrences";
$philomessage[112] = "Select a Search Option";
$philomessage[113] = "Single Term and Phrase Search";
$philomessage[114] = "Phrase separated by";
$philomessage[115] = "or fewer";
$philomessage[116] = "exactly";
$philomessage[117] = "Proximity Searching in the same Sentence or";
$philomessage[118] = "in the same Paragraph";
$philomessage[119] = "Last";
$philomessage[120] = "First";
$philomessage[121] = "To look up a word in a dictionary, select the word with your mouse and press 'd' on your keyboard.";
$philomessage[122] = "Context";
$philomessage[123] = "Invalid option: this database does not have SQL SubDocument management enabled.";
$philomessage[124] = "List of available search terms for";
$philomessage[125] = "with bibliographic limits set to";
$philomessage[126] = "List shows frequency of each term.";
$philomessage[127] = "Keyword";
$philomessage[128] = "Right";
$philomessage[129] = "Left";
$philomessage[130] = "PubPlace";
$philomessage[131] = "Resort results by";
$philomessage[132] = "Note from page";
$philomessage[133] = "ERROR";
$philomessage[134] = "no reftable";
$philomessage[135] = "reading reftable";
$philomessage[136] = "no link";

# end robert, begin russ
# latest messages for philohistory.pl

$philomessage[137] = "Select a Search Option";

$philomessage[138] = "Single Term and Phrase Search (default)";

$philomessage[139] = "Phrase separated by";

$philomessage[140] = "Proximity Searching in the same Sentence or ";

$philomessage[141] = "in the same Paragraph";

$philomessage[142] = "Select a Results Format";

$philomessage[143] = "Occurrences with Context (default)";

$philomessage[144] = "Occurrences Line by Line";

$philomessage[145] = "Frequency by Title";

$philomessage[146] = "Frequency by Title per 10,000";

$philomessage[147] = "Frequency by Author";

$philomessage[148] = "Frequency by Author per 10,000";

$philomessage[149] = "Check %s to hide titles";

$philomessage[150] = "Frequency by Years";

$philomessage[151] = "Frequency by Years per 10,000";

$philomessage[152] = "Select Year Group";

$philomessage[153] = "Year";

$philomessage[154] = "Decade";

$philomessage[155] = "Quarter Cent.";

$philomessage[156] = "Half Cent.";

$philomessage[157] = "Century";

$philomessage[158] = "Check %s to hide titles";

$philomessage[159] = "Collocation Table Spanning %s words";

$philomessage[160] = "Turn Filter Off";

$philomessage[161] = "Word in Clause Position (Theme-Rheme)";

$philomessage[162] = "Front of Clause Only";

$philomessage[163] = "Front and Last Only";

$philomessage[164] = "Front, Last, Middle";

$philomessage[165] = "Full Report";

$philomessage[166] = "Display Options";

$philomessage[167] = "PhiloLogic Search History";

$philomessage[168] = "Return to %s Search Form";

$philomessage[169] = "Powered by PhiloLogic";

# russ's original messages

$philomessage[170] = "<p><b>Possible Internal Error</b>: Search exceeded preset timeout limit: $timelimit seconds.  Please retry.  If the problem persists, please contact $ERRORCONTACT with details of this search.";
                
$philomessage[171] = "Internal Error";

$philomessage[172] = "Try running your search with bibliographic limits or for fewer very common words. This will be corrected in a future update of PhiloLogic.";

$philomessage[173] = "<h2>Nothing found matching specified search term(s)</h2> <b>Note:</b> make sure that your search entries do not include textual punctuation.  Remember that accents must be taken into account.";
               
$philomessage[174] = "memory limit exceeded. exiting.";

$philomessage[175] = "Segmentation fault.";

$philomessage[176] = "Your search found <b>%s</b> occurrences<p>\n";

$philomessage[177] = "Click here for a \u%s\l Report";

$philomessage[178] = "<b>This page contains the first 25 occurrences. Please follow the link(s) at the bottom of the page to see the rest of the occurrences your search found.</b>";
             
$philomessage[179] = "<hr>The search is still in progress. <b>%s</b> occurrences have been generated so far (Please follow the link(s) below to check on the progress).<p>\n";              
	     
$philomessage[180] = "More search results (batches of %s)";

$philomessage[181] = "Retrieve all occurrences";

$philomessage[182] = " (This may take some time to download)";

$philomessage[183] = "search progress";

$philomessage[184] = "Number of Unique Forms: %s";

$philomessage[185] = "<b>Search Terms: </b>%s";

$philomessage[186] = "Generating Collocation Table.  This should take approximately %s seconds.";

$philomessage[187] = "The complete report will take about: %s seconds";

$philomessage[188] = "Your search generated more than 20,000 occurrences.";

$philomessage[189] = "A Line by Line (KWIC) Report cannot be sorted for results of more than 20,000 occurrences. Please refine your search.  Contact $ERRORCONTACT to have this limit increased.";
$philomessage[190] = "<b>Line by Line (KWIC) Report</b><br> Sorted by keyword and words to its %s.";

$philomessage[191] = "Error Reading Document Total Word Count File!";

$philomessage[192] = "<b>Search results sorted by %s</b>";

$philomessage[193] = "Frequency by Title in descending numeric order with  frequency in bold and [rate per 10,000] in brackets:";

$philomessage[194] ="Frequency by Title in descending order of rate per 10,000 with [frequency] in brackets (e.g., 4.72 [4] means 4.72 occurrences in 10,000 words with a total of 4 occurrences in that title.):"; 
              
	      
$philomessage[195] = "Frequency by Author";

$philomessage[196] = " in descending numeric order with frequency in bold and 
              [rate per 10,000] in brackets: ";

$philomessage[197] = "in descending order of rate per 10,000 with [frequency] 
              in brackets (e.g., 4.72 [4] means 4.72 occurrences in 
	      10,000 words with a total of 4 occurrences in that author's 
	      works.): ";
	      
$philomessage[198] = "Frequency by Years in descending order of rate per 
              10,000 with [frequency] in brackets (e.g., 3.09 [8] 
	      means 3.09 occurrences in 10,000 words with a total 
	      of 8 occurrences for that period of years.): ";
	      
$philomessage[199] = "Frequency by Years in descending numeric order with 
              frequency in bold and [rate per 10,000] in brackets: ";
              
$philomessage[200] = "<b>Warning</b>: In some installations of 
                  PhiloLogic, including very common words such as
                  <b>%s</b> in phrase proximity searches
                  may result in search failures.  Try running
                  this search again using less common words to
                  be certain.  This error will be corrected in a 
                  future update of PhiloLogic.";
                  

$philomessage[201] = "Internal Error: bad args in searchsubdoctable. 
                       Contact $ERRORCONTACT";

$philomessage[202] = " <br>Found %s objects at depth $objdep
                        in the whole database.";
                        
$philomessage[203] = "<b>No objects found</b>.";

$philomessage[204] = "Found %s objects in selected
                               documents to search.";
                               
$philomessage[205] = "No matching objects in selected documents.";

$philomessage[206] = "Found $x objects in selected documents.";

$philomessage[207] = "<b>No objects found in selected documents</b>.";

$philomessage[208] = "Perl module Unicode::String has not been installed.
           This may result in odd line by line formatting. Please
           contact $ERRORCONTACT.";

$philomessage[209] = "Results Bibliography";

$philomessage[210] = "<b>Keywords found (with occurrences)</b>: ";

$philomessage[211] = "The %s most common words are being filtered from this report.  To include filtered words select \"Turn Filter Off\" on the search-form.";

$philomessage[212] = "Report Filtering is off";

$philomessage[213] = "Ranking";

$philomessage[214] = "Within %s Words<br>on Either Side";

$philomessage[215] = "Within %s Words<br>to Left only";

$philomessage[216] = "Within %s Words<br>to Right only";

$philomessage[217] = "Displaying first %s of %s hits.";

$philomessage[218] = "Invalid request";

$philomessage[219] = "Results list not found. Please run your search again.";

$philomessage[220] = "Invalid request.";

$philomessage[221] = "Previous";

$philomessage[222] = "Next";

$philomessage[223] = "ERROR: No File";

$philomessage[224] = "dbname must be alphanumeric";

$philomessage[225] = "The Loader used to load %s";

$philomessage[226] = "The current version of the cgi scripts";

$philomessage[227] = "Word Count";

$philomessage[228] = "Error: Word Count file for docid <b>%s</b> not found. Please contact $ERRORCONTACT.<p>";

$philomessage[229] = "Total Words:";

$philomessage[230] = "Total Unique Words:";

$philomessage[231] = "Sorted by words";

$philomessage[232] = "sort %s by frequencies";

$philomessage[233] = "Sorted by descending frequencies";

$philomessage[234] = "sort  %s by words";

$philomessage[235] = "Invalid Database name: %s. Contact $ERRORCONTACT.";

$philomessage[236] = "Database name not registered: %s. Contact $ERRORCONTACT.";

$philomessage[237] = "Cannot find philosubs.pl for %s. Contact $ERRORCONTACT.";

$philomessage[238] = "The results list not found.<p> <i>Results files are deleted from the server after 3 hours. Please run your search again.</i>";

$philomessage[239] = "Table of Contents";

$philomessage[240] = "Click <A HREF=\"%s/select.pl?%s\">here</A> to run a search on selected parts of this document.";

$philomessage[241] = "There is currently no PhiloLogic Search History for this browser.";

$philomessage[242] = "Error: Could not find entry %s in History";

$philomessage[243] = "Search History Deleted";

$philomessage[244] = "Internal Error: Cannot find function library for %s. Contact the Database Administrator.";

$philomessage[245] = "Search Query Edit Function";

$philomessage[246] = "Press to <input type=\"submit\" value=\"DELETE\"> selected entries below or Delete <a href=\"%s?DELETEALL=ON&HISTORYFILE=%s&REFER_QS=%s\">ALL ENTRIES</a>";

$philomessage[247] = "Del";

$philomessage[248] = "Date (GMT)";

$philomessage[249] = "Query Parameters";

$philomessage[250] = "Select Action";

$philomessage[251] = "Rerun&nbsp;Search";

$philomessage[252] = "Edit Search";

$philomessage[253] = "Similarity Search";

$philomessage[254] = "Error: Could not find navigation data for this document.\nPlease contact $ERRORCONTACT with details of this search.";

$philomessage[255] = "Search criteria";

$philomessage[256] = "More search results";

$philomessage[257] = "batches of %s";

$philomessage[258] = "Retrieve all occurrences";

$philomessage[259] = "This may take some time to download";

$philomessage[260] = "The search is still in progress (reload this page or follow the link(s) at the bottom of the page to check on the progress)";

$philomessage[261] = "Concordance";

$philomessage[262] = "KWIC";

$philomessage[263] = "Occurrences";

$philomessage[264] = "The search is still in progress. <b>%s</b> occurences have been generated so far ";

$philomessage[265] = " (reload this page or follow the link(s) below to check on the progress)";

$philomessage[266] = "(reload this page to check on the progress)";

$philomessage[267] = "Positions are calculated on within what percentage of the length of the clause the word falls.  Front of Clause (first 35%); Last (last 10%), Remainder (middle 55%), Too Short (clause length 3 words or less).  Words of 2 letters or fewer and numbers are excluded in calculating clause length. Clauses are identified with punctuation as the primary determining factor.";

$philomessage[268] = "Go to Statistical Summary Below";

$philomessage[269] = "Go to Front of Clause";

$philomessage[270] = "hits";

$philomessage[271] = "Last of Clause";

$philomessage[272] = "Middle of Clause";

$philomessage[273] = "Too Short";

$philomessage[274] = "Front";

$philomessage[275] = "Front of Clause (Theme)";

$philomessage[276] = "Middle";

$philomessage[277] = "Last";

$philomessage[278] = "Last of Clause: %s out of %s";

$philomessage[279] = "Middle of Clause: $rheme out of $mvocounter";

$philomessage[280] = "Too Short: %s out of %s";

$philomessage[281] = "Statistical Summary";

$philomessage[282] = "Front of Clause: %s out of %s [%s\%]";

$philomessage[283] = "Avg. Clause length: %s";

$philomessage[284] = "keyword";

$philomessage[285] = "Go";

$philomessage[286] = "Not Displayed";

$philomessage[287] = "Middle of Clause: %s out of %s [%s\%]";

$philomessage[288] = "Last of Clause: %s out of %s [%s\%]";

$philomessage[289] = "Too Short: %s out of %s [%s\%]";

$philomessage[290] = "Documents with rate of theme greater than %s%% and more than 10 occurrences.";

$philomessage[291] = "Displayed Results Bibliography";

$philomessage[292] = "Found %s objects.";

$philomessage[293] = "for";

$philomessage[294] = "document(s)";
$philomessage[295] = "Bibliographic criteria";
$philomessage[296] = "Clause Position Analysis";
$philomessage[297] = "CLEAR";
$philomessage[298] = "SEARCH";
$philomessage[299] = "or";
$philomessage[300] = "none";
$philomessage[301] = "All documents";
$philomessage[302] = "User Selected Documents";
$philomessage[303] = "Searching for %s";
$philomessage[304] = "Search in Selected Parts";
$philomessage[305] = "in";
$philomessage[306] = "Previous %s";
$philomessage[307] = "Next %s";
$philomessage[308] = "<b>Line by Line (KWIC) Report</b><br> Sorted by %s";
