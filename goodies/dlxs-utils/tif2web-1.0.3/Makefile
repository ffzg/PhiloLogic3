# local customization:

# (1) change the following as necessary to reflect the include and library
#     paths of
#
#     * libjpeg,
#     * libpng,
#     * libtiff, and
#     * zlib
#
# respectively, if not in /usr/include and /usr/lib
JPEGINCDIR = /usr/local/libjpeg/include
JPEGLIBDIR = /usr/local/libjpeg/lib

PNGINCDIR = /usr/local/libpng/include
PNGLIBDIR = /usr/local/libpng/lib

TIFINCDIR = /usr/local/tiff/include
TIFLIBDIR = /usr/local/tiff/lib

ZINCDIR   = /usr/local/zlib/include
ZLIBDIR   = /usr/local/zlib/lib

# (2) change the following as necessary to reflect the compilation environment,
#     either of
#
#     * LINUX
#     * SOLARIS
OS = SOLARIS

# (3) change the following as necessary to reflect the compiler used
CC = gcc


#
# NO CHANGES NEEDED BELOW THIS LINE
#


IDIRS	= -I$(JPEGINCDIR) -I$(PNGINCDIR) -I$(TIFINCDIR) -I$(ZINCDIR) -I/usr/include
LIBS	= -L$(JPEGLIBDIR) -L$(TIFLIBDIR) -L$(PNGLIBDIR) -L$(ZLIBDIR) -L/usr/lib -lpng -ltiff -ljpeg -lz -lm

OPT     = -O -static
CFLAGS  = $(OPT) $(IDIRS) -D$(OS)

TIF2WEB = t2w.o bttab.o xvgifwr.o scale.o scalearb.o writepng.o
TIF2WEB_SRC = t2w.c xvgifwr.c writepng.c scale.c xv.h scale.h scalearb.c scalearb.h mkbttab.c tif2web.1

TARGS   = tif2web mkbttab

all: $(TARGS)

tif2web: $(TIF2WEB)
	 $(CC) $(CFLAGS) -o tif2web $(TIF2WEB) $(LIBS)

scale.c:    scale.h
tiffrres.o: pres.h

bttab.o: mkbttab
	@ echo "mkbttab"
	@ trap "rm -f bttab.c" 0 1 2 3 10; \
	  ./mkbttab; \
	  $(CC) $(CFLAGS) -c bttab.c

clean:
	rm -f *.o *~ $(TARGS)
