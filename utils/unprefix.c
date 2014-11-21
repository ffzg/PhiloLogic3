// $Id: unprefix.c,v 2.10 2004/05/28 19:22:16 o Exp $
/* unprefix.c - undoes enprefix.c, q.v.
 */

#include <stdio.h>
#include <string.h>

#define MAXWORD 512

main (argc, argv)
    int argc;
    char *argv[];
{
    register i;
    unsigned char w[MAXWORD];
    unsigned doc, part, sent, word;
    unsigned x;
    unsigned sl;

    int ix;
    for (ix = 1; ix < argc && argv[ix][0] == '-'; ix++) {
	switch (argv[ix][1]) {
	case '#':
	    break;
	}
    }

    while (i = getchar(), !feof(stdin)) {
	for (x = i + getchar(); i < x; i++) w[i] = getchar();
	w[i] = '\0';

	printf("%s\n", w);
    }

    exit(0);
}
