#
# Makefile for OPENSTEP.
#

-include Build/Makefile.common

MAKEFILEDIR = $(NEXT_ROOT)/NextDeveloper/Makefiles/pb_makefiles
CODE_GEN_STYLE = DYNAMIC
MAKEFILE = tool.make
LIBS = 
DEBUG_LIBS = $(LIBS)
PROF_LIBS = $(LIBS)


FRAMEWORKS = -framework Foundation


include $(MAKEFILEDIR)/platform.make

-include Makefile.preamble

include $(MAKEFILEDIR)/$(MAKEFILE)

-include Makefile.postamble

-include Makefile.dependencies
