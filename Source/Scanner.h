/*
 * Scanner.h  --- Lex header.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat,  7 Nov 2015 04:14:14 +0000 (GMT)
 * Keywords:   
 * URL:        Not distributed yet.
 */
/* {{{ License: */
/*
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
/* }}} */
/* {{{ Commentary: */
/*
 *
 */
/* }}} */

#ifndef _SCANNER_H_
#define _SCANNER_H_

#import <stdio.h>

/*
 * This tries to deal with spurious printing on Rhapsody.
 */
#ifdef ECHO
# undef ECHO
# define ECHO
#else
# define ECHO
#endif

#ifdef _IN_LEXER_
#import "Parser.h"
int lineno = 1;
#else
extern int   lineno;
extern FILE *yyin;
#endif

#ifndef YY_DECL
# define YY_DECL      int yylex(YYSTYPE *yylval, YYLTYPE *yylloc)
#endif

#endif /* !_SCANNER_H_ */

/* Scanner.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
