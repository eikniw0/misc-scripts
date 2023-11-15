##
# Building apk-tools

-include config.mk

PACKAGE := apk-tools
VERSION := 2.10.4

##
# Default directories

DESTDIR		:=
SBINDIR		:= /data/data/com.termux/files/usr/bin
LIBDIR		:= /data/data/com.termux/files/usr/lib
CONFDIR		:= /data/data/com.termux/files/usr/etc/apk
MANDIR		:= /data/data/com.termux/files/usr/share/man
DOCDIR		:= /data/data/com.termux/files/usr/share/doc/apk

export DESTDIR SBINDIR LIBDIR CONFDIR MANDIR DOCDIR

##
# Top-level rules and targets

targets		:= libfetch/ src/

##
# Include all rules and stuff

include Make.rules

##
# Top-level targets

install:
	$(INSTALLDIR) $(DESTDIR)$(DOCDIR)
	$(INSTALL) README $(DESTDIR)$(DOCDIR)

check test: FORCE
	$(Q)$(MAKE) TEST=y
	$(Q)$(MAKE) -C test

static:
	$(Q)$(MAKE) STATIC=y

tag: check
	git commit . -m "apk-tools-$(VERSION)"
	git tag -s v$(VERSION) -m "apk-tools-$(VERSION)"

src/: libfetch/
