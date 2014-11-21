#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.
# $Id: configure.ac,v 2.17 2004/11/19 20:31:26 o Exp $

AC_PREREQ(2.59)
AC_INIT(PhiloLogic, 3.2rc5, bugs@philologic.uchicago.edu)
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR([pack/bitpack.c])
AC_CANONICAL_BUILD
AC_CANONICAL_HOST

# Checks for programs.
AC_PROG_CXX
AC_PROG_CC
AC_PROG_LEX
AC_PROG_LN_S
AC_PROG_MAKE_SET


AC_PATH_PROG_EGREP

AC_PATH_PROG(MYSQL,mysql,no)
if test "$MYSQL" = "no"; then
   AC_MSG_WARN([mysql not found in your path; some metadata searches require MySQL.])
fi

AC_PATH_PROG(AGREP,agrep,"")
if test "$AGREP" = ""; then
  AC_MSG_WARN([agrep not found; approximate match suggestions will not be used.])
fi

AC_PATH_PROG(PS,ps,no)
if test "$PS" = "no"; then
  AC_MSG_WARN([ps not found.])
fi

AC_PATH_PROG(GREP,grep,no)
if test "$GREP" = "no"; then
  AC_MSG_WARN([grep not found.])
fi

AC_PATH_PROG(SED,sed,no)
if test "$SED" = "no"; then
  AC_MSG_WARN([sed not found.])
fi

AC_PATH_PROG(MAKE,make,no)
if test "$MAKE" = "no"; then
  AC_MSG_ERROR([make not found; you *really* need make.])
fi

AC_PATH_PROG(PERL,perl,no)
if test "$PERL" = "no"; then
  AC_MSG_ERROR([perl not found in PATH: $PATH; I need perl.])
fi

AC_PATH_PROG(GAWK,gawk,no)
if test "$GAWK" = "no"; then
  AC_MSG_ERROR([gawk not found in PATH: $PATH; I need gawk.])
fi

AC_PATH_PROG(GREP,grep,no)
if test "$GREP" = "no"; then
  AC_MSG_ERROR([grep not found in PATH: $PATH; I need grep.])
fi

AC_PATH_PROG(PS,ps,no)
if test "$PS" = "no"; then
  AC_MSG_ERROR([ps not found in PATH: $PATH; I need ps.])
fi

AC_PATH_PROG(SED,sed,no)
if test "$SED" = "no"; then
  AC_MSG_ERROR([sed not found in PATH: $PATH; I need sed.])
fi

AC_PATH_PROG(GZIP,gzip,no)
if test "$GZIP" = "no"; then
  AC_MSG_ERROR([gzip not found in PATH: $PATH; I need gzip.])
fi

AC_PATH_PROG(ZCAT,zcat,no)
if test "$ZCAT" = "no"; then
  AC_MSG_ERROR([zcat not found in PATH: $PATH; I need zcat.])
fi


# Checks for libraries.
# FIXME: Replace `main' with a function in `-lfl':
AC_CHECK_LIB([fl], [main])
# FIXME: Replace `main' with a function in `-lgdbm':
AC_CHECK_LIB([gdbm], [main])

# Checks for header files.
AC_HEADER_STDC
AC_CHECK_HEADER([gdbm.h], [], [AC_MSG_ERROR([gdbm.h not found; please install the gdbm library and its development headers])])
AC_CHECK_HEADERS([fcntl.h memory.h stdlib.h string.h strings.h])


# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC
AC_FUNC_STAT
AC_CHECK_FUNCS([strchr strncasecmp strspn])

AC_ARG_WITH( boot-init-d,
	AC_HELP_STRING([--with-boot-init-d=DIR	sets path to default boot init.d directory 
				@<:@/etc/rc2.d@:>@]),
	boot_init_d=$withval, boot_init_d=/etc/rc2.d )
AC_SUBST(boot_init_d)

AC_ARG_WITH( init-d,
	AC_HELP_STRING( [--with-init-d=DIR	sets path to initscripts directory @<:@/etc/init.d@:>@]),
	init_d=$withval, init_d=/etc/init.d )
AC_SUBST(init_d)

#Platform-specific config.
case $host in
        *-*-darwin*) 
        PH_LDFLAGS="-undefined dynamic_lookup"
        PH_LDMODULEFLAGS="-bundle -bundle_loader /bin/search3 -undefined dynamic_lookup"
	PH_LDSEARCHFLAGS="-undefined dynamic_lookup"
	PH_PIC="-fno-common"
	PH_MODULETARGET="libunpack_e.bundle"
	PH_BUILDENV="MACOSX_DEPLOYMENT_TARGET=10.3"
	NSERVER="../goodies/OSX/NSERVER_OSX/Nserver/"
	NSERVER_LOCATION="/Library/StartupItems/nserver/"
	NSERVER_INSTALL="${INSTALL} -d ${NSERVER_LOCATION}; ${INSTALL} ${NSERVER}* ${NSERVER_LOCATION}"
	NSERVER_ACTIVATE="chmod +x ${NSERVER_LOCATION}/nserver"
	WEB_DEFAULT_PATH="/Library/WebServer/Documents/philologic/"
	CGI_DEFAULT_PATH="/Library/WebServer/CGI-Executables/philologic/"
	DEFAULT_GROUP="admin"
        ;;
        *-*-*linux*) 
        PH_LDFLAGS="-Wl,--export-dynamic"
	PH_LDMODULEFLAGS="-shared"
	PH_LDSEARCHFLAGS="--export-dynamic"
	PH_PIC="-fPIC"
	PH_MODULETARGET="libunpack_e.so"
	PH_BUILDENV=""
	NSERVER="nserver"
	NSERVER_LOCATION=${init_d}
	NSERVER_INSTALL="${INSTALL} ${NSERVER} ${NSERVER_LOCATION}"
	NSERVER_ACTIVATE="${LN_S} -f ${NSERVER_LOCATION}/nserver ${boot_init_d}/S99nserver"
	WEB_DEFAULT_PATH="/var/www/html/philologic/"
	CGI_DEFAULT_PATH="/var/www/cgi-bin/philologic/"
	DEFAULT_GROUP="philologic"
        ;;
        *) 
	PH_LDFLAGS=""
	PH_LDMODULEFLAGS=""
	PH_LDSEARCHFLAGS=""
	PH_PIC=""
	PH_MODULETARGET=""
	PH_BUILDENV=""
	NSERVER="nserver"	
	NSERVER_LOCATION=${init_d}
	NSERVER_INSTALL="${INSTALL} ${NSERVER} ${NSERVER_LOCATION}"
        NSERVER_ACTIVATE="${LN_S} -f ${NSERVER_LOCATION}/nserver ${boot_init_d}/S99nserver"
	WEB_DEFAULT_PATH="/var/www/html/philologic/"
        CGI_DEFAULT_PATH="/var/www/cgi-bin/philologic/"
	DEFAULT_GROUP="philologic"
        ;;
esac
AC_SUBST(PH_DFLAGS)
AC_SUBST(PH_LDMODULEFLAGS)
AC_SUBST(PH_LDSEARCHFLAGS)
AC_SUBST(PH_PIC)
AC_SUBST(PH_MODULETARGET)
AC_SUBST(PH_BUILDENV)
AC_SUBST(NSERVER_INSTALL)
AC_SUBST(NSERVER_ACTIVATE)
AC_SUBST(NSERVER_LOCATION)
AC_SUBST(INCLUDES)
#Process command line args.  

AC_ARG_WITH( cgi-path,
	AC_HELP_STRING([--with-cgi-path=DIR	sets filesystem path to cgi-bin directory 
			@<:@${CGI_DEFAULT_PATH}@:>@]),
	cgi_path=$withval, cgi_path=${CGI_DEFAULT_PATH} )
AC_SUBST(cgi_path)

AC_ARG_WITH( cgi-url,
	AC_HELP_STRING([--with-cgi-url=DIR	sets URL path to cgi-bin directory @<:@/cgi-bin/philologic@:>@]),
	cgi_url=$withval, cgi_url=/cgi-bin/philologic )
AC_SUBST(cgi_url)

AC_ARG_WITH( web-path,
	AC_HELP_STRING( [--with-web-path=DIR	sets filesystem path for sample search page 
			and source downloads @<:@${WEB_DEFAULT_PATH}@:>@]),
	web_path=$withval, web_path=${WEB_DEFAULT_PATH} )
AC_SUBST(web_path)

AC_ARG_WITH( web-url,
	AC_HELP_STRING( [--with-web-url=DIR	sets URL path for sample search page
				and source downloads @<:@/philologic@:>@]),
	web_url=$withval, web_url=/philologic )
AC_SUBST(web_url)

AC_ARG_WITH( authuser-group,
	AC_HELP_STRING( [--with-authuser-group=groupname	name of group authorized to build
				PhiloLogic databases @<:@${DEFAULT_GROUP}@:>@]),
	authuser_group=$withval, authuser_group=${DEFAULT_GROUP} )
AC_SUBST(authuser_group)

AC_MSG_NOTICE('configuring philologic build for ${host}.')
AC_MSG_NOTICE('web_path= ${web_path}.')
AC_MSG_NOTICE('cgi_path=${cgi_path}.')
AC_MSG_NOTICE('authorized group=${authuser_group}')
AC_MSG_NOTICE('nserver_install=${NSERVER_LOCATION}')
#Process the Makefiles.
AC_CONFIG_FILES([Makefile
		loader.xmake 
		cgi-bin/Makefile
		installdir/Makefile
		installdir/lib/Makefile
		pack/Makefile
		toms/Makefile
		utils/Makefile
		etc/Makefile
		search3/Makefile
		search3/plugin/Makefile
		search3/unpack/Makefile
		goodies/OSX/NSERVER_OSX/nserver/nserver
])
AC_OUTPUT
