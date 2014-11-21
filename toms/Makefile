# $Id: Makefile.in,v 2.11 2004/08/23 21:45:03 o Exp $
# toms/Makefile.  Generated from Makefile.in by configure.
include ../load.cfg

CC=gcc
PERL=/usr/bin/perl

TARGETS = storeobjects tomsload1 tomsload2 mkheaders mkinfo mknavig omerge extpgmarks


%:	%.plin
	echo \#\!$(PERL) | cat - $*.plin >$@
	chmod +x $@

%: 	%.sh
	echo \#\!$(SH) | cat - $*.sh >$@
	chmod +x $@

everything: $(TARGETS)

clean: 
	rm -f *.o *~ 

dist-clean: clean
	rm -f $(TARGETS)

