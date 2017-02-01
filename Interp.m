/*
 * Interp.m  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Wed,  1 Feb 2017 13:35:41 +0000 (GMT)
 * Keywords:   
 * URL:        Not distributed yet.
 */

/* {{{ License: */
/*
 * Copyright (c) 1990 The Regents of the University of California.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *      This product includes software developed by the University of
 *      California, Berkeley and its contributors.
 * 4. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
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

#import "Symbol.h"
#import "SyntaxTree.h"

extern const char *node_types[];
extern const char *return_types[];
extern const int   children_per_node[];

static
void
doAssign(Symbol *lhs, Symbol *rhs)
{
  [lhs setData:rhs];
  
  printf("%s = %s\n",
         [[lhs symbolName] stringValue],
         [[rhs data] stringValue]);
}

static
BOOL
isEqual(Symbol *lhs, Symbol *rhs)
{
  return NO;
}

static
String *
getIdent(Symbol *symb)
{
  return nil;
}

static
int
getInteger(Symbol *symb)
{
  return 0;
}

static
String *
getString(Symbol *symb)
{
  return nil;
}

static
String *
coerceString(Symbol *symb)
{
  return nil;
}

static
void
dointerp(SyntaxTree *node)
{
  size_t     i        = 0;
  STNodeType ntype    = [node nodeType];
  size_t     children = children_per_node[ntype];

  switch (ntype) {
    case EmptyStmt:
      printf("Ignoring empty statement...\n");
      break;

    case StmtList:
      {
        for (i = 0; i < children; i++) {
          printf("Interpreting children...\n");
          dointerp([node childAtIndex:i]);
        }
      }
      break;

    case ExprStmt:
      {
        printf("Expression: ");
        dointerp([node childAtIndex:0]);
      }
      break;

    case AssignExpr:
      printf("Assigning...\n");
      doAssign([node symbol], [[node childAtIndex:0] symbol]);
      break;

    default:
      break;
  }
}

void
interpret(SyntaxTree *root)
{
  dointerp(root);
}

/* Interp.m ends here */
