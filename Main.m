/*
 * Main.m  --- Some title
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/08 23:52:11 asmodai>
 * Revision:   9
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat,  7 Nov 2015 04:24:24 +0000 (GMT)
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

#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>
#import <libc.h>

#include <sys/types.h>

#import "Symbol.h"
#import "SymbolTable.h"
#import "SyntaxTree.h"

#import "Lexer.h"
#import "Parse.h"

#import "Manager.h"
#import "Architecture.h"
#import "Platform.h"

extern int yyparse(void);

SymbolTable *root_symtab;
SyntaxTree  *root_syntree;

int errors = 0;

void
errorf(char *fmt, ...)
{
  va_list ap;

  errors++;
  fprintf(stderr, "Line %d: ", lineno);

  va_start(ap, fmt);
  vfprintf(stderr, fmt, ap);
  va_end(ap);

  fprintf(stderr, "\n");
}

void
error_summary(void)
{
  printf("%d error(s) were found.\n", errors);
}

void
yyerror(char *msg)
{
  errorf(msg);
}

int
yywrap(void)
{
  return 1;
}

char *
strdup(const char *str)
{
  size_t  len = 0;
  char   *copy = NULL;

  len = strlen(str) + 1;

  if (!(copy = malloc((u_int)len))) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  bcopy(str, copy, len);

  return copy;
}

int
main(int argc, char **argv)
{
  //Instruction *code = nil;
  Platform     *plat = nil;
  Architecture *arch = nil;

  root_symtab  = [[SymbolTable alloc] init];
  root_syntree = [[SyntaxTree alloc] init];
  
  plat = [[Platform alloc] init];
  arch = [[Architecture alloc] init];

  yyin = NULL;

  if (argc == 2) {
    yyin = fopen(argv[1], "r");
  }

  if (yyin == NULL) {
    yyin = stdin;
  }

  yyparse();
  error_summary();

  [root_symtab printDebug:"Symbols"];
  putchar('\n');

  [root_syntree printDebug:"Parsed tokens"];
  putchar('\n');

  printf("\n\n");

  [[Manager sharedInstance] printDebug:"Object manager"];

  return errors ? 1 : 0;
}

/* Main.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
