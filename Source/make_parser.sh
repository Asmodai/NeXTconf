#!/bin/sh
# -*- Mode: Shell-script -*-
#
# make_parser.sh --- Some title
#
# Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    Sat,  7 Nov 2015 04:56:05 +0000 (GMT)
# Keywords:   
# URL:        not distributed yet
#
# {{{ License:
#
# This program is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# Licenseas published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any
# later version.
#
# This program isdistributed in the hope that it will be
# useful, but WITHOUT ANY  WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public
# License along with this program.  If not, see
# <http://www.gnu.org/licenses/>.
#
# }}}
# {{{ Commentary:
#
# }}}

LEX_BIN=/usr/local/bin/flex
YACC_BIN=/usr/local/bin/bison

OBJC_MODE=1

LEX_INPUT=Scanner.l
LEX_OUTPUT=Scanner.c
OBJC_LEX_OUTPUT=Scanner.m

YACC_INPUT=Parser.y
YACC_OUTPUT=Parser.c
OBJC_YACC_OUTPUT=Parser.m

# Generate lexer.
$LEX_BIN -o${LEX_OUTPUT} ${LEX_INPUT}

# Generate parser
$YACC_BIN --defines --verbose -o ${YACC_OUTPUT} ${YACC_INPUT}

# ObjC mode?
if [ $OBJC_MODE -eq 1 ]
then
    mv ${LEX_OUTPUT} ${OBJC_LEX_OUTPUT}
    mv ${YACC_OUTPUT} ${OBJC_YACC_OUTPUT}
fi

# make_parser.sh ends here
# Local Variables: ***
# indent-tabs-mode: nil ***
# End: ***
