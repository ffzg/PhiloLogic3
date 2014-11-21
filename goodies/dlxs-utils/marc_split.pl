#!/l/local/bin/perl

#*******************************************************************
#
#       File:   marc_split.pl
#       Desc:   Splits a file of MARC records into individual
#               files named by their NOTIS-ID.
#
#*******************************************************************

# $Id: marc_split.pl,v 1.2 2004/01/14 19:59:00 sooty Exp $

# $count = "0";
# $spin_count = 0;
# @spinner = ("-", "\\", "|", "/" );

#*******************************************************************        
#
#   Function:	PrintSpinner 
#   Desc:	Dumb feedback to stdout for user
#   Args:	n/a
#   Returns: 	n/a
#
#*******************************************************************        

# sub PrintSpinner
# {
  # print "$spinner[$spin_count]\x08"; 
  # $spin_count++;
  # $spin_count %= 5;
#}

#*******************************************************************        
#
#   Function: main
#   Desc: (see file descrition)
#   Args: input:  <umrrecs.marc> file 
#         output: <moa_notis.txt> file
#		  <moa_list.txt> file
#   Returns: n/a
#
#*******************************************************************        
        
main: 
{
   #been running this on each separate files
   $/ = "\035";
   $field = "\036";
   $subfield = "\037";

   if ( $#ARGV >= 0 )
   { 
      $inputfile = $ARGV[0]; 
   }
   else
   { 
      print "Syntax: marc_split.pl <input-filename>\n";
      return;
   }
      
   open (MARC, $inputfile) or die "ERROR: Unable to open input file --";

   while (<MARC>) 
   {
      chomp;

      my(%record);

      $data = $_;
      $record{'leader'} = substr($_, 0, 24);
      $record{'logical_record_length'} = substr($record{'leader'}, 0, 5);
      $record{'data_offset'} = substr($record{'leader'}, 12, 5);
      $record{'all_data'} = substr($_, $record{'data_offset'});
      substr($_, 0, 24) = '';

      while ($_ =~ s,^(\d{12}),,) 
      {
         my($entry) = $1;
	 my($tag) = substr($entry, 0, 3);

         if ($tag =~ "001")
         {	  
             my($field_length) = substr($entry, 3, 4);
	     my($fl) = $field_length;
	     $fl =~ s,^0+,,;
	     my($starting_char_offset) = substr($entry, 7, 5);
	     my($scp) = $starting_char_offset;
	     $scp =~ s,^0+,,;

             $record{"$tag"}{"field_length"} = $field_length;
	     $record{"$tag"}{"starting_char_offset"} = $starting_char_offset;
	     $record{"$tag"}{"data"} = substr($record{'all_data'}, $scp, $fl);
	     $record{"$tag"}{"data"} =~ s,$field,,;          
	     $record{"$tag"}{"data"} =~ s,$subfield(\w),,g;
          }
#          &PrintSpinner;
      } # end--while ($_ =~ s,^(\d{12}),,) 

    $notisid = $record{'001'}{'data'};
    $notisid =~ s,^UL,,;
    ($notisid) = split /\s/, $notisid, 0;
        
    # Output single MARC record
    
    $pathname = "./marc/" . $notisid . ".marc";
    open (NOTIS, ">$pathname") or die "ERROR: Unable to open input file --";
    print( NOTIS $data . $/ ); 
    close(NOTIS);
    
    $count++;

  } # end-- while (<>) 

  print "\n Total records processed: $count \n";

  close(MARC);

} # end main

