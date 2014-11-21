
extern unsigned char scale3tab[];

#ifndef	__sgi
#if	defined(__alpha) || defined(vax) || defined(mips) || defined(__MSDOS__)
#define	LITTLE_ENDIAN
#endif	/* __alpha || vax || mips || __MSDOS__ */
#endif	/* __sgi */


#ifdef	LITTLE_ENDIAN

/*  or-word... or the next 32 bits into the argument word  */
#define	OW(p,v) \
	switch((unsigned long)(p) & 3) { \
	case	0: \
		v |= *(unsigned long *)(p); \
		break; \
	case	1: \
		v |= *(unsigned long *)((char *)(p) - 1) >> 8;\
		v |= *(unsigned long *)((char *)(p) + 3) << 24; \
		break; \
	case	2: \
		v |= *(unsigned long *)((char *)(p) - 2) >> 16; \
		v |= *(unsigned long *)((char *)(p) + 2) << 16; \
		break; \
	case	3: \
		v |= *(unsigned long *)((char *)(p) - 3) >> 24; \
		v |= *(unsigned long *)((char *)(p) + 1) << 8; \
		break; \
	}

#else
#define	OW(p,v) \
	switch((unsigned long)(p) & 3) { \
	case	0: \
		v |= *(unsigned long *)(p); \
		break; \
	case	1: \
		v |= *(unsigned long *)((char *)(p) - 1) << 8; \
		v |= *(unsigned long *)((char *)(p) + 3) >> 24; \
		break; \
	case	2: \
		v |= *(unsigned long *)((char *)(p) - 2) << 16; \
		v |= *(unsigned long *)((char *)(p) + 2) >> 16; \
		break; \
	case	3: \
		v |= *(unsigned long *)((char *)(p) - 3) << 24; \
		v |= *(unsigned long *)((char *)(p) + 1) >> 8; \
		break; \
	}

#endif	/* LITTLE_ENDIAN */


#ifdef	LITTLE_ENDIAN

/*  fetch-word... fetch the next 32 bits and inc the pointer based on "inc"  */

#define	FETCHW(p,v,inc) \
	switch((unsigned long)(p) & 3) { \
	case	0: \
		v = *(unsigned long *)(p); \
		p += inc; \
		break; \
	case	1: \
		v = *(unsigned long *)((char *)(p) - 1) >> 8;\
		v |= *(unsigned long *)((char *)(p) + 3) << 24; \
		p += inc; \
		break; \
	case	2: \
		v = *(unsigned long *)((char *)(p) - 2) >> 16; \
		v |= *(unsigned long *)((char *)(p) + 2) << 16; \
		p += inc; \
		break; \
	case	3: \
		v = *(unsigned long *)((char *)(p) - 3) >> 24; \
		v |= *(unsigned long *)((char *)(p) + 1) << 8; \
		p += inc; \
		break; \
	};

#else
#define	FETCHW(p,v,inc) \
	switch((unsigned long)(p) & 3) { \
	case	0: \
		v = *(unsigned long *)(p); \
		p += inc; \
		break; \
	case	1: \
		v = *(unsigned long *)((char *)(p) - 1) << 8; \
		v |= *(unsigned long *)((char *)(p) + 3) >> 24; \
		p += inc; \
		break; \
	case	2: \
		v = *(unsigned long *)((char *)(p) - 2) << 16; \
		v |= *(unsigned long *)((char *)(p) + 2) >> 16; \
		p += inc; \
		break; \
	case	3: \
		v = *(unsigned long *)((char *)(p) - 3) << 24; \
		v |= *(unsigned long *)((char *)(p) + 1) >> 8; \
		p += inc; \
		break; \
	}

#endif	/* LITTLE_ENDIAN */

#define FETCH5(p,v1,v2) FETCHW(p,v1,sizeof(unsigned long)) \
			FETCHW(p,v2,1)
#define	FETCH4(p,v)	FETCHW(p,v,sizeof(unsigned long))
#define	FETCH3(p,v)	FETCHW(p,v,sizeof(unsigned long)-1)


#ifdef	LITTLE_ENDIAN
/* position of 4-bit quantity */
#define	POS4(w,p)	((p) & 4) ? (((w) >> ((p) - 4)) & 0xf) \
	: (((w) >> ((p) + 4)) & 0xf)
#else
#define	POS4(w,p)	(((w) >> (28-(p))) & 0xf)
#endif
#define	POS2(w,p)	(((p) & 2) ? POS4(w,(p)>>1) >> 2 : POS4(w,p) & 0x3)

