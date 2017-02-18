/*
 * Scanner.l  --- Lex tokeniser.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
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
/* }}} */

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

#import "Utils.h"
#define _IN_LEXER_
#import "Scanner.h"
#import "Parser.h"

void make_identifier(YYSTYPE *, char *);
void make_string_constant(YYSTYPE *, char *);
void make_integer_constant(YYSTYPE *, char *);
void make_boolean_constant(YYSTYPE *, char *);
void eat_comment(void);

%}

%x C_COMMENT

BVALUE    (true|false)
LETTER    [a-zA-Z_]
DIGIT     [0-9]+
IDENT     {LETTER}({LETTER}|{DIGIT})*
STR       \"[^\"]*\"
WSPACE    [ \t]+
END_STMT  ;

%%

"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL);   }
<C_COMMENT>.    {}

"if"       { return IF;                                               }
"else"     { return ELSE;                                             }
"for"      { return FOR;                                              }
"in"       { return IN;                                               }
"print"    { return PRINT;                                            }
"include"  { return INCLUDE;                                          }
"or"       { return LOGICAL_OR;                                       }
"xor"      { return LOGICAL_XOR;                                      }
"and"      { return LOGICAL_AND;                                      }
"="        { return ASSIGN;                                           }
"=="       { return EQUAL;                                            }
"!="       { return NEQUAL;                                           }
"+"        { return CONCAT;                                           }
";"        { return END_STMT;                                         }
"("        { return OPEN_PAR;                                         }
")"        { return CLOSE_PAR;                                        }
"{"        { return BEGIN_CS;                                         }
"}"        { return END_CS;                                           }
"["        { return OPEN_METH;                                        }
"]"        { return CLOSE_METH;                                       }
":"        { return METH_ARG;                                         }
{BVALUE}   { make_boolean_constant(yylval, yytext); return BOOLEAN;   }
{IDENT}    { make_identifier(yylval, yytext); return ID;              }
{STR}      { make_string_constant(yylval, yytext); return STRING;     }
{DIGIT}    { make_integer_constant(yylval, yytext); return INTEGER;   }
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
make_identifier(YYSTYPE *yylval, char *yytext)
{
  yylval->str = strdup(yytext);
}

/*
 * Make a string constant.
 */
void
make_string_constant(YYSTYPE *yylval, char *yytext)
{
  int l = 0;

  l = strlen(yytext) - 2;

  yylval->str = malloc((l + 1) * sizeof *yylval->str);
  strncpy(yylval->str, &yytext[1], l);
  yylval->str[l] = 0;
}

/*
 * Make an integer constant.
 */
void
make_integer_constant(YYSTYPE *yylval, char *yytext)
{
  yylval->fixnum = atol(yytext);
}

void
make_boolean_constant(YYSTYPE *yylval, char *yytext)
{
  if (strncasecmp(yytext, "true", 4) == 0) {
    yylval->fixnum = (int)YES;
  } else {
    yylval->fixnum = (int)NO;
  }
}

/* Grammar.l ends here */
/*
 * Local Variables: ***
 * mode: flex ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
