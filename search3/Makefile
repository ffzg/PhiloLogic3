# $Id: Makefile.in,v 2.11 2004/05/28 19:22:06 o Exp $
LDFLAGS= -L/sw/lib/
CFLAGS= -O3
CPPFLAGS= -I/sw/include/
LDFLAGS= -L/sw/lib/
PH_CFLAGS= -I./unpack -D_REENTRANT -fomit-frame-pointer -funroll-all-loops -finline-functions
CC= gcc
PH_BUILDENV = MACOSX_DEPLOYMENT_TARGET=10.3
PH_LDSEARCHFLAGS = -undefined dynamic_lookup

all: 	search3

search3: search3.o search.o retreive.o args.o gmap.o word.o blockmap.o level.o out.o log.o plugin/libindex.a unpack/getresource.o unpack/bitsvector.o
	$(PH_BUILDENV) $(CC) $(CFLAGS) $(CPPFLAGS) $(PH_CFLAGS) $(LDFLAGS) $(PH_LDSEARCHFLAGS) search3.o args.o search.o retreive.o gmap.o word.o blockmap.o level.o out.o log.o -ldl unpack/getresource.o unpack/bitsvector.o -lgdbm -lindex -L./plugin -L./unpack -o search3

unpack/getresource.o: 
	(cd unpack; make getresource.o)

unpack/bitsvector.o: 
	(cd unpack; make bitsvector.o)

plugin/libindex.a:	plugin
	(cd plugin; make libindex.a)

unpack/libunpack_e.bundle: 
	(cd unpack; make libunpack_e.bundle)

#%.o: %.lo
#	ln -s $*.lo $@

args.o:		args.c args.h c.h search.h plugin/hit.h

gmap.o:		gmap.h gmap.c c.h

word.o:		word.h word.c c.h

level.o:	level.h blockmap.h gmap.h word.h level.c c.h

blockmap.o:	blockmap.h blockmap.c level.h word.h search.h c.h

search.o:	search.c blockmap.h blockmap.c level.h word.h search.h c.h

out.o:		out.h out.c

log.o:		log.h log.c

install:	all
	/usr/bin/install -c search3 ${exec_prefix}/bin

clean: 
	rm -f *.o *~ search3
	(cd plugin; make clean)
	(cd unpack; make clean)
