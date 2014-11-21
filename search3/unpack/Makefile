# $Id: Makefile.in,v 1.2 2004/05/28 19:22:11 o Exp $
CC= gcc
PH_CFLAGS= -I.. -I../../search-engine 
CFLAGS= -O3
CPPFLAGS=-I/sw/include/
LDFLAGS= -L/sw/lib/
PH_LDMODULEFLAGS=-bundle -bundle_loader /bin/search3 -undefined dynamic_lookup
PH_FPIC=-fno-common
all: validate-index libunpack_e.bundle
libunpack_e.bundle: unpack.lo getresource.o bitsvector.o
	$(CC) $(CFLAGS) $(PH_CFLAGS) $(CPPFLAGS) $(PH_LDMODULEFLAGS) $(LDFLAGS) unpack.lo bitsvector.o getresource.o -o libunpack_e.bundle 

unpack.lo: unpack.c unpack.h 
	$(CC) $(CFLAGS) $(CPPFLAGS) $(PH_CFLAGS) -I../include $(PH_FPIC)  -c -o unpack.lo unpack.c

getresource.o: getresource.c
	$(CC) $(CFLAGS) $(PH_FPIC) -c -o getresource.o getresource.c

bitsvector.o: bitsvector.c
	$(CC) $(CFLAGS) $(PH_FPIC) -c -o bitsvector.o bitsvector.c

validate-index: validate-index.c unpack.o bitsvector.o getresource.o
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o validate-index validate-index.c unpack.o bitsvector.o getresource.o -lgdbm

clean: 
	rm -f *.o *.lo libunpack_e.bundle *~ validate-index
