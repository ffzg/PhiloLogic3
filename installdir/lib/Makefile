# $Id: Makefile.in,v 2.12 2004/11/16 00:44:05 o Exp $
SOURCES = Results_Footer.html Results_Header.html format.ph philo-db.cfg philosubs.pl security.ph

install:
	/usr/bin/install -c -d ${prefix}/var/lib/philologic/installdir/lib
	/usr/bin/install -c $(SOURCES) ${prefix}/var/lib/philologic/installdir/lib

clean:
	rm -f *~

dist-clean: clean
