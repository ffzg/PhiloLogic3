/*
 *  mkbttab:  make bitmap tables required for fast
 *    scaling algorithms (make the bitmap tables once
 *    rather than gen'ing them each time you start up
 *    a scaling program)
 */


#include <stdio.h>

#define	BTTAB	"bttab.c"

int bc[8] = {
	0,		/* 0 */
	1,		/* 1 */
	1, 		/* 2 */
	2,		/* 3 */
	1,		/* 4 */
	2,		/* 5 */
	2,		/* 6 */
	3,		/* 7 */
};

main ()
{
	FILE 	* fp;
	register int i;
	unsigned char v;

	if ((fp = fopen (BTTAB, "w")) == NULL) {
		perror (BTTAB);
		exit (1);
	}
	fprintf (fp, "/* THIS FILE IS MACHINE GENERATED... DO NOT MODIFY */ \n");

	/*
	 * write out the scale x 3 bitmap
	 *
	 * entries correspond to shrinking groups of
	 * 3 bits to one bit
	 */
	fprintf (fp, "/* scale3tab: merge 3 bits -> 1 */ \n");
	fprintf (fp, "unsigned char scale3tab[] = {\n");

	for (i=0; i < 4096; ++i) {
		v = 0;
		if ( bc[(i & 0xE00) >> 9] > 1 )
			v |= 0x8;
		if ( bc[(i & 0x1C0) >> 6] > 1 )
			v |= 0x4;
		if ( bc[(i & 0x038) >> 3] > 1 )
			v |= 0x2;
		if ( bc[(i & 0x007)] > 1 )
			v |= 0x1;
	
		fprintf (fp, " %#x,\n", v);
	}

	fprintf (fp, "};\n");

	fclose (fp);

	exit (0);
}
