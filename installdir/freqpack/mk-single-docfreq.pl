#!/usr/bin/perl

$wordfreqdir = $FREQ_DIR . "wordfreqdoc/";

opendir WORDFREQDIR, $wordfreqdir;
@allfiles= grep !/^\.\.?$/,  readdir WORDFREQDIR;
closedir WORDFREQDIR;

open OUTFILE, ">" . $FREQ_DIR . "word.freq.doc";

foreach $file (@allfiles) {
    open INFILE, $wordfreqdir . "/" . $file;
    while ($line = <INFILE>) {
	if (!($line =~ /^ZZZ/)) { 
	    print OUTFILE $line;
	}
    }
    close INFILE;
}

close OUTFILE;
