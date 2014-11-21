# $Id: Makefile.in,v 2.12 2004/11/16 00:44:05 o Exp $
# cgi-bin/Makefile.  Generated from Makefile.in by configure.
SCRIPTS = search3 getobject.pl nserver.pl artfl_conc.pl getrawdoc.pl artfl_kwic.pl artfl_pole.pl hitlist.del.cron select.pl contextualize.pl navigate.pl showrest_ getsource.pl search3t theme_rheme.pl philohistory.pl artfl_sortedkwic.pl kwicresort.pl getwordcount.pl getnote.pl

SOURCES = getobject.pl.plin nserver.pl.plin artfl_conc.pl.plin getrawdoc.pl.plin artfl_kwic.pl.plin artfl_pole.pl.plin hitlist.del.cron.plin select.pl.plin contextualize.pl.plin navigate.pl.plin showrest_.plin Makefile.in getsource.pl.plin search3t.plin theme_rheme.pl.plin philohistory.pl.plin artfl_sortedkwic.pl.plin  kwicresort.pl.plin getwordcount.pl.plin getnote.pl.plin

%:      %.plin
	../config.status --file=$@:$@.plin
	chmod +x $@

all: $(SCRIPTS)

clean:
	rm -f $(SCRIPTS) *~

dist-clean: clean
	rm -f config.log

distclean: dist-clean

install: all
#	/usr/bin/install -c -d /Library/WebServer/CGI-Executables/philologic//
	../mkinstalldirs /Library/WebServer/CGI-Executables/philologic//
	for foo in $(SCRIPTS); do \
	/usr/bin/install -c $$foo /Library/WebServer/CGI-Executables/philologic//; done
	/usr/bin/install -c -d ${prefix}/var/lib/philologic/cgi-bin
	/usr/bin/install -c $(SOURCES) ${prefix}/var/lib/philologic/cgi-bin/
	rm -f ${prefix}/var/lib/philologic/local-cgi-bin
	ln -s -f /Library/WebServer/CGI-Executables/philologic// ${prefix}/var/lib/philologic/local-cgi-bin
