#!/l/local/bin/perl






$count = "0";

# Set input file from command line or from default

if ( $#ARGV >= 0 )
   { $inputfile = $ARGV[0]; }
else
   { $inputfile = "records.marc"; }

open (NOTIS, $inputfile) or die "ERROR: Unable to open input file --";

# grab all the notis ids/ root paths extents and titles from the moa lists

while (<NOTIS>) {
        chop;
        
	local ($notis, $root, $pageextent, $moatitle)= split (/\|\|\|/, $_);
      #	$ROOT{$notis} = $root;
	$EXTENT{$notis} =$pageextent;
	$MOATITLE{$notis} = $moatitle;
	

}

#been running this on each separate files
$/ = "\035";
$field = "\036";
$subfield = "\037";

$index = 0;


while (<>) {

    chomp;

    my(%record);

    $record{'leader'} = substr($_, 0, 24);
    $record{'logical_record_length'} = substr($record{'leader'}, 0, 5);
    $record{'record_status'} = substr($record{'leader'}, 5, 1);
    $record{'type_of_record'} = substr($record{'leader'}, 6, 1);
    $record{'bibliographic_level'} = substr($record{'leader'}, 7, 1);
    $record{'type_of_control'} = substr($record{'leader'}, 8, 1);
    $record{'undefined'} = substr($record{'leader'}, 9, 1);
    $record{'indicator_count'} = substr($record{'leader'}, 10, 1);
    $record{'subfield_code_count'} = substr($record{'leader'}, 11, 1);
    $record{'base_address_of_data'} = substr($record{'leader'}, 12, 5);
    $record{'encoding_level'} = substr($record{'leader'}, 17, 1);
    $record{'descriptive_cataloging_form'} = substr($record{'leader'}, 18, 1);
    $record{'linked_record_requirement'} = substr($record{'leader'}, 19, 1);
    $record{'entry_map'} = substr($record{'leader'}, 20, 4);
    ## entry_map is more complicated by the standard, but apparently
    ## only ever holds default values so far...

    $record{'all_data'} = substr($_, $record{'base_address_of_data'});

    substr($_, 0, 24) = '';

    while ($_ =~ s,^(\d{12}),,) {
	my($entry) = $1;
	my($tag) = substr($entry, 0, 3);

        #this accomodates that fact that sometimes there are multiples of a single field

	foreach $oldtag (sort(keys (%record))) {
	    if ($tag eq $oldtag) {
		$tag="$tag" . "a";

	    }
	}
	my($field_length) = substr($entry, 3, 4);
	my($fl) = $field_length;
	$fl =~ s,^0+,,;
	my($starting_character_position) = substr($entry, 7, 5);
	my($scp) = $starting_character_position;
	$scp =~ s,^0+,,;
	$record{"$tag"}{"field_length"} = $field_length;
	$record{"$tag"}{"starting_character_position"} = 
	    $starting_character_position;
	$record{"$tag"}{"data"} = substr($record{'all_data'}, $scp, $fl);
	$record{"$tag"}{"data"} =~ s,$field,,;
	$record{"$tag"}{"data"} =~ s,$subfield(\w),|lesssubtag|M.\u$1|moresubtag|,g;
# jpw	$record{"$tag"}{"data"} =~ s,$subfield(a),,g;
# this is pretty bogus
	$record{"$tag"}{"data"} =~ s,$subfield(\w), ; ,g;
    }

    foreach $field (sort(keys (%record))) {


 	if ($field =~ m,(^\d{3}$|^\d{3}\w+$),) {

	    $inform = "$record{$field}{'data'}";
	    $inform =~ s,\&,\&amp;,g;
	    $inform =~ s,<,\&lt\;,g;
	    $inform =~ s,>,\&gt\;,g;
	    $inform =~ s,\|lesssubtag\|,<,g;
	    $inform =~ s,\|moresubtag\|,>,g;
	    $inform =~ s,<(M.\w)>([^<]*),<$1>$2</$1>,g;
	    $inform =~ s,<(M.\w)>([^<]*)$,<$1>$2</$1>,g;
	    $inform =~ s,^\s+,,g;
	    $inform =~ s,^\d+\s?<,<,g;
	    $inform =~ s,^\d+\?\s?<,<,g;
	    $inform =~ s,^\?+\s?<,<,g;
	    




            $inform =~ s,<M.[0-9]>[^<]*</M.[0-9]>,,g;

	    $inform =~ s,\xe2e,\&eacute\;,g;
	    $inform =~ s,\xe2E,\&Eacute\;,g;
	    $inform =~ s,\xe2a,\&aacute\;,g;
	    $inform =~ s,\xe2n,\&nacute\;,g;
	    $inform =~ s,\xe1e,\&egrave\;,g;
	    $inform =~ s,\xe8u,\&uuml\;,g;
	    $inform =~ s,\xe8e,\&euml\;,g;
	    $inform =~ s,\xb6,\&oelig\;,g;
	    $inform =~ s,\xa5,\&AElig\;,g;
	    $inform =~  s,\xb5,\&aelig\;,g;
	    $inform =~  s,\xca,+,g;
	    $inform =~  s,\xe4n,\&ntilde\;,g;
	    $inform =~  s,\xb0,\&lsquo\;,g;
	    $inform =~  s,\xae,\&rsquo\;,g;
	    $inform =~  s,\xe2o,\&oacute\;,g;
	    $inform =~  s,\xf0c,\&ccedil\;,g;
            
            #these are suspect
	    $inform =~  s,\xb7,,g;
	    $inform =~  s,\xc0,0,g;
	    $inform =~  s,\x0,,g;
	    $inform =~  s,p,,g;
	    $inform =~  s,b,,g;
	    $inform =~  s,s,,g;
	    if ($field =~ m,245,) {
		push @titles, $inform;
	    }


	    elsif ($field =~ m,(211|212|214|222|242|243|247),) {
		push @othernotes, $inform;

	    }


	    elsif ($field =~ m,(246|240),) {
		push @alttitle, $inform;

	    }

            elsif ($field =~ m,111,) {
               push @conf, $inform;
            }
# 111 is conference main entry -- had been in othernotes

	    elsif  ($field =~ m,(100|110),) {
		push @author, $inform;
   	    }
	    elsif ($field =~ m,130,) {
               push @uniform, $inform;
            }
#actually, we prefer 130 (over 245) as title if there is one

	    elsif ($field =~ m,250,) {
		push @edition, $inform;

	    } 
	    elsif ($field =~ m,260,) {
	    	push @pubstmt, $inform;
	    
	    }
	    elsif ($field =~ m,(261|262|265),) {
		$inform ="$field--$inform";
		push @blah, $inform;

	    }
	    elsif ($field =~ m,(300|305|306|310|315|321|340|350|351|355|357|362),) {
		 push @extent, $inform;
            }
	    elsif ($field =~ m,(400|410|411|440|490),){
		push @series, $inform;
	    }
	    elsif ($field =~ m,500,) {
		push @notes, $inform;

	    }
	    elsif ($field =~ m,510,) {
		push @stcno, $inform;

	    }	    elsif ($field =~ m,(^6|810),) {
		push @subjects, $inform;

	    }
	    elsif ($field =~ m,(700),) {
		push @addauths, $inform;

	    }
	    elsif ($field =~ m,(710),) {
		push @corpauths, $inform;

	    }
	    elsif ($field =~ m,(711),) {
		push @mtgauths, $inform;

	    }
	    elsif ($field =~ m,(730),) {
		push @addtitle, $inform;

	    }
	    elsif ($field =~ m,^7,) {
		push @addentries, $inform;

	    }

#700, 710, 711 are actually added authors

	    elsif ($field =~ m,856,) {
		push @vid, $inform;

	    }


	    elsif ($field =~ m,^9,) {
		if (not $field =~ m,998,) {
		    push @XXentries, $inform;

	    }
        }
     }  
    }
	
	$notisid = $record{'001'}{'data'};
	$notisid =~ s,^UL,,;
	$notisid =~ s,ocm,,;
	$notisid =~ s,\s,,g;
	if (-e "teiout/$notisid.hdr") {
	    print "$notisid duplicate\n";
	}
#	$rootid = $ROOT{$notisid};

	$digextent = $EXTENT{$notisid};
	$comtitle = $MOATITLE{$notisid};
	$count ++;
        
        &CreateTei;
}

    print $count;

    
sub CreateTei {
    $sgmfile = "teiout/$notisid.hdr";
    my $now = `date +"%Y-%m-%d"`; chop $now;


    open (SGMDOC, ">$sgmfile") or die "ERROR: Unable to open output file --";
    print SGMDOC (qq{<HEADER><FILEDESC>\n});

    print SGMDOC (qq{<TITLESTMT>\n});

    if (@titles) {
	foreach $item (@titles) {
    print SGMDOC (qq{<TITLE TYPE=\"245\">});
	    $item =~ s,<M.A>,,g;
	    $item =~ s,</M.A>,,g;
	    $item =~ s,<M.B>, ,g;
	    $item =~ s,</M.B>,,g;
	    $item =~ s,<M.C>, ,g;
	    $item =~ s,</M.C>,,g;
	    $item =~ s,<M.H>[^<]*</M.H>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
	    print SGMDOC $item;
    }	
    print SGMDOC (qq{</TITLE>\n});
    }


    if (@author) {
	foreach $item (@author) {

	print SGMDOC (qq{<AUTHOR>});
	    $item =~ s,<M.A>,,g;
	    $item =~ s,</M.A>,,g;
	    $item =~ s,<M.Q>, ,g;
	    $item =~ s,</M.Q>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
	    print SGMDOC $item;
	print SGMDOC (qq{</AUTHOR>\n});
    }				#
    }

  
    print SGMDOC (qq{</TITLESTMT>\n});
    print SGMDOC (qq{<EXTENT>$digextent 600dpi TIFF G4 page images</EXTENT>\n});

    print SGMDOC (qq{<PUBLICATIONSTMT>\n});

    print SGMDOC (qq{<PUBLISHER>University of Michigan, Digital Library Production Service</PUBLISHER><PUBPLACE>Ann Arbor, Michigan</PUBPLACE>\n});
    print SGMDOC (qq{<DATE>2001</DATE>\n});

    print SGMDOC (qq{<IDNO TYPE="marc">$notisid</IDNO>\n});

    if (@stcno) {
	foreach $item (@stcno) {

    print SGMDOC (qq{<IDNO TYPE="stc">});
	    $item =~ s,<M.A>,,g;
	    $item =~ s,</M.A>,,g;
	    $item =~ s,<M.C>, ,g;
	    $item =~ s,</M.C>,,g;
    print SGMDOC $item;
	print SGMDOC (qq{</IDNO>\n});
    }				#
    }

    if (@vid) {
	foreach $item (@vid) {

    print SGMDOC (qq{<IDNO TYPE="vid">});
	    $item =~ s,<M.U>http://wwwlib.umi.com/eebo/image/,,g;
	    $item =~ s,</M.U>,,g;
    print SGMDOC $item;
	print SGMDOC (qq{</IDNO>\n});
    }				#
    }


    print SGMDOC (qq{<AVAILABILITY>\n<P>These pages may freely searched and displayed. Permission must be received for subsequent distribution in print or electronically. Please go to http://www.umdl.umich.edu/ for more information.</P>\n</AVAILABILITY>});
    print SGMDOC (qq{</PUBLICATIONSTMT>\n});

 if (@series) {
	print SGMDOC (qq{<SERIESSTMT>});
     foreach $item (@series) {
        print SGMDOC (qq{<TITLE>});
	    $item =~ s,<M.A>,,g;
	    $item =~ s,</M.A>,,g;
	    $item =~ s,<M.V>, ,g;
	    $item =~ s,</M.V>,,g;
           $item =~ s,<M..>, ,g;
           $item =~ s,</M..>,,g;
    print SGMDOC $item;
        print SGMDOC (qq{</TITLE>});
    }	
	print SGMDOC (qq{</SERIESSTMT>\n}); # 
}			# 
    
 
    print SGMDOC (qq{<SOURCEDESC>\n});
    
    print SGMDOC (qq{<BIBLFULL>\n});
    print SGMDOC (qq{<TITLESTMT>\n});
    if (@titles) {
	foreach $item (@titles) {
	print SGMDOC (qq{<TITLE TYPE=\"245\">});
	    $item =~ s,<M.A>,,g;
	    $item =~ s,</M.A>,,g;
	    $item =~ s,<M.B>, ,g;
	    $item =~ s,</M.B>,,g;
	    $item =~ s,<M.C>, ,g;
	    $item =~ s,</M.C>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
	    print SGMDOC $item;
    print SGMDOC (qq{</TITLE>\n});
    }	
    }	

    if (@alttitle) {
	foreach $item (@alttitle) {
    print SGMDOC (qq{<TITLE TYPE=\"alt\">});
	    $item =~ s,<M.A>,,g;
	    $item =~ s,</M.A>,,g;
	    $item =~ s,<M.B>, ,g;
	    $item =~ s,</M.B>,,g;
	    $item =~ s,<M.C>, ,g;
	    $item =~ s,</M.C>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
	    print SGMDOC $item;
    print SGMDOC (qq{</TITLE>\n});
    }	
    }

    if (@addtitle) {
	foreach $item (@addtitle) {

	    $item =~ s,<M.A>,<TITLE TYPE="add">,g;
	    $item =~ s,</M.A>,</TITLE>,g;
	    $item =~ s,<M..>[^<]*</M..>,,g;
	    print SGMDOC $item;
    }				#
    }
    if (@author) {
	foreach $item (@author) {

	print SGMDOC (qq{<AUTHOR>});
	    $item =~ s,<M.A>,,g;
	    $item =~ s,</M.A>,,g;
	    $item =~ s,<M.Q>, ,g;
	    $item =~ s,</M.Q>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
	    print SGMDOC $item;
	print SGMDOC (qq{</AUTHOR>\n});
    }				#
    }

    if (@addauths) {
	foreach $item (@addauths) {

	    $item =~ s,<M.A>,<AUTHOR>,g;
	    $item =~ s,</M.A>,,g;
	    $item =~ s,<M.D>, ,g;
	    $item =~ s,</M.D>,,g;
	    $item =~ s,<M..>[^<]*</M..>,,g;
	    print SGMDOC $item;
	print SGMDOC (qq{</AUTHOR>\n});
    }				#
    }

    print SGMDOC (qq{</TITLESTMT>\n});			#
    if (@edition) {
	print SGMDOC (qq{<EDITIONSTMT>});
       foreach $item (@edition) {
	print SGMDOC (qq{<EDITION>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.C>, ,g;
           $item =~ s,</M.C>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</EDITION>\n});
    }				#
	print SGMDOC (qq{</EDITIONSTMT>\n});
    }				#    
			#
    if (@extent) {
       foreach $item (@extent) {
	print SGMDOC (qq{<EXTENT>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.C>, ,g;
           $item =~ s,</M.C>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</EXTENT>\n});
    }				#
    }
    print SGMDOC (qq{<PUBLICATIONSTMT>});
    
    if (@pubstmt) {
       foreach $item (@pubstmt) {
           $item =~ s,<M.A>,<PUBPLACE>,g;
           $item =~ s,</M.A>,</PUBPLACE>,g;
           $item =~ s,<M.B>,<PUBLISHER>,g;
           $item =~ s,</M.B>,</PUBLISHER>,g;
           $item =~ s,<M.C>,<DATE>,g;
           $item =~ s,</M.C>,</DATE>,g;
           $item =~ s,<M.D>,<PUBPLACE>,g;
	   $item =~ s,</M.D>,</PUBPLACE>,g;
	   $item =~ s,<M.E>,<PUBPLACE>,g;
	   $item =~ s,</M.E>,</PUBPLACE>,g;
	   $item =~ s,<M.F>,<PUBLISHER>,g;
	   $item =~ s,</M.F>,</PUBLISHER>,g;
	   $item =~ s,<M.G>,<DATE>,g;
	   $item =~ s,</M.G>,</DATE>,g;
           print SGMDOC $item;
       }    
    }
    print SGMDOC (qq{</PUBLICATIONSTMT>});
    print SGMDOC (qq{<NOTESSTMT>});

	if (@conf) {

	foreach $item (@conf) {
	print SGMDOC (qq{<NOTE><P>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
           $item =~ s,<M.X>, -- ,g;
           $item =~ s,</M.X>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</P></NOTE>});
    }
    }
	if (@uniform) {

	foreach $item (@uniform) {
	print SGMDOC (qq{<NOTE><P>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
            $item =~ s,<M.X>, -- ,g;
           $item =~ s,</M.X>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</P></NOTE>});
    }
    }
# There are none

	if (@corpauths) {

	foreach $item (@corpauths) {
	print SGMDOC (qq{<NOTE><P>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
            $item =~ s,<M.X>, -- ,g;
           $item =~ s,</M.X>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</P></NOTE>});
    }
    }
	if (@mtgauths) {
	foreach $item (@mtgauths) {
	print SGMDOC (qq{<NOTE><P>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
            $item =~ s,<M.X>, -- ,g;
           $item =~ s,</M.X>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</P></NOTE>});
    }
    }
	if (@notes) {

	foreach $item (@notes) {
	print SGMDOC (qq{<NOTE><P>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
            $item =~ s,<M.X>, -- ,g;
           $item =~ s,</M.X>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</P></NOTE>});
    }
    }
	if (@othernotes) {

	foreach $item (@othernotes) {
	print SGMDOC (qq{<NOTE><P>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
            $item =~ s,<M.X>, -- ,g;
           $item =~ s,</M.X>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</P></NOTE>});
    }
    }
	if (@XXentries) {

	foreach $item (@XXentries) {
	print SGMDOC (qq{<NOTE><P>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
            $item =~ s,<M.X>, -- ,g;
           $item =~ s,</M.X>,,g;
	    $item =~ s,<M..>, ,g;
	    $item =~ s,</M..>,,g;
           print SGMDOC $item;
	print SGMDOC (qq{</P></NOTE>});
    }
    }
#There are none.
	
    print SGMDOC (qq{</NOTESSTMT>\n});    
    print SGMDOC (qq{</BIBLFULL>\n});


    print SGMDOC (qq{</SOURCEDESC>\n});
    print SGMDOC (qq{</FILEDESC>\n<ENCODINGDESC><PROJECTDESC><P>Header created with script marc2tei.pl on $now.</P></PROJECTDESC><EDITORIALDECL N="4"><P>Encoding has been done using the recommendations for Level 4 of the TEI in Libraries Guidelines.  Digital page images are linked to the text file.</P></EDITORIALDECL></ENCODINGDESC>});

    if (@subjects) {
	print SGMDOC (qq{<PROFILEDESC>\n});
	print SGMDOC (qq{<TEXTCLASS>\n<KEYWORDS>});
	if (@subjects){
	foreach $item (@subjects) {
	    print SGMDOC (qq{<TERM>});
           $item =~ s,<M.A>,,g;
           $item =~ s,</M.A>,,g;
           $item =~ s,<M.B>, -- ,g;
           $item =~ s,</M.B>,,g;
           $item =~ s,<M.C>, -- ,g;
           $item =~ s,</M.C>,,g;
           $item =~ s,<M.D>, -- ,g;
           $item =~ s,</M.D>,,g;
           $item =~ s,<M.P>, -- ,g;
           $item =~ s,</M.P>,,g;
           $item =~ s,<M.T>, -- ,g;
           $item =~ s,</M.T>,,g;
           $item =~ s,<M.V>, -- ,g;
           $item =~ s,</M.V>,,g;
           $item =~ s,<M.X>, -- ,g;
           $item =~ s,</M.X>,,g;
           $item =~ s,<M.Y>, -- ,g;
           $item =~ s,</M.Y>,,g;
           $item =~ s,<M.Z>, -- ,g;
           $item =~ s,</M.Z>,,g;
           $item =~ s,<M.E>, ,g;
           $item =~ s,</M.E>,,g;
           $item =~ s,<M.F>, ,g;
           $item =~ s,</M.F>,,g;
           $item =~ s,<M.G>, ,g;
           $item =~ s,</M.G>,,g;
           $item =~ s,<M.K>, ,g;
           $item =~ s,</M.K>,,g;
           $item =~ s,<M.L>, ,g;
           $item =~ s,</M.L>,,g;
           $item =~ s,<M.N>, ,g;
           $item =~ s,</M.N>,,g;
           $item =~ s,<M.Q>, ,g;
           $item =~ s,</M.Q>,,g;
           $item =~ s,<M..>, ,g;
           $item =~ s,</M..>,,g;
           print SGMDOC $item;
	    print SGMDOC (qq{</TERM>});
	}	
}				
  
    print SGMDOC (qq{</KEYWORDS>\n</TEXTCLASS>});

    print SGMDOC (qq{</PROFILEDESC>\n}); 
}
    print SGMDOC (qq{</HEADER>\n});


    close SGMDOC;
    @subjects = ();
    @titles = ();
    @alttitle = ();
    @pubstmt = ();
    @author = ();
    @uniform = ();
    @addentries =();
    @edition =();
    @addauths =();
    @addtitle =();
    @stcno =();
    @vid =();
    @corpauths =();
    @conf =();
    @mtgauths =();
    @XXentries =();
    @othernotes = ();
    @extent = ();
    @series = ();
    @notes = ();
#    $rootid = '';
    $notisid ='';
}


#some error checking to make sure that we haven't mixed up materials

open (PROCESS, ">>processing");
$testtitle = $titles[0];
$testtitle =~ s,<\w>,,g;
$testtitle =~ s,</\w>,,g;
$testtitle =~ s,\n,,g;
$testtitle =~ s,^(\S+\s\S+\s\S+\s).*,$1,g;


$comtitle =~ s,^(\S+\s\S+\s\S+\s).*,$1,g;


if ($comtitle =~ m,$testtile,) {
}
else {
    print PROCESS (qq{MARC: $testtitle/ MOA: $comtitle - $notisid\n\n});
}

close PROCESS;







