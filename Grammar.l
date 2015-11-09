/*
 * Grammar.l  --- Lex tokeniser.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/09 02:46:07 asmodai>
 * Revision:   8
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat,  7 Nov 2015 07:09:14 +0000 (GMT)
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
%{

#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>
#import <libc.h>
#import <string.h>

#import <sys/types.h>

#import "Symbol.h"
#import "SymbolTable.h"
#import "SyntaxTree.h"

#define _IN_LEXER_
#import "Lexer.h"
#import "Parse.h"

extern char *strdup(const char *);
extern int   yywrap(void);

void make_identifier(void);
void make_string_constant(void);
void make_integer_constant(void);
void eat_comment(void);

%}

LETTER    [a-zA-Z_]
DIGIT     [0-9]+
IDENT     {LETTER}({LETTER}|{DIGIT})*
STR       \"[^\"]*\"
WSPACE    [ \t]+
END_STMT  ;

%%

"if"       { return IF;                                               }
"else"     { return ELSE;                                             }
"for"      { return FOR;                                              }
"in"       { return IN;                                               }
"print"    { return PRINT;                                            }
"="        { return ASSIGN;                                           }
"=="       { return EQUAL;                                            }
"+"        { return CONCAT;                                           }
";"        { return END_STMT;                                         }
"("        { return OPEN_PAR;                                         }
")"        { return CLOSE_PAR;                                        }
"{"        { return BEGIN_CS;                                         }
"}"        { return END_CS;                                           }
"["        { return OPEN_METH;                                        }
"]"        { return CLOSE_METH;                                       }
{IDENT}    { make_identifier(); return ID;                            }
{STR}      { make_string_constant(); return STRING;                   }
{DIGIT}    { make_integer_constant(); return INTEGER;                 }
"//"       { eat_comment();                                           }
\n         { lineno++;                                                }
{WSPACE}   {                                                          }
.          { return ERROR_TOKEN;                                      }

%%

/*
 * Ignore comments from input to EOF.
 */
void
eat_comment(void)
{
  char c = 0;

  while ((c == input()) != '\n' && c != 0)
    ;

  lineno++;
}

/*
 * Make an identifier.
 */
void
make_identifier(void)
{
  yylval.str = strdup(yytext);
}

/*
 * Make a string constant.
 */
void
make_string_constant(void)
{
  int l = 0;

  l = strlen(yytext) - 2;

  yylval.str = malloc((l + 1) * sizeof *yylval.str);
  strncpy(yylval.str, &yytext[1], l);
  yylval.str[l] = 0;
}

/*
 * Make an integer constant.
 */
void
make_integer_constant(void)
{
  yylval.fixnum = atol(yytext);
}

/* Grammar.l ends here */
/*
 * Local Variables: ***
 * mode: fundamental ***
 * indent-tabs-mode: nil ***
 * End: ***
 */