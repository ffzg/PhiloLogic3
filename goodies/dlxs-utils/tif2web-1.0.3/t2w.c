/*
 *  t2w:  read a tiff, optionally scale it, write a gif or png.
 *
 */

#include <sys/types.h>
#include <sys/time.h>
#include <sys/param.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "tiffio.h"
#include "scale.h"
#include "scalearb.h"

#ifdef LINUX
#include <unistd.h>
#endif

#define	Count(a)	(sizeof (a) / sizeof ((a)[0]))

void FatalError ();
void buildcm(int nc, double gam, unsigned char cm[16], unsigned char mc[16]);



#define	BPB	8	/* 8 bits per byte */

#define	CM_NULL	0	/* null color map */
#define	NC_BW	2	/* 2 colors for b/w */
#define	NC_GS	16	/* 16 colors for grayscale */
#define	NC_GSA	16	/* 256 colors for grayscale-arb */
#define	CS_BW	2	/* b/w color style == 2 */
#define	CS_WB	3	/* w/b color style == 3 */
#define	CS_WB	3	/* w/b color style == 3 */
#define	CS_GS	1	/* grayscale color style == 2 */


/*  scaling/conversion types  */

typedef enum {
    Sc_2BW = 0,
    Sc_2GS,		/* illegal */
    Sc_3BW,
    Sc_3GS,
    Sc_4BW,
    Sc_4GS,
    Sc_5BW,			/* NIY */
    Sc_5GS,
    Sc_6BW,
    Sc_6GS,
    Sc_8BW,
    Sc_8GS,
    Sc_9BW,
    Sc_9GS,
    Sc_10BW,			/* NIY */
    Sc_10GS,
    Sc_12BW,
    Sc_12GS,
    Sc_AnyBW,			/* NIY */
    Sc_AnyGS,
    Sc_None,

    Sc_LAST,
} ScaleType;

typedef enum {
    Size_60,
    Size_75,
    Size_100,
    Size_specific,
    Size_variable,
} Size_e;

/* Type of target size conversion. */

typedef enum {
    Target_Best,
    Target_Max,
    Target_Exact,
} Target_e;

typedef enum {
    Dim_x,
    Dim_y,
} Dimension_e;


char * scale_name[Sc_LAST] =
{
  "2x-bw",
  "2x-gs",
  "3x-bw",
  "3x-gs",
  "4x-bw",
  "4x-gs",
  "5x-bw",
  "5x-gs",
  "6x-bw",
  "6x-gs",
  "8x-bw",
  "8x-gs",
  "9x-bw",
  "9x-gs",
  "10x-bw",
  "10x-gs",
  "12x-bw",
  "12x-gs",
  "Any-bw",
  "Any-gs",
  "-none-",
};



/*  colormaps  */

static unsigned char bw[2] = {0, 0xff};
static unsigned char wb[2] = {0xff, 0};
static unsigned char gsbw[16] = {
    0x00,
    0x00,
    0x24,
    0x24,
    0x48,
    0x48,
    0x6d,
    0x6d,
    0x91,
    0x91,
    0xb6,
    0xb6,
    0xda,
    0xda,
    0xff,
    0xff,
};

static unsigned char gswb[16] = {
    0xff,
    0xff,
    0xda,
    0xda,
    0xb6,
    0xb6,
    0x91,
    0x91,
    0x6d,
    0x6d,
    0x48,
    0x48,
    0x24,
    0x24,
    0x00,
    0x00,
};


ScaleType sctype = Sc_None;
int gray = 1;
int trans = 0;
int verbose = 0;

#define DEFAULT_BEST_FIT 800

int		best_target = DEFAULT_BEST_FIT;
Target_e	target_mode = Target_Best;
Dimension_e     target_dim = Dim_x;
double		exact_scale;

/*  administrative stuff  */ 
int DEBUG = 0;
int dotimings = 0;
#define	TIME(x)		if (dotimings) {fprintf x;}
#define	StartTime()	gettimeofday(&tstart,0)
#define	EndTime()	(gettimeofday(&tdone,0), \
			 (1000000 * (tdone.tv_sec - tstart.tv_sec)) + \
			 (tdone.tv_usec-tstart.tv_usec))

extern ScaleType findScale (Target_e, int, Size_e, double *);


main(argc,argv)
int argc;
char **argv;
{
	TIFF *tif;
	unsigned long imagelength, imagewidth;
	unsigned char *buf, *obuf, *auxbuf, *stripp;
	struct timeval tstart, tdone;
	unsigned stripSize;
	unsigned strip;
	unsigned numstrips;
	int flagGIF = 0;
       	int flagPNG = 0;

	char	* suffix;
	char	* path;
	char	* pgm;
	char	ofname[MAXPATHLEN];
	char	* ofile = NULL;
	FILE	* ofp;
	char	* xfile = NULL;
	TIFF	* xtif;
	unsigned short	photometric = 0;
	unsigned imagesize;
	int	invert = 0;

	int	nsecs;
	Size_e	size_spec = Size_specific;

	double	cmgamma = 1.2;	/* contrast enhancement factor of color map */
	int	cmsteps = 5;	/* Number of steps in color map */

	int	c;
	extern int optind;

	pgm = argv[0];
	
	/*
	 *  arg processing...
	 */
	while ((c = getopt (argc, argv, "ainlsS234568bvTtPGA:o:F:f:xyr:g:N:")) != EOF) {
		
	    switch (c) 
	    {

	    case 'a':
		/* "Any" -- use arbitrary scale factor, use with S/s/l. */
		target_mode = Target_Exact;
		break;

	    case 'A':
		/* "Any" -- specify a floating point scale factor. */
		size_spec = Size_specific;
		if (gray)
		    sctype = Sc_AnyGS;
		else
		    sctype = Sc_AnyBW;
		exact_scale = atof(optarg);
		break;

		/* "very Small" -- make us fit a narrow 75 dpi screen */
	    case 'S':
		size_spec = Size_60;
		break;

		/* "small" -- try to make us fit in a typical 75dpi screen */
	    case 's':
		size_spec = Size_75;
		break;
		/* "large" -- try to make us fit in a typical 100dpi screen */

	    case 'l':
		size_spec = Size_100;
		break;

	    case '2':
		size_spec = Size_specific;
		if (gray)
		    sctype = Sc_2GS;
		else
		    sctype = Sc_2BW;
		break;

	    case '3':
		size_spec = Size_specific;
		if (gray)
		    sctype = Sc_3GS;
		else
		    sctype = Sc_3BW;
		break;

	    case '4':
		size_spec = Size_specific;
		if (gray)
		    sctype = Sc_4GS;
		else
		    sctype = Sc_4BW;
		break;

	    case '5':
		size_spec = Size_specific;
		if (gray)
		    sctype = Sc_5GS;
		else
		    sctype = Sc_5BW;
		break;

	    case '6':
		size_spec = Size_specific;
		if (gray)
		    sctype = Sc_6GS;
		else
		    sctype = Sc_6BW;
		break;

	    case '8':
		size_spec = Size_specific;
		if (gray)
		    sctype = Sc_8GS;
		else
		    sctype = Sc_8BW;
		break;

	    case 'b':
		gray = 0;
		if (sctype == Sc_2GS || sctype == Sc_2BW)
		    sctype = Sc_2BW;
		else if (sctype == Sc_3GS || sctype == Sc_3BW)
		    sctype = Sc_3BW;
		else if (sctype == Sc_4GS || sctype == Sc_4BW)
		    sctype = Sc_4BW;
		else if (sctype == Sc_5GS || sctype == Sc_5BW)
		    sctype = Sc_5BW;
		else if (sctype == Sc_6GS || sctype == Sc_6BW)
		    sctype = Sc_6BW;
		else if (sctype == Sc_8GS || sctype == Sc_8BW)
		    sctype = Sc_8BW;
		else if (sctype == Sc_AnyGS || sctype == Sc_AnyBW)
		    sctype = Sc_AnyBW;
		else if (sctype != Sc_None)
		    goto usage;
		break;

	    case 'n':
		sctype = Sc_None;
		break;
	    
	    case 'i':
		invert = 1;
		break;

	    case 'v':
		verbose = 1;
		break;

	    case 't':
		dotimings = 1;
		break;

		/* transparent background */
	    case 'T':
		trans = 1;
		break;

	    case 'o':
		ofile = optarg;
		break;

	    case 'F':
		if ( target_mode != Target_Exact )
		    target_mode = Target_Max;
		size_spec = Size_variable;
		best_target = atoi(optarg);
		break;

	    case 'f':
		if ( target_mode != Target_Exact )
		    target_mode = Target_Best;
		size_spec = Size_variable;
		best_target = atoi(optarg);
		break;

	    case 'y':
		target_dim = Dim_y;
		break;

	    case 'x':
		target_dim = Dim_x;
		break;

	    case 'r':
		xfile = optarg;
		break;

	    case 'g':
		cmgamma = atof(optarg);
		break;

	    case 'N':
	      cmsteps = atoi(optarg);
	      break;
	    case 'G':
	      flagGIF = 1;  /* to represent tiff to GIF conversion */
	      break; 
	    case 'P': 
	      flagPNG = 1;  /* to represent tiff to PNG conversion */
	      break; 

	    case '?': 
	    usage: 
	      FatalError (
			  "usage:\t%s -[G|P] [-v] [-t] [-b|[-g gamma] -N numgrays] [-T] [-[alsS123468]|-A scale|[-[fF] size|-r ref.tif] -[xy]] [-o ofile] file ...\n"
			  "\n\tGeneral arguments:\n\n"
			  "\t\t-o outfile\toutput file name; if not specified, output\n"
			  "\t\t\t\tfiles are named by replacing input file suffix\n"
			  "\t\t\t\twith .gif or .png; if specified, only a single\n"
			  "\t\t\t\tfile will be processed\n"
			  "\t\t-v\t\tverbose mode\n"
			  "\t\t-t\t\tprint timing information\n"
			  "\n\tOutput format arguments (must specify one of the following):\n\n"
			  "\t\t-G\t\tproduce GIF output\n"
			  "\t\t-P\t\tproduce PNG output\n"
			  "\n\tColormap arguments:\n\n"
			  "\t\t-b\t\tmonochrome output\n"
			  "\t\t-g gamma\tgamma coefficient [1.2]\n"
			  "\t\t-N numgrays\tnumber of grays used for antialiasing [5]\n"
			  "\t\t-T\t\tproduce transparent background\n"
			  "\n\tScaling arguments:\n\n"
			  "\t\t-a\t\tarbitrary scaling (with -l, -s, -S) (slower)\n"
			  "\t\t-l\t\tlarge output (nominally 100dpi)\n"
			  "\t\t-s\t\tsmall output (nominally 75dpi)\n"
			  "\t\t-S\t\tvery small output (nominally 60dpi)\n"
			  "\t\t-1234568\treduce by factor (specify one of 1234568)\n"
			  "\t\t-A scale\tarbitrary scaling in range 1.0 - 16.0\n"
			  "\t\t-f size\t\tscale to approx width or height\n"
			  "\t\t-F size\t\tscale to max width or height\n"
			  "\t\t-r ref.tif\tscale to width or height of ref.tif\n"
			  "\t\t-x\t\treduce to target size (-f, -F, -r) using width\n"
			  "\t\t-y\t\treduce to target size (-f, -F, -r) using height\n"
			  "\n",
			  pgm); 
	    }
	}

	if ( flagGIF == 0 && flagPNG == 0 ) {
	  fprintf (stderr,
		   "You must specify the output format\n");
	  goto usage;
	}

	if (sctype == Sc_2GS)
	{  
	    /* not supported, for now */
	    fprintf (stderr,
		     "Sorry, the 2x Gray Scale option is not yet supported\n");
	    exit (1);

	}
 	if (sctype == Sc_5BW)
	{  
	    /* not supported, for now */
	    fprintf (stderr,
		     "Sorry, the 5x B&W Scale option is not yet supported\n");
	    exit (1);
	}
 	if (sctype == Sc_AnyBW)
	{  
	    /* not supported, for now */
	    fprintf (stderr,
		     "Sorry, arbitrary B&W Scale option is not yet supported\n");
	    exit (1);
	}

	if (optind >= argc || 
	    (ofile && (argc-optind != 1)))
		goto usage;

	/* Fill the color maps. */
	buildcm( cmsteps, cmgamma, gsbw, gswb );

	/*
	 *  read, scale, write  each input file
	 */
	while (optind < argc) 
	{
	  
	  path = argv[optind++];

	  if (ofile) {

	    /* output filename supplied */
	    strcpy (ofname, ofile);
	  } else {

	    /*
             * output filename not supplied; work off input filename
	     * with suffix, if any, removed
	     */
	    strncpy(ofname, path,
		    ( suffix = strrchr(path, '.') ) ? suffix - path : strlen(path));

	    /* append appropriate suffix */
	    if        ( flagGIF == 1 ) {
	      suffix = ".gif";
	    } else if ( flagPNG == 1 ) {
	      suffix = ".png";
	    }
	    strcat(ofname, suffix);
	  }

	  if ((ofp = fopen (ofname, "w")) == NULL)
	    FatalError ("couldn't open %s\n", ofname);

	  tif = TIFFOpen(path, "r");
	  if (tif == NULL)
	    FatalError ("couldn't open %s\n", argv[1]);

	  /*  image size, black on white/white on black... */ 
	  TIFFGetField(tif, TIFFTAG_IMAGELENGTH, &imagelength);
	  TIFFGetField(tif, TIFFTAG_IMAGEWIDTH, &imagewidth);
	  TIFFGetField(tif, TIFFTAG_PHOTOMETRIC, &photometric);

	  /*
	   * are we scaling based on screen width? 
	   */
	  if (size_spec != Size_specific)
	    {
		  
#ifdef useres	
		  
		    int xres;
		    /* adjust to our resolution */
		    TIFFGetField (tif, TIFFTAG_XRESOLUTION, &xres);
		    sctype = findScale (target_mode, xres, size_spec,
					&exact_scale);
		     printf("/n AFTER FINDSCALE sctype: %d\n", sctype);
#else
		   
		    if ( xfile && (xtif = TIFFOpen(xfile, "r")) != NULL)
		    {
			int basewidth;
			float baseres, xres;
			if ( target_dim == Dim_x )
			{
			    TIFFGetField (xtif, TIFFTAG_IMAGEWIDTH,
					  &basewidth);
			    TIFFGetField (xtif, TIFFTAG_XRESOLUTION,
					  &baseres);
			    TIFFGetField (tif, TIFFTAG_XRESOLUTION,
					  &xres);
			}
			else
			{
			    TIFFGetField (xtif, TIFFTAG_IMAGELENGTH,
					  &basewidth);
			    TIFFGetField (xtif, TIFFTAG_YRESOLUTION,
					  &baseres);
			    TIFFGetField (tif, TIFFTAG_YRESOLUTION,
					  &xres);
			}
			basewidth = basewidth * xres / baseres;
			TIFFClose(xtif);
			sctype = findScale (target_mode, basewidth, size_spec,
					    &exact_scale);

		      
		    }
		    else
			sctype = findScale (target_mode, imagewidth, size_spec,
					    &exact_scale);
		    	
#endif		    
		}
		
		/*
		 * read in the image in strips.  (one strip if possible)
		 */
		
		numstrips = TIFFNumberOfStrips (tif);
		buf = (unsigned char *)calloc(((imagewidth+BPB-1)/BPB),
					      imagelength);

		
		stripSize = TIFFStripSize (tif);
	
		StartTime();
		for (strip = 0, stripp=buf;
		     strip < numstrips;
		     strip++)
		  {
		    stripp += TIFFReadEncodedStrip(tif, strip, stripp, stripSize);
		    
		  }
		nsecs = EndTime();
		TIME ((stderr, "g4decode: took %d usecs\n", nsecs));

		/*
		 * scale the image using a fast x 3 algorithm
		 */
		if (verbose)
		{
		    if ( sctype != Sc_AnyBW && sctype != Sc_AnyGS )
			fprintf (stderr, "Scaling: %s [%dx%d] (%s)\n",
				 path,
				 imagewidth, imagelength,
				 scale_name[sctype]);
		    else
			fprintf (stderr, "Scaling: %s [%dx%d] (%s %g)\n",
				 path,
				 imagewidth, imagelength,
				 scale_name[sctype], exact_scale);
		}	
		
		switch (sctype) 
		{
		    case Sc_2BW:
			imagesize = ((((imagewidth+2)/2)/BPB)+1)*
			  ((imagelength+2)/2);
			obuf = (unsigned char *) malloc(imagesize);
						       
			StartTime();

			scale2bw (buf, obuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));
			break;

		    case Sc_3BW:
			imagesize = (((imagewidth+2)/3)/BPB+1)*
			  ((imagelength+2)/3);
			obuf = (unsigned char *)malloc(imagesize);
			StartTime();

			scale3bw (buf, obuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));
			break;

		    case Sc_3GS:
			imagesize = (((imagewidth+2)/3))*
			  ((imagelength+2)/3);
			obuf = (unsigned char *)malloc(imagesize);
			StartTime();

			scale3gs (buf, obuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			
			TIME ((stderr, "scale: took %d usecs\n", nsecs));
			break;

			
		    case Sc_4GS:
			imagesize = ((imagewidth+3)/4)*
			  ((imagelength+3)/4);
			obuf = (unsigned char *)malloc(imagesize);
			StartTime();

			scale4gs (buf, obuf, &imagewidth, &imagelength);
				
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));
			break;

		    case Sc_4BW:
			imagesize = (((imagewidth+3)/4)/BPB+1)*
			  ((imagelength+3)/4);
			obuf = (unsigned char *)malloc(imagesize);
			StartTime();

			scale4bw (buf, obuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));
			break;

		    case Sc_5GS:
			imagesize = ((imagewidth+4)/5+1)*
			  ((imagelength+4)/5+1);
			obuf = (unsigned char *)malloc(imagesize);
			StartTime();

			scale5gs (buf, obuf, &imagewidth, &imagelength);
				
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));
			break;

		    case Sc_5BW:
			/* not supported, for now */
			fprintf (stderr,
				 "Sorry, the 5x Black&White option is not yet supported\n");
			exit (1);
#if 0
			imagesize = (((imagewidth+4)/5)/BPB+1)*
			  ((imagelength+4)/5);
			obuf = (unsigned char *)malloc(imagesize);
			StartTime();

			scale5bw (buf, obuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));
#endif
			break;

		    case Sc_6BW:
		    case Sc_6GS:
			obuf = (unsigned char *) 
			    malloc(((((imagewidth+2)/2)/BPB)+1)*
  			      ((imagelength+2)/2));

			StartTime();

			scale2jbig (buf, obuf, &imagewidth, &imagelength);

			imagesize = ((imagewidth+2)/3)*
			  ((imagelength+2)/3);
			auxbuf = (unsigned char *)malloc(imagesize);

			if (sctype == Sc_6BW)
			    scale3bw (obuf, auxbuf, &imagewidth, &imagelength);
			else
			    scale3gs (obuf, auxbuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));

			free (obuf);
			obuf = auxbuf;
			break;

		    case Sc_8BW:
		    case Sc_8GS:
			obuf = (unsigned char *)
			  malloc(((((imagewidth+2)/2)/BPB)+1)*
						       ((imagelength+2)/2));

			StartTime();
			scale2jbig (buf, obuf, &imagewidth, &imagelength);

			imagesize = ((imagewidth+3)/4)*
			    ((imagelength+3)/4);
			auxbuf = (unsigned char *)malloc(imagesize);

			if (sctype == Sc_8BW)
			    scale4bw (obuf, auxbuf, &imagewidth, &imagelength);
			else
			    scale4gs (obuf, auxbuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));

			free (obuf);
			obuf = auxbuf;
			break;


		    case Sc_9BW:
		    case Sc_9GS:
			imagesize = (((imagewidth+2)/3))*
			  ((imagelength+2)/3);
			obuf = (unsigned char *) malloc(imagesize);

			StartTime();
			scale3bw (buf, obuf, &imagewidth, &imagelength);

			imagesize = ((imagewidth+2)/3)*
			    ((imagelength+2)/3);
			auxbuf = (unsigned char *)malloc(imagesize);

			if (sctype == Sc_9BW)
			    scale3bw (obuf, auxbuf, &imagewidth, &imagelength);
			else
			    scale3gs (obuf, auxbuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));

			free (obuf);
			obuf = auxbuf;
			break;

		    case Sc_10BW:
			/* not supported, for now */
			fprintf (stderr,
				 "Sorry, the 10x Black&White option is not yet supported\n");
			exit (1);
		    case Sc_10GS:
			obuf = (unsigned char *)
			  malloc(((((imagewidth+2)/2)/BPB)+1)*
						       ((imagelength+2)/2));

			StartTime();
			scale2jbig (buf, obuf, &imagewidth, &imagelength);

			imagesize = ((imagewidth+4)/5)*
			    ((imagelength+4)/5);
			auxbuf = (unsigned char *)malloc(imagesize);

#if 0
			if (sctype == Sc_10BW)
			    scale5bw (obuf, auxbuf, &imagewidth, &imagelength);
			else
#endif
			    scale5gs (obuf, auxbuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));

			free (obuf);
			obuf = auxbuf;
			break;


		    case Sc_12BW:
		    case Sc_12GS:
 			imagesize = (((imagewidth+2)/3))*
			  ((imagelength+2)/3);
			obuf = (unsigned char *) malloc(imagesize);

			StartTime();
			scale3bw (buf, obuf, &imagewidth, &imagelength);

			imagesize = ((imagewidth+3)/4)*
			    ((imagelength+3)/4);
			auxbuf = (unsigned char *)malloc(imagesize);

			if (sctype == Sc_12BW)
			    scale4bw (obuf, auxbuf, &imagewidth, &imagelength);
			else
			    scale4gs (obuf, auxbuf, &imagewidth, &imagelength);
			
			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));

			free (obuf);
			obuf = auxbuf;
			break;

		    case Sc_AnyGS:
		    {
			unsigned char *ibuf;
			int wf, lf;

			StartTime();
			/* If scale > 8, first divide by 2. */
			if ( exact_scale > 8.0 )
			{
			    ibuf = (unsigned char *)
				malloc(((((imagewidth+2)/2)/BPB)+1)*
				       ((imagelength+2)/2));
			    scale2jbig (buf, ibuf, &imagewidth, &imagelength);
			    exact_scale /= 2;
			}
			else
			    ibuf = buf;

			/* Compute width and height of output bitmap. */
			wf = (int)(imagewidth / exact_scale + 0.5);
			lf = (int)(imagelength / exact_scale + 0.5);
			
			/* Size of output bitmap. */
			imagesize = wf * lf;
			obuf = (unsigned char *)calloc(wf, lf);

			scalearb(ibuf, obuf, exact_scale,
				 &imagewidth, &imagelength);
			if ( ibuf != buf )
			    free(ibuf);

			nsecs = EndTime();
			TIME ((stderr, "scale: took %d usecs\n", nsecs));
			break;
		    }
		    case Sc_None:
		    default:
			imagesize = (imagewidth * imagelength) / 8;
			obuf = buf;
			break;
		}

		if (invert)
		{
		    register unsigned char * ptr = obuf;
		    register unsigned char * end = obuf + imagesize;
		    for (; ptr < end; )
			*ptr++ ^= 0xff;

		    photometric = !photometric;
		}

		StartTime();
		switch (sctype) 
		{
		case Sc_2GS:
		case Sc_3GS:
		case Sc_5GS:
		case Sc_6GS:
		case Sc_8GS:
		case Sc_9GS:
		case Sc_10GS:
		case Sc_12GS:
		case Sc_AnyGS:
		case Sc_4GS:
		  {
		    unsigned char * cm = (photometric == 0) ? gswb : gsbw;

		    if(flagPNG == 1)
		      {
			WritePNG(ofp, obuf, imagewidth, imagelength,
				 cm, cm, cm,
				 NC_GS, CS_GS, trans);
		      }
		    if(flagGIF == 1)
		      {
			WriteGIF(ofp, obuf, imagewidth, imagelength,
				 cm, cm, cm,
				 NC_GS, CS_GS, trans);
		      }
		  }
		  break;
			
		case Sc_2BW:
		case Sc_3BW:
		case Sc_4BW:
		case Sc_6BW:
		case Sc_8BW:
		case Sc_9BW:
		case Sc_12BW:
		case Sc_AnyBW:
		case Sc_None:
		default:
		  {
		    unsigned char * cm = (photometric == 0) ? wb : bw;

		    if(flagPNG == 1)
		      {
			WritePNG(ofp, obuf, imagewidth, imagelength,
				 cm, cm, cm,
				 NC_BW, CS_WB, trans);
		      }
		    if(flagGIF == 1)
		      {
			WriteGIF(ofp, obuf, imagewidth, imagelength,
				 cm, cm, cm,
				 NC_BW, CS_WB, trans);
		      }
		  }
		  break;
		}

		nsecs = EndTime ();
		TIME ((stderr, "write: took %d usecs\n", nsecs));


		if (optind < argc) 
		{
			if (buf != obuf)
				free (obuf);
			free (buf);
			TIFFClose(tif);
		}
	}
	exit(0);
}


int
scales [Sc_LAST] = 
{
    2,		/* 2 bw */
    0,		/* 2 gs - NIY */
    3,		/* 3 bw */
    3,		/* 3 gs */
    4,		/* 4 bw */	
    4,		/* 4 gs */
    0,		/* 5 bw - NIY */	
    5,		/* 5 gs */
    6,		/* 6 bw */
    6,		/* 6 gs */
    8,		/* 8 bw */
    8,		/* 8 gs */
    9,		/* 9 bw */
    9,		/* 9 gs */
    0,		/* 10 bw - NIY */
    10,		/* 10 gs */
    12,		/* 12 bw */
    12,		/* 12 gs */
    0,		/* Any bw - not used here */
    0,		/* Any gs - not used here */
    1,		/* none */
};



/*
 *  findScale: find the best scale to fit the proposed width bitmap
 */
ScaleType 
findScale (Target_e mode, int width, Size_e size, double *exact_scale)
{
    int target;
    int i;
    int best = -1;
    int best_diff = 0;

    ScaleType result;
 
    if (best_target < 0)
    {
	target = DEFAULT_BEST_FIT;
    }
    else
    {
	target = best_target;
    }
    if ( size == Size_75 )
	target = (target * 3) / 4;
    else if ( size == Size_60 )
	target = (target * 3) / 5;


    if ( mode == Target_Exact )
    {
      
	*exact_scale = (double)width / target;
	if ( *exact_scale < 1.0 )
	{
	    *exact_scale = 1.0;
	}
	else if ( *exact_scale > 16.0 )
	{
	    *exact_scale = 16.0;
	}
	
	return gray ? Sc_AnyGS : Sc_AnyBW;
    }
 
    for (i=0; i < Count(scales); i++)
    {
	int diff;
	if ( scales[i] == 0 )
	    continue;

	diff = target - (width/scales[i]);

	if ( mode == Target_Best )
	    diff = abs(diff);

	if ((best == -1 || diff < best_diff) && diff >= 0

	    /* b/w's are even; only b/w for 2's */
	    && !( (gray != (i & 1))
		 || (gray && scales[i] == 2)))
	{
	    best = i;
	    best_diff = diff; 
	}
	
	if (verbose)
	    fprintf(stderr, "Width: %5d Scale: %5d Diff %5d\n", width,
		    scales[i], diff);
	
    }
    /* In Target_Max mode, the target may be so small we don't find any.
     * Use maximum reduction in that case.
     */
    if ( best == -1 )
    {
	for (i=0; i < Count(scales); i++)
	{
	    if ( (best == -1 || scales[i] > best_diff)
	    && !( (gray != (i & 1))
		 || (gray && scales[i] == 2)))
	    {
		best = i;
		best_diff = scales[i];
	    }
	}
    }
    
    result = (ScaleType)best;

    return result;
}


/* Build the gray-scale color maps with a specified number of steps.
 * An "s-curve" is used to provide some contrast enhancement; the value
 * of gam is the slope of the curve in the middle.  The curve is represented
 * as a cubic, with coefficients a * x^3 + b * x^2 + c * x:
 *	a = 4 - 4*gam
 *	b = 6*gam - 6
 *	c = 3 - 2*gam
 * gam must be in the range 1 to 1.5 in order that the curve value not
 * be negative.
 * 
 * Evaluation of the curve proceeds at the points 
 *	0, 1/(nc-1), ..., (nc-2)/(nc-1), 1
 *
 * The 16-element colormap is filled as follows:
 * It is divided into nc intervals, centered about i*16/nc, so that the two
 * intervals at the ends are 1/2 the size of the others.
 *
 * The array cm is filled 0 - 1, mc is filled 1 - 0.
 */

void
buildcm(int nc, double gam, unsigned char cm[16], unsigned char mc[16])
{
    double a, b, c, t, s;
    int i, n;
 
    a = 4 - 4*gam;
    b = 6*gam - 6;
    c = 3 - 2*gam;

    cm[0] = 0;
    cm[15] = 255;

    for ( i = 0; i < 15; i++ )
    {
	/* Figure out which "slot" to use. */
	n = (1 + (i * 2 * (nc - 1)) / 15) / 2;
	t = (double)n / (nc - 1);
	s = (((a * t) + b) * t + c) * t;
	if ( s < 0 ) s = 0;
	if ( s > 1 ) s = 1;
	cm[i] = (int)(s * 255);
	mc[15-i] = cm[i];
    }
}

void
FatalError (fmt, a, b, c, d, e)
char * fmt;
{
	fprintf (stderr, fmt, a, b, c, d, e);
	exit (1);
}
