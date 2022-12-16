/*
 * Main.m  --- The Glue.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
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
#import "Settings.h"
#import "MakeFile.h"
#import "Header.h"
#import "Utils.h"
#import "version.h"

extern int yyparse(void *);

char *progname = NULL;

void /* noreturn */
usage(void)
{
  fprintf(stderr,
          "usage: %s [-hiv"
#ifdef DEBUG
          "COPST"
#endif
          "] -f <file>\n"
          "  -f <file>   The NeXTconf script to execute.\n"
          "  -h          Display this help message.\n"
          "  -i          Display information about the installed system.\n"
          "  -v          Display the tool's version.\n"
#ifdef DEBUG
          "\n"
          "  -C          [debug] Show opcode for script.\n"
          "  -O          [debug] Show runtime objects.\n"
          "  -S          [debug] Show symbol table for script.\n"
          "  -T          [debug] Show token tree for script. *SLOW*\n"
          "  -P          [debug] Add an infinite loop for profiling.\n"
#endif
          ,progname);

  exit(EXIT_FAILURE);
}

void /* noreturn */
show_info(void)
{
  String       *name = nil;
  Architecture *arch = nil;
  Platform     *plat = nil;

  name = [[String alloc] initWithString:"Architecture"];
  arch = [[PropertyManager sharedInstance] findInstance:name];
  [name free];
  if (arch) {
    [arch print];
  }

  name = [[String alloc] initWithString:"Platform"];
  plat = [[PropertyManager sharedInstance] findInstance:name];
  [name free];
  if (plat) {
    [plat print];
  }

  exit(EXIT_SUCCESS);
}

void /* noreturn */
show_version(void)
{
  [Version print];

  exit(EXIT_SUCCESS);
}

void
generate(void)
{
  String   *name     = nil;
  Settings *settings = nil;
  MakeFile *makefile = nil;
  Header   *header   = nil;

  name     = [[String alloc] initWithString:"Settings"];
  settings = [[PropertyManager sharedInstance] findInstance:name];
  [name free];

  name     = [[String alloc] initWithString:"MakeFile"];
  makefile = [[PropertyManager sharedInstance] findInstance:name];
  [name free];

  name   = [[String alloc] initWithString:"Header"];
  header = [[PropertyManager sharedInstance] findInstance:name];
  [name free];

  if (!makefile) {
    fprintf(stderr, "Error when trying to find our 'makefile' instance!\n");
    exit(EXIT_FAILURE);
  }

  if (!header) {
    fprintf(stderr, "Error when trying to find our 'header' instance!\n");
    exit(EXIT_FAILURE);
  }

  if (!settings) {
    fprintf(stderr, "Error when trying to find our 'settings' instance!\n");
    exit(EXIT_FAILURE);
  }

  if ([[settings generateMakefile] boolValue] == YES) {
    [makefile generate:[settings makefileLocation]];
  }

  if ([[settings generateHeader] boolValue] == YES) {
    [header generate:[settings headerLocation]];
  }
}

/*
 * TODO:
 *
 *   Could we abuse the fact that `-MachLaunch' is an argument when an app or
 *   tool is launched from Workspace Manager for something?
 */
int
main(int argc, char **argv)
{
  int             ch      = 0;
  char           *fname   = NULL;
  IntInstr       *code    = nil;
  VirtualMachine *vm      = nil;
  SyntaxTree     *syntree = nil;

#ifdef DEBUG
  BOOL cFlag = NO;
  BOOL tFlag = NO;
  BOOL sFlag = NO;
  BOOL oFlag = NO;
  BOOL pFlag = NO;
#endif

  extern char *optarg;
              
  [[PropertyManager sharedInstance] instantiateAllClasses];

  syntree = [[SyntaxTree alloc] init];
  vm      = [[VirtualMachine alloc] init];
  
  progname = argv[0];
  yyin     = NULL;

#ifdef DEBUG
# define OPTS "hviCOPSTf:"
#else
# define OPTS "hvif:"
#endif

  while ((ch = getopt(argc, argv, OPTS)) != EOF) {
    switch (ch) {
      case 'h':
        usage();
        break;

      case 'v':
        show_version();
        break;

      case 'i':
        show_info();
        break;

      case 'f':
        fname = optarg;
        break;

#ifdef DEBUG

      case 'C':
        cFlag = YES;
        break;

      case 'O':
        oFlag = YES;
        break;

      case 'P':
        pFlag = YES;
        break;

      case 'S':
        sFlag = YES;
        break;

      case 'T':
        tFlag = YES;
        break;

#endif

      default:
        usage();
    }
  }

  if (!fname) {
    fprintf(stderr, "No NeXTconf script provided!\n");
    exit(EXIT_FAILURE);
  }

#ifdef DEBUG
  if (pFlag) {
    printf("Press any key when ready to profile.\n");
    getchar();
  }
#endif

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

#ifdef DEBUG
  if (tFlag) {
    putchar('\n');
    [syntree printDebug:"Parsed tokens"];
    putchar('\n');
  }
#endif

  if (errors > 0) {
    error_summary();
    exit(EXIT_FAILURE);
  }

  code = [IntInstr generate:syntree];
  [code number:1];
  [syntree free];

#ifdef DEBUG
  if (cFlag) {
    putchar('\n');
    [code printDebug:"Intermediate code"];
    putchar('\n');
  }
#endif

  [vm reset];
  [vm read:code];
  [vm execute];

#ifdef DEBUG
  if (sFlag) {
    putchar('\n');
    [[SymbolTable sharedInstance] printDebug:"Symbols"];
    putchar('\n');
  }

  if (oFlag) {
    putchar('\n');
    [[PropertyManager sharedInstance] printDebug:"Managed objects"];
    putchar('\n');
  }

  if (pFlag) {
    printf("Press any key when ready to end execution.\n");
    getchar();
  }
#endif

  generate();

  return errors ? 1 : 0;
}

/* Main.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
