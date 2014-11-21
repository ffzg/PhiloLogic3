// $Id: enprefix.c,v 2.10 2004/05/28 19:22:16 o Exp $
/*
 * enprefix.c - reads in a file of words (assumed to be sorted and uniq'ed)
 * and puts out the list in a prefix omitted format.
 * The output is a sequence of records each of which consists of:
 *
 *    1) a one byte unsigned integer (char) giving the length of the prefix
 *    2) a one byte unsigned integer (char) giving the length of the suffix
 *    3) the suffix of the word in normal ascii characters
 *
 * The first record has zero as prefix length, the suffix length is the same as
 * the word length and the suffix is the word itself.  From then on, words
 * may be constructed by taking the first prefix-length characters from the
 * previous word and appending the suffix.
 */
#include <stdio.h>
#include <string.h>

#define MAXWORD 512

main (argc, argv)
    int argc;
    char *argv[];
{
    register i;
    int sl;
    char thisword[MAXWORD];
    char lastword[MAXWORD];

    int ix;
    for (ix = 1; ix < argc && argv[ix][0] == '-'; ix++) {
	switch (argv[ix][1]) {
	case '#':
	    break;
	}
    }

    lastword[0] = '\0';

    while(fscanf(stdin,"%[^\n]\n",thisword)==1) {

	/* note: this subloop assumes that the words are unique */
	for (i=0;lastword[i]==thisword[i];++i) ; 
	sl = strlen(&(thisword[i]));		/* suffix length */

	/* print out this word */
	printf("%c%c%s",
	    (char) i,				/* prefix length */
	    (char) sl,				/* suffix length */
	    &(thisword[i]));			/* suffix */

	/* rememberthis word */
	strcpy(lastword,thisword);
    }

    exit(0);
}
