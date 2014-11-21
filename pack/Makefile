# $Id: Makefile.in,v 2.11 2004/08/23 21:44:28 o Exp $
# pack/Makefile.  Generated from Makefile.in by configure.
CC = gcc
CFLAGS= -O3 $(PH_CFLAGS)
CPPFLAGS= -I/sw/include/
LDFLAGS = -L/sw/lib/
PH_CFLAGS = -L../libraries -I../include -I/usr/local/include -g -O2 -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D_LARGEFILE64_SOURCE
PERL = /usr/bin/perl

PROGRAMS = indstrip lengths filtt1
TARGETS = p-t1 p-t2 e-n2 dbspecs*.h $(PROGRAMS)

%:	%.make
	echo \#\!$(SUBMAKE) -f | cat - $*.make >$@
	chmod +x $@

%:	%.sh
	echo \#\!$(SH) | cat - $*.sh >$@
	chmod +x $@

%:	%.plin
	echo \#\!$(PERL) | cat - $*.plin >$@
	chmod +x $@

everything: $(PROGRAMS)

indstrip: indstrip.c
	$(CC) $(CFLAGS) indstrip.c -o indstrip

filtt1: filtt1.c
	$(CC) $(CFLAGS) filtt1.c -o filtt1

p-t1:	p-t1.o bitpack.o dbspecs2.h
	$(CC) $(CFLAGS) $(PH_CFLAGS) $(CPPFLAGS) $(LDFLAGS) p-t1.o bitpack.o -lgdbm -o p-t1

p-t2:	p-t2.o bitpack.o dbspecs2.h
	$(CC) $(CFLAGS) $(PH_CFLAGS) $(CPPFLAGS) $(LDFLAGS) p-t2.o bitpack.o -lgdbm -o p-t2

e-n2:	e-n2.c bitpack3.h bitpack3.o dbspecs0c.h
	$(CC) $(CFLAGS) $(PH_CFLAGS) e-n2.c bitpack3.o -o $@

clean:
	rm -f *.o *~ $(TARGETS)

dist-clean: clean
	rm -f $(PROGRAMS)
