# $Id: Makefile.in,v 2.12 2004/08/23 21:45:03 o Exp $
SCRIPTS = philoload philosearch.html philologic.cfg nserver
SOURCES = philoload.plin philosearch.html.in philologic.cfg.in nserver.in Makefile.in dbnames

all: philoload.plin philosearch.html.in nserver.in
	../config.status --file=philoload:philoload.plin
	../config.status --file=philosearch.html:philosearch.html.in
	../config.status --file=philologic.cfg:philologic.cfg.in
	../config.status --file=nserver:nserver.in

install: all
	/usr/bin/install -c philoload ${exec_prefix}/bin
	/usr/bin/install -c -d -g admin -m u=rwx,g=rwx,o=rx ${prefix}/etc/philologic/
	/usr/bin/install -c -g admin -m u=rwx,g=rwx,o=rx philosearch.html /Library/WebServer/Documents/philologic/
	/usr/bin/install -c -g admin -m u=rwx,g=rwx,o=rx philopowered.png /Library/WebServer/Documents/philologic/
	/usr/bin/install -c -g admin -m u=rwx,g=rwx,o=rx philo_white.png /Library/WebServer/Documents/philologic/
	/usr/bin/install -c -g admin -m u=rwx,g=rwx,o=rx moo.ajax.js /Library/WebServer/Documents/philologic/
	/usr/bin/install -c -g admin -m u=rwx,g=rwx,o=rx prototype.lite.js /Library/WebServer/Documents/philologic/
	/usr/bin/install -c -g admin -m u=rwx,g=rwx,o=rx notes.js /Library/WebServer/Documents/philologic/
	/usr/bin/install -c -g admin -m u=rwx,g=rwx,o=rx philologic.cfg ${prefix}/etc/philologic/
	/usr/bin/install -c -g admin -m u=rwx,g=rwx,o=rx dbnames ${prefix}/etc/philologic/
	/usr/bin/install -c -d -g admin -m u=rwx,g=rwx,o=rx ${prefix}/var/lib/philologic/etc/
	/usr/bin/install -c $(SOURCES) ${prefix}/var/lib/philologic/etc/
#	/usr/bin/install -c nserver /etc/init.d
	/usr/bin/install -c -d /Library/StartupItems/nserver/; /usr/bin/install -c ../goodies/OSX/NSERVER_OSX/Nserver/* /Library/StartupItems/nserver/
#	ln -s -f /etc/init.d/nserver /etc/rc2.d/S99nserver
	chmod +x /Library/StartupItems/nserver//nserver
	/usr/bin/install -c -d ${prefix}/var/lib/philologic/init.d


clean:
	rm -f $(SCRIPTS)

dist-clean: clean

distclean: dist-clean
