#
# Makefile for NEXTSTEP.
#

-include Build/Makefile.common

MAKEFILEDIR = /NextDeveloper/Makefiles/app
MAKEFILE = tool.make
INSTALLDIR = $(HOME)/bin
INSTALLFLAGS = -c -s -m 755
SOURCEMODE = 444

LIBS = -lNeXT_s
DEBUG_LIBS = $(LIBS)
PROF_LIBS = $(LIBS)

-include Makefile.preamble

include $(MAKEFILEDIR)/$(MAKEFILE)

-include Makefile.postamble

-include Makefile.dependencies
