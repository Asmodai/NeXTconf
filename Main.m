/*
 * Main.m  --- The Glue.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
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
#import <errno.h>

#import <sys/types.h>

#import "Symbol.h"
#import "SymbolTable.h"
#import "SyntaxTree.h"
#import "IntInstr.h"
#import "VirtMachine.h"
#import "Version.h"

#import "Scanner.h"
#import "Parser.h"

#import "PropertyManager.h"
#import "Architecture.h"
#import "Platform.h"

#import "Utils.h"
#import "Constants.h"

extern int yyparse(void *);

SymbolTable *root_symtab;

char *progname = NULL;

void
usage(void)
{
  fprintf(stderr,
          "usage: %s [-ivh] <file>\n",
          progname);
  exit(EXIT_FAILURE);
}

int
main(int argc, char **argv)
{
  int             ch      = 0;
  char           *fname   = NULL;
  IntInstr       *code    = nil;
  VirtualMachine *vm      = nil;
  SyntaxTree     *syntree = nil;
  BOOL            cFlag   = NO;
  BOOL            tFlag   = NO;
  BOOL            sFlag   = NO;

  //extern int   optind;
  extern char *optarg;

  make_constants();

  [[PropertyManager sharedInstance] instantiateAllClasses];

  root_symtab = [[SymbolTable alloc] init];
  syntree     = [[SyntaxTree alloc] init];
  vm          = [[VirtualMachine alloc] init];
  
  progname = argv[0];
  yyin     = NULL;

  while ((ch = getopt(argc, argv, "citosvhf:")) != EOF) {
    switch (ch) {
      case 'c':
        cFlag = YES;
        break;

      case 'v':
        [Version print];
        break;

      case 'i':
        {
          String       *name = nil;
          Architecture *arch = nil;
          Platform     *plat = nil;

          name = [[String alloc] initWithString:"Architecture"];
          arch = [[PropertyManager sharedInstance] findInstance:name];
          if (arch) {
            [arch print];
          }
          xfree(name);
          
          name = [[String alloc] initWithString:"Platform"];
          plat = [[PropertyManager sharedInstance] findInstance:name];
          if (plat) {
            [plat print];
          }
          xfree(name);          
        }
        break;

      case 'o':
        [[PropertyManager sharedInstance] printDebug:"Managed objects"];
        break;

      case 's':
        sFlag = YES;
        break;

      case 't':
        tFlag = YES;
        break;

      case 'h':
        usage();
        break;

      case 'f':
        fname = optarg;
        break;
    }
  }

  if (!fname) {
    exit(EXIT_FAILURE);
  }

  if ((yyin = fopen(fname, "r")) == NULL) {
    fprintf(stderr, "%s: Could not open '%s': %s.\n",
            progname,
            fname,
            strerror(errno));
    exit(EXIT_FAILURE);
  }

  if (yyin == NULL) {
    yyin = stdin;
  }

  yyparse(syntree);

  if (tFlag) {
    [syntree printDebug:"Parsed tokens"];
    putchar('\n');
  }

  if (errors > 0) {
    error_summary();
    exit(EXIT_FAILURE);
  }

  if (sFlag) {
    [root_symtab printDebug:"Symbols"];
    putchar('\n');
  }

  code = [IntInstr generate:syntree];
  [code number:1];

  if (cFlag) {
    [code printDebug:"Intermediate code"];
    putchar('\n');
  }

  [vm reset];
  [vm read:code];
  [vm execute];

  return errors ? 1 : 0;
}

/* Main.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
