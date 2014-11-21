/*
 *  scale:  translate (using various techniques) from an input
 *  buffer at one resolution to an output buffer at a different
 *  resolution.
 */
#include <stdio.h>
#include <stdlib.h>
#include "scale.h"
#include "scaleP.h"
#include "pres.h"

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


int	by2[16] = {
    0x00,			/* 0000 */
    0x01,			/* 0001 */
    0x01,			/* 0010 */
    0x01,			/* 0011 */
    0x02,			/* 0100 */
    0x03,			/* 0101 */
    0x03,			/* 0110 */
    0x03,			/* 0111 */
    0x02,			/* 1000 */
    0x03,			/* 1001 */
    0x03,			/* 1010 */
    0x03,			/* 1011 */
    0x03,			/* 1100 */
    0x03,			/* 1101 */
    0x03,			/* 1110 */
    0x03,			/* 1111 */
};

void 
scale2bw (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l)
{
	register unsigned long x1, x2;
	register unsigned char * i0, * i1, * end, * i0end;
	unsigned rowwid;
	unsigned rrowwid;
	unsigned y;

	/*
	 *  process rows 2 at a time.  grab bits 32 at a time.
	 *  or together 2x2 squares of bits and if any are on,
	 *  compress them down to a single point in the output.
	 */
	rowwid = ((*w + 7) / BPB);
	rrowwid = (rowwid/sizeof(long)) * sizeof(long);    /* new row width trunc'd to words */

	i0 = ibm;
	i1 = i0 + rowwid;
	i0end = i0 + rrowwid;
	end = i0 + (rowwid * *l);

	*w = (i0end - i0) * (BPB/2);
	*l /= 2;
	y = 0;

	while (i0 < end) {

		/* or together two clumps of 32 bits; output 16 bits */
		FETCH4 (i0, x1);
		FETCH4 (i1, x2);

		x1 |= x2;

		if (x1) {
		    int pos;
		    unsigned b = 0;

		    for (pos=0; pos<sizeof(long)*BPB; pos += 4) {
			unsigned p = POS4(x1,pos);

			if (p)
			    b |= by2[p] << (14 - (pos >> 1));
		    }

		    *obm++ = b >> 8;
		    *obm++ = b & 0xff;
		} else {
		    /* two bytes of zero */
		    *obm++ = 0;
		    *obm++ = 0;
		}
			
		if (i0 >= i0end) {
			y += 2;
			i0 = ibm + (y * rowwid);
			i0end = i0 + rrowwid;
			i1 = i0 + rowwid;
		}
	}
		
}

void
scale2jbig(unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l)
{
    int bpr = howmany(*w,BPB);
    unsigned int sy, sx, rh = *l;
    const unsigned char *phm2p, *phm1p, *php0p;
    unsigned char *plm1p, *plp0p;
    register int state;
    register unsigned char phm2, phm1, php0, plm1, plp0;

    /* Return new image size. */
    *w = ((bpr+1)/2) * BPB;
    *l /= 2;

    /* Set up row pointers.  First row of thumbnail array is for boundary. */
    plm1p = obm;
    memset(obm, bpr/2, 0);
    plp0p = obm;

    /* Duplicate first row for boundary condition. */
    phm2p = ibm;
    phm1p = ibm;
    php0p = ibm + bpr;

    /* Loop over input image 2 at a time. */
    for ( sy = 1; sy <= rh; sy += 2 ) {
	/* Start of row, assume pixels to the "left" are zero. */
	phm2 = phm1 = php0 = plm1 = plp0 = 0;
	state = 0;

	/* Boundary condition on last row, for odd number of rows. */
	if ( sy == rh )
	    php0p = phm1p;

	/*
	 * Loop over input pixels 2 bytes (16 pixels) at a time,
	 * forming output 1 byte (8 pixels) at a time.
	 */
	for ( sx = 0; sx < bpr; sx += 2 ) {
	    /**** Output bit 0 ****/

	    /*
	     * First "slide in" values from the previous byte:
	     * Bits 8,5,2 from 6,3,0; Bit 11 from 10; Bit 9 from
	     * previous output value.
	     */
	    state = ((state<<2)&0x124) + ((state<<1)&0x800) +
		((plp0<<9)&0x200);

	    /* Now get the current byte values. */
	    phm2 = *phm2p++;
	    phm1 = *phm1p++;
	    php0 = *php0p++;
	    plm1 = *plm1p++;
	    plp0 = 0;

	    /* And slot in bits 10, 7,6, 4,3, 1,0. */
	    state = state + ((plm1<<3)&0x400) +
		(phm2&0xc0) + ((phm1>>3)&0x18) + ((php0>>6)&0x3);
	    plp0 += pres[state] << 7;


	    /**** Output bit 1 ****/
	    /* Slide values from previous bit.
	     * Note: bit 7 of plp0 is previous output bit.
	     */
	    state = ((state<<2)&0x124) + ((state<<1)&0x800) +
		((plp0<<2)&0x200);
	    /* And new values. */
	    state = state + ((plm1<<4)&0x400) +
		((phm2<<2)&0xc0) + ((phm1>>1)&0x18) + ((php0>>4)&0x3);
	    plp0 += pres[state] << 6;


	    /**** Output bit 2 ****/
	    state = ((state<<2)&0x124) + ((state<<1)&0x800) +
		((plp0<<3)&0x200);
	    state = state + ((plm1<<5)&0x400) +
		((phm2<<4)&0xc0) + ((phm1<<1)&0x18) + ((php0>>2)&0x3);
	    plp0 += pres[state] << 5;


	    /**** Output bit 3 ****/
	    state = ((state<<2)&0x124) + ((state<<1)&0x800) +
		((plp0<<4)&0x200);
	    state = state + ((plm1<<6)&0x400) +
		((phm2<<6)&0xc0) + ((phm1<<3)&0x18) + ((php0)&0x3);
	    plp0 += pres[state] << 4;

	    /* Get new high-res pixels. */
	    if ( sx + 1 != bpr ) {
		phm2 = *phm2p++;
		phm1 = *phm1p++;
		php0 = *php0p++;
	    } else {
		phm2 = phm1 = php0 = 0;
	    }

	    /**** Output bit 4 ****/
	    state = ((state<<2)&0x124) + ((state<<1)&0x800) +
		((plp0<<5)&0x200);
	    state = state + ((plm1<<7)&0x400) +
		(phm2&0xc0) + ((phm1>>3)&0x18) + ((php0>>6)&0x3);
	    plp0 += pres[state] << 3;


	    /**** Output bit 5 ****/
	    state = ((state<<2)&0x124) + ((state<<1)&0x800) +
		((plp0<<6)&0x200);
	    state = state + ((plm1<<8)&0x400) +
		((phm2<<2)&0xc0) + ((phm1>>1)&0x18) + ((php0>>4)&0x3);
	    plp0 += pres[state] << 2;


	    /**** Output bit 6 ****/
	    state = ((state<<2)&0x124) + ((state<<1)&0x800) +
		((plp0<<7)&0x200);
	    state = state + ((plm1<<9)&0x400) +
		((phm2<<4)&0xc0) + ((phm1<<1)&0x18) + ((php0>>2)&0x3);
	    plp0 += pres[state] << 1;


	    /**** Output bit 7 ****/
	    state = ((state<<2)&0x124) + ((state<<1)&0x800) +
		((plp0<<8)&0x200);
	    state = state + ((plm1<<10)&0x400) +
		((phm2<<6)&0xc0) + ((phm1<<3)&0x18) + ((php0)&0x3);
	    plp0 += pres[state];

	    /* Output the next byte */
	    *plp0p++ = plp0;
	}

	/* Boundary condition */
	if ( sy == 1 )
	  plm1p = obm;

	/* Bump the high resolution pointers an extra row. */
	phm2p = phm1p;
	phm1p = php0p;
	php0p += bpr;
    }

}


void 
scale3bw (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l)
{
	register unsigned long x;
	register unsigned char * i0, * i1, * i2, * end, * i0end;
	unsigned rowwid = ((*w + 7) / BPB);
	unsigned y;

	/*
	 *  process rows 3 at a time.  grab bits 24 at a time.
	 *  or together 3x3 squares of bits and if any are on,
	 *  compress them down to a single point in the output.
	 */
	i0 = ibm;
	i1 = i0 + rowwid;
	i2 = i1 + rowwid;
	i0end = i1 - 2;
	end = i0 + (rowwid * *l);

	*w = (rowwid / 3) * BPB;
	*l /= 3;
	y = 0;

	while (i0 < end) {

		x = 0;

		/* or together three clumps of 24 bits */
		OW (i0, x);
		OW (i1, x);
		OW (i2, x);

#ifdef	LITTLE_ENDIAN
		x &= 0xffffff;	/* valuable bits are low */
#else
		x >>= 8;        /* valuable bits are high */
		x &= 0xffffff;
#endif
		if (x) {
#ifdef	LITTLE_ENDIAN
			unsigned hw, lw;
			/*  ab cd ef gh  ->  gh ef cd ab
			    we want... def  =  x >> 16 & 0xff | x & 0xf00
			               abc  =  x << 4 & 0xff0 | x >> 12 & 0xf
			    eeeeyuck.
                         */
				       
			hw = ((x & 0xff) << 4) |
				((x >> 12) & 0xf);
			lw = ((x >> 16) & 0xff) |
				(x & 0xf00);
			*obm++ = (scale3tab[hw] << 4) |
				scale3tab[lw];
#else
			*obm++ = (scale3tab[x >> 12] << 4) |
				scale3tab[x & 0xfff];
#endif
		} else
			*obm++ = 0;

		i0 += 3;
		i1 += 3;
		i2 += 3;

		if (i0 >= i0end) {
			y += 3;
			i0 = ibm + (y * rowwid);
			i1 = i0 + rowwid;
			i2 = i1 + rowwid;
			i0end = i1 - 2;
		}
	}
		
}


/*
 * scale4bw: reduce by a factor of four and convert to
 * a mono bitmap
 */

void
scale4bw (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l)
{
	register unsigned long x;
	register unsigned char * i0, * i1, * i2, * i3;
	register unsigned char * end, * i0end;
	unsigned rowwid;
	unsigned rrowwid;
	unsigned y;
	unsigned char * bm = obm;

	/*
	 *  process rows 4 at a time.  grab bits 4 at a time.
	 *  from 4 rows, making 4x4 squares of bits; extract
	 *  one bit based whether any of the constituant
	 *  bits were turned on...
	 *
	 */

	rowwid = ((*w + 7) / 8);     /* row width in bytes */
	rrowwid = (rowwid/4) * 4;    /* new row width in bytes */

	i0 = ibm;
	i0end = i0 + rrowwid;
	i1 = i0 + rowwid;
	i2 = i1 + rowwid;
	i3 = i2 + rowwid;
	end = i0 + (rowwid * *l);

	*w = (i0end - i0) * (BPB/4);
	*l /= 4;
	y = 0;

	Assert(sizeof(long)*BPB == 32);

	while (i0 < end) {
		unsigned long w0, w1, w2, w3;
		int nb;
		int pos;
		unsigned char b;

		FETCH4(i0,w0);
		FETCH4(i1,w1);
		FETCH4(i2,w2);
		FETCH4(i3,w3);

		b = 0;

		for (pos=0; pos<sizeof(long)*BPB; pos += 4) {
		    x = POS4(w0,pos);
		    x |= POS4(w1,pos);
		    x |= POS4(w2,pos);
		    x |= POS4(w3,pos);

		    if (x)
			b |= 1<<(7-(pos>>2));
		}

		/* each 4x4 square => 1 bit */
		*obm++ = b;
		
		if (i0 >= i0end) {
			y += 4;
			i0 = ibm + (y * rowwid);
			i0end = i0 + rrowwid;
			i1 = i0 + rowwid;
			i2 = i1 + rowwid;
			i3 = i2 + rowwid;
		}
	}
}




/*
 *  gray scale scaling...
 */

static int bitcnt[16] = {
	0, 1, 1, 2, 1, 2, 2, 3,
	1, 2, 2, 3, 2, 3, 3, 4
};

/* LITTLE: gh ef cd ab
   BIG:    ab cd ef gh

   mask off groups of 3 bits
   fetched as (little or big endian) longs
*/
           
static unsigned long bm3[8] = {
#ifdef	LITTLE_ENDIAN	
	0x000000e0,
	0x0000001c,
	0x00008003,
	0x00007000,
	0x00000e00,
	0x00c00100,
	0x00380000,
	0x00070000,
#else
	0xe0000000,
	0x1c000000,
	0x03800000,
	0x00700000,
	0x000e0000,
	0x0001c000,
	0x00003800,
	0x00000700,
#endif
};

/*
 *  bi3:  index quickly to starting bits of groups
 *  of 3 bits fetched from memory as longs
 *  (screwy for little endian since bits become
 *  discontiguous)
 */

#ifdef	LITTLE_ENDIAN
int bi3[8][2] = {
	/* a   b	a = start of 1 bit run, b=start of 2 bits */
	   5,  6,
	   2,  3,
	   15, 0, 
	   12, 13,
	   9,  10,
	   8,  22,
	   19, 20,
	   16, 17,
};
#endif
/*
 * scale3gs: reduce by a factor of three and convert to
 * an appropriate gray scale mapping...
 */

void 
scale3gs (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l)
{
	register unsigned long x;
	register unsigned char * i0, * i1, * i2, * end, * i0end;
	unsigned rowwid = ((*w + 7) / 8);
	unsigned rrowwid = (rowwid / 3) * 3;
	unsigned y;

	/*
	 *  process rows 3 at a time.  grab bits 24 at a time.
	 *  or together 3x3 squares of bits and if any are on,
	 *  compress them down to a single point in the output.
	 */
	i0 = ibm;
	i1 = i0 + rowwid;
	i2 = i1 + rowwid;
	i0end = i0 + rrowwid;
	end = i0 + (rowwid * *l);

	*w = ((i0end - i0) * BPB)/3;
	*w &= ~7;			/* byte boundary */
	*l /= 3;
	y = 0;

	while (i0 < end) {
		unsigned long w0, w1, w2;
		int i;

		/* pull out three patches of 24 bits */
		FETCH3 (i0, w0);
		FETCH3 (i1, w1); 
		FETCH3 (i2, w2);

		
		for (i=0; i<8; i++) {
			int nb;
			unsigned long w;
			unsigned long m = bm3[i];
#ifdef	LITTLE_ENDIAN
			int b1 = bi3[i][0];
			int b2 = bi3[i][1];

			/* count up the bits in this word...
			   little endian fetches produce bizarre
			   bit ordering, so it's hard to guess where
			   bits will be */
			w = w0 & m;
			nb = ((w >> b1) & 0x1) +
				bitcnt [(w >> b2) & 0x3];
			w = w1 & m;
			nb += ((w >> b1) & 0x1) +
				bitcnt [(w >> b2) & 0x3];
			w = w2 & m;
			nb += ((w >> b1) & 0x1) +
				bitcnt [(w >> b2) & 0x3];
#else
			nb = bitcnt [ (w0 >> (29-(i*3))) & 0x7 ];
			nb += bitcnt [ (w1 >> (29-(i*3))) & 0x7 ];
			nb += bitcnt [ (w2 >> (29-(i*3))) & 0x7 ];
#endif

			/*  scale up to a 16 color gray scale  */

			*obm++ = (nb*7) >> 2;
		}

		if (i0 >= i0end) {
			y += 3;
			i0 = ibm + (y * rowwid);
			i0end = i0 + rrowwid;
			i1 = i0 + rowwid;
			i2 = i1 + rowwid;
		}
	}
		
}


/*
 * scale4gs: reduce by a factor of four and convert to
 * an appropriate gray scale mapping...
 */

void
scale4gs (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l)
{
	register unsigned long x;
	register unsigned char * i0, * i1, * i2, * i3;
	register unsigned char * end, * i0end;
	unsigned rowwid = ((*w + (BPB-1)) / BPB);
	unsigned rrowwid = (rowwid / 4) * 4;
	unsigned y;

	/*
	 *  process rows 4 at a time.  grab bits 4 at a time.
	 *  from 4 rows, making 4x4 squares of bits; extract
	 *  a 4 bit gray scale based on the number of bits
	 *  turned on...
	 *
	 */

	i0 = ibm;
	i0end = i0 + rrowwid;
	i1 = i0 + rowwid;
	i2 = i1 + rowwid;
	i3 = i2 + rowwid;
	end = i0 + (rowwid * *l);

	*w = (i0end - i0) * (BPB/4);
	*w &= ~7;
	*l /= 4;
	y = 0;

	Assert(sizeof(long)*BPB == 32);

	while (i0 < end) {
		unsigned long w0, w1, w2, w3;
		int nb;
		int pos;

		FETCH4(i0,w0);
		FETCH4(i1,w1);
		FETCH4(i2,w2);
		FETCH4(i3,w3);

		for (pos=0; pos<sizeof(long)*BPB; pos += 4) {
			/* make a 16 bit (0-15) index out of 4 4bit quantities */
			nb = bitcnt[POS4(w0,pos)];
			nb += bitcnt[POS4(w1,pos)];
			nb += bitcnt[POS4(w2,pos)];
			nb += bitcnt[POS4(w3,pos)];

			/* each 4x4 square => 8 bits */
			*obm++ = Min(0xf,nb);
		}

		if (i0 >= i0end) {
			y += 4;
			i0 = ibm + (y * rowwid);
			i0end = i0 + rrowwid;
			i1 = i0 + rowwid;
			i2 = i1 + rowwid;
			i3 = i2 + rowwid;
		}
	}
}


/* LITTLE: gh ef cd ab / xx xx xx ij
   BIG:    ab cd ef gh / ij xx xx xx

   mask off groups of 5 bits
   fetched as (little or big endian) longs
*/
           
static unsigned long bm5[8][2] = {
#ifdef	LITTLE_ENDIAN	
                    /*    g    h    e    f    c    d    a    b    i    j */
  0x000000f8, 0x00, /* 0000 0000 0000 0000 0000 0000 1111 1000 0000 0000 */
  0x0000c007, 0x00, /* 0000 0000 0000 0000 1100 0000 0000 0111 0000 0000 */ 
  0x00003e00, 0x00, /* 0000 0000 0000 0000 0011 1110 0000 0000 0000 0000 */
  0x00f00100, 0x00, /* 0000 0000 1111 0000 0000 0001 0000 0000 0000 0000 */
  0x800f0000, 0x00, /* 1000 0000 0000 1111 0000 0000 0000 0000 0000 0000 */
  0x7c000000, 0x00, /* 0111 1100 0000 0000 0000 0000 0000 0000 0000 0000 */
  0x03000000, 0xe0, /* 0000 0011 0000 0000 0000 0000 0000 0000 1110 0000 */
  0x00000000, 0x1f, /* 0000 0000 0000 0000 0000 0000 0000 0000 0001 1111 */
#else
                    /*    a    b    c    d    e    f    g    h    i    j */
  0xf8000000, 0x00, /* 1111 1000 0000 0000 0000 0000 0000 0000 0000 0000 */
  0x07c00000, 0x00, /* 0000 0111 1100 0000 0000 0000 0000 0000 0000 0000 */ 
  0x003e0000, 0x00, /* 0000 0000 0011 1110 0000 0000 0000 0000 0000 0000 */
  0x0001f000, 0x00, /* 0000 0000 0000 0001 1111 0000 0000 0000 0000 0000 */
  0x00000f80, 0x00, /* 0000 0000 0000 0000 0000 1111 1000 0000 0000 0000 */
  0x0000007c, 0x00, /* 0000 0000 0000 0000 0000 0000 0111 1100 0000 0000 */
  0x00000003, 0xe0000000, 
		    /* 0000 0000 0000 0000 0000 0000 0000 0011 1110 0000 */
  0x00000000, 0x1f000000, 
		    /* 0000 0000 0000 0000 0000 0000 0000 0000 0001 1111 */
#endif
};

/*
 *  bi5:  index quickly to starting bits of groups
 *  of 5 bits fetched from memory as longs
 *  (screwy for little endian since bits become
 *  discontiguous).  
 * Note that since bit groups in the two longs never overlap, these
 * indices are mod4.  To get the actual 5-bit quantity, you need to shift
 * nybble 1 left by 1 + (i mod 4), and nybble 2 right by 4 - shift1
 */

#ifdef	LITTLE_ENDIAN
int bi5[8][2] = {
	/* a   b	a = start of nybble 1, b= start of nybble 2 */
	   4,   0,		/* shift1 = 1L, shift2 = 3R */
	   0,  12,		/* shift1 = 2L, shift2 = 2R */
	   12,  8,		/* shift1 = 3L, shift2 = 1R */
	   8,  20,		/* shift1 = 4L, shift2 = 0R */
	   16, 28,		/* shift1 = 1L, shift2 = 3R */
	   28, 24,		/* shift1 = 2L, shift2 = 2R */
	   24,  4,		/* shift1 = 3L, shift2 = 1R */
	    4,  0,		/* shift1 = 4L, shift2 = 0R */
};
#else
int bi5[8][2] = {
	/* a   b	a = start of nybble 1, b= start of nybble 2 */
	   28, 24,		/* shift1 = 1L, shift2 = 3R */
	   24, 20,		/* shift1 = 2L, shift2 = 2R */
	   20, 16,		/* shift1 = 3L, shift2 = 1R */
	   16, 12,		/* shift1 = 4L, shift2 = 0R */
	    8,  4,		/* shift1 = 1L, shift2 = 3R */
	    4,  0,		/* shift1 = 2L, shift2 = 2R */
	    0, 28,		/* shift1 = 3L, shift2 = 1R */
	   28, 24,		/* shift1 = 4L, shift2 = 0R */
};
#endif
/*
 * scale5gs: reduce by a factor of five and convert to
 * an appropriate gray scale mapping...
 */

void 
scale5gs (unsigned char *ibm, unsigned char *obm, long unsigned int *w, long unsigned int *l)
{
	register unsigned long x;
	register unsigned char * i0, * i1, * i2, * i3, * i4, * end, * i0end;
	unsigned rowwid = ((*w + 7) / 8);
	unsigned rrowwid = (rowwid / 5) * 5;
	unsigned y;

	/*
	 *  process rows 5 at a time.  grab bits 40 at a time.
	 *  or together 5x5 squares of bits and if any are on,
	 *  compress them down to a single point in the output.
	 */
	i0 = ibm;
	i1 = i0 + rowwid;
	i2 = i1 + rowwid;
	i3 = i2 + rowwid;
	i4 = i3 + rowwid;
	i0end = i0 + rrowwid;
	end = i0 + (rowwid * *l);
	*w = ((i0end - i0) * BPB)/5;
	*w &= ~7;			/* byte boundary */
	*l /= 5;
	y = 0;

	while (i0 < end) {
		unsigned long w00, w10, w20, w30, w40;
		unsigned long w01, w11, w21, w31, w41;
		int i;

		/* pull out 5 patches of 40 bits */
		FETCH5 (i0, w00,w01);
		FETCH5 (i1, w10,w11); 
		FETCH5 (i2, w20,w21);
		FETCH5 (i3, w30,w31);
		FETCH5 (i4, w40,w41);

		
		for (i=0; i<8; i++) {
			int nb;
			unsigned long w;
			unsigned long m0 = bm5[i][0];
			unsigned long m1 = bm5[i][1];

			int b1 = bi5[i][0];
			int b2 = bi5[i][1];

			/* count up the bits in this word...
			   little endian fetches produce bizarre
			   bit ordering, so it's hard to guess where
			   bits will be */
			w = (w00 & m0) | (w01 & m1);
			nb = bitcnt[((w >> b1) & 0xf)] +
				bitcnt [(w >> b2) & 0xf];
			w = (w10 & m0) | (w11 & m1);
			nb += bitcnt[((w >> b1) & 0xf)] +
				bitcnt [(w >> b2) & 0xf];
			w = (w20 & m0) | (w21 & m1);
			nb += bitcnt[((w >> b1) & 0xf)] +
				bitcnt [(w >> b2) & 0xf];
			w = (w30 & m0) | (w31 & m1);
			nb += bitcnt[((w >> b1) & 0xf)] +
				bitcnt [(w >> b2) & 0xf];
			w = (w40 & m0) | (w41 & m1);
			nb += bitcnt[((w >> b1) & 0xf)] +
				bitcnt [(w >> b2) & 0xf];

			/* Multiply by 5 (0 -- 125) and divide by 8 to get
			 * 0 -- 15 range
			 */
			*obm++ = (nb*5) >> 3;
		}

		if (i0 >= i0end) {
			y += 5;
			i0 = ibm + (y * rowwid);
			i0end = i0 + rrowwid;
			i1 = i0 + rowwid;
			i2 = i1 + rowwid;
			i3 = i2 + rowwid;
			i4 = i3 + rowwid;
		}
	}
		
}

