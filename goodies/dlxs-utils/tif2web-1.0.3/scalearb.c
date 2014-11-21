/*
 *  scale by an arbitrary factor > 1 and < 8, an input
 *  buffer at one resolution to an output buffer at a different
 *  resolution.
 */
#include <stdio.h>
#include <math.h>
#include "scalearb.h"

#ifdef TESTING
#define LITTLE_ENDIAN
#endif

/* number of bits per byte */
#define	BPB	8

#define	Max(a,b)	((a)>(b)?(a):(b))
#define	Min(a,b)	((a)<(b)?(a):(b))

#define howmany(x,y) ((((unsigned long)(x))+(((unsigned long)(y))-1))/((unsigned long)(y)))

#define	Assert(cond)	do { \
                          if (!(cond)) { \
                            fprintf(stderr,"ASSERT fails at %d %s\n", \
				  __LINE__, __FILE__); \
                            exit(1); \
			  } \
                        } while(0)


/*
 * Various tables for extracting and counting bits.
 */
static int tablesInited = 0;

/* Count bits in a byte. */
/* Use 4-bit table to build 8-bit table. */
static int bitcnt4[16] = {
    0, 1, 1, 2, 1, 2, 2, 3,
    1, 2, 2, 3, 2, 3, 3, 4
};
static int bitcnt8[256];

/* Pull out N+1 bits at an offset of O in byte B. */
/*                      B  N  O */
static unsigned char bm[2][8][8];

static void initTables()
{
    int nbits, offset;
    int bits;

    if ( tablesInited )
	return;

    for ( nbits = 1; nbits <= 8; nbits++ )
    {
	int i;
	bits = 0;
	/* Build n-bit bitmask in a 16-bit field. */
	for ( i = 0; i < nbits; i++ )
	{
#ifdef LITTLE_ENDIAN
	    bits <<= 1;
	    bits |= 1;
#else
	    bits >>= 1;
	    bits |= 0x8000;
#endif
	}

	/* Generate each offset. */
	for ( offset = 0; offset < 8; offset++ )
	{
#ifdef LITTLE_ENDIAN
	    bm[0][nbits-1][offset] = bits & 0xff;
	    bm[1][nbits-1][offset] = (bits>>8) & 0xff;
	    bits <<= 1;
#else
	    bm[0][nbits-1][offset] = (bits>>8) & 0xff;
	    bm[1][nbits-1][offset] = bits & 0xff;
	    bits >>= 1;
#endif
	}
    }

    /* Initialize bit-count table. */
    for ( bits = 0; bits < 256; bits++ )
    {
	bitcnt8[bits] = bitcnt4[bits&0xf] + bitcnt4[(bits>>4)&0xf];
    }

    tablesInited = 1;
}




/*
 * Scale the input bitmap by a factor 1 <= f <= 8 to the output grayscale
 * pixmap.
 *
 * Inputs:
 *	ibm:	Input bitmap
 *	obm:	Pixmap to hold output.
 *	f:	Scaling factor
 *	w:	Pointer to width of ibm
 *	l:	Pointer to length (height) of ibm
 * Outputs:
 *	obm:	Holds output pixmap
 *	w:	Updated to width of obm
 *	l:	Updated to length of obm
 *
 * Use a Bresenham-like algorithm to step through the input:
 * 
 * In the horizontal direction, draw a line in (in,out) space from
 * (0,0) to (w, wf), where wf = round(w/f).  The trick is to step by
 * either floor(f) or ceil(f) along the the 'in' axis for each step on
 * the 'out' axis.
 * 
 * The error function is
 *	err = in * wf - out * w
 * The change in the error function from adding lowstep = floor(f) to in 
 * and 1 to out is therefore
 *	delta = lowstep * wf - w
 * The change from adding lowstep+1 = ceil(f) is
 *	delta1 = delta + wf;
 * The test is therefore
 *	Add delta to err.  
 *	If the result is greater than -wf/2, use lowstep
 *	If the result is less than or equal to -wf/2, use lowstep+1 and
 *		add wf to err
 *	We can make this more efficient by initializing err to wf/2, and
 *		testing against 0.
 */

void scalearb(unsigned char *ibm, unsigned char *obm, double f, unsigned long *wp, unsigned long *lp)
{
    unsigned int x, y;
    unsigned int ix, iy;
    unsigned char *ip0, *ip[8], i0[8], i1[8];
    unsigned char *op0, *op;
    int w = *wp;
    int l = *lp;
    int wf, lf;
    int deltax, errx, xstep, offset;
    int deltay, erry, ystep;
    unsigned rowwid = ((w + (BPB-1)) / BPB);
    unsigned int lowstep;
    int i;

    initTables();

    wf = (int)(w / f + 0.5);
    lf = (int)(l / f + 0.5);

    lowstep = (int)floor(f);

    deltax = lowstep * wf - w;
    deltay = lowstep * lf - l;

    erry = lf / 2;

    /* Pointer to first row. */
    ip0 = ibm;
    op0 = obm;

    for ( iy = 0, y = 0; y < lf; y++ )
    {
	erry += deltay;
	ystep = lowstep;
	if ( erry < 0 )
	{
	    erry += lf;
	    ystep++;
	}

	/* Increment input row and check for overflow. */
	iy += ystep;
	if ( iy > l )
	{
	    ystep += l - iy;
	}

	/* Initialize pointers to the next ystep rows. */
	for ( i = 0; i < ystep; i++ )
	{
	    ip[i] = ip0 + i*rowwid;
	    /* Grab first 2 bytes from each row. */
	    i0[i] = *(ip[i]);
	    ip[i]++;
	    i1[i] = *(ip[i]);
	}
	ip0 += ystep * rowwid;


	/* Output pointer */
	op = op0;
	op0 += wf;

	/* Initialize row error. */
	errx = wf / 2;
	for ( offset = 0, ix = 0, x = 0; x < wf; x++ )
	{
	    int cnt = 0;	/* For counting bits */
	    unsigned char bm0, bm1;
	    unsigned char *i0p, *i1p;
	    /* Figure out the step at this point */
	    errx += deltax;
	    xstep = lowstep;
	    if ( errx < 0 )
	    {
		errx += wf;
		xstep++;
	    }

	    /* Don't go past the end of the input. */
	    ix += xstep;
	    if ( ix > w )
	    {
		xstep += w - ix;
	    }

	    /* Iterate over the rows. */
	    bm0 = bm[0][xstep-1][offset];
	    bm1 = bm[1][xstep-1][offset];
	    i0p = &i0[0];
	    i1p = &i1[0];
	    for (i = 0; i < ystep; i++)
	    {
		/* bit extracts don't overlap because scale <= 8 */
		cnt += bitcnt8[(bm0&*i0p++) | (bm1&*i1p++)];
	    }

	    /* Normalize -- bias a little towards white. */
	    *op = (unsigned char)((cnt * 16) / (xstep * ystep));
	    if ( *op > 15 ) *op = 15;
	    op++;

	    /* Step */
	    offset += xstep;
	    if ( offset >= 8 )
	    {
		offset -= 8;
		/* Get next input byte from each row. */
		if ( ix <= w )
		{
		    for ( i = 0; i < ystep; i++ )
		    {
			i0[i] = i1[i];
			ip[i]++;
			i1[i] = *(ip[i]);
		    }
		}
		else
		{
		    for ( i = 0; i < ystep; i++ )
			i0[i] = i1[i] = 0;
		}
	    }
	}
    }

    *wp = wf;
    *lp = lf;
}

#ifdef TESTING

main(int argc, char **argv)
{
    FILE *bmp;
    double factor;
    int w, l;
    unsigned char *ibits, *opixels;
    char line[80], c;
    int i, j, n;

    if ( argc != 3 )
    {
	fprintf( stderr, "Usage: %s bitmap factor\n", argv[0] );
	exit(0);
    }

    factor = atof( argv[2] );
    if ( factor < 1 || factor > 8 )
    {
	fprintf( stderr, "%s: factor (%g) must be between 1 and 8\n",
		 argv[0], factor );
    }

    if ( bmp = fopen(argv[1], "r") )
    {
	fgets(line, 80, bmp);
	sscanf(line, "#define %*s %d", &w);
	fgets(line, 80, bmp);
	sscanf(line, "#define %*s %d", &l);
	fgets(line, 80, bmp);

	ibits = (unsigned char *)calloc( (w+7)/8, l );
	n = ((w+7)/8) * l;

	i = 0;
	while ( (c = getc(bmp)) != '}' && i < n)
	{
	    if ( c == 'x' )
	    {
		int b;
		line[0] = getc(bmp);
		line[1] = getc(bmp);
		line[2] = 0;
		sscanf(line, "%x", &b);
		*(ibits+i) = (unsigned char)b;
		i++;
	    }
	}    
	close(bmp);


	opixels = (unsigned char *)calloc( (int)(w / factor + 0.5),
					   (int)(l / factor + 0.5) );

	scalearb(ibits, opixels, factor, &w, &l);

	printf( "width = %d\nheight = %d\n", w, l );
	for ( j = 0; j < l; j++ )
	{
	    for ( i = 0; i < w; i++ )
	    {
		printf("%2d%c", (int)(opixels[i+j*w]),
		       i==(w-1) ? '\n' : ' ');
	    }
	}
    }
}
#endif
