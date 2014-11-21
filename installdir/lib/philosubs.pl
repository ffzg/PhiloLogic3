# $Id: philosubs.pl,v 2.11 2004/11/16 00:44:05 o Exp $
use Classic::Perl;
do "philo-db.cfg";   # read in the database-specific configuration

&LoadLocalMessages;	 # read in the language-specific mesages file specified in philo-db.cfg

# ======================================================================
# ======================== The Subroutines =============================
# ======================================================================
#
# ---------------------- Defined Subroutines --------------------------
#       * denotes ones you MAY want to edit.
#
# mkTitle:            Generates initial result header*
# mkBiblio:           Formats bibliographic entry*
# getbiblioLine:      Gets a tab delimited bibliographic entry
# getcite:            Gets the shrt cite for CONC and KWIC reports
# getbline:           
# volumeNum:          Possibly obsolete from Encyclopedie
# ObjectFormat:       Formats all text objects*
# nonewlines:         Removes newlines from inside tags
# refresolver:        Resolves <ptr, <ref, <note tags*
# kwicheader:         Generates KWIC header*
# concheader:         Generates CONC header*
# objectheader:       Generates object header*
# contextheader:      Generates contextualization header*
# kwicfooter:         Generates KWIC footer*
# concfooter:         Generates CONC footer*
# objectfooter:       Generates object footer*
# contextfooter:      Generates contextualization footer*
# GetHit:             Get a search result hit
# concheadline:       Generates the headline for CONC report, 
#                       switches based on $UseDicoDisplays*
# concheadlinestandard: Generates the headline for CONC report in stdd format*
# concheadlinedico:   Generates the headline for CONC report in dico format*
# readnavbar:         Reads general header file*
# readfooternavbar:   Reads general footer file*
# KwicFormat:         Formats text in KWIC report*
# PoleTransform:      Modifies groups of words for Collocation report*
# UTF8up2low:         Translates UFT-8 upper to lower (limited)
# ConcFormat:         Formats text in CONC report*
# DFperiodbuild:      Sets periods for period frequencies
# NavigBiblio:        Formats bibliography in Navigation/TOC report
# SelectBiblio:       Formats bibliography for internal part search form*
# NavDivTitle:        Formats heads in Navigation/TOC report
# FreqFormat:         Formats frequency reports*
# mkSelectSearch:     Generates internal part search form*
# getKWICtitle:       Generates KWIC report citation, 
#                        switches based on $UseDicoDisplays*
# getKWICtitlestandard: Generates KWIC report citation for standard texts
# getKWICtitledico:   Generates KWIC report citation for dictionaries 
# ConcSpan:           Calculates where a hit ends
# KwicSpan:           Calculates where a hit ends
# PoleSpan:           Calculates where a hit ends
# ObjectSpan:         Calculates where a hit ends
# EntityConvert:      Convert ents to display characters*
# Ents2Unicode:       Convert ents to UTF-8
# MilestoneHandler:   Format Milestones for display*
# PageTagHandler:     Formats page tags for display*
# ExpandAbbrev:       Expand Abbreviations if set for display.
# SearchInBibliography: Search box in bibliographic results
# SimilarWordSearch:  Agrep search on wordlist if you have no matches
# postfix2UTF8:       Convert postfix accent notation to UTF-8
# clean_word_pattern: Process user word pattern(s) for searching
# pattern_to_show:    Process cleaned word pattern for display to user   
# clean_corpus_pattern: Process metadata arguments for searching.
# GimmeArgsToShow:    Modifies metadata arguments for display
# SimilarWord:        Run a similarity search on word/frequency list
# BiblioSearchOptions: Make bibliographic search boxes for new searches
# SearchResultOptions: Make Search Result Options for new searches
# BrowseAvailableTerms: Terms button for SQL enabled metadata fields.
# BrowseTermsFormat:  Format the browse terms before sort and uniq
# WritePhiloHistory:  Write a search history entry.
# CheckSQLError:      Check for an SQL connect error (may be a problem).
# mkSelectBibSearchForm: Generate the form for the Selected Search Bib.
# ThemeHitLine:       Process the conc line for theme-rheme
# SetThemeLimit:      Set number of words at front of clause will be theme
# SetThemeColors:     Set theme, rheme, last hitword colors.
# mkfreqtitleline:    Generate a title line for frequency counts.
# getrelativefreq:    Calculate relative frequencies of words per title etc.
# SearchContextOptions: Generate Search option lines for search forms
# MakeKwicSortKey:    Generate sort key for sorted line by line (KWIC)
# CleanKwicSortKey:   Clean the KWIC strings to allow correct sorting.
# HitNavigationLine:  Generate a contextual hit navigation links
# cleansubdocargs:    clean args going to the subdocgimme function.
# subdocargs2display: format args to subdocgimme for display
# DivDisplayLine:     Format hits for div level searches
# quickdickjs:        Generate javascript for the dictionary search
# BrowseSubDocTerms:  Generate SQL Terms in SubDoc tables.
# WordSearchSortKey:  Modify the hitlist sort by biblio criteria.
# KwicResortForm:     Generate the Kwic Resort Form.
# DivHeadFreqLinks:   Title/Links for Freq by Div reports.
# ATEnotetext:        build a page backlink from a note as specified in ATE
# ATEnotelinker:      build a link to the notetext as specified in ATE
# ReadReferenceTable: read in the general reference table
# ARTFLresolver:      build two way links, <ref/<note as specified in ARTFL
# LoadLocalMessages:  load in the localized (language-specfic) message file
#
# These are not in any particular order.  New ones are simply added at 
# the end.  
#
# ----------------------------------------------------------------------  
# mkTitle: A stub that reads in a header file.  You can add more
#          here as required or print what you want.  The header file 
#          is set in readnavbar.  Note that the header file needs
#          to have HTML/UTF-8 declarations, CSS, etc.  
# Called from: search2t
# ----------------------------------------------------------------------
sub mkTitle {
local ($title); 
$title = &readnavbar();
if ($LINKDICT)
    {
      $title .= quickdicjs($LINKDICT);
    }
return $title;
}

# ----------------------------------------------------------------------
# mkBiblio: This takes a tab delimited bibliographic record and formats
#           it for output.  I've hardwired our standard variable names
#           to make editing easier.  You can add more or modify as
#           required.  All bibliographic output comes from here.
#           The link option is required for certain ARTFL databases
#           that restrict context.  Should be left on for most applications.
#           You could comment that switch out.
# Called from:
# ----------------------------------------------------------------------
sub mkBiblio {
    local ($bibline) = $_[0];
    local ($title, $author, $date, $publisher, $n, $c, $ret, $biblinefields); 
    local ($genre, $pubplace, $extent, $editor, $pubdate);
    local ($createdate, $authordates, $keywords, $language, $collection);
    local ($gender, $sourcenote, $period);
    local ($tnav, $filesize, $filename, $scite);
    @biblinefields = split ('\t', $bibline); 

# The last four fields are reserved

    $n = $biblinefields[$#biblinefields];             # PhiloLogic document id
    $filesize = $biblinefields[$#biblinefields - 1];  # filesize in bytes
    $filename = $biblinefields[$#biblinefields - 2];  # filename 
    $scite = $biblinefields[$#biblinefields - 3];     # shrtcite

# Then we want in order, numbered from ZERO, the goodies we will format.

    $title = $biblinefields[0];
    $author = $biblinefields[1];
    $date = $biblinefields[2];
    $bibliodate = $date;               # set for quickdict below...
    $genre = $biblinefields[3];
    $publisher = $biblinefields[4];
    $pubplace = $biblinefields[5];
    $extent = $biblinefields[6];
    $editor = $biblinefields[7];
    $pubdate = $biblinefields[8];
    $createdate = $biblinefields[9];
    $authordates = $biblinefields[10];
    $keywords = $biblinefields[11];
    $language = $biblinefields[12];
    $collection = $biblinefields[13];
    $gender = $biblinefields[14];
    $sourcenote = $biblinefields[15];
    $period = $biblinefields[16];

    $c = &getcite ( $n ); 

    if ($_[1] eq "link") {
       $tnav = "<a href=\"" . $PHILONAVIGATE . "?" . $dbname; 
       $tnav .= "." . $n . "\">";
       $title = $tnav . $title . "</a>";
       }

# Here we are going to give a default bibliographic display.  You can
# edit these and add from the list below.  Leave the <fs/>, as this is
# to denote items extracted from multiple entries of the same xpath
# in the TEI header.  The formatting uses HTML.  I should use my CSS.

    $ret = "<a name=\"" . $c . "\"></a>";

    if ($biblinewithbox) {
        $ret .= "<input type=\"checkbox\" name=\"multidocid\" ";
	$ret .= "value=\"" . $n . "\"> ";
	}
    $author =~ s/<fs\/>/; /g;
    $ret .= $author;
    if (!$date || $date eq "NA") {
         $date = "n.d.";
	 }
    if ($authordates) {
	$ret .= " (". $authordates . ") ";
	}
    $ret .= " [<b>" . $date . "</b>], ";
    $title =~ s/^<fs\/>//g;
    $title =~ s/<fs\/>/; /g;

    $ret .= "<i>" . $title . "</i> ";
    $ret .= " (";
    if ($publisher) {
	$publisher =~ s/<fs\/>/; /g;
	$publisher =~ s/; *;/;/g;
    	$ret .= $publisher;
	}
    if ($pubplace) {
        $pubplace =~ s/<fs\/>/; /g;
	$ret .= ", " . $pubplace;
  	}
#    if ($pubdate) {
#        $pubdate =~ s/<fs\/>/; /g;
#	$ret .= ", " . $pubdate;
#	}
#   if ($createdate) {
#        $createdate =~ s/<fs\/>/; /g;
#        $ret .= ", [" . $createdate . "]";
#        }
    $ret .= ")";
    if ($extent) {
	$extent =~ s/<fs\/>/; /g;
	$ret .= ", " . $extent;
	}
    if ($editor) {
	$editor =~ s/<fs\/>/; /g;
	if ($editor =~ /edit/i) {
		$ret .= ", " . $editor;
		}
	else {
		$ret .= ", Ed. " . $editor;
		}
	}
    if ($genre) {
	$genre =~ s/<fs\/>/; /g;
	$ret .= " [" . $philomessage[67] . ": " . $genre . "] ";
	}
    $PHILOGETWORDCOUNT = $PHILOCGI . "/getwordcount.pl";
    $getcount = "<a href=\"$PHILOGETWORDCOUNT" . "?" . $dbname . "." . $n;
    $getcount .= "\">";
    $ret .= " [" . $getcount . $philomessage[68] . "</a>]";

    $ret .= " [<b>" . $c . "</b>]. ";

    if ($sourcenote) {
        $ret .= "<br><span class=small>";
	$ret .= $sourcenote;
	$ret .= "</span>";
	}
# Clean ups?  
    $ret =~ s/,,/,/g;
    return $ret;
}

# ----------------------------------------------------------------------
# getbiblioLine: calls two subroutines to get a bibliographic record
#                and to format the record.  Probably a holdover.
# Called from:
# ----------------------------------------------------------------------
sub getbiblioLine {
local ($doc, $link) =@_; 
$biblioLine = &getbline ($doc); 
return &mkBiblio ($biblioLine, $link); 
}

# ----------------------------------------------------------------------
# getcite: This is definitely a holdover as it gets the shrt cite from
#          the file docinfo (which contains other data).  The shrt cite
#          or identifier is also in the bibliography.  It loads the
#          identifiers in an array.  
# Called from:
# ----------------------------------------------------------------------
sub getcite {
local ($doc) = $_[0]; 
local ($c,$i); 
if ( $#citebuffer >= 0 ) {
    $c = $citebuffer[$doc];
    }
else {
    $i = $doc + 1; 
    open (DOCINFO, $SYSTEM_DIR . "docinfo");
    while ( $i-- ) {
	$c = <DOCINFO>; 
    }
    $c = (split (" ", $c))[2]; 
}
return $c; 
}

# ----------------------------------------------------------------------
# getbline: Get the bibliographic record.  In some implementations, this
#           talks to SQL (mySQL).  We should probably add a switch for
#           this, but since the defaul build does not assume SQL, we
#           will leave it for now.
# Called from:
# ----------------------------------------------------------------------
sub getbline {
    local ($doc) = $_[0];
    open (BIB, $SYSTEM_DIR . "bibliography") unless $biblioLinesProcessed;
    while ( $biblioLinesProcessed < $doc + 1) {
	$biblioLineRead = <BIB>;
	$biblioLinesProcessed++; 
    }
    return $biblioLineRead; 
}


# ----------------------------------------------------------------------
# volumeNum: a holdover from the 2e.  Calculates volume number from
#            file number.  Ignore it.
# Called from:  Should not be called.  Delete it?
# ----------------------------------------------------------------------
sub volumeNum {
local ($doc) = $_[0];
local ($num);
$num = int ($doc / 8) + 1;
return $num;
}


# ----------------------------------------------------------------------
# ObjectFormat: I will describe it once I have it set up properly.
# Called from:
# ----------------------------------------------------------------------
# I have not decided if I should use a poor man's parser here.  
# I'm splitting on newlines ... as they are generally found
# in the Object.  Decide, would you.....

sub ObjectFormat {
    local ( $text, $testtext, $reffilepath, $reftabexists); 

# Let's get the text and do some simple formatting of selected
# types.....
    $testtext = $_[0];

# If this is a plaintext load, do some very simple formatting
# and return it.
    if ($TextType eq "plaintext") {
         $testtext =~ s/\n/<br>\n/g;
         $testtext =~ s/(  +)/"&nbsp;" x length($1)/gie;
         return $testtext;
         }

# If we ever do alot of docbook, this should be a subroutine.
    if ($TextType eq "docbook") {
        $testtext =~ s/<title>/<span class=head>/gi;
        $testtext =~ s/<\/title>/<\/span>/gi;
        $testtext =~ s/<para>/<p>/gi;
        $testtext =~ s/<\/para>/<\/p>/gi;
	$testtext =~ s/<emph[^>]*>/<span class=emph>/gi;
        $testtext =~ s/<\/emphasis>/<\/span>/gi;
	return $testtext;
        }
# End DocBook

# ATE -- ARTFL Text Encoding.  Put a permanent URL to this 
# specification.  We have to add some language on the note
# and notetext specificiations.  I have them some place.
     if ($TextType eq "ate") {
	$testtext =~ s/(<[^>]*>)/&nonewlines($1)/gie;
	if ($testtext =~ /<meta *name="DC/i) {
		$testtext =~ s/</&lt;/g;
		$testtext = "<pre>\n" . $testtext . "</pre>\n";
		return $testtext;
		}
	$testtext =~ s/(<page[^>]*>)/&PageTagHandler($1)/gie;
	$testtext =~ s/<h1>/<span class=head>/gi;
	$testtext =~ s/<\/h1>/<\/span>/gi;
	$testtext =~ s/<h2>/<span class=head>/gi;
	$testtext =~ s/<\/h2>/<\/span>/gi;
	$testtext =~ s/<h3>/<span class=head>/gi;
	$testtext =~ s/<\/h3>/<\/span>/gi;
	$testtext =~ s/&dot;/\./g;
	$testtext =~ s/<FIGURE[^>]*>/[unresolved link]/gi;
	if ($testtext =~ /<notetext/i) {
		$testtext =~ s/(<notetext [^>]*>)/&ATEnotetext($1)/gie;
		$testtext =~ s/<\/notetext>//gi;
		}
	if ($testtext =~ /<note /) {
	        $testtext =~ s/(<note [^>]*>)/&ATEnotelinker($1)/gie;
	     }

	return ($testtext);
	}
# End of ATE specifications.  We can always add more, but it is
# typically HTML.  Note I am NOT running any character converts
# and the like.  Maybe I should....

##################################################################
#         The rest of this is for TEI encoded documents
##################################################################
# Check to see if we have an object id table for this document.
    $reffilepath = $SYSTEM_DIR . "references/" . $doc;
    if (-e $reffilepath) {
    	$reftabexists = 1;
	}

# If you have a teiheader tag, let's just dump it.  It's a TEI
# Header with lot's of useful info, but I don't want to try to
# render it.  We could try to render it all, but there is so much
# useful stuff that displaying it is probably better.  We do
# NOT search in headers.

    if ($testtext =~ /<teiheader/i || $testtext =~ /<mepheader/i) {
        $testtext =~ s/</&lt;/g;
	$testtext = "<pre>\n" . $testtext . "</pre>\n";
	return ($testtext);
	}
# Convert tags to CSS span classes.  This appears to be required as
# some browsers, such as IE 6, does not appear to function well with
# CSS doing direct rendering of TEI tags.  Sigh.  Oddly enuff, we are 
# also seeing LOTS of tags with newlines, so let's break tags and words
# out

       $testtext =~ s/(<[^>]*>)/&nonewlines($1)/gie;

# If we have a table and an end table, convert rows and cells.  Not
# sure what happens if you land in the middle of a table.

       if ($testtext =~ /<table/i) {
		if ($testtext =~ /<\/table/i) {
		       $testtext =~ s/<row[^>]*>/<tr>/gi;
		       $testtext =~ s/<\/row[^>]*>/<\/tr>/gi;
		       $testtext =~ s/<cell[^>]*>/<td>/gi;
		       $testtext =~ s/<\/cell[^>]*>/<\/td>/gi;
		    }
		}

# ARTFL TEI specific note and reference handler.  This is really
# just an extraction from the more general and much messier
# refresolver subroutine.  Added just for ease of maintenance since
# we will want only ARTFL notes whenever possible.  The original
# refresolver will still run, including on ARTFL TEI references
# which are not resolved in the simple one.   
        if ($TextType eq "artfltei") {
# ARTFL NOTE Handler...
           if ($testtext =~ /<note [^>]*>/i) {
                $testtext =~ s/(<note [^>]*>)/&ARTFLresolver($1)/gie;
                }
# ARTFL REF Handler...  
        if ($testtext =~ /<ref /i) {
             $testtext =~ s/(<ref [^>]*>)/&ARTFLresolver($1)/gie;
             }
          }

# Not sure why we're splitting this up here, but we'll let it
# go for now.
       @lines = split ("\n", $testtext);
       for $_ (@lines) {
#
# The <s/> sentence tag from TEI gets rendered as strinkthru
# so
        s/<s\/>/<sent\/>/g;
# Convert TEI tags to CSS span classes.  This should be a subroutine.
# It could call a defintion table for object types and should
# parse the values for <emph, <hi, etc.  Do I even want to think about
# handling REND in objects?

# General text and title page tags....
	s/<head[^>]*>/<span class=head>/gi;
	s/<\/head>/<\/span>/gi;
	s/<docauthor[^>]*>/<span class=docauthor>/gi;
	s/<\/docauthor>/<\/span>/gi;
	s/<doctitle[^>]*>/<span class=doctitle>/gi;
	s/<\/doctitle>/<\/span>/gi;
	s/<byline[^>]*>/<span class=byline>/gi;
	s/<\/byline>/<\/span>/gi;
	s/<bibl[^>]*>/<span class=bibl>/gi;
	s/<\/bibl>/<\/span>/gi;
	s/<pubplace[^>]*>/<span class=pubplace>/gi;
	s/<\/pubplace>/<\/span>/gi;
	s/<docedition[^>]*>/<span class=docedition>/gi;
	s/<\/docedition>/<\/span>/gi;
	s/<docimprint[^>]*>/<span class=docimprint>/gi;
	s/<\/docimprint>/<\/span>/gi;
	s/<publisher[^>]*>/<span class=publisher>/gi;
	s/<\/publisher>/<\/span>/gi;
	s/<addrline[^>]*>/<span class=addrline>/gi;
	s/<\/addrline>/<\/span>/gi;
	s/<docdate[^>]*>/<span class=docdate>/gi;
	s/<\/docdate>/<\/span>/gi;
	s/<opener[^>]*>/<span class=opener>/gi;
	s/<\/opener>/<\/span>/gi;
	s/<signed[^>]*>/<span class=signed>/gi;
	s/<\/signed>/<\/span>/gi;
	s/<epigraph[^>]*>/<span class=epigraph>/gi;
	s/<\/epigraph>/<\/span>/gi;
        s/<argument[^>]*>/<span class=argument>/gi;
        s/<\/argument>/<\/span>/gi;
	s/<salute[^>]*>/<span class=salute>/gi;
	s/<\/salute>/<\/span>/gi;
	s/<trailer[^>]*>/<span class=trailer>/gi;
	s/<\/trailer>/<\/span>/gi;
	s/<closer[^>]*>/<span class=closer>/gi;
	s/<\/closer>/<\/span>/gi;
	s/<item[^>]*>/<span class=item>/gi;
	s/<\/item>/<\/span>/gi;
	s/<label[^>]*>/<span class=label>/gi;
	s/<\/label>/<\/span>/gi;
	s/<FOREIGN[^>]*>/<span class=foreign>/gi;
	s/<\/FOREIGN>/<\/span>/gi;
	s/<titlepart[^>]*>/<span class=titlepart>/gi;
	s/<\/titlepart>/<\/span>/gi;
	s/<titlepage[^>]*>/<span class=titlepage>/gi;
	s/<\/titlepage>/<\/span>/gi;
	s/<title[^>]*>/<span class=title>/gi;
	s/<\/title>/<\/span>/gi;
# Drama Tags
        s/<stage[^>]*>/<span class=stage>/gi;
        s/<\/stage>/<\/span>/gi;
        s/<speaker[^>]*>/<span class=speaker>/gi;
        s/<\/speaker>/<\/span>/gi;
        s/<roledesc[^>]*>/<span class=roledesc>/gi;
        s/<\/roledesc>/<\/span>/gi;
        s/<role[^>]*>/<span class=role>/gi;
        s/<\/role>/<\/span>/gi;

# Display Tags: Needs to be a subroutine....
        s/<emph  *REND="smallcaps">/<span class=emphsc>/gi;
        s/<emph[^>]*>/<span class=emph>/gi;
        s/<\/emph>/<\/span>/gi;
	s/<hi  *rend="ital[^"]*">/<span class=hiitalic>/gi;
	s/<hi  *rend="smallcaps">/<span class=hismallcap>/gi;
	s/<hi  *rend="underline">/<span class=hiunderline>/gi;
	s/<HI  *REND="font\(bold\)">/<span class=hibold>/gi;
	s/<hi  *rend="bold">/<span class=hibold>/gi;
        s/<HI>/<span class=hi>/gi;
        s/<\/HI>/<\/span>/gi;


# Call the Reference Resolver.  There are a number of ways to get
# references.  For now, let's cycle thru the possibilities as seen
# in various encoding practices.  Maybe I should put examples here.

# General: REF tags
        if (/<ref /i && $reftabexists) {
	                                 # Ref with link
             s/(<ref[^>]*>)([^<]*)(<\/ref>)/&refresolver($1,$2,$3)/gie;
                                         # Ref without link
             s/(<ref [^>]*>)/&refresolver($1,"","")/gie;
            }

# General: PTR
        if (/<ptr /i && $reftabexists) {
                                        # Pointer with link
           s/(<ptr [^>]*>)([^<]*)(<\/ptr>)/&refresolver($1,$2,$3)/gie;
                                        # Pointer without link
           s/(<ptr [^>]*>)/&refresolver($1,"","")/gie;
           }
# Brown WWP references to notes are called by <anchor
#       Example: <anchor id="a005" corresp="n005"/>
	if (/<anchor /i && /corresp=/i && $reftabexists) {
            s/(<anchor [^>]*>)/&refresolver($1,"","")/gie;
	}
# Brown WWP MCR with a link
#       Example: <mcr id="a090" corresp="n090" rend="pre(*)">Cabinet</mcr>
	if (/<mcr /i && /corresp=/i && $reftabexists) {
	   s/(<mcr [^>]*>)([^<]*)(<\/mcr>)/&refresolver($1,$2,$3)/gie;
	}
# Brown WWP SEG with a link 
#       Example: <seg rend="pre(*)" id="a07" corresp="n07">'Tother</seg>
	if (/<seg /i && /corresp=/i && $reftabexists) {
		s/(<seg [^>]*>)([^<]*)(<\/seg>)/&refresolver($1,$2,$3)/gie;
		}

# Notes: This is just to display different kinds of notes.  Note links
# are resolved above.  More of these should probably go away since
# we discourage inline and onpage notes, but hey, if you get 'em....
        if (/<note/i) {
                $tempnote = $_;
                if ($tempnote =~ /place="?foot/i) {
                        s/<NOTE[^>]*>/<P><span class=footnote>/gi;
                        }
                elsif ($tempnote =~ /place="?marg/i) {
                        s/<NOTE[^>]*>/<P><span class=marginnote>/gi;
                        }
                elsif ($tempnote =~ /place="?inlin/i) {
                        s/<NOTE[^>]*>/<P><span class=inlinenote>/gi;
                        }
                elsif ($tempnote =~ /place="?end/i) {
                        s/<NOTE[^>]*>/<P><span class=endnote>/gi;
                        }
                           # You have probably resolved most of the note
			   # targets above but for display purposes:
                elsif (/<note target=/i) { 
                    s/<note target=[^>]*>/<span class=notetarget>/gi;
                        }
                else {
		     s/<NOTE[^>]*>/<span class=generalnote>/gi;
		}
        }
        s/<\/NOTE>/<\/span>/gi;

# Line handling.  If you have line numbers, you can set the display here.
# Probably needs to be a subroutine.
	s/<L  *REND="indent\(.\)">/<l>&nbsp;&nbsp;&nbsp;/gi;
	s/<L  *REND="indent.">/<l>&nbsp;&nbsp;&nbsp;/gi;
#	s/<lb [^>]*>/<br>/gi;
	s/<lb>/<br>/gi;
	s/<ab [^>]*>/<br>\n/gi;
	s/<ab>/<br>\n/gi;
	s/(<L *[^>]*>)/<br>\n/gi;
	s/<\/l>/ /gi;

# Milestone handler 
        if (/<milestone/i) {
	     s/(<milestone[^>]*>)/&MilestoneHandler($1)/gie;
	  }

# Page Tags
	if (/<pb/i) {
		s/(<pb[^>]*>)/&PageTagHandler($1)/gie;
	}

# Abbreviation Expander
	if ($displayabbrexpan) {
	   if (/<abbr/i) {
		s/(<abbr[^>]*>[^<]*<\/abbr>)/&ExpandAbbrev($1)/gie;
	   }
        }
# MW handler for Brown WWP
#   <mw type="sig" rend="break(yes)align(center)">a.iii.</mw>
#   <mw type="catch" rend="align(right)">he can</mw>
        if (/<mw/i) {
	   s/<mw[^>]*>([^<]*)<\/mw>/<span class=mwright>$1<\/span>/gi;
	}

# Odds and ends....
	s/<q>//gi;                       # <q> make some browsers add "
	s/<q [^>]*>//gi;
	s/<\/q>//gi;
	s/<lg[^>]*>/<p>/gi;
	s/<\/lg[^>]*>/<br>/gi;
	s/<LIST[^>]*>/<p>/gi;
	s/<ref>/ <ref>/gi;              # A database specific fix

# Image links and captions -- displaying them for now.
# This should be a subroutine ... and probably to handle various
# kinds of external link resolution.  Look into xrefs as well.
	s/(<figure[^>]*>)/$1 <tt>[unresolved image link]<\/tt>/gi;
	s/(<figdesc>)/<tt>[figure description]<\/tt> $1/gi;
	s/(<\/figdesc>)/<tt>[end figure description]<\/tt> $1<p>/gi;

	$_ .= "\n";
	$text .= $_;
  }
    
# Convert Character Entities....
    if ($text =~ /&[\#0-9A-Za-z]*;/) {
        $text = &Ents2Unicode($text);
        $text = &EntityConvert($text);
        }
# You may need to clean up some things.
        $text =~ s/<BR><BR>/<BR>/gi;

# Add a couple of end spans just in case.
	$text .= "</span>\n</span>";
return $text;
}

# ----------------------------------------------------------------------
# nonewlines: changes newlines and DOS newlines to spaces inside of
#             tags.  For some reason, you get them.
# Called from: ObjectFormat
# ----------------------------------------------------------------------
sub nonewlines() {
	local ($thetag);
	$thetag = $_[0];
	$thetag =~ s/\n/ /g;
	$thetag =~ s/\015/ /g;
return $thetag;
}

# ----------------------------------------------------------------------
# refresolver: STILL EXPERIMENTAL.  Reads a document specific file
# stored in SYSTEM_DIR/references/$doc for ids and  mapping to 
# PhiloLogic objects to handle note references, pointers, etc.  
# Builds a hash table for these on first access.  The current format 
# of the reference file is (tab delimted)
# docid  objectid        objecttype  paraobj     pgobject  divobject
# 1      yeats.v3a.5fm   note        3:1:0:9     57        3:1:0 
# 112    p53             div         3:52:0:-1   130       3:52:0
# Build particular links by checking the objecttype when you find an
# objectid.  Note resolves to paraobj, pb to pgobject, div to
# div objects.  Particular databases will need tuning here.
# Called from: ObjectFormat
# ----------------------------------------------------------------------
sub refresolver() {
	local ($theref, $thelink, $theendref, $reffilepath, $reflinein);
	local ($thetarget, $x, $readmorerefs, $tempbuf, $LINK, $localdoc);
	local ($foundone, $t, $reftype);
	$theref = $_[0];
        $thelink = $_[1];
        $theendref = $_[2];
	$x = $theref;
# Grab internal reference (n="CHARS"), where CHARS is the
# symbol to click on.  This is for PhiloLogic TEI specification
        if (!$thelink) {
                if ($x =~ / n=/i) {
                        $x =~ m/n="([^"]*)"/i;
                        $thelink = $1;
                        }
                }

# For PhiloLogic Notes ... we are treating the note tag as a reverse
# ref, so in refresolver:

  if ($x =~ /<note/i) {
                $imanote = 1;
                $thelink = "page";
                if ($x =~ /resp=/i) {
                        $x =~ m/resp="([^"]*)"/i;
                        $noteresp = $1;
                        }
                if ($x =~ /place=/i) {
                        $x =~ m/place="([^"]*)"/i;
                        $noteplace = $1;
                        }
                }

# Objectids in the encoding I have seen can be either "target" or
# "corresp", so let's get that from the tag.  There may be others.
	if ($x =~ /target=/i) {
		$x =~ s/target="([^"]*)"//i;
		$thetarget = $1;
		}
	elsif ($x =~ /corresp=/i) {
		$x =~ s/corresp="([^"]*)"//i;
		$thetarget = $1;
		}
	$localdoc = $doc;
# Read the reference file, if you don't have one, and build the document
# hash table ... as a global so you don't read it lots of times.  Since
# this is called from ObjectFormat, you can assume only one document.
	if (!$gotreftable) {
		$reffilepath = $SYSTEM_DIR . "references/" . $localdoc;
		open (REFTABLEFH, "$reffilepath"); 
		$readmorerefs = 1;
		while ($reflinein = <REFTABLEFH>) {
			$gotreftable += 1;
			@t = split("\t", $reflinein);
			$tempbuf .= $reflinein . "\n";
			$DOCREFHASH{$t[1]} = $reflinein;
			}
		close (REFTABLEFH);
		@DOCREFLIST = split("\n", $tempbuf);
	}
# If you have the reference hash ... then check to see if you have the
# target in the hash.  If not, return the arguments of the call.  But you
# probably have something, so let's build the link.... I should probably
# add more types here.  
	if ($gotreftable) {
	    $foundone = "";
	    $foundone = $DOCREFHASH{$thetarget};
	    if ($foundone) {
	    	@arefline = split('\t', $foundone);
	    	if ($arefline[2] =~ /pb/i) {          # PAGE LINK: build link 
	           $refobject = $arefline[4] - 1;     # to page object.
		   	if ($refobject) {
			   if (!$thelink) {
				$thelink = "[page]";
				}
		           $LINK = "<a href=\"" . $PHILOGETOBJECT . "?";
			   $LINK .= "p." . $doc . ":" . $refobject;
			   $LINK .= "." . $dbname ."\">";
			   $LINK .= $thelink . "</a>";
			   }
			}
                       elsif ($arefline[2] =~ /note/i) { # NOTE LINK
                           $refobject = $arefline[3];
                           if ($refobject) {
                              if (!$thelink) {
                                   $thelink = "[note]";
                                   }
                              $LINK = " <a href=\"" . $PHILOGETOBJECT . "?";
                              $LINK .= "c." . $doc . ":" . $refobject;
			      $LINK .= "." . $dbname . '"';
			      $LINK .= $NOTEWINDOWPARAMS;
			      $LINK .= '>';
                              $LINK .= $thelink . "</a> ";
                              }
                        }

                       elsif ($arefline[2] =~ /anchor|div/i) { # ANCHOR/DIV LINK
                           $refobject = $arefline[5];
			   if ($refobject =~ /:\-1/) {
			   	$refobject =~ s/:\-1//g;
		           	}
                           if ($refobject) {
			      if (!$thelink) {
				   $thelink = "ptr";
				   }
                              $LINK = " [<a href=\"". $PHILOGETOBJECT . "?";
                              $LINK .= "c." . $doc . ":" . $refobject;
                              $LINK .= "." . $dbname ."\">";
                              $LINK .= $thelink . "</a>] ";
                              }
                        }

                       else {                               # UNSPECIFIED LINK
                           $refobject = $arefline[4] - 1;   # try to a page.
                           if ($refobject > 0) {
			      if (!$thelink) {
                                $thelink = "[page]";
                                }
                              $LINK = "<a href=\"" . $PHILOGETOBJECT . "?";
                              $LINK .= "p." . $doc . ":" . $refobject;
                              $LINK .= "." . $dbname ."\">";
                              $LINK .= $thelink . "</a>";
                              }
                        }

	}
}
	
# If you don't have a link, then return the args.  If you want to
# test things, uncomment the second line, which will return $thetarget
# and the number of items in the document reference table
	if (!$LINK) {
	     $LINK = $theref . $thelink .  $theendref;
#	     $LINK .= "[Tried " . $thetarget . " " . $gotreftable . "]";
	}

# Some links have REND arguments: typically for Table of Contents. So
# let's set the CSS for display purposes.
        if ($theref =~ /REND.*right/i) {
		$LINK = "<span class=refalignright>" . $LINK . "</span>";
		}
	$theref = "$LINK";

# If this is a note tag with a backpointer, ARTFL flavor...
        if ($imanote) {
                if ($noteplace) {
                    $theref = "<note place=\"" . $noteplace . "\"> [Note:";
                    }
                else {
                    $theref = "<note>[" . $philomessage[69] . ": ";
                    }
                if ($noteresp) {
                        $theref .= "(" . $noteresp . ") ";
                        }
                $theref .= $philomessage[70] . " ";
                $theref .=  $LINK . "] ";
                }
        else {
                $theref = "$LINK";
        }

return $theref;
}

# ----------------------------------------------------------------------
# kwicheader: Reads the result header for KWIC reports.  You can add 
#             things here.
# Called from:
# ----------------------------------------------------------------------
sub kwicheader {
local ($txt);
$txt = &readnavbar();
  if ($LINKDICT)
    {
      $txt .= quickdicjs($LINKDICT);
    }
return "$txt";
}

# ----------------------------------------------------------------------
# concheader: Reads the result header for CONC reports.  You can add 
#             things here.
# Called from:
# ----------------------------------------------------------------------
sub concheader {
local ($txt);
$txt = &readnavbar();
  if ($LINKDICT)
    {
      $txt .= quickdicjs($LINKDICT);
    }
return "$txt";
}

# ----------------------------------------------------------------------
# objectheader: Reads the result header and gets the bibliography
#               for the document.  Objects are called for only 1 document.
# Called from:
# ----------------------------------------------------------------------
sub objectheader {
local ($txt);
$txt = &readnavbar;
$txt .=  &getbiblioLine ($doc,"link") . "<hr noshade>\n";
  if ($LINKDICT)
    {
      $txt .= quickdicjs($LINKDICT);
    }
return "$txt";
}

# ----------------------------------------------------------------------
# contextheader: Reads the result header and gets the bibliography
#                for the document.  Objects are called for only 1 document.
#                Contextualization is typically to get a page from a hit.
# Called from:
# ----------------------------------------------------------------------
sub contextheader {
local ($txt);
$txt = &readnavbar;
$txt .=   &getbiblioLine ($doc,"link") . "<hr noshade>\n";
   if ($LINKDICT)
    {
      $txt .= quickdicjs($LINKDICT);
    }
return "$txt";
}

# ----------------------------------------------------------------------
# kwicfooter: Reads the result footer for KWIC reports.
# Called from:
# ----------------------------------------------------------------------
sub kwicfooter {
local ($txt);
$txt = "<hr>";
$txt .= &readfooternavbar;
return "$txt";
}

# ----------------------------------------------------------------------
# concfooter: Reads the result footer for CONC reports.
# Called from:
# ----------------------------------------------------------------------
sub concfooter {
local ($txt);
$txt = "<hr>";
$txt .= &readfooternavbar;
return "$txt";
}

# ----------------------------------------------------------------------
# objectfooter: Reads the result footer and generates a bibliography
#               for objects.
# Called from:
# ----------------------------------------------------------------------
sub objectfooter {
local ($txt);
$txt =  "<hr noshade>" . &getbiblioLine ($doc,"link") . "<hr noshade>\n";
$txt .= &readfooternavbar;
return "$txt";
}

# ----------------------------------------------------------------------
# contextfooter: Reads the result footer and generates a bibliography 
#                for objects contextualized from hits.
# Called from:
# ----------------------------------------------------------------------
sub contextfooter {
local ($txt);
$txt =  "<hr noshade>" . &getbiblioLine ($doc,"link") . "\n<hr noshade>\n";
$txt .= &readfooternavbar;
return "$txt";
}

# ----------------------------------------------------------------------
# GetHit: an internal function to read hit index data.
# Called from:
# ----------------------------------------------------------------------
sub GetHit {
    local($str);
    read (TFILE, $bufstr, 1024 * $hitsize) unless $readinit % 1024;
    $str = substr ($bufstr, $readinit++ % 1024 * $hitsize, $hitsize);
    return $str;
}

# ----------------------------------------------------------------------
# concheadline: generates the author/title info and contextual links
#               from hits.  I SHOULD use the standard bibliographic
#               info management, but I wrote this as an extension.
#               I may extend this to look at the div type file to
#               label the divs properly.
# Revised: 03/01/06, RSH. Made it a switcher based on philo-db.cfg
#variable $UseDicoDisplays.
# ----------------------------------------------------------------------

sub concheadline {
    if ($UseDicoDisplays) {
	$headline = &concheadlinedico(@_);
    } else {
	$headline = &concheadlinestandard(@_);
    }
    
    
    return $headline;
}


# ----------------------------------------------------------------------
# concheadlinestandard: generates the author/title info and contextual links
#               from hits, with standard formatting.
# ----------------------------------------------------------------------

sub concheadlinestandard {
    local ( $cite, $pagenum, $pref, @ohref ) = @_; 
    local ( $headline, @mvobibsplit, $conctit, $concauth, $mvoprocessed );
    local ( $mvobilioLine); 

    if ($mvoconclastdoc ne $doc) {
	open (MVOBIB, $SYSTEM_DIR . "bibliography");
	$mvoprocessed = 0;
	while ($mvoprocessed < $doc + 1) {
	    $mvobilioLine = <MVOBIB>;
	    $mvoprocessed++;
	}
	close (MVOBIB);
	@mvobibsplit = split("\t", $mvobilioLine);
	$concauth = $mvobibsplit[1];
	$concauth =~ s/<fs\/>/; /g;
	$concauth =~ s/, [0-9\-][0-9\/\-]*//g;
	$concauth =~ s/  *$//g;
	$conctit = $mvobibsplit[0];
	$conctit =~ s/<fs\/>/; /g;
	if (length($conctit) > 35) {
	    $conctit = substr($conctit,0,35);
	    $conctit =~ s/ [^ ]*$//;
	    $conctit .= "...";
	}
	if (length($concauth) > 20) {
	    $concauth = substr($concauth,0,20);
	    $concauth =~ s/ [^ ]*$//;
	    $concauth .= "... ";
	}      

	$mvonewcite = $concauth . ". " . "<i>" . $conctit . "</i>";
    }
    $mvoconclastdoc = $doc;
                                              
# A holdover from ATE specification where we have page tags as "nts"
# and link only to the "paragraph".  Leave it here since I will do an
# ATE version of all of this as well.
    if ($pagenum eq "nts") {                  
        $headline = "$mvonewcite ";          
        $headline .= "[$ohref[3] Note</a>] "; 
    }                                     

    else {                                    
	$div1 = $OBJECTLABELS[1];
        $div2 = $OBJECTLABELS[2];
        $div3 = $OBJECTLABELS[3];
	$headline = "$mvonewcite ";

# Put the contextualizations together....
# If you don't have a page tag, don't give a page link.
	if (!$pagenum || $pagenum eq "?" || $pagenum eq "na") {
	    $headline .= "[";
		}
        else {
		$headline .= "[" . $OBJECTLABELS[0] . $pref . " " . $pagenum . "</a> |\n";
		}
	$headline .= $ohref[3] .$OBJECTLABELS[4] .  "</a> |\n";

# Hack to fix problematic contextualizations in my text loader.
        if ($ohref[2] =~ /:0\./ || $ohref[2] eq "") {
	    $donothing = 1;
	}
	else {
	    $headline .= " $ohref[2] $div3</a> |";
	} 
#    $headline .= " $ohref[2] $div3</a> |" unless $ohref[2] eq "";

        if ($ohref[1] =~ /:0\./ || $ohref[1] eq "") {
	    $donothing = 1;
        }
        else {
	    $headline .= " $ohref[1] $div2</a> |";
        }
#    $headline .= " $ohref[1] $div2</a> |" unless $ohref[1] eq "";

	$headline .= " $ohref[0] $div1</a>]";
    }
    return $headline; 
}    
# ----------------------------------------------------------------------
# concheadlinedico: generates the author/title info and contextual links
#               from hits, formatted for dictionaries, with link head
#words and pages.
# ----------------------------------------------------------------------

sub concheadlinedico {
    local ( $cite, $pagenum, $pref, @ohref ) = @_;
    local ( $headline, @mvobibsplit, $conctit, $concauth, $mvoprocessed );
    local ( $mvobilioLine, $x );

    if ( !$mvoreaddividx ) {
        open( MVOBIB, $SYSTEM_DIR . "divindex.raw" );
        while ( $mvobilioLine = <MVOBIB> ) {
            @mvobibsplit = split( "\t", $mvobilioLine );
            $BAYLEDIVIDX{ $mvobibsplit[0] } = $mvobibsplit[1];
            $mvoreaddividx++;
        }
        close(MVOBIB);
    }

#   Patch to fix some broken ids, where we have a trailing 0th object
    $ohref[1] =~ s/c\.([0-9:]*)/&fixobjectphiloid($1)/gie;
    $ohref[1] =~ m/c\.([0-9:]*)/;
    $x = $1;
    $conctit = $BAYLEDIVIDX{$x};
    if ( !$conctit ) {
        $conctit = $philomessage[71];
    }
    # PATCH to preserve highlighting bytes
    $headline = $ohref[1] . " " . $conctit . "</a> ";   # MVO 03/08

    $div1 = $philomessage[72]  unless $div1;
    $div2 = $philomessage[73]  unless $div2;
    $div3 = $philomessage[74] unless $div3;

    # If you don't have a page tag, don't give a page link.
    if ( !$pagenum || $pagenum eq "?" || $pagenum eq "na" ) {
        $headline .= "]\n";
    }
    else {
        $headline .= "(" . $philomessage[75] . " $pref $pagenum</a>)\n";
    }

    return $headline;
}

# ----------------------------------------------------------------------
sub fixobjectphiloid {
        my $id = $_[0];
        $id =~ s/:0$//;
        my $rtn = "c." . $id;
return ($rtn)
}


# ----------------------------------------------------------------------
# readnavbar: This reads the general result header file found in the
#             database lib/ directory, Results_Header.html.  You can
#             as show below, modify it with various things if you want. 
# Called from:
# ----------------------------------------------------------------------
sub readnavbar {
	local ($navigbar, $navin, $mvosysdir, $philowhite);
	$mvosysdir = $SYSTEM_DIR;
	if (!$mvosysdir) {
		$mvosysdir = $sys_dir;
		}
	$philowhite = "$PHILOWEBURL" . "/philo_white.png";
	open (NAVBAR, $mvosysdir . "lib/Results_Header.html");
	while ($navin = <NAVBAR>) {
# Example of modifications we used at ARTFL to set particular things.
#		$navin =~ s/EFTSSEARCHFORM/$Search_Form/;
                $navin =~ s/ZZZPHILOWHITEPNGZZZ/$philowhite/g;

# If the $LINKDICT variable is turned on (in philo-db.cfg)
# add an onkeypress event to the body tag to check pressed
# keys to see if it is the key for opening the external dico
		if ($LINKDICT) {
		    $navin =~ s/<body(.*?)>/<body\1  onkeypress="if \(dictOn\) checkKeyPressed\(event\);">/gi;
		}

		$navigbar .= $navin;
		}
	close NAVBAR;
	return $navigbar;
}

# ----------------------------------------------------------------------
# readfooternavbar: This reads the general result footer file found in the
#             database lib/ directory, Results_Footer.html.  You can
#             as show below, modify it with various things if you want.
# Called from:
# ----------------------------------------------------------------------
sub readfooternavbar {
        local ($footernavbar, $navin, $mvosysdir, $powerby);
        $mvosysdir = $SYSTEM_DIR;
        if (!$mvosysdir) {
                $mvosysdir = $sys_dir;
                }
        $powerby = "$PHILOWEBURL" . "/philopowered.png";
        open (NAVBAR, $mvosysdir . "lib/Results_Footer.html");
        while ($navin = <NAVBAR>) {
# Example of modifications we used at ARTFL to set particular things.
#                $navin =~ s/EFTSSEARCHFORM/$Search_Form/;
#                $navin =~ s/EFTSDATABASEHOME/$eftsdatabasehome/g;
		 $navin =~ s/ZZZPHILOPOWEREDPNGZZZ/$powerby/g;


#################################################################
# If you remove the following line(s) without permission from the
# copyright holder(s) (and/or without providing equivalent
# functionality by other means) you are violating the license of
# PhiloLogic (AGPL clause 2d)

	$navin =~ s/DOWNLOADURLPLUSDBNAME/$PHILOCGI\/getsource.pl?dbname=$dbname/g;

##################################################################
# you're safe now, I guess.
#
                $footernavbar .= $navin;
                }
        close NAVBAR;
        return $footernavbar;
}

# ----------------------------------------------------------------------
# KwicFormat: Format some text for display in a KWIC report.  These are
#             oneline, fixed character width reports, so we want it
#             very simple.
# Called from:
# ----------------------------------------------------------------------
sub KwicFormat {
    local($bf) = $_[0];
    $bf=~s/^[^<]*>/ /;
    $bf=~s/<[^>]*$/ /;
# Abbreviation Expander
        if ($displayabbrexpan) {
           if ($bf =~ /<abbr/i) {
                $bf =~ s/(<abbr[^>]*>[^<]*<\/abbr>)/&ExpandAbbrev($1)/gie;
           }
        }
    $bf=~s/<[^>]*>//g;
    $bf=~tr/\012/ /;
    $bf=~tr/\015/ /;
    $bf=~s/\t/ /g;
    $bf=~s/\' /\'/g;
    $bf =~ s/\&nbsp;/ /gi;
    if ($bf =~ /&[\#0-9A-Za-z]*;/) {
        $bf = &Ents2Unicode($bf);
        $bf = &EntityConvert($bf);
        }
    $bf=~s/  *(["?,;:!\.\-)])/$1/g;
    $bf =~ s/\&amp;/ /gi;
    $bf =~ s/\&para;/ /g;
    $bf=~s/ +/ /g;
    return $bf;
}

# ----------------------------------------------------------------------
# PoleTransform: Format input text to be chopped up and counted in
#                collocation reports.  We want fairly simple words
#                here which will be split on " ".  
# Called from:
# ----------------------------------------------------------------------
sub PoleTransform {
    local($bf) = $_[0];
    $bf =~ tr/\012/ /;
    $bf =~ tr/\015/ /;
    $bf=~s/^[^<]*>/ /;
    $bf=~s/<[^>]*$/ /;
# Abbreviation Expander if it is set on.
        if ($displayabbrexpan) {
           if (/<abbr/i) {
                s/(<abbr[^>]*>[^<]*<\/abbr>)/&ExpandAbbrev($1)/gie;
           }
        }
    $bf =~ s/<[^>]*>/ /g;
    $bf =~ s/\&nbsp;/ /gi;
    $bf =~ s/&amp;/ /g;
    $bf =~ tr/A-Z/a-z/;
    $bf =~ s/\|//g;
    $bf =~ s/\+//g;
    $bf =~ s/[^a-z&;'\177-\344 ]/ /g;
# Break Apostrophes if set on.
    if ($breakapost) {
    	$bf =~ s/\'/\' /g;
	}
    $bf = &Ents2Unicode($bf);
    $bf = &EntityConvert($bf);
    $bf =~ s/&dagger;/ /g;
    $bf =~ s/&para;/ /g;
    $bf =~ s/&sect;/ /g;
    $bf =~ s/(["?,;:!\.\-])/ /g;
    $bf =~ s/\xc3([\x80-\x9E])/&UTF8up2low($1)/ge;
    $bf =~ s/ +/ /g;
    return $bf;
}

# ----------------------------------------------------------------------
# UTF8up2low: convert selected upper case UTF-8 characters to lower
#             case for collocations reports.  Your mileage may vary.
#             How many languages have case distinction like this.  :-)
# Called from: PoleTransform
# ----------------------------------------------------------------------
sub UTF8up2low() {
local ($onechar, $rtn);
      $onechar = $_[0];
      $onechar =~ tr/\x80-\x9E/\xA0-\xBE/;
      $rtn = "\xc3" . $onechar;
return $rtn;
}


# ----------------------------------------------------------------------
# ConcFormat: Format the text to display in a CONC (Concordance) Report.
#             We remove alot of tagging, since we want to have a fairly
#             consistent display of a "chunk" for each hit.  We tend
#             to keep lines and a few other things.
# Called from:
# ----------------------------------------------------------------------
sub ConcFormat {
    local($bf) = $_[0];
# A Hall of Shame Hack, right off the start, to eliminate putting header info
# in a concordance report.....
    if ($bf =~ /<\/teiheader>/i) {
                $bf =~ s/<\/teiheader>/XXXXZZZZ/i;
               ($temp, $bf) = split (/XXXXZZZZ/, $bf) ;
                }
# End Hall of Shame Hack...
    $bf=~s/ ([?,;:!\.\-])/$1/g;
    $bf =~ s/^[^ \n]*[ \n]// if $lo;
    $bf =~ s/[^ \n]*$// unless $ro + $rl == $dl;
    if ($bf =~ /&[\#0-9A-Za-z]*;/) {
	$bf = &Ents2Unicode($bf);
    	$bf = &EntityConvert($bf);
	}
    $bf =~ s/^[^<]*>//;
    $bf =~ s/<[^>]*$//;
# Abbreviation Expander
        if ($displayabbrexpan) {
           if ($bf =~ /<abbr/i) {
                $bf =~ s/(<abbr[^>]*>[^<]*<\/abbr>)/&ExpandAbbrev($1)/gie;
           }
        }

    $bf =~ s:</*[hH][1-3]>: :g;
    $bf =~ s:<br>: :gi;
    $bf =~ s:</*[pP]>: :g;
    $bf =~ s:</*center>: :gi;
    $bf =~ s:</*table[^>]*>: :gi;
    $bf =~ s/<\/?head[^>]*>/ /gi;
    $bf =~ s/<\/?div[^>]*>/ /gi;
    $bf =~ s/<\/?q[^>]*>/ /gi;
    $bf =~ s/<\/?emph[^>]*>//gi;
    $bf =~ s/<\/?del[^>]*>/ /gi;
    $bf =~ s/<\/?ref[^>]*>/ /gi;
    $bf =~ s/<\/?note[^>]*>/ /gi;
    $bf =~ s/<\/?hi[^>]*>//gi;
    $bf =~ s/<\/?title[^>]*>//gi;
    $bf =~ s/<\/?advert[^>]*>//gi;
    $bf =~ s/<\/?item[^>]*>/ /gi;
    $bf =~ s/<\/?label[^>]*>/ /gi;
    $bf =~ s/<\/?milestone[^>]*\/?>/ /gi;
    $bf =~ s/<\/?sp[^>]*>/ /gi;
    $bf =~ s/<\/?anchor[^>]*\/>/ /gi;
    $bf =~ s/<\/?ptr[^>]*\/?>/ /gi;
    $bf =~ s/<pb[^>]*\/?>/ /gi;
    $bf =~ s/<\/?s[^>]*>//g;
    $bf =~ s/<l n="([^"]*)">/<br><font size="-1">$1<\/font>&nbsp;&nbsp;/gi;
    $bf =~ s/<l[\n ]*[^>]*>/<br>\n/gi;
    $bf =~ s/<l>/<br>\n/gi;
    $bf =~ s/<\/l>/ /gi;
    $bf =~ s/<lg[\n ][^>]*>/ /gi;
    $bf =~ s/<\/lg>/ /gi;
    $bf =~ s/<\/?row[^>]*>//gi;
    $bf =~ s/<\/?cell[^>]*>//gi;

    return $bf;
}

# ----------------------------------------------------------------------
# DFperiodbuild: generate a period as selected by the user for hit
#                frequencies by period.  Input should be 4 int, years.
# Called from: search2t
# ----------------------------------------------------------------------
sub DFperiodbuild {
    local ($p, $quarter);
    $p = $_[0];
    if (!$DFPERIOD) {
        return $p;
	}
    if ($p =~ /[A-Za-z]/) {
	return $p;
	}
    $p =~ s/ //g;
    $p =~ s/\?//g;
    if ($DFPERIOD eq "1") {                              # by decade
    	$p =~ s/([0-9])[0-9]$/$1 _BLANK_ 0\-$1 _BLANK_ 9/;
        $p =~ s/ _BLANK_ //g;
	}
    elsif ($DFPERIOD eq "2") {                           # by quarter
 	$p =~ s/([0-9][0-9])$//;
	$quarter = $1;
	if ($quarter < 25) {
		$p .= "00-24";
	}elsif ($quarter < 50) {    
                $p .= "25-49";
	}elsif ($quarter < 75) {    
                $p .= "50-74";
	}else{
		$p .= "75-99";
	}
    }	
    elsif ($DFPERIOD eq "3") {                           # by half century
	$p =~ s/[0-4][0-9]$/00\-49/;
	$p =~ s/[5-9][0-9]$/50\-99/;
         }	
    elsif ($DFPERIOD eq "4") {                           # by century
	$p =~ s/[0-9][0-9]$/00\-99/;
         }	
    else {
	$p =~ s/([0-9])[0-9]$/$1 _BLANK_ 0\-$1 _BLANK_ 9/;
	$p =~ s/ _BLANK_ //g;
	}
    return $p;
}

# ----------------------------------------------------------------------
#  NavigBiblio: generate the bibliography for document navigation/TOC.
# Called from: the cgi-bin function navigate
# ----------------------------------------------------------------------
sub NavigBiblio {
	local ($doc, $rtn);
	$doc = $_[0];
	$rtn = "<span class=navhead>" . $philomessage[76] . "</span><p>\n";
	$rtn .= "<span class=navbiblio>";
	$rtn .= &getbiblioLine($doc);
	$rtn .= "</span>\n<p>\n";
return $rtn;
}

# ----------------------------------------------------------------------
# SelectBiblio: generate the bibliography for document navigation/TOC
#               in the dyanmically generated Search on Selected Parts.
# Called from: cgi-bin/*/select
# ----------------------------------------------------------------------
sub SelectBiblio {
        local ($doc, $rtn);
        $doc = $_[0];
        $rtn = "<span class=navhead>" . $philomessage[304] . "</span><p>\n";
        $rtn .= "<span class=navbiblio>";
        $rtn .= &getbiblioLine($doc);
        $rtn .= "</span>\n<p>\n";
return $rtn;
}

# ----------------------------------------------------------------------
# NavDivTitle: Format div identifiers (typically heads) in navigation/TOC.
#              To stop the display in ToC, return "" for selected titles
#              such as "HyperDiv".
# Called from:
# ----------------------------------------------------------------------
sub NavDivTitle {
	local ($rtn);
	$rtn = $_[0];
	if ($rtn =~ /\[hyperdiv\]/i) {
		$rtn = "";
		}
	$rtn =~ s/\&dot;/\./g;
	$rtn =~ s/_//g;
return $rtn;
}

# ----------------------------------------------------------------------
# FreqFormat: Format identifiers in frequency reports.  
# Called from: mkfreqtitleline.  
# ----------------------------------------------------------------------
sub FreqFormat {
        local ($rtn);
        $rtn = $_[0];
        $rtn =~ s/\&dot;/\./g;
	$rtn =~ s/<fs\/?>/; /g;
return $rtn;
}

# ----------------------------------------------------------------------
# mkSelectSearch: generates the form to "Search in Selected Parts".
# Called from: cgi-bin/*/select    
# ----------------------------------------------------------------------
sub mkSelectSearch {
local ($rtn);
$rtn = "<FORM ACTION=\"". $PHILOSEARCH3T . "\">\n";
$rtn .= "<hr>\n";
$rtn .= $philomessage[77] . ": <INPUT NAME=\"word\" SIZE=20>"; 
$rtn .= "&nbsp;&nbsp;";
$rtn .= "<INPUT TYPE=\"submit\" VALUE=\"" . $philomessage[298] . "\">
     <inPUT TYPE=\"reset\" VALUE=\"" . $philomessage[297] . "\"><p>\n";
$rtn .= &SearchContextOptions;
$rtn .= "<br>\n";
$rtn .= &SearchResultOptions(1);
$rtn .= "<INPUT TYPE=\"hidden\" NAME=\"dbname\" VALUE=\"" . $dbname . "\">
     <INPUT TYPE=\"hidden\" NAME=\"DOCUMENT\" VALUE=\"" . $doc . "\"> <br>\n";
$rtn .= "<hr><center><b>" . $philomessage[78] . "</center></b><p>\n";
return $rtn;
}

# ----------------------------------------------------------------------
# getKWICtitle: generates the shortcite on the left hand of KWIC report
#               report and adds a link to the page if available.                                                                                                                       
#               We are using a fix character width representation.  The                                                                                                                
#               shrt cite ($title) is an identifier.  We should probably                                                                                                                
#               avoid using HTML formatting here and talk to CSS. 
# Revised: 03/01/06, RSH. Made it a switcher based on philo-db.cfg
#variable $UseDicoDisplays.
# ----------------------------------------------------------------------

sub getKWICtitle {
    if ($UseDicoDisplays) {
	$title = &getKWICtitledico(@_);
    } else {
	$title = &getKWICtitlestandard(@_);
    }
    
    
    return $title;
}

# ----------------------------------------------------------------------
# getKWICtitlestandard: formats the shrt cite on the left hand of the KWIC
#               in the format for non-dictionary texts.
# Revised: Nov 10 2004, MVO.  Added the nocounter option for handling
#          sorted KWICs.
# ----------------------------------------------------------------------
sub getKWICtitlestandard {
	local ($title, $nocounter, $intlink);
	$nocounter = $_[0];
        $title = $citebuffer[$doc];            # get the shrt cite
	$intlink = "<a href=\"#" . $title . "\">";
        $title =~ s/&nbsp;//g;                 # no spaces please
	$title = &KwicFormat($title);
	$title_length = length($title) + length($counter) + 1;
        if ($title_length > $maxhead) {
           $title = substr ($title, 0, $maxhead - 4 - length($counter));
           $title .= "...";
           $title_length = $maxhead;
           }
        if ($nocounter) {
            $title_length = length($title) + 1 + 4;
            }
        else {
            $title_length = length($title) + length($counter) + 1;
            }
        if ($title_length > $maxhead) {
           if ($nocounter) {
               $title = substr ($title, 0, $maxhead - 4 - 4);
               }
           else {
               $title = substr ($title, 0, $maxhead - 4 - length($counter));
               }
           $title .= "...";
           $title_length = $maxhead;
           }
	pop (@o);
        if (!$ChainLinksRestricted) {
	    $href = "<A HREF=\"" . $CONTEXTUALIZER . "?p."; 
            $href .= $doc . "." .  $dbname . "." . join (".", @o) . "\">";
	    }
        else {
	    $hitlist =~ s/^.*\.//g;
	    $href = "<A HREF=\"" . $CONTEXTUALIZER . "?p.";
            $href .= $hitlist . "." . $dbname . "." . ($counter-1);
            $href .= "." . $CONTEXT . "." . $WORDS . ".0\">";
	    }
# Put it all together now.
# First the title.
        if ($nocounter) {
             $title = "<tt>" . ". <b>" . $title . "</a></b></tt><tt> </tt>";
             #$title .= "<tt>" . $intlink . "bib</a> </tt>"; 
              }
        else {
               $title = "<tt>" . $counter . ". <b>" . $title;
               $title .= "</b></tt><tt> </tt>"; 
             }
	$title .= "<tt>(" . $intlink . "bib</a>:</tt>";
# Then the pagenumber and the link to the 
# page if we have a page
        if ($pagenum eq "?" || $pagenum eq "0") {
		$title .= "<tt>p." . $pagenum . ")</tt>";	
		}
	else {
        	$title .= $href . "<tt>p." . $pagenum . "</a>)</tt>";
	}
return $title;
}

# ----------------------------------------------------------------------
# getKWICtitledico: formats the shrt cite on the left hand of the KWIC
#                for use in dictionaries.
# Called from:
# Added in Philo 3.002
# ----------------------------------------------------------------------
sub getKWICtitledico {
    local ($title, $nocounter, $intlink, $x, $thisobject, $mvobilioLine);
    local ($mvobibsplit, $contit, $thislink, $offs, $mvohref);
#    $nocounter = $_[0];
    $nocounter = 1;
# Restored from STANDARD
    $mvohref = "<A HREF=\"" . $CONTEXTUALIZER . "?p."; 
    $mvohref .= $doc . "." .  $dbname . "." . join (".", @o) . "\">";
# END

    $thisobject = $doc . ":" . @index[0];
    if (@index[1] > 0) {
        $thisobject .= ":" . @index[1];
    }
    if (@index[2] > 0) {
        $thisobject .= ":" . @index[2];
    }

    if (!$mvoreaddividx) {
        open (MVOBIB, $SYSTEM_DIR . "divindex.raw");
        while ($mvobilioLine = <MVOBIB>) {
            @mvobibsplit = split("\t", $mvobilioLine);
            $BAYLEDIVIDX{$mvobibsplit[0]} = $mvobibsplit[1];
            $mvoreaddividx++;
        }
        close (MVOBIB);
    }

    $conctit = $BAYLEDIVIDX{$thisobject};
    if (!$conctit) {
        $conctit = $philomessage[71];
    }
    else {
        $offs = join(".", @o);
        $offs =~ s/\.[0-9]*$//;
        $thislink = "<a href=\"" . $PHILOGETOBJECT . "?c." . $thisobject;
        $thislink .= "." . $dbname . "." . $offs . "\">";
    }
    $title = $conctit;
    $title =~ s/ *$//;
    $title =~ s/\*//g;
    $title =~ s/ +/ /g;
    $title =~ s/^ +//g;
    $title =~ s/\xc3\xA7/c/g;
    $title = &KwicFormat($title);

    $title_length = length($title) + length($counter) + 1;
    if ($title_length > $maxhead) {
        $title = substr ($title, 0, $maxhead - 4 - length($counter));
        $title .= "...";
        $title_length = $maxhead;
    }
    if ($nocounter) {
        $title_length = length($title) + 1 + 4;
    }
    else {
        $title_length = length($title) + length($counter) + 1;
    }

    if ($title_length > $maxhead) {
        if ($nocounter) {
            $title = substr ($title, 0, $maxhead - 4 - 4);
        }
        else {
            $title = substr ($title, 0, $maxhead - 4 - length($counter));
        }
        $title .= "...";
        $title_length = $maxhead;
    }

# First the title.
    if ($nocounter) {
        $title = $thislink . "<tt>" . $title . "</a>:</tt>";
    }
    else {
        $title = "<tt>" . $counter . ". </tt>";
        $title .= $thislink . "<tt>" .  $title;
        $title .= "</a>:</tt>";
    }

    if ($pagenum eq "?" || $pagenum eq "0") {
        $title .= "<tt>p." . $pagenum . ")</tt>";       
    }
    else {
        $title .= " " . $mvohref . "<tt>(p." . $pagenum . ")</a></tt>";
    }
 
   # $pagenum_length = 0;
    return $title;
}


# ----------------------------------------------------------------------
# ConcSpan: Puts the end hit format tag at the end of a word.  Required
#           because we only know where the word begins.  May need to
#           be modified for spanning particular tags that should not
#           break words.
# Called from: artfl_conc.pl, theme_rheme.pl
# ----------------------------------------------------------------------
sub ConcSpan {
   local ($concline);
   $concline = $_[0];
   $concline = &EntityConvert($concline); 
   $concline =~ s/([<\.\'\ "\?\n\:\-,\!\@\$\%\^\*])/$hithighoff_conc$1/;
return $concline;
}

# ----------------------------------------------------------------------
# KwicSpan: Puts the end hit format tag at the end of a word.  Required
#           because we only know where the word begins.  May need to
#           be modified for spanning particular tags that should not
#           break words.
# Called from:
# ----------------------------------------------------------------------
sub KwicSpan {
  local ($kwicline);
  $kwicline = $_[0];
  $kwicline = &EntityConvert($kwicline); 
  $kwicline =~ s/([<\.\'\ "\?\n\:\-,\!\@\$\%\^\*\(\)])/$hithighoff_kwic$1/;
return $kwicline;
}

# ----------------------------------------------------------------------
# PoleSpan: Puts the end hit format tag at the end of a word.  Required
#           because we only know where the word begins.  May need to
#           be modified for spanning particular tags that should not
#           break words.  In this case, I am using the format convention
#           to get the hit word in collocations (ugly).
# Called from:
# ----------------------------------------------------------------------
sub PoleSpan {
  local ($poleline);
  $poleline = $_[0];
  $poleline = &EntityConvert($poleline);
  $poleline =~ s/([<\.\'\ "\?\n\:\-,\@\$\%\^\*])/$hithighoff_kwic$1/;
return $poleline;
}

# ----------------------------------------------------------------------
# ObjectSpan: Puts the end hit format tag at the end of a word.  Required
#             because we only know where the word begins.  May need to
#             be modified for spanning particular tags that should not
#             break words.
# Called from:
# ----------------------------------------------------------------------
sub ObjectSpan {
  local ($object);
  $object = $_[0];
  $object = &EntityConvert($object);
  $object =~ s:([\t\n\.,\!\?\`<> \~/\:\@\$\%\^\*\-]):$hithighoff_obj$1:;
return $object;
}

# ----------------------------------------------------------------------
# EntityConvert: Converts Character Entities to printable characters.
#                Ideally, this would come from an external character
#                registration table.
# Called from:
# ----------------------------------------------------------------------
sub EntityConvert {
    local ($bf);
    $bf = $_[0];
    $bf =~ s/\&dot;/\./g;
#    $bf =~ s/&s;/S/gi;
    $bf =~ s/&([sS]);/$1/gi;
    $bf =~ s/&sol;/\//gi;
    $bf =~ s/\&dollar;/\$/gi;
    $bf =~ s/&lsquo;/`/g;
    $bf =~ s/&rsquo;/'/g;
    $bf =~ s/&ldquo;/"/gi;
    $bf =~ s/&rdquo;/"/gi;
    $bf =~ s/&apos;/'/g;
    $bf =~ s/&hyphen;/-/g;
    $bf =~ s/&quest;/\?/g;
    $bf =~ s/&excl;/\!/g;
    $bf =~ s/&blank;/ /g;
    $bf =~ s/&colon;/:/g;
    $bf =~ s/&ast;/\*/g;
    $bf =~ s/\&mdash;/-/gi;
    $bf =~ s/\&sdash;/-/gi;
    $bf =~ s/\&shy;/-/gi;
return $bf;
}

# ----------------------------------------------------------------------
# Ents2Unicode: converts selected character entities to UTF-8.  This
#               should come from an external character registration table.
# Called from:  collocation and kwic reports (I think).
# ----------------------------------------------------------------------
sub Ents2Unicode {
     local ($bf);
     $bf = $_[0];
     $bf =~ s/\&Agrave;/\xc3\x80/g; 
     $bf =~ s/\&Aacute;/\xc3\x81/g; 
     $bf =~ s/\&Acirc;/\xc3\x82/g;
     $bf =~ s/\&Atilde;/\xc3\x83/g;
     $bf =~ s/\&Auml;/\xc3\x84/g;
     $bf =~ s/\&Aring;/\xc3\x85/g;
     $bf =~ s/\&AElig;/\xc3\x86/g;
     $bf =~ s/\&Ccedil;/\xc3\x87/g;
     $bf =~ s/\&Egrave;/\xc3\x88/g;
     $bf =~ s/\&Eacute;/\xc3\x89/g;
     $bf =~ s/\&Ecirc;/\xc3\x8A/g;
     $bf =~ s/\&Euml;/\xc3\x8B/g;
     $bf =~ s/\&Igrave;/\xc3\x8C/g;
     $bf =~ s/\&Iacute;/\xc3\x8D/g;
     $bf =~ s/\&Icirc;/\xc3\x8E/g;
     $bf =~ s/\&Iuml;/\xc3\x8F/g;
     $bf =~ s/\&ETH;/\xc3\x90/g;
     $bf =~ s/\&Ntilde;/\xc3\x91/g;
     $bf =~ s/\&Ograve;/\xc3\x92/g;
     $bf =~ s/\&Oacute;/\xc3\x93/g;
     $bf =~ s/\&Ocirc;/\xc3\x94/g;
     $bf =~ s/\&Otilde;/\xc3\x95/g;
     $bf =~ s/\&Ouml;/\xc3\x96/g;
     $bf =~ s/\&#215;/\xc3\x97/g; # MULTIPLICATION SIGN
     $bf =~ s/\&Oslash;/\xc3\x98/g;
     $bf =~ s/\&Ugrave;/\xc3\x99/g;
     $bf =~ s/\&Uacute;/\xc3\x9A/g;
     $bf =~ s/\&Ucirc;/\xc3\x9B/g;
     $bf =~ s/\&Uuml;/\xc3\x9C/g;
     $bf =~ s/\&Yacute;/\xc3\x9D/g;
     $bf =~ s/\&THORN;/\xc3\x9E/g;
     $bf =~ s/\&szlig;/\xc3\x9F/g;
     $bf =~ s/\&agrave;/\xc3\xA0/g;
     $bf =~ s/\&aacute;/\xc3\xA1/g;
     $bf =~ s/\&acirc;/\xc3\xA2/g;
     $bf =~ s/\&atilde;/\xc3\xA3/g;
     $bf =~ s/\&auml;/\xc3\xA4/g;
     $bf =~ s/\&aring;/\xc3\xA5/g;
     $bf =~ s/\&aelig;/\xc3\xA6/g;
     $bf =~ s/\&ccedil;/\xc3\xA7/g;
     $bf =~ s/\&egrave;/\xc3\xA8/g;
     $bf =~ s/\&eacute;/\xc3\xA9/g;
     $bf =~ s/\&ecirc;/\xc3\xAA/g;
     $bf =~ s/\&euml;/\xc3\xAB/g;
     $bf =~ s/\&igrave;/\xc3\xAC/g;
     $bf =~ s/\&iacute;/\xc3\xAD/g;
     $bf =~ s/\&icirc;/\xc3\xAE/g;
     $bf =~ s/\&iuml;/\xc3\xAF/g;
     $bf =~ s/\&eth;/\xc3\xB0/g;
     $bf =~ s/\&ntilde;/\xc3\xB1/g;
     $bf =~ s/\&ograve;/\xc3\xB2/g;
     $bf =~ s/\&oacute;/\xc3\xB3/g;
     $bf =~ s/\&ocirc;/\xc3\xB4/g;
     $bf =~ s/\&otilde;/\xc3\xB5/g;
     $bf =~ s/\&ouml;/\xc3\xB6/g;
     $bf =~ s/\&#247;/\xc3\xB7/g;   #  DIVISION SIGN
     $bf =~ s/\&oslash;/\xc3\xB8/g;
     $bf =~ s/\&ugrave;/\xc3\xB9/g;
     $bf =~ s/\&uacute;/\xc3\xBA/g;
     $bf =~ s/\&ucirc;/\xc3\xBB/g;
     $bf =~ s/\&uuml;/\xc3\xBC/g;
     $bf =~ s/\&yacute;/\xc3\xBD/g;
     $bf =~ s/\&thorn;/\xc3\xBE/g;
     $bf =~ s/\&yuml;/\xc3\xBF/g;
    $bf =~ s/\&agr;/\xce\xb1/g;
    $bf =~ s/\&alpha;/\xce\xb1/g;
    $bf =~ s/\&bgr;/\xce\xb2/g;
    $bf =~ s/\&beta;/\xce\xb2/g;
    $bf =~ s/\&ggr;/\xce\xb3/g;
    $bf =~ s/\&gamma;/\xce\xb3/g;
    $bf =~ s/\&dgr;/\xce\xb4/g;
    $bf =~ s/\&delta;/\xce\xb4/g;
    $bf =~ s/\&egr;/\xce\xb5/g;
    $bf =~ s/\&epsilon;/\xce\xb5/g;
    $bf =~ s/\&zgr;/\xce\xb6/g;
    $bf =~ s/\&zeta;/\xce\xb6/g;
    $bf =~ s/\&eegr;/\xce\xb7/g;
    $bf =~ s/\&eta;/\xce\xb7/g;
    $bf =~ s/\&thgr;/\xce\xb8/g;
    $bf =~ s/\&theta;/\xce\xb8/g;
    $bf =~ s/\&igr;/\xce\xb9/g;
    $bf =~ s/\&iota;/\xce\xb9/g;
    $bf =~ s/\&kgr;/\xce\xba/g;
    $bf =~ s/\&kappa;/\xce\xba/g;
    $bf =~ s/\&lgr;/\xce\xbb/g;
    $bf =~ s/\&lambda;/\xce\xbb/g;
    $bf =~ s/\&mgr;/\xce\xbc/g;
    $bf =~ s/\&mu;/\xce\xbc/g;
    $bf =~ s/\&ngr;/\xce\xbd/g;
    $bf =~ s/\&nu;/\xce\xbd/g;
    $bf =~ s/\&xgr;/\xce\xbe/g;
    $bf =~ s/\&xi;/\xce\xbe/g;
    $bf =~ s/\&ogr;/\xce\xbf/g;
    $bf =~ s/\&omicron;/\xce\xbf/g;
    $bf =~ s/\&pgr;/\xcf\x80/g;
    $bf =~ s/\&pi;/\xcf\x80/g;
    $bf =~ s/\&rgr;/\xcf\x81/g;
    $bf =~ s/\&rho;/\xcf\x81/g;
    $bf =~ s/\&sfgr;/\xcf\x82/g;
    $bf =~ s/\&sigmaf;/\xcf\x82/g;
    $bf =~ s/\&sgr;/\xcf\x83/g;
    $bf =~ s/\&sigma;/\xcf\x83/g;
    $bf =~ s/\&tgr;/\xcf\x84/g;
    $bf =~ s/\&tau;/\xcf\x84/g;
    $bf =~ s/\&ugr;/\xcf\x85/g;
    $bf =~ s/\&upsilon;/\xcf\x85/g;
    $bf =~ s/\&phgr;/\xcf\x86/g;
    $bf =~ s/\&phi;/\xcf\x86/g;
    $bf =~ s/\&khgr;/\xcf\x87/g;
    $bf =~ s/\&chi;/\xcf\x87/g;
    $bf =~ s/\&psgr;/\xcf\x88/g;
    $bf =~ s/\&psi;/\xcf\x88/g;
    $bf =~ s/\&ohgr;/\xcf\x89/g;
    $bf =~ s/\&omega;/\xcf\x89/g;
    $bf =~ s/\&Agr;/\xce\x91/g;
    $bf =~ s/\&Alpha;/\xce\x91/g;
    $bf =~ s/\&Bgr;/\xce\x92/g;
    $bf =~ s/\&Beta;/\xce\x92/g;
    $bf =~ s/\&Ggr;/\xce\x93/g;
    $bf =~ s/\&Gamma;/\xce\x93/g;
    $bf =~ s/\&Dgr;/\xce\x94/g;
    $bf =~ s/\&Delta;/\xce\x94/g;
    $bf =~ s/\&Egr;/\xce\x95/g;
    $bf =~ s/\&Epsilon;/\xce\x95/g;
    $bf =~ s/\&Zgr;/\xce\x96/g;
    $bf =~ s/\&Zeta;/\xce\x96/g;
    $bf =~ s/\&EEgr;/\xce\x97/g;
    $bf =~ s/\&Eta;/\xce\x97/g;
    $bf =~ s/\&THgr;/\xce\x98/g;
    $bf =~ s/\&Theta;/\xce\x98/g;
    $bf =~ s/\&Igr;/\xce\x99/g;
    $bf =~ s/\&Iota;/\xce\x99/g;
    $bf =~ s/\&Kgr;/\xce\x9a/g;
    $bf =~ s/\&Kappa;/\xce\x9a/g;
    $bf =~ s/\&Lgr;/\xce\x9b/g;
    $bf =~ s/\&Lambda;/\xce\x9b/g;
    $bf =~ s/\&Mgr;/\xce\x9c/g;
    $bf =~ s/\&Mu;/\xce\x9c/g;
    $bf =~ s/\&Ngr;/\xce\x9d/g;
    $bf =~ s/\&Nu;/\xce\x9d/g;
    $bf =~ s/\&Xgr;/\xce\x9e/g;
    $bf =~ s/\&Xi;/\xce\x9e/g;
    $bf =~ s/\&Ogr;/\xce\x9f/g;
    $bf =~ s/\&Omicron;/\xce\x9f/g;
    $bf =~ s/\&Pgr;/\xce\xa0/g;
    $bf =~ s/\&Pi;/\xce\xa0/g;
    $bf =~ s/\&Rgr;/\xce\xa1/g;
    $bf =~ s/\&Rho;/\xce\xa1/g;
    $bf =~ s/\&Sgr;/\xce\xa3/g;
    $bf =~ s/\&Sigma;/\xce\xa3/g;
    $bf =~ s/\&Tgr;/\xce\xa4/g;
    $bf =~ s/\&Tau;/\xce\xa4/g;
    $bf =~ s/\&Ugr;/\xce\xa5/g;
    $bf =~ s/\&Upsilon;/\xce\xa5/g;
    $bf =~ s/\&PHgr;/\xce\xa6/g;
    $bf =~ s/\&Phi;/\xce\xa6/g;
    $bf =~ s/\&KHgr;/\xce\xa7/g;
    $bf =~ s/\&Chi;/\xce\xa7/g;
    $bf =~ s/\&PSgr;/\xce\xa8/g;
    $bf =~ s/\&Psi;/\xce\xa8/g;
    $bf =~ s/\&OHgr;/\xce\xa9/g;
    $bf =~ s/\&Omega;/\xce\xa9/g;
return $bf;
}

# ----------------------------------------------------------------------
# MilestoneHandler: formats milestone tags for display.  These vary 
#       considerably among valid TEI encoded documents.  What follows
#       is based on examples from various samples.
# Called from: ObjectFormat
# ----------------------------------------------------------------------
sub MilestoneHandler {
	local ($rtn, $milestonein, $milestone, $n, $unit, $id);
	$milestone = $_[0];
	$milestonein = $milestone;
	$milestone =~ s/unit="([^"]*)"//i;
	$unit = $1;
	$milestone =~ s/id="([^"]*)"//i;
	$id = $1;
	$milestone =~ s/ n="([^"]*)"//i;
	$n = $1;
	if ($unit =~ /typography/i) {
		$rtn = "<span class=mstonetype>" . $n . "</span>";
		return $rtn;
		}
	if ($n) { 
		$rtn = "<span class=mstonen>" . $n . "</span>";
		return $rtn;
		}
	if ($id) { 
		$rtn = "<span class=mstoneid>" . $id . "</span>";
		return $rtn;
		}
$rtn = $milestonein;
return $rtn;
}

# ----------------------------------------------------------------------
# PageTagHandler: formats page tags for display.  Use CSS for this?
# Called from: ObjectFormat
# ----------------------------------------------------------------------
sub PageTagHandler {
	local ($rtn, $pagetag, $pgnumber);
	$pagetag = $_[0];
	$pagetag =~ s/ n="([^"]*)"//i;
	$pgnumber = $1;
	if (!$pgnumber) {
		$pgnumber = "na";
	}
       $rtn = "<p><center> -- " . $pgnumber . " -- </center><p>";
return $rtn;
}

# ----------------------------------------------------------------------
# ExpandAbbrev: Expand Abbreviations if set for display. 
# Called from: ObjectFormat, ConcFormat, KwicFormat 
# ----------------------------------------------------------------------
sub ExpandAbbrev {
	local ($rtn, $abbrev, $r, $c);
	$abbrev = $_[0];
	$c = $abbrev;
	$abbrev =~ s/expan="([^"]*)"//i;
	$r = $1;
	if ($r) {
		$rtn = "<u>" . $r . "</u>";
	}		
	else {
		$rtn = $c;
	}
return $rtn;
}

# ----------------------------------------------------------------------
# SearchInBibliogrphy: Print a search box with bibliography if set            
# Called from: search2t if the global variable $searchfrombibliography,
# set in philo-db.cfg is > 0;  This is only for initial searches. I am
# keeping it simple, so no search/output options.
# Suggested by Julia Flanders.
# ----------------------------------------------------------------------

sub SearchInBibliography {
	local ($rtn, $theform, $gimlist, $x, $y, $arg, $value);
	$theform = '<form action="' . $PHILOSEARCH3T . '">';
	$theform .= sprintf($philomessage[26], $length);
	$theform .= "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	$theform .= " " . $philomessage[79] . ": ";
	$theform .= '<input name="word" size="10"> ';
        $theform .= '<input type="submit" value="Go">';
        $theform .= ' (' . $philomessage[81] . ', <tt>' . $philomessage[80] . '</tt>)';
	$theform .= '<input type="hidden" name="CONJUNCT" ';
	$theform .= 'value="PHRASE">';
	$theform .= '<input type="hidden" name="DISTANCE" ';
	$theform .= 'value="3">';
	$theform .= '<input type="hidden" name="dbname" ';
	$theform .= 'value="' . $dbname . '">';
	if ($gimme_arg) {
	    @gimlist = split(" ", $gimme_arg); 
	    foreach $x (@gimlist) {
		($arg, $value) = split("=", $x);
		$theform .= "<input type=\"hidden\" ";
		$theform .= "name=\"" . $arg . "\" ";
		$theform .= "value=\"" . $value . "\">";
	        } 
	}
	$theform .= '</form>';
	$rtn = $theform;
return ($rtn);
}


# ----------------------------------------------------------------------
# SimilarWordSearch: If you fail to get any word matches from crapser,
# usually the result of a typo or some other problem, run an agrep 
# (approximate grep) search on the word list. Check to see if agrep 
# is installed on the system.  Not certain what it will do with all
# of our Unicode, reg-ex matching.  
# ----------------------------------------------------------------------
sub SimilarWordSearch {
	local ($SIMWORDS, $w, $THEWORDS, $havewords, $asimilarword);
	local ($simwordcount, $simwordbuffer, $gotagrep);
# Check to see if we have agrep on this system.
	$gotagrep = -e("$AGREP");
	if (!$gotagrep) {
		return;
		}
# If we do, then let's go....
	$SIMWORDS = "/tmp/philosimwords.$$";
	$THEWORDS = $SYSTEM_DIR . "words.R";
	foreach $w (@words) {
	    $w =~ s/^..//;
# Taint Mode patch.  We need to evalute the word to make 
# sure it does not contain any unwanted characters:
            if ($w =~ /^([A-Za-z\xa0-\xc30-9]+)$/) {
                $w = $1;
                }
            else {
               $w = "";
                }
# Here you can tune the flex matching...using AGREP arguments.
	    if ((length$w) > 4) {
	             $flexvalue = 1;
                 if (length($w) > 7) {
	             $flexvalue = 2;
                     } 
	         if (length($w) > 12) { 
	      	     $flexvalue = 3; 
		     }
                 $THEARG = "$AGREP -w -". $flexvalue . " \"" . $w . "\" ";
	         $THEARG .= $THEWORDS . " >> " . $SIMWORDS;
	         system ($THEARG);
	     }
	}
	$havewords = -s("$SIMWORDS");
	if ($havewords) {
		open (SIMILARWORDS, $SIMWORDS); 
		while ($asimilarword = <SIMILARWORDS>) {
			$asimilarword =~ s/\n//;
			$simwordcount += 1;
			$simwordbuffer .= $asimilarword . "; \n";
			last if $simwordcount > 100;
		}	
	}
	if ($simwordcount) {
		print "<b>" . $philomessage[49] . "</b> ";
	    $simwordbuffer =~ s/; \n$//;
	    print $simwordbuffer;
	    }
	system ("rm -f $SIMWORDS");
	return;
}

# ----------------------------------------------------------------------
# postfix2UTF8: This converts user input accented characters in the
# "postfix" notation (e^) to UTF-8 for searching.
# Called from: search2t 
# ----------------------------------------------------------------------

sub postfix2UTF8 {
    local ($l) = $_[0];
    $l =~ s/a\\/\xc3\xa0/g;
    $l =~ s/a\//\xc3\xa1/g;
    $l =~ s/a\^/\xc3\xa2/g;
    $l =~ s/a\~/\xc3\xa3/g;
    $l =~ s/a\"/\xc3\xa4/g;

    $l =~ s/c\,/\xc3\xa7/g;

    $l =~ s/d\^/\xc3\xb0/g;  # eth
    $l =~ s/d\^/\xc3\x90/g;  # ETH

    $l =~ s/e\\/\xc3\xa8/g;
    $l =~ s/e\//\xc3\xa9/g;
    $l =~ s/e\^/\xc3\xaa/g;
    $l =~ s/e\"/\xc3\xab/g;

    $l =~ s/i\\/\xc3\xac/g;
    $l =~ s/i\//\xc3\xad/g;
    $l =~ s/i\^/\xc3\xae/g;
    $l =~ s/i\"/\xc3\xaf/g;

    $l =~ s/n\~/\xc3\xb1/g;

    $l =~ s/o\\/\xc3\xb2/g;
    $l =~ s/o\//\xc3\xb3/g;
    $l =~ s/o\^/\xc3\xb4/g;
    $l =~ s/o\~/\xc3\xb5/g;
    $l =~ s/o\"/\xc3\xb6/g;

    $l =~ s/p\^/\xc3\xbe/g;  # thorn
    $l =~ s/P\^/\xc3\x9e/g;  # THORN

    $l =~ s/s\^/\337/g;  # Need UTF8 for szlig

    $l =~ s/u\\/\xc3\xb9/g;
    $l =~ s/u\//\xc3\xba/g;
    $l =~ s/u\^/\xc3\xbb/g;
    $l =~ s/u\"/\xc3\xbc/g;

    $l =~ s/y\//\xc3\xbd/g;  # Verify UTF8
    $l =~ s/y\"/\xc3\xbf/g;  # Verify UTF8

return $l;
}

# ----------------------------------------------------------------------
# clean_word_pattern: this modifies the user supplied word to search
# for.  We may add a line to transform " OR " in to "|", etc. 
# Called from: search2t
# ----------------------------------------------------------------------
sub clean_word_pattern {
    local ($word);
    $word = $_[0];
    $word =~ s/%20/\+/g;
    $word =~ s/[ \+]+OR[ \+]+/\|/g;
    $word =~ s/[ \+]+AND[ \+]+/\+/g;
    $word =~ s/%../pack("H2", substr($&,1))/ge;     # Convert Mime
    $word = &postfix2UTF8($word);
    $word =~ s/^\++//;                              # Strip Lead Spaces
    $word =~ s/\++$//;                              # Strip Trailing Spaces
    $word =~ s/\++/\+/g;                            # Remove Multiple Space
    $word =~ s/\++\|\++/\|/g;                       # Delete Spaces around
#   Convert * to .* where the preceeding character is not a ".", or
#   "]" or ")" in order to allow the normal construct word* rather than
#   requiring word.*
    $word =~ s/([^\.\]\)])\*/$1\.\*/g;
    $word =~ s/^\*/\.\*/;
    $word = &lowercaseify($word);  # Change Upper to lower case accented characters
    return $word;
}

# ----------------------------------------------------------------------
# pattern_to_show: this modifies the user supplied word to search
# for so we can print what we are looking for to the user.
# Called from: search2t
# ----------------------------------------------------------------------
sub pattern_to_show {
    local ($word) = $_[0];
    $word =~ s/\+/ /g;
#   $word =~ s/\256(.)/sprintf("%c",ord($1)-32)/ge;  # Render Upper Case Tag
    return $word;
}

# ----------------------------------------------------------------------
# clean_corpus_pattern: this modifies the user supplied metadata arguments
# to search for.  Transforming " OR " in to "|", " AND " to " ",
# in cases where we do not have SQL, so old style gimme will run.
# The corpus pattern is a simple argument string which goes to gimme
# as a command line argument:
#      title=poetical+subjects  author=robinson
# This should be more robust ... but there is a question of whether
# we will hook this up as an internal function.
# Called from: search2t
# ----------------------------------------------------------------------
sub clean_corpus_pattern {
    $gimme_arg =~ s/%20/+/g;
    $gimme_arg =~ s/%../pack("H2", substr($&,1))/ge;
    $gimme_arg = &postfix2UTF8($gimme_arg);
    $gimme_arg =~ s/[ \+]+\|[ \+]+/\|/g;
    if (!$SQLenabled) {                        # if no SQL, use gimme notation
	$gimme_arg =~ s/[ \+]+OR[ \+]+/\|/g;
	$gimme_arg =~ s/[ \+]+AND[ \+]+/\+/g;
	}
    $gimme_arg =~ s/([^\.\]\)])\*/$1\.\*/g;
    $gimme_arg =~ s/=\++/\=/g;                 # get rid of leading spaces
    $gimme_arg =~ s/\++ / /g;                  # get rid of trailing spaces
    $gimme_arg =~ s/\++$//g;                   # get rid of trailing spaces
    $gimme_arg =~ s/'/\\'/g;                   # Escape apostrophes
    $gimme_arg =~ s/;/\\;/g;                   # Escape semi-colons
    $gimme_arg =~ s/\|/\\\|/g;                 # Escape "|"
    $gimme_arg =~ s/\"/\\\"/g;                 # Escape """
#   The following if from Enabling metadata searches containing ampersands (&) PATCH
    $gimme_arg =~ s/\+\&\+/\+\\\&\+/g;         # Escape "&" in titles... grrrr.
}

# ----------------------------------------------------------------------
# GimmeArgsToShow: modifies the user supplied metadata arguments for
#                  display.  You might remove the variable names, capitalize
#                  then, etc.  Do not add a newline.
# Called from: search2t
# ----------------------------------------------------------------------
sub GimmeArgsToShow {
    local ($g);
    $g = $_[0];
    $g =~ s/\+/ /g;
return $g;
}

# ----------------------------------------------------------------------
# SimilarWord: This is a user selected similarity search on the counts
#              file.  It bypasses the standard search and generates a
#              list of matching words in a search form wtih a selection 
#              function with bibliographic limits and output options.
#              This should probably be linked up with some elements
#              of SimilarWordSearch, but it does behave differently,
#              so for the time being, leave it distinct.  Unicode characters
#              make accented/non-accented behavior less than good because
#              of multiple bytes per character.  Replace with a Unicode
#              aware agrep?  Or my old PF474 code for much better
#              similarity.  Also, creation an ISO-Latin counts file?
# Called from: search2t
# ----------------------------------------------------------------------
sub SimilarWord {
   local ($w, $flexvalue);
   $word = &clean_word_pattern($word);
# Some preliminaries to make sure that we have everything we need.
   if (!$AGREP) {
	  print "<p>" . $philomessage[50] . "<p>";
      return;
      }
   if (!$word) {
      print "<p>" . $philomessage[51] . "<p>";
      return;
      }
   if (length($word) < 5) {
      print "<p>" . $philomessage[52] . "<p>";
      return;
      }
   if ($word =~/[ \+]/) {
      print "<p>" . $philomessage[53] . "<p>";
      return;
      }
   $w = $word;

# This is to untaint the word and to see if there are odd characters
# that we don't want in a search.  May have unicode problems.
   if ($w =~ /^([a-zA-Z\177-\376\']+)$/) { 
        $w = $1;                
	}
   else {    
       print "<p>" . $philomessage[54] . "<p>\n"; 
       return;
      }
   $w =~ tr/A-Z/a-z/; 
# Having checked all of this, we can run the search.
    $SIMWORDS = "/tmp/philosimwords.$$";
    $THEWORDS = $SYSTEM_DIR . "counts";
# Set the flex values -- should be tuned for Unicode.
    $flexvalue = 1;
    if (length($w) > 4) {
        $flexvalue = 1;
        }
    if (length($w) > 7) {
        $flexvalue = 2;
        } 
    if (length($w) > 12) { 
       $flexvalue = 3; 
        }
    $THEARG = "$AGREP -w -". $flexvalue . " \"" . $w . "\" ";
    $THEARG .= $THEWORDS . " >> " . $SIMWORDS;
    system ($THEARG);
    $havewords = -s("$SIMWORDS");
# If you have similar words, generate a search form with a check box
# for each word.  
    if ($havewords) {
       $SEARCHSTRING = '<input type="checkbox" name="multiw" value="';
       open (SIMILARWORDS, $SIMWORDS);
       while ($asimilarword = <SIMILARWORDS>) {
             $asimilarword =~ s/\n//;
             $simwordcount += 1;
             $asimilarword =~ s/^(  *)//;
             $leftpaddings = $1;
	     ($freq, $searchword) = split(/ /,$asimilarword);  # This split
	     $displword = $searchword;                         # fails if uniq
	     $simwordbuffer .= $leftpaddings . $freq . "  ";   # uses tab
             $simwordbuffer .= $SEARCHSTRING . $searchword;
             $simwordbuffer .= "\">" . $displword . "\n";
	     }
       close (SIMILARWORDS);
       print sprintf($philomessage[55], $simwordcount);
       print "<p>" . $philomessage[56];
       print $philomessage[57] . "\n";

       print "<form action=$PHILOSEARCH3T?>";
       print '<input type="hidden" name="dbname" ';
       print 'value="' . $dbname . '">';
       print '<input type="submit" value="' . $philomessage[298] . '"> ' . $philomessage[299] . ' ';
       print '<input type="reset" value="' . $philomessage[297] . '"> <hr>';
       print "<pre>\n";
       print $simwordbuffer;
       print "</pre>\n";
       print &BiblioSearchOptions;
       print &SearchResultOptions(3);
       print '<p><input type="submit" value="' . $philomessage[298] . '"> ' . $philomessage[299] . ' ';
       print '<input type="reset" value="' . $philomessage[297] . '">';
       print "\n\n</FORM>\n";
       }
# Or you did not find any, so say so and exit.
    else {
    	print "<p>" . sprintf($philomessage[58], $w) . "<p>";
       }
    system ("rm -f $SIMWORDS");
    return;
}

# ----------------------------------------------------------------------
# BiblioSearchOptions: Generate the bibliographic part of a search
#                      form.  This could be called from a file, but
#                      let's keep it simple for now.  We may use this
#                      for other generated search forms.
#                      UPDATE: Now it checks to see if the auto-generated
#                      bibliographic search form exists, and if so, uses it
# Called from: SimilarWord
# ----------------------------------------------------------------------
sub BiblioSearchOptions { 
  local ($rtn);

  if (-e "$SYSTEM_DIR/lib/forms/bibliographic.form.html") {
      open(BIBFORM,"$SYSTEM_DIR/lib/forms/bibliographic.form.html");
      while (my $line = <BIBFORM>) {
	  $rtn .= $line;
      }
      return $rtn;
  } else {
      $rtn = "<p><b>&sect; " . $philomessage[82] . ":</b><br>
   " . $philomessage[83] . ":&nbsp;<input name=\"author\" size=\"30\"> 
         (" . $philomessage[81] . ", <tt>" . $philomessage[84] . "</tt>)<br> 
    " . $philomessage[85] . ":&nbsp;&nbsp;&nbsp;<input name=\"title\" size=\"30\"> 
         (" . $philomessage[81] . ", <tt>" . $philomessage[86] . "</tt>)<br>
    " . $philomessage[87] . ":&nbsp;&nbsp;&nbsp;<input name=\"date\" size=\"30\">
          (" . $philomessage[81] . ", <tt>1750-1799</tt>)<p>";
      return $rtn;
  }
}
	
#----------------------------------------------------------------------
# SearchResultOptions: Generate the Result Options form part of a search
#                      form.  This could be called from a file, but
#                      let's keep it simple for now. We may use this
#                      for other generated search forms.
# Called from: SimilarWord
# ----------------------------------------------------------------------
sub SearchResultOptions {
local ($rtn, $resultlevel);
$resultlevel = $_[0];
if (!$resultlevel) {
	$resultlevel = 1;
	}
if ($resultlevel == 1) {
	$rtn = $philomessage[88] . ": ";
	}
else {
	$rtn = "<b>&sect; " . $philomessage[89] . "</b>:<br> &nbsp; ";
}
# Basic Result Options: arg=1;
$rtn .= "<input CHECKED name=\"OUTPUT\" type=\"radio\" value=\"conc\">
     " . $philomessage[90] . " (" . $philomessage[91] . ") &nbsp;&nbsp;
     <input name=\"OUTPUT\" type=\"radio\" value=\"kwic\">"
     . $philomessage[144];
if ($resultlevel == 1) {
     return ($rtn);
     }

# Frequency Result Options: arg=2
$rtn .= "<br> &nbsp;
     <input TYPE=\"radio\" NAME=\"OUTPUT\" VALUE=\"TF\">
     " . $philomessage[145] . " &nbsp;&nbsp;
     <input TYPE=\"radio\" NAME=\"OUTPUT\" VALUE=\"TFRATE\">
     " . $philomessage[146] . "
     <br>&nbsp;
     <input name=\"OUTPUT\" type=\"radio\" value=\"AF\">
     " . $philomessage[147] . "
     <input type=\"radio\" name=\"OUTPUT\" value=\"AFRATE\">
     " . $philomessage[148] . "
     [" . $philomessage[92] . " <input TYPE=\"checkbox\" NAME=\"AFTITLEDISP\" VALUE=\"OFF\">
     " . $philomessage[93] . "] <br> &nbsp;
     <input name=\"OUTPUT\" type=\"radio\" value=\"DF\">
     " . $philomessage[150] . " &nbsp;
     <input type=\"radio\" name=\"OUTPUT\" value=\"DFRATE\">
     " . $philomessage[151] . "<br>
     &nbsp; &nbsp; &nbsp; " . $philomessage[152] . "  <select name=\"DFPERIOD\">
               <option value=\"0\">" . $philomessage[153] . "</option>
               <option selected value=\"1\">" . $philomessage[154] . "</option>
               <option value=\"2\">" . $philomessage[155] . "</option>
               <option value=\"3\">" . $philomessage[156] . "</option>
               <option value=\"4\">" . $philomessage[157] . "</option>
               </select>
     &nbsp;[" . $philomessage[92] . " 
     <input TYPE=\"checkbox\" NAME=\"DFTITLEDISP\" VALUE=\"OFF\"> " . $philomessage[93];

if ($resultlevel == 2) {
     return ($rtn);
     }

#  Collocations and Theme-Rheme: arg=3
$rtn .= "<br>
     &nbsp;<input TYPE=\"radio\" NAME=\"OUTPUT\" VALUE=\"PF\">
     " . $philomessage[94] . " " . $philomessage[95] . "
     <select name=POLESPAN>
     <option>10
     <option>9
     <option>8
     <option>7
     <option>6
     <option selected>5
     <option>4
     <option>3
     <option>2
     <option>1</option></select> " . $philomessage[96] . " " . $philomessage[97] . ":" . "
     <input TYPE=\"checkbox\" NAME=\"POLEFILTER\" VALUE=\"OFF\">
     <br>
     &nbsp;<input type=\"radio\" name=\"OUTPUT\" value=\"THMRHM\">
     " . $philomessage[98] . "</a> (" . $philomessage[99] . ")
     &nbsp; " . $philomessage[100] . ":
     <select name=\"THMPRTLIMIT\">
               <option value=\"1\">" . $philomessage[101] . "</option>
               <option value=\"2\">" . $philomessage[102] . "</option>
               <option value=\"3\">" . $philomessage[103] . "</option>
               <option value=\"4\">" . $philomessage[104] . "</option>
               </select>";
if ($resultlevel == 3) {
     return ($rtn);
     }

# And all including similiary = 4;
$rtn .= "<br> &nbsp;<input type=\"checkbox\" name=\"SIMWORD\" value=\"ON\">" . $philomessage[105] . "</a> (" . $philomessage[106] . " " . $philomessage[107] . ")";

return ($rtn);
}

#----------------------------------------------------------------------
# BrowseAvailableTerms: Generate a list of available terms for an SQL
#                       metadata field.  Dumps all available terms if
#                       there are no search criteria or values returned
#                       for that field from the search.
# Called from: search2t
# ----------------------------------------------------------------------
sub BrowseAvailableTerms {
  local ($gbargs);
  if (!$SQLenabled) {
  	print "<p>" . 
	print "<p>" . $philomessage[59] . "\n";
	return;
	}
 
  $gbargs = $_[0];                   # get gimme_args passed as param
  $tempqs = $QS;
  $tempqs =~ s/xxbrowse([^\=]*)\=//;
  $thebrowseterm = $1;
  print sprintf($philomessage[60], $thebrowseterm);
  if ($gbargs) {
	
       print " " . sprintf($philomessage[61], $gbargs);
       }
  else {
       print " " . $philomessage[62];
      }
  print " " . $philomessage[63] . " ";
  print "<p>";
  $gbargs .= " verbose=\"on\"";
  $gbargs .= " xxbrowse=\"" . $thebrowseterm . "\"";
  system ("$SYSTEM_DIR/gimme " . $gbargs . " | sort | uniq -c > " . $CORPUS );
  CheckSQLError(); 
  if (-s $CORPUS) {
  	open CORPUS, $CORPUS;
  	while ($biblinin = <CORPUS>) {
      		if ($biblinin =~ /[a-zA-Z\177-\376]/) {
		$biblinin =~ s/^ +([0-9]+)/$1 - /;
          	print $biblinin . "<br>\n";
          	}
      	}
  close CORPUS;
  }
  else {
  	print "<p>" . $philomessage[64] . "<p>\n";
  }
  system ("rm -f $CORPUS");
return;
}

#----------------------------------------------------------------------
# BrowseTermsFormat: Format the browse terms.  The gimme function is
#                    used to generate the browse terms is called in
#                    BrowseAvailableTerms.  This function typically
#                    splits internal fields and can do other clean-up.
#                    The list is then sorted and uniqed.  
# Called from: search2t/gimme
# ----------------------------------------------------------------------
sub BrowseTermsFormat() {
	local ($term);
	$term = $_[0];
	$term =~ s/<fs\/>/\n/g;
	$term =~ s/ -- /\n/g;
	$term =~ s/[\,\. ]*\n/\n/g;
	$term =~ s/[\,\. ]*$//g;
return $term;
}

#----------------------------------------------------------------------
# WritePhiloHistory: Write a file of Philo search2t QueryStrings in order
#                    to keep history.  The history is being kept, for now,
#                    in PHILOHISTDIR / IP number of the requesting computer.
#                    We may need to add a user specified name.  Let's see.
#                    History is displayed in a completely distinct script.
# Called from: search2t
# ----------------------------------------------------------------------
sub WritePhiloHistory() {
	local ($thisquery, $theident, $ip);
        $ip =  $ENV{'REMOTE_ADDR'};
	$ip =~ m/^([0-9\.]*)$/;                # Untaint this.
	$ip = $1;
	$thisquery = $QS;                      
	$thisquery =~ m/^(.*)$/;               # Untaint this.  Dangerous?
	$thisquery = $1;
	$KEEPHISTORY =~ m/^([0-9]*)$/;         # Untaint this.
	$theident = $1;
        if ($theident) {
                $historyfile = $PHILOHISTDIR . "/" . $theident;
                if (!open (HISTORY, ">>" . $historyfile)) {
                        print $philomessage[65] . " ";
			print $philomessage[66] . "<br>";
                        }
                else {
                        print HISTORY gmtime() . "\t";
                        print HISTORY "$QS\n";
                        close (HISTORY);
                }
        }
return;
}

#----------------------------------------------------------------------
# CheckSQLError: Check to see if gimme generated an ERROR file. If so
#                indicate to the user that there may be a problem and 
#                Exit.  Note that I am using a global file here.  This
#                may well cause problems.  I can't get a process id
#                or something else to pass along.  Should check this.
#		 Most of the time this will be an installation problem.
#                I would be happier if I could use the same process ID
#                number as the CORPUS file ($$), but this is a system
#                call, so I loose it.
# Called from: search2t
# ----------------------------------------------------------------------
#
sub CheckSQLError {
    if ($SQLenabled) {
       if (-e "/tmp/GIMME_ERROR") {
           open (GIMER, "/tmp/GIMME_ERROR");
           while ($line = <GIMER>) {
                  print $line;
                  }
           system ("rm -f /tmp/GIMME_ERROR $CORPUS");
           print &kwicfooter;
           exit;
          }
     }
return;
}

#----------------------------------------------------------------------
# mkSelectBibSearchForm: Generate most of the search form for the
#                        user selected bibliography report.  This is
#                        invoked when $searchfrombibliography == 2
# Called from: search2t
# ----------------------------------------------------------------------
sub mkSelectBibSearchForm {
	local ($rtn, $theform);
	$theform = "<form action=$PHILOSEARCH3T?>\n";
	$theform .= "<input type=\"hidden\" name=\"dbname\" ";
        $theform .= "value=\"" . $dbname . "\">\n";
	$theform .= $philomessage[108] . ": ";
	$theform .= "<input name=\"word\" size=\"30\">";
	$theform .= "&nbsp;&nbsp;&nbsp;";
        $theform .= "<input type=\"submit\" value=\"" . $philomessage[298] . "\"> " . $philomessage[299] . " ";
        $theform .= "<input type=\"reset\" value=\"" . $philomessage[297] . "\">\n";
	$theform .= "<p>" . &SearchContextOptions;
        $theform .= "<br>" . &SearchResultOptions(1);
	$theform .= "<hr>\n";
	$rtn = $philomessage[109] . " " . $philomessage[110] . " ";
	$rtn .= "<p>";
	$rtn .= $theform;
return $rtn;
}

#----------------------------------------------------------------------
# ThemeHitLine: Take the concordance hit as a string for identifying
#               where in a roughly calculated clause the hitword is
#               located.  Filter out some short words and other stuff.
# Called from: theme_rheme.pl
#----------------------------------------------------------------------

sub ThemeHitLine {
    local ($text, @chunks, @hitline, $MYHITLINE);
    $text = $_[0];
    $text =~ s/\n/ /g;
    $text =~ s/&amp;/ /g;
    $text =~ s/&(.)[a-z]*;/$1/gi;
    $text =~ s/([0-9])\.([0-9])/$1$2/g;
    $text =~ s/([A-Z])\./$1/;
    $text =~ s/([A-Z][a-z])\./$1/;
    $text =~ s/([A-Z][a-z][a-z])\./$1/;
    $text =~ s/([\.\,\:\?\;\!])/\n/g;
    $text =~ s/<\/?i>/ /gi;
    $text =~ s/ --* /-/g;
    $text =~ s/< hitword>  */< hitword>/;
    $text =~ s/< hitword>/< hitword>/g;
    $text =~ s/< \/hitword>//;
    $text =~ s/<[A-Za-z][^>]*>/ /g;
    $text =~ s/< hitword>/<hitword>/g;
    @chunks = split(/\n/, $text);
    @hitline = grep(/<hitword>/, @chunks);
    $MYHITLINE = " " . $hitline[0] . " ";
    $MYHITLINE =~ tr/A-Z/a-z/;
    $MYHITLINE =~ s/\'/ /g;
    $MYHITLINE =~ s/<br>/ /gi;
    $MYHITLINE =~ s/<p>/ /gi;
    $MYHITLINE =~ s/\-/ /g;
    $MYHITLINE =~ s/ [A-Za-z][A-Za-z] / /g;
    $MYHITLINE =~ s/ [a-z] / /g;
    $MYHITLINE =~ s/ &agrave; / /g;
    $MYHITLINE =~ s/ [ldc]es / /g;
    $MYHITLINE =~ s/  *$//;
    $MYHITLINE =~ s/^  *//;
    $MYHITLINE =~ s/  */ /g;
return $MYHITLINE;
}
	
#----------------------------------------------------------------------
# SetThemeLimit: Set the sliding scale of what to call a theme by length
#                of clause.  This is pretty much experimental.
# Called from: theme_rheme.pl
#----------------------------------------------------------------------
sub SetThemeLimit {
	local ($n, $rtn);
	$n = $_[0];
        if ($n > 27) {
            $rtn = 15;
            }
        elsif ($n > 17) {
            $rtn = 20;
            }
        elsif ($numofdwords < 9) {
            $rtn = 35;
            }
        else {
            $rtn = 25;
            }
return $rtn;
}

#----------------------------------------------------------------------
# SetThemeColors: Sets the colors for the various word in clause
#                 locations.  Also, sets the hitword to a special
#                 tag.  Do not change these.
# Called from: theme_rheme.pl
#----------------------------------------------------------------------
sub SetThemeColors {
    $themehitcoloron = "<FONT COLOR=\"#006600\"><b>";
    $themehitcoloroff = "</FONT></b>";
    $rhemehitcoloron = "<FONT COLOR=\"#990CC0\"><b>";
    $rhemehitcoloroff = "</FONT></b>";
    $lasthitcoloron = "<FONT COLOR=\"#0000A0\"><b>";
    $lasthitcoloroff = "</FONT></b>";
    $shorthitcoloron = "<b>";
    $shorthitcoloroff = "</b>";

    $hithighon_conc = "< hitword>";       # Leave these two as is
    $hithighoff_conc = "< /hitword>";
}

# -----------------------------------------------------------------------
# getrelativefreq: Get relative frequency of words per title, author, 
#                  period.  Note that I have a $perwhat here, but am
#                  not setting it anywhere, so it defaults to 10000.  
#                  Future considerations.  I'm also using a STRING 
#                  function to get N*.NN  Bad.
# Called by: search2t, frequency generators.
# -----------------------------------------------------------------------
sub getrelativefreq { 
   local ($wfreq, $tfreq, $perwhat, $rtn);
   $wfreq = $_[0];
   $tfreq = $_[1];
   $perwhat = $_[2];
   $rtn = 0;
   if (!$tfreq) {
      return $rtn;
      } 
   if (!$perwhat) {
      $perwhat = 10000;
      }
   $rtn = ($wfreq/$tfreq) * $perwhat;
   $rtn =~  s/^([0-9]*\.[0-9][0-9]).*/$1/;  # I really should do better
   return $rtn;
}

# -----------------------------------------------------------------------
# mkfreqtitleline: Generate a title line for frequency counts.  
#                  The title line includes the author, when passed, the
#                  title and link to document navigation, and links to
#                  the occurrences in the HITLIST file.
# Called by search2t, all frequency generators
# -----------------------------------------------------------------------
sub mkfreqtitleline {
        local ($title, $author, $wordfreq, $freqdocid, $freqhitstart, $rtn);
        local ($hitspan, $rateper10000, $printfreq, $lperwhat);
        $title = $_[0];
        $author = $_[1];
        $wordfreq = $_[2]; 
        $freqdocid = $_[3];
        $freqhitstart = $_[4];
	$rateper10000 = $_[5];
	$printfreq = $_[6];
        $author = &FreqFormat($author);
        $title = &FreqFormat($title);
        $hitspan = ($freqhitstart  + $wordfreq  - 1);
        if ($author) {
                $rtn = $author . ", ";
                }
        $rtn .= "<i><a href=\"$PHILOCGI/navigate.pl?";
        $rtn .= $dbname . "." . $freqdocid . "\">" . $title;
        $rtn .= "</a></i> [";
        if ($printfreq) {
		$rtn .= $wordfreq . " ";
		}
        $rtn .= "<A HREF=\"$PHILOCGI/showrest_?conc.";
        $rtn .= $CONJUNCT . "." . $nw . "." . $$ . "." . $freqhitstart . ".";
        $rtn .= $hitspan . "." . $dbname . ".1" .  "\">" . $philomessage[111] . "</A>";

	if ($printfreq) {
		if (!$perwhat) {
			$lperwhat = 10000;
			}
		else {
			$lperwhat = $perwhat;
		     }
                $rtn .= " (" . $rateper10000 .  ")";
                }

        $rtn .= "]<br>\n";
return $rtn;
}

# -----------------------------------------------------------------------
# SearchContextOptions: Generate Search option lines for various
#                       search forms
# Called by: 
# -----------------------------------------------------------------------
sub SearchContextOptions {
local ($rtn);
$rtn = $philomessage[112] . ":<br>
       &nbsp;&nbsp;&nbsp;&nbsp;
       <input CHECKED name=\"CONJUNCT\" type=\"radio\" value=\"PHRASE\">
       " . $philomessage[113] . " (" . $philomessage[91] . ")
       <input name=\"CONJUNCT\" type=\"radio\" value=\"PROXY\">
       " . $philomessage[114] . " 
       <input name=\"DISTANCE\" size=\"2\" value=\"2\"> " . $philomessage[96] . "
       <select name=\"PROXY\">
            <option value=\"or fewer\" selected>" . $philomessage[115] . "</option>
            <option value=\"exactly\">" . $philomessage[116] . "</option>
       </select><br>
       &nbsp;&nbsp;&nbsp;&nbsp;
       <input name=\"CONJUNCT\" type=\"radio\" value=\"6\">
        " . $philomessage[117] . " 
        <input name=\"CONJUNCT\" type=\"radio\" value=\"5\">
        " . $philomessage[118];
return $rtn;
}

# -----------------------------------------------------------------------
# MakeKwicSortKey: Generate sort key for sorted line by line (KWIC)
#                  reports.  This creates a sort key prepended to
#                  the KWIC line, which is sorted in a pipeline.  
# Called by: artfl_sortedkwic.pl
# -----------------------------------------------------------------------
sub MakeKwicSortKey{
    local ($left, $right, $KWSS, $thissortkey, $keyword, $leftword);
    local ($rightword, $leftwords, $w);
    $left = $_[0];
    $right = $_[1];
    $KWSS = $_[2];
    $left = &CleanKwicSortKey($left);
    $right = &CleanKwicSortKey($right);
    $right =~ m/$hithighon_kwic([^<]*)$hithighoff_kwic/;
    $keyword = $1;
    $left =~ s/ +$//;
    @leftwords = split (/ /,$left);
    foreach $w (@leftwords) {
        $leftword = $w . " " . $leftword;
    }
    $right =~ m/$hithighoff_kwic ([a-zA-Z\177-\377&; \']*)/;
    $rightword = $1;

    $thissortkey = $keyword . " |";
    if ($KWSS == 1) {
        $thissortkey .= $rightword . "|" . $leftword;
        }
    else {
        $thissortkey .= $leftword . "|" . $rightword;
        }
    $thissortkey .= "\t";
    $thissortkey =~ tr/A-Z/a-z/;
    $thissortkey =~ s/ +/ /g;

return $thissortkey;
}

# -----------------------------------------------------------------------
# CleanKwicSortKey: Clean the KWIC strings to allow correct sorting.
#                   Getting rid of numbers, punctuation, etc.  
# Called by: MakeKwicSortKey
# -----------------------------------------------------------------------
sub CleanKwicSortKey {
        local ($line, $donothing);
        $line = $_[0];
        $line =~ s/[\.\,\?\(\)\:\"\-\!\*\'\`]/ /g;
        if ($line =~ /\xc3/) {
                $line =~ s/\xc3[\x80-\x85\xa0-\xa5]/a/g;
                $line =~ s/\xc3[\x88-\x8b\xa8-\xab]/e/g;
                $line =~ s/\xc3[\x8c-\x8f\xac-\xaf]/i/g;
                $line =~ s/\xc3[\x92-\x96\xb2-\xb5]/o/g;
                $line =~ s/\xc3[\x99-\x9c\xb9-\xbc]/u/g;
                $line =~ s/\xc3[\x87\xa7]/c/g;
        }
        if ($line =~ /\&[^;]*;/) {
                $donothing = 0;
                }
        else {
                $line =~ s/;//g;
        }
        $line =~ s/[0-9]/ /g;
        $line =~ s/ +$//;
        $line =~ s/ +/ /g;
return $line;
}

############################################################################
############################ New PhiloLogic3 Subroutines ###################
############################################################################

# -----------------------------------------------------------------------
# HitNavigationLine: Generate a contextual hit navigation links by
#                    blocks specified in HITBLOCKSIZE and length
#                    in NAVLINEBLOCKLENGTH.  This attempts to center
#                    the current block of hits, with X on each side
#                    and provide First and Last block links.
# Called by: search3t and showrest_
# MVO: March 8, 2005.
# -----------------------------------------------------------------------
sub HitNavigationLine {
	local ($rtn, $rep, $conj, $nw, $id, $start);
	local ($howmany, $length, $startblock, $lastblock, $x, $printend);
	local ($printend, $s1, $s2, $thisblock, $nearend, $nearstart);
	local ($fromsearch);
# Get args.  I'm being a bit paranoid here, since I could just get 'em
# from globals.  
	$rep = $_[0];           # kind of report.
	$conj = $_[1];          # CONJUNCT
	$nw  = $_[2];           # number of words
	$id = $_[3];            # the id of the histlist.
	$start = $_[4];         # the start block
	$length = $_[5];        # total number of hits.
	$fromsearch = $_[6];    # flag set to "25" if this is from search3
#
# Defaults should come from configuration, but better safe than sorry.
	if (!$HITBLOCKSIZE) {
		$HITBLOCKSIZE = 100;
		}
	if (!$NAVLINEBLOCKLENGTH) {
		$NAVLINEBLOCKLENGTH = 20;
		}
	if ($length < $HITBLOCKSIZE) {         # do nothing if short hitlist
		return;
		}

	$howmany = int($length / $HITBLOCKSIZE);
	$nearend = ($howmany - $NAVLINEBLOCKLENGTH) * $HITBLOCKSIZE;
	$nearstart = $HITBLOCKSIZE * ($NAVLINEBLOCKLENGTH / 2);

# If you have more blocks of hits to link to than the length of the
# list set by configuration, determine if the selected block to print
# is at the beginning, the end, or in the middle of the list.  Set
# some parameters.
	if ($howmany > $NAVLINEBLOCKLENGTH) {
		if ($start < $nearstart) {
			$startblock = 1;
			$lastblock = $NAVLINEBLOCKLENGTH;
			$printstart = "1";
			$printend = $philomessage[119];
			$x = int($start / $HITBLOCKSIZE);
			$thisblock = $x;
			}
		elsif ($start > $nearend) {
			$startblock = $howmany - $NAVLINEBLOCKLENGTH;
			$lastblock = $howmany;
			$printstart = $philomessage[120];
			$x = int($start / $HITBLOCKSIZE);
			$thisblock = $x;
			}
		else   {
			$x = int($start / $HITBLOCKSIZE);
			$startblock = $x - int($NAVLINEBLOCKLENGTH/2);
			$lastblock = $x + int($NAVLINEBLOCKLENGTH/2);
			$thisblock = $x;
			if ($lastblock > $howmany) {
				$lastblock = $howmany;
				}
			$printstart = $philomessage[120];
			$printend = $philomessage[119];
			}
		}
# Otherwise, you are going to process the entire list.
	else {
		$x = int($start / $HITBLOCKSIZE);
		$thisblock = $x;
		$startblock = 1;
		$lastblock = $howmany;
		$printstart = 1;
	}

	
	#$rtn = "<p>Entered HitNavigationLine<br>";
	#$rtn .= "Blocks = $howmany<br>";
	#$rtn .= "START = $start<br>";
	#$rtn .= "X = $x<br>";
	#$rtn .= "StartBlock = $startblock<br>";
	#$rtn .= "LastBlock = $lastblock<br>";

# Print the blocks, providing links to all but the block you are
# currently looking at, indicated by $thisblock.  Well, you are
# not printing ... you are appending to $rtn.  This get evaluted
# in the calling routines.  

# Print the first block 0 to HITBLOCKSIZE hits.  You need this here since
# you want to print a First block when you are in the middle of a long
# list.
	if ($printstart) {
		if ($thisblock == 0 && !$fromsearch) {
			$rtn .= " $printstart ";
			}
		else {
			$rtn .= " <A HREF=\"$PHILOCGI/showrest_?";
                	$rtn .= "$rep.$conj.$nw.$id.";
			$rtn .= "0.99.$dbname";
			$rtn .= "\">$printstart</a>";
			}
		}
# Now print the blocks you selected above.
	for ($i=$startblock; $i <= $lastblock; $i++) {
		if ($thisblock == $i) {
			$pi = $i + 1;
			$rtn .= " $pi ";
			}	
		elsif ($i > 0) {
			$rtn .= " <A HREF=\"$PHILOCGI/showrest_?";
                	$rtn .= "$rep.$conj.$nw.$id.";
			$s1 = ((($i + 1) * $HITBLOCKSIZE) - $HITBLOCKSIZE);
			$s2 = ((($i + 1) * $HITBLOCKSIZE) - 1);
			if ($s2 > $length) {
				$s2 = $length - 1;
				}
			$rtn .= "$s1.$s2.$dbname";
			$pi = $i + 1;
			$rtn .= "\">$pi</a> ";
			}
		else {
			$donothing = 0;  # this should never happen...
			}
		}

# And print the END block if required.....
	if ($printend) {
		$rtn .= " ";
		$rtn .= " <A HREF=\"$PHILOCGI/showrest_?";
                $rtn .= "$rep.$conj.$nw.$id.";
		$s1 = ((($howmany + 1) * $HITBLOCKSIZE) - $HITBLOCKSIZE);
		$s2 = $length - 1;
		$rtn .= "$s1.$s2.$dbname";
		$rtn .= "\">$printend</a>";
		}

return($rtn);
}

# -----------------------------------------------------------------------
# cleansubdocargs: clean args going to the subdocgimme function.  I
# could probably use the cleangimmeargs function, but there may be
# some differences down the road.
# Called by: search3t
# MVO: March 8, 2005.
# -----------------------------------------------------------------------
sub cleansubdocargs {
    local ($theargs);
    $theargs = $_[0];
    $theargs =~ s/%20/+/g;
    $theargs =~ s/%../pack("H2", substr($&,1))/ge;
#    $theargs = &postfix2UTF8($theargs);     # old painful holdover
    $theargs =~ s/[ \+]+\|[ \+]+/\|/g;
    if (!$subdocSQLenabled) {                    
        $theargs =~ s/[ \+]+OR[ \+]+/\|/g;  
        $theargs =~ s/[ \+]+AND[ \+]+/\+/g;
        }
    $theargs =~ s/([^\.\]\)])\*/$1\.\*/g;
    $theargs =~ s/=\++/\=/g;                 # get rid of leading spaces
    $theargs =~ s/\++ / /g;                  # get rid of trailing spaces
    $theargs =~ s/\++$//g;                   # get rid of trailing spaces
    $theargs =~ s/'/\\'/g;                   # Escape apostrophes
    $theargs =~ s/;/\\;/g;                   # Escape semi-colons
    $theargs =~ s/\|/\\\|/g;                 # Escape "|"
    $theargs =~ s/\"/\\\"/g;                 # Escape """
return($theargs);
}

# -----------------------------------------------------------------------
# subdocargs2display: format args to subdocgimme for display
# Called by: search3t 
# MVO: March 8, 2005.
# -----------------------------------------------------------------------
sub subdocargs2display {
    local ($theargs);
    $theargs = $_[0];
    $theargs =~ s/%20/+/g;
    $theargs =~ s/\+/ /g;
    $theargs =~ s/%../pack("H2", substr($&,1))/ge;
    $theargs =~ s/dgdivhead/divhead/;
    $theargs =~ s/dgdivtype/divtype/;
    $theargs =~ s/dgsubdivtag/tag/;
    $theargs =~ s/dgsubdivtype/type/;
    $theargs =~ s/dgdivocauthor/author/;
    $theargs =~ s/dgdivocdateline/dateline/;
    $theargs =~ s/dgdivocsalutation/salutation/;
    $theargs =~ s/dgsubdivlang/language/g;
#   $theargs = &postfix2UTF8($theargs);
return($theargs);
}

# -----------------------------------------------------------------------
# DivDisplayLine: Format hits for div level searches with or without
#                 bibliographic metadata.  It prints the div title
#                 (<head>...</head> in the data ($results[1]), with
#                 a link to the object and the standard bibliographic
#                 generator.  
# Called by: search3t
# MVO: March 8, 2005.
# -----------------------------------------------------------------------
sub DivDisplayLine {
	local ($thedivline, $results, $rtn, $subresults);
	$thedivline = $_[0];
	@results=split(/\t/, $thedivline);
        $rtn .= "<p><a href=\"";
        $rtn .= $PHILOGETOBJECT . "?c." . $results[0];
        $rtn .= "." . $dbname . "\">";
        $rtn .= "$results[1]</a> in ";
        @subresults = split(":", $results[0]);
        $rtn .= &getbiblioLine($subresults[0], "link");
return ($rtn);
}

#_______________________________________________________________________
# quickdicjs: Generates the javascript to open a dictionary window
#             Assumes lib/quickdict.js  Options are set in philo-db.cfg
#             $LINKDICT = 1;  
# Options: 1 = ARTFL one look dictionary function with morphological
#              package.  Obviously for French. 
#          2 = Oxford English Dictionary.
#          3 = ARTFL Websters Dictionary
#          4 = onelook.com
#             
#_______________________________________________________________________
sub quickdicjs {
    local($output);
    $dicopt = $_[0];
    if ($dicopt == 1) {
       if ($bibliodate ne "n.d." && $bibliodate ne "") {
        if ($bibliodate < 1699) {
            $docyear = "1600-1699";
        } elsif ($bibliodate < 1799) {
            $docyear = "1700-1799";
        } elsif ($bibliodate < 1899) {
            $docyear = "1800-1899";
        } elsif ($bibliodate > 1899) {
            $docyear = "1900-1999";
        }
        $dictURL = "http://artflx.uchicago.edu/cgi-bin/dicos/quickdict.pl?docyear=" . $docyear . "&strippedhw=";
        } else {
            $dictURL = "http://artflx.uchicago.edu/cgi-bin/dicos/quickdict.pl?strippedhw=";
        }

   } elsif ($dicopt == 2) {
       $dictURL = "http://dictionary.oed.com/cgi/findword?query_type=word&find.x=0&find.y=0&find=Find+word&queryword=";
   } elsif ($dicopt == 3) {
       $dictURL = "http://machaut.uchicago.edu/?action=search&resource=Webster%27s&quicksearch=on&word=";
   } elsif ($dicopt == 4) {
       $dictURL = "http://onelook.com/?ls=a&w=";
   }

    if ($SYSTEM_DIR eq "") {
        $mysysdir = $sys_dir;
    } else {
        $mysysdir = $SYSTEM_DIR;
    }

    $jscode = "";
    open (JSFILE, $mysysdir . "lib/quickdict.js");
    while ($jsline = <JSFILE>) {
        $jscode .= $jsline;
    }
    close JSFILE;
    $output = $philomessage[121] . "<br><br><script language='JavaScript'><!--\n\nvar dictURL='" . $dictURL . "';\nvar dictOn = true;\n\n" .  $jscode . "\n\n//--></script>";
    return $output;
}

# -----------------------------------------------------------------------
# SubDivDisplayLine: Format hits for div level searches with or without
#                 bibliographic metadata.  It prints the div title
#                 (<head>...</head> in the data ($results[1]), with
#                 a link to the object and the standard bibliographic
#                 generator.  
# Called by: search3t
# MVO: March 8, 2005.
# -----------------------------------------------------------------------
sub SubDivDisplayLine {
        local ($thedivline, $results, $rtn, $subresults, $upone );
        $thedivline = $_[0];
        @results=split(/\t/, $thedivline);
        @subresults = split(":", $results[0]);
	if ($subresults[0] eq $lastsubdivdoc) {
	   $donothing = 0;
		}
	else {
	   $rtn = "<p>";
	   $rtn .= &getbiblioLine($subresults[0], "link");
	   $rtn .= "<br>"; 
	   $lastsubdivdoc = $subresults[0];
	   }
        $rtn .= "<a href=\"";
        $rtn .= $PHILOGETOBJECT . "?c." . $results[0];
        $rtn .= "." . $dbname . "\">";
        $rtn .= $results[1];
	if ($results[2]) {
		$rtn .= "&nbsp;type=" . $results[2];
		}
	if ($results[3]) {
		$rtn .= "&nbsp;n=" . $results[3];
		}
	if ($results[4]) {
		$rtn .= "&nbsp;id=" . $results[4];
		}
	if ($results[5]) {
		$rtn .= "&nbsp;who=" . $results[5];
		}
	if ($results[6]) {
		$rtn .= "&nbsp;lang=" . $results[6];
		}
        $rtn .= "</a>&nbsp;";
	$upone = $results[0]; 
	$upone =~ s/:[0-9]*$//;
	$upone =~ s/:0$//;
	$rtn .= "[<a href=\"";
        $rtn .= $PHILOGETOBJECT . "?c." . $upone;
	$rtn .= "." . $dbname . "\">";
	$rtn .= $philomessage[122] . "</a>]; ";

return ($rtn);
}


# ----------------------------------------------------------------------
# BrowseSubDocTerms: Generate a list of available terms for an SQL
#                    metadata field in SUBDOC tables.  Dumps all 
#                    available terms if there are no search criteria 
#                    or values returned for that field from the search.
#                    Triggered by zzbrowse or yybrowse
# Called from: search3t
# ----------------------------------------------------------------------
sub BrowseSubDocTerms {
  local ($gbargs, $subdoclevel, $targs, $allargs, $tempqs, $x);
  if (!$subdocSQLenabled) {
        print "<p>" . $philomessage[123] . "\n";
        return;
        }
 
  $targs = $_[0];                   # get gimme_args passed as param
  $subdoclevel = $_[1];
  $tempqs = $QS;
  if ($subdoclevel eq "subdiv") {
  	$tempqs =~ s/zzbrowse([^\=]*)\=//;
  	$thebrowseterm = $1;
	$gbargs = "-v -subdiv";
	}
   else {
  	$tempqs =~ s/yybrowse([^\=]*)\=//;
  	$thebrowseterm = $1;
	$gbargs = "-v -div";
	}
	
  print $philomessage[124] . " <tt>";
  print &subdocargs2display($thebrowseterm);
  print "</tt> ";
  if ($targs) {
       print $philomessage[125] . " <tt>";
       print &subdocargs2display($targs);
       print "</tt>.";
       }
  else {
       print $philomessage[62];
      }
  print " " . $philomessage[126] . " ";
  print "<p>";
  $allargs = $gbargs . " " . $targs . " xxbrowse=\"" . $thebrowseterm . "\"";
  $allargs =~ m/^(.*)$/;
  $allargs = $1;
  system ("$SYSTEM_DIR/subdocgimme " . $allargs . " | sort | uniq -c > " . $CORPUS );
  CheckSQLError(); 
  if (-s $CORPUS) {
        open CORPUS, $CORPUS;
        while ($biblinin = <CORPUS>) {
                if ($biblinin =~ /[a-zA-Z\177-\376]/) {
                    $biblinin =~ s/^ +([0-9]+)/$1 - /;
                    print $biblinin . "<br>\n";
		    $x++;
                }
        }
  if ($x < 1) {
	print "<p>" . $philomessage[64] . "<p>\n";
	}
  close CORPUS;
  }
  else {
        print "<p>" . $philomessage[64] . "<p>\n";
  }
  system ("rm -f $CORPUS");
return;
}

# ----------------------------------------------------------------------
# WordSearchSortKey: Modify the hitlist sort criteria. 
# Called from: search3t: TRSORT.  The sort criteria a bibliographic
# fields.
# ----------------------------------------------------------------------
sub WordSearchSortKey {
	local ($thesortkey);
	$thesortkey = $_[0];
	$thesortkey =~ tr/A-Z/a-z/;
	$thesortkey =~ s/^;//;
	$thesortkey =~ s/^[;"\[ ]*//;
	$thesortkey =~ s/^the //;
	$thesortkey =~ s/^a //;
	$thesortkey =~ s/^ +//;
	$thesortkey =~ s/\t//g;
	$thesortkey =~ s/\015//g;
	$thesortkey =~ s/<fs\/>//g;
return ($thesortkey);
}

# ----------------------------------------------------------------------
# KwicResortForm: Generate the Kwic Resort Form.  This maps the 
#                 standard bibliographic arguments to the fields
#                 by number to use standard unix sort.  
# Called from: search3t:artfl_sortedkwic.pl and kwicresort.pl
# ----------------------------------------------------------------------
sub KwicResortForm {
    local ($rtn, $theselectvals, $theid, $thesorter);
    $theid = $_[0];
    $thesorter = "$PHILOCGI/kwicresort.pl?";
    $thesorter .= "dbname=" . $dbname;
    $thesorter .= "&theid=" . $theid;
# Comment and Uncomment sort fields which are reasonable
# for this database. 
    $theselectvals = "<option Value=\"1\">" . $philomessage[127] . "</option>\n";
    $theselectvals .= "<option Value=\"2\">" . $philomessage[128] . "</option>\n";
    $theselectvals .= "<option Value=\"3\">" . $philomessage[129] . "</option>\n";
    $theselectvals .= "<option Value=\"5\">" . $philomessage[85] . "</option>\n";
    $theselectvals .= "<option Value=\"6\">" . $philomessage[83] . "</option>\n";
    $theselectvals .= "<option Value=\"7\">" . $philomessage[87] . "</option>\n";
#    $theselectvals .= "<option Value=\"8\">Genre</option>\n";
#    $theselectvals .= "<option Value=\"9\">Publisher</option>\n";
    $theselectvals .= "<option Value=\"10\">" . $philomessage[130] . "</option>\n";
#    $theselectvals .= "<option Value=\"11\">Extent</option>\n";
#    $theselectvals .= "<option Value=\"12\">Editor</option>\n";
#    $theselectvals .= "<option Value=\"13\">PubDate</option>\n";
#    $theselectvals .= "<option Value=\"14\">CreateDate</option>\n";
#    $theselectvals .= "<option Value=\"15\">AuthorDate</option>\n";
#    $theselectvals .= "<option Value=\"16\">Subject</option>\n";
#    $theselectvals .= "<option Value=\"17\">Language</option>\n";
#    $theselectvals .= "<option Value=\"18\">Collection</option>\n";
#    $theselectvals .= "<option Value=\"19\">Gender</option>\n";
#    $theselectvals .= "<option Value=\"20\">Note</option>\n";
#    $theselectvals .= "<option Value=\"21\">Period</option>\n";
    $rtn = "<center>";
    $rtn .= "<form action = \"" . $thesorter . "\">";
    $rtn .= $philomessage[131] . " ";
    $rtn .= "<select name=sortfield1 size=1>";
    $rtn .= $theselectvals;
    $rtn .= "</select>&nbsp;&nbsp;";
    $rtn .= "<select name=sortfield2 size=1>";
    $rtn .= $theselectvals;
    $rtn .= "</select>&nbsp;&nbsp;";
    $rtn .= "<select name=sortfield3 size=1>";
    $rtn .= $theselectvals;
    $rtn .= "</select>&nbsp;&nbsp;";
    $rtn .= "<INPUT TYPE=\"hidden\" NAME=\"dbname\" VALUE=\"" . $dbname . "\">";
    $rtn .= "<INPUT TYPE=\"hidden\" NAME=\"theid\" VALUE=\"" . $theid . "\">";
    $rtn .= "<input type=submit value=SORT>";
    $rtn .= "&nbsp;&nbsp;<input type=reset value=RESET>"; 
    $rtn .= "</form>\n";
    $rtn .= "</center><p>\n";
return ($rtn);
}

# ----------------------------------------------------------------------
# KwicResortBibKey: Clean up the tab delimited biblioline for sorting
#                   You can, of course, split the fields on tabs
#                   and do things like get rid of leading "A", and
#                   "The" in titles.  
# Called from: search3t:artfl_sortedkwic.pl (sorted by kwicresort.pl)
# ----------------------------------------------------------------------
sub KwicResortBibKey {
	local ($rtn);
	$rtn = $_[0];
	$rtn =~ tr/A-Z/a-z/;
	$rtn =~ s/<[^>]*>/ /g;
	$rtn =~ s/\t[" ]*/\t/g;
	$rtn =~ s/^[" ]*/\t/g;
        $rtn =~ s/[\[\]\(\)]/ /g;
	$rtn =~ s/^[a|the|an] //;
	$rtn =~ s/\t[a|the|an] /\t/;
return ($rtn);
}

# ----------------------------------------------------------------------
#  DivHeadFreqLinks: For the frequency by Div Head report, this allows
#                    to modify the links.  Used to link to page images
#                    and the like.  If you want something else as the
#                    title, you can add it here as well.
# Called from: search3t
# ----------------------------------------------------------------------

sub DivHeadFreqLinks {
  local ($rtn);
  $rtn = "<a href=\"" . $PHILOGETOBJECT . "?c." . $freqdivid . ".";
  $rtn .= $dbname . "\">" . $title;
  # Of course, you can link to some other server.  In this case a
  # a page image link, for dirty OCR.
  # $rtn = &makepageimagelink($freqdivid);
  # $rtn .= $title;
  $rtn .= "</a></i> [";
  $rtn .= $wordfreq . " ";
  $rtn .= "<A HREF=\"$PHILOCGI/showrest_?kwic.";
  $rtn .= $CONJUNCT . "." . $nw . "." . $$ . "." . $freqhitstart . ".";
  $rtn .= $hitspan . "." . $dbname . ".1" .  "\">" . $philomessage[111] . "</A>";
  $rtn .= "]<br>\n";
return ($rtn);
}

# ----------------------------------------------------------------------
# ATEnotetext: build a page backlink from a note as specified in ATE
#              encoding.  This should only be triggered for TextType = ate.
#              ARTFL and related projects specific.
# Called from: ObjectFormat
# ----------------------------------------------------------------------
sub ATEnotetext {
	local ($thisnote, $notenumber, $callingpage, $callingobject, $notelink);
	local ($rtn);
	$thisnote = $_[0];
	$thisnote =~ m/ n="([^"]*)"/i;
	$notenumber = $1;
	$thisnote =~ m/ xpg="([^"]*)"/i;
	$callingpage = $1;
	$thisnote =~ m/ xpgobj="([^"]*)"/i;
	$callingobject = $1;
	$notelink = "<a href=\"" . $PAGESERVER . "?p." . $doc . ":";
	$notelink .= $callingobject . "." . $dbname . "\">";
	$rtn = $philomessage[132] . " " .  $notelink . $callingpage . "<\/a>:";
	$rtn .= $notenumber . ".";
return ($rtn);
}

# ----------------------------------------------------------------------
# ATEnotelinker: build a link to the notetext as specified in ATE
#              encoding.  This should only be triggered for TextType = ate.
#              ARTFL and related projects specific.  This replicates
#              elements in &refresolver, just so we can keep these things
#              clear.
# <note n="1" ref="1">
# <notetext n="1" xpg="89" xpgobj="95">
# n is the target....
# 1       18      notetext        2:0:-1:17       229     2:0:-1
# Called from: ObjectFormat
# ----------------------------------------------------------------------
sub ATEnotelinker {
    local ($rtn, $reffilepath,  $reftabexists, $thislink);
    local ($n, $ref, $LINK, $refobject, $thelink);
    $thislink = $_[0];
    $thislink =~ m/ n="([^"]*)"/i;
    $n = $1;
    $thislink =~ m/ ref="([^"]*)"/i;
    $ref = $1;
# Check to see if we have an object id table for this document.
    $reffilepath = $SYSTEM_DIR . "references/" . $doc;
    if (-e $reffilepath) {
        $reftabexists = 1;
        }
    if (!$reftabexists) {
	$rtn = "[" . $philomessage[133] . ": " . $philomessage[134]. " " . $n . ":" . $ref . "]";
	return ($rtn);
	}
    if (!$gotreftable) {
	&ReadReferenceTable($doc);
        if (!$gotreftable) {
	    $rtn = "[" . $philomessage[133] . ": " . $philomessage[135] . " " . $n . ":" . $ref . "]";
	    return ($rtn);
	    }
	}
     $foundone = "";
     $foundone = $DOCREFHASH{$n};
     if (!$foundone) {
	  $rtn = "[" . $philomessage[133] . ": " . $philomessage[136] . " " . $n . ":" . $ref . "]";
	  return ($rtn);
	}
     @arefline = split('\t', $foundone);
     $refobject = $arefline[3];
     if ($DisplayPopNotes) {
            if (!$PHILOGETNOTE) {
                $PHILOGETNOTE = $PHILOGETOBJECT;
                $PHILOGETNOTE =~ s/object/note/;
                }
            $LINK = " <a href=\"javascript:displayNote('$refobject', '";
            $LINK .=  $PHILOGETNOTE . "?";
            $LINK .= "c." . $doc . ":" . $refobject;
            $LINK .= "." . $dbname . "')\">";
            if (!$ref) {
                 $ref = "[" . $philomessage[69] . "]";
                 }
            if (length($ref) < 3) {
                $ref = "[" . $ref . "]";
                }
            $LINK .= "<sup>" . $ref . "</sup></a><span id='note_";
            $LINK .= $refobject . "' class='hiddennote'";
            $LINK .= "onClick=\"hideNote('$refobject')\"></span>";
            }
      else {
            $LINK = " <a href=\"" . $PHILOGETOBJECT . "?";
            $LINK .= "c." . $doc . ":" . $refobject;
            $LINK .= "." . $dbname . '"';
            $LINK .= $NOTEWINDOWPARAMS . ">";
            if (!$ref) {
	        $ref= "[" . $philomessage[69] . "]";
	        }
            if (length($ref) < 3) {
                $ref = "[" . $ref . "]";
                }
           $LINK .= "<sup>" . $ref . "</sup></a>";
    }
    $rtn = $LINK;
return ($rtn);
}

# ----------------------------------------------------------------------
# ReadReferenceTable: read in the general reference table.  This is
#                     also found in refresolver, but I am splitting 
#                     this up for ATE and ARTFL-TEI documents.  
# Called from: ObjectFormat
# ----------------------------------------------------------------------
sub ReadReferenceTable {
     $reffilepath = $SYSTEM_DIR . "references/" . $doc;
     open (REFTABLEFH, "$reffilepath"); 
     $readmorerefs = 1;
     while ($reflinein = <REFTABLEFH>) {
            $gotreftable += 1;
            @t = split("\t", $reflinein);
            $tempbuf .= $reflinein . "\n";
            $DOCREFHASH{$t[1]} = $reflinein;
            }
     close (REFTABLEFH);
     @DOCREFLIST = split("\n", $tempbuf);
return;
}
# ----------------------------------------------------------------------
# ARTFLresolver: build a link to the notetext as specified in ARTFL
#              TEI encoding.  This should only be triggered for 
#              TextType = artfltei.  This is the recommended ARTFL
#              TEI encoding for notes and references.  The idea is
#              that notes live in distinct <divs so they can be
#              index outside of normal text streams and identified
#              for searching or exclusion (at DIV type).  
#              ARTFL and related projects specific.  This replicates
#              elements in &refresolver, and is here to ease future
#              maintenance.
# We want two way reference resolution.
# <ref type="note" id="ref1" target="n1" n="1"/>
# <note id="n1" place="foot" target="ref1" resp="Author">
# doc      id     type     para   pg       div
# 2       ref291  ref     2:3:0:2 25      2:3:0 
# 2       n291    note    2:3:1:0 29      2:3:1
# Called from: ObjectFormat
# ----------------------------------------------------------------------
sub ARTFLresolver {
    local ($rtn, $reffilepath,  $n, $reftabexists, $thislink, $linktype);
    local ($id, $type, $place, $target, $ref, $LINK, $refobject, $thelink);
    $thislink = $_[0];
    $thislink =~ m/ target="([^"]*)"/i;
    $target = $1;
    if (!$target) {           # Not an ARTFL ref or note as target is required.
	return ($thislink);   # So just return it.
	}
    if ($thislink =~ /<ref/i) {
       $linktype = "ref";
       $thislink =~ m/ type="([^"]*)"/i;
       $type = $1;
       $thislink =~ m/ n="([^"]*)"/i;
       $n = $1;
       }
    if ($thislink =~ /<note/i) {
       $linktype = "note";
       $thislink =~ m/ place="([^"]*)"/i;
       $place = $1;
       $thislink =~ m/ resp="([^"]*)"/i;
       $resp = $1;
       }
    $thislink =~ m/ id="([^"]*)"/i;
    $id = $1;
# Check to see if we have an object id table for this document.
    $reffilepath = $SYSTEM_DIR . "references/" . $doc;
    if (-e $reffilepath) {
        $reftabexists = 1;
        }
    if (!$reftabexists) {
        $rtn = "[" . $philomessage[133] . ": " . $philomessage[134] . " " . $n . ":" . $ref . "]";
        return ($rtn);
        }
# If you have not loaded the reference table for this doc, do so.
    if (!$gotreftable) {
        &ReadReferenceTable($doc);
        if (!$gotreftable) {
            $rtn = "[" . $philomessage[133] . ": " . $philomessage[135] . " " . $n . ":" . $ref . "]";
            return ($rtn);
            }
        }
# Check to see if you have a reference.
     $foundone = "";
     $foundone = $DOCREFHASH{$target};
# if not, bounce an error message....
     if (!$foundone) {
          $rtn = "[" . $philomessage[133] . ": " . $philomessage[136] . " " . $n . ":" . $ref . "]";
          return ($rtn);
        }
# otherwise build the link.  Remember, refs point to paraobjects
# $arefline[3] while notes point to page objects $arefline[4]
     @arefline = split('\t', $foundone);
     if ($linktype eq "ref") {
        $refobject = $arefline[3];
     if ($DisplayPopNotes) {
            if (!$PHILOGETNOTE) {
                $PHILOGETNOTE = $PHILOGETOBJECT;
                $PHILOGETNOTE =~ s/object/note/;
		}
	    $LINK = " <a href=\"javascript:displayNote('$refobject', '";
            $LINK .=  $PHILOGETNOTE . "?";
	    $LINK .= "c." . $doc . ":" . $refobject;
            $LINK .= "." . $dbname . "')\">";
	    if (!$n) {
                 $n = "[" . $philomessage[69] . "]";
                 }
            if (length($n) < 3) {
                $n = "[" . $n . "]";
                }
            $LINK .= "<sup>" . $n . "</sup></a><span id='note_";
	    $LINK .= $refobject . "' class='hiddennote'";
            $LINK .= "onClick=\"hideNote('$refobject')\"></span>";
            }
      else {
            $LINK = " <a href=\"" . $PHILOGETOBJECT . "?";
            $LINK .= "c." . $doc . ":" . $refobject;
            $LINK .= "." . $dbname . '"';
            $LINK .= $NOTEWINDOWPARAMS . ">";
            if (!$n) {
	         $n = "[" . $philomessage[69] . "]";
	         }
	    if (length($n) < 3) {
		$n = "[" . $n . "]";
		}
	     $LINK .= "<sup>" . $n . "</sup></a>";
        }
        $rtn = $LINK;
	 }
      else {
	$refobject = $arefline[4] - 1;
	$LINK = "<p>" . $philomessage[69] . " ";
	if ($resp) {
		$LINK .= "(" . $resp . ")";
		}
	$LINK .= " " . $philomessage[70] . " ";
	$LINK .= "<a href=\"" . $PHILOGETOBJECT . "?";
        $LINK .= "p." . $doc . ":" . $refobject;
        $LINK .= "." . $dbname ."\">";
        $LINK .= $philomessage[75] . "</a> ";
	$rtn = $LINK;
	}
return ($rtn);
}

# ----------------------------------------------------------------------
# PopNoteFormat: Formats notes for in-line pop-in display 
# Called from: getnote.pl
# ----------------------------------------------------------------------
# NOTE: This better be a TEI or ATE text we are dealing with or this 
# probably won't do too much.... don't use this note scheme otherwise.
# What will we find in notes that we need to format? Not as much as in
# some other objects... italics, emphasis, titles maybe, etc.

sub PopNoteFormat {
   local ($testtext);

   $testtext = $_[0];

   $testtext =~ s/&dot;/\./g;
   $testtext =~ s/<emph  *REND="smallcaps">/<span class=emphsc>/gi;
   $testtext =~ s/<emph[^>]*>/<span class=emph>/gi;
   $testtext =~ s/<\/emph>/<\/span>/gi;
   $testtext =~ s/<hi  *rend="ital[^"]*">/<span class=hiitalic>/gi;
   $testtext =~ s/<hi  *rend="smallcaps">/<span class=hismallcap>/gi;
   $testtext =~ s/<hi  *rend="underline">/<span class=hiunderline>/gi;
   $testtext =~ s/<HI  *REND="font\(bold\)">/<span class=hibold>/gi;
   $testtext =~ s/<hi  *rend="bold">/<span class=hibold>/gi;
   $testtext =~ s/<HI>/<span class=hi>/gi;
   $testtext =~ s/<\/HI>/<\/span>/gi;
   if ($testtext =~ /<pb/i) {
       $testtext =~ s/(<pb[^>]*>)/&PageTagHandler($1)/gie;
   }
   if ($testtext =~ /&[\#0-9A-Za-z]*;/) {
        $testtext = &Ents2Unicode($testtext);
        $testtext = &EntityConvert($testtext);
   }

   return $testtext;
}

# ----------------------------------------------------------------------
# LoadLocalMessages: loads in the language-specific messages file
# Called from: philosubs.pl
# ----------------------------------------------------------------------
# NOTE: We check to see which language-specific messages file is called
# for in philo-db.cfg, and load it up. These messages are displayed
# to the user through the CGIs. To change which file gets loaded, that is,
# to use a different language, don't edit this function -- set your
# perference in philo-db.cfg.
# Someday, we may alter this function to override the default based on a
# cookie or other user-level setting.

sub LoadLocalMessages {
	if ($PHILOMESSAGEFILE eq "") {
		$PHILOMESSAGEFILE = "english.messages.pl";
	}
	do $PHILOMESSAGEFILE;
}

# ====================== Additional Subroutines =======================
# As part of the migration to gargantua, we arem adding additional subroutines
# many of which come from various extensions from the Philologic Wiki
# and some other odds and ends.  MVO 4-10-09
# ====================================================================
# ----------------------------------------------------------------------
# lowercaseify:  PhiloLogic will fold some upper-case characters to lower 
# case, including some accented characters. This causes problems for searching 
# on these characters when entered in capitals, because in words.R, these 
# are represented in lower case. The same case folding does not normally 
# occur on search strings.  This should be replaced by a full perl module

sub lowercaseify() {
    my $theword = $_[0];
    $theword =~ s/\xc3([\x80-\x9E])/&up2low($1)/ge;
    return ($theword);
}
# ---------------------------------------------------------------------
# up2low: maps upper case to lower case, of second UTF-8 byte.  This will
# work for French and others.  
# Called by: lowercaseify

sub up2low() {
    my $onechar = $_[0];
    $onechar =~ tr/\x80-\x9E/\xA0-\xBE/;
    my $rtn = "\xc3" . $onechar;
    return ($rtn);
}

# ----------------------------------------------------------------------
# GetKwicResortLabels: get labels for displaying the sort key for kwic resorting
# Called from: kwicresort.pl
# This is sprintf message 309....
# ----------------------------------------------------------------------

sub GetKwicResortLabels {
        my $f1 = $_[0]; my $f2 = $_[1]; my $f3 = $_[2];
        my ($rtn, $ListofResortSortOptions);
        $ListofResortSortOptions[0] = "";
        $ListofResortSortOptions[1] = "Keyword";
        $ListofResortSortOptions[2] = "Words to the Right";
        $ListofResortSortOptions[3] = "Words to the Left";
        $ListofResortSortOptions[4] = "Field";
        $ListofResortSortOptions[5] = "Work Title";
        $ListofResortSortOptions[6] = "Work Author";
        $ListofResortSortOptions[7] = "Work Year";
        $ListofResortSortOptions[8] = "Field";
        $ListofResortSortOptions[9] = "Field";
        $ListofResortSortOptions[10] = "Publication Place";
        $rtn = $ListofResortSortOptions[$f1];
        $rtn .= ", ";
        $rtn .= $ListofResortSortOptions[$f2];
        $rtn .= ", ";
        $rtn .= $ListofResortSortOptions[$f3];
return ($rtn);
}


1; 

