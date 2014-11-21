# $Id: Makefile.in,v 2.14 2004/11/16 00:44:05 o Exp $
# utils/Makefile.  Generated from Makefile.in by configure.

include ../load.cfg

CFLAGS= -O3
CC= gcc
PERL= /usr/bin/perl

PH_CFLAGS = -I../include
LDFLAGS = -L../libraries

TARGETS = enprefix unprefix packing-info rawindex replacer seeknread splitter mkbibliography mkbiblio split newdocs textload mkbiblio-twig dublin.extract dividxhashmake.pl


%:	%.plin ../load.cfg
	echo \#\!$(PERL) | cat - $*.plin >$@
	chmod +x $@

everything: $(TARGETS)

textload: $(TEXTLOAD) ../load.cfg
	echo \#\!$(PERL) | cat - $(TEXTLOAD) >$@
	chmod +x $@

mkbibliography: $(MKBIBLIOGRAPHY) ../load.cfg
	echo \#\!$(PERL) | cat - $(MKBIBLIOGRAPHY) >$@
	chmod +x $@

dist-clean:
	rm -f $(TARGETS)

clean: dist-clean



