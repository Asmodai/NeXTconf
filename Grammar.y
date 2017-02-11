/*
 * Grammar.y  --- Yacc grammar.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
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
#import "Selector.h"
#import "SymbolTable.h"
#import "Manager.h"
#import "SyntaxTree.h"
#import "Lexer.h"

extern SymbolTable *root_symtab;
extern SyntaxTree  *root_syntree;

void        errorf(char *fmt, ...);
void        yyerror(char *msg);
const char *make_symbol_name(void);
const char *make_immediate_name(void);

/* We want debugging. */
#define YYDEBUG 1

/* Tell Yacc/bison to be verbose. */
#define YYERROR_VERBOSE

/*
 * Insert a number into the root symbol table.
 */
#define IINT(__a)                   \
  [root_symtab insertSymbol:(__a)]

/*
 * Insert a boolean into the root symbol table.
 */
#define IBOOL(__a)                  \
  [root_symtab insertSymbol:(__a)]

/*
 * Insert an identifier into the root symbol table.
 */
#define IINDENT(__a)                \
  [root_symtab insertSymbol:(__a)]

/*
 * Insert a symbol into the root symbol table.
 */
#define ISYMB(__a)                  \
  [root_symtab insertSymbol:(__a)]

/*
 * Create an integer symbol.
 */
#define CINT(__a)                                                  \
  [[Symbol alloc] initWithData:(__a)                               \
                       andName:(const char *)make_immediate_name() \
                       andType:SymbolNumber];

/*
 * Create a boolean symbol.
 */
#define CBOOL(__a)                                                 \
  [[Symbol alloc] initWithData:(__a)                               \
                       andName:(const char *)make_immediate_name() \
                       andType:SymbolBoolean];

/*
 * Create an identifier symbol.
 */
#define CIDENT(__a, __b)              \
  [[Symbol alloc] initWithData:nil    \
                       andName:(__a)  \
                       andType:(__b)]

/*
 * Create a string constant symbol.
 */
#define CSYMB(__a, __b, __c)                                         \
  [[Symbol alloc] initWithData:[[String alloc] initWithString:(__a)] \
                       andName:(__b)                                 \
                       andType:(__c)]

/*
 * Create a syntax tree with no child nodes.
 */
#define CTREE(__a)                       \
  [[SyntaxTree alloc] initWithType:(__a)]

/*
 * Create a syntax tree with 1 child node.
 */
#define CTREE1(__a, __b)                 \
  [[SyntaxTree alloc] initWithType:(__a) \
                         andChild1:(__b)]

/*
 * Create a syntax tree with 2 child nodes.
 */
#define CTREE2(__a, __b, __c)            \
  [[SyntaxTree alloc] initWithType:(__a) \
                         andChild1:(__b) \
                         andChild2:(__c)]

/*
 * Create a syntax tree with 3 child nodes.
 */
#define CTREE3(__a, __b, __c, __d)       \
  [[SyntaxTree alloc] initWithType:(__a) \
                         andChild1:(__b) \
                         andChild2:(__c) \
                         andChild3:(__d)]

%}

%union {
  char          *str;
  unsigned long  fixnum;
  Symbol        *symbol;
  SyntaxTree    *tnode;
}

%token ERROR_TOKEN
%token IF
%token ELSE
%token FOR
%token IN
%token PRINT
%token ASSIGN
%token EQUAL
%token NEQUAL
%token CONCAT
%token END_STMT OPEN_PAR CLOSE_PAR
%token OPEN_METH CLOSE_METH
%token BEGIN_CS END_CS
%token <str> ID STRING
%token <fixnum> INTEGER BOOLEAN

%type <symbol> identifier string integer boolean
%type <str>    class_name method_name
%type <tnode>  program statement_list statement
%type <tnode>  if_statement compound_statement
%type <tnode>  for_statement expr equal_expr assign_expr
%type <tnode>  concat_expr simple_expr method_call

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%expect 1

%%

program
   : statement_list                 { root_syntree = $1;                       }
   ;

statement_list
   : statement statement_list       { $$ = CTREE2(StmtList, $1, $2);           }
   | /* Empty */                    { $$ = CTREE(EmptyStmt);                   }
   ;

statement
   : END_STMT                       { $$ = CTREE(EmptyStmt);                   }
   | expr END_STMT                  { $$ = CTREE1(ExprStmt, $1);               }
   | PRINT expr END_STMT            { $$ = CTREE1(PrintStmt, $2);              }
   | if_statement                   { $$ = $1;                                 }
   | for_statement                  { $$ = $1;                                 }
   | compound_statement             { $$ = $1;                                 }
   | error END_STMT                 { $$ = CTREE(ErrorStmt);                   }
   ;

if_statement
   : IF OPEN_PAR expr CLOSE_PAR statement %prec LOWER_THAN_ELSE {
       $$ = CTREE2(IfThenStmt, $3, $5);
     }
   | IF OPEN_PAR expr CLOSE_PAR statement ELSE statement {
       if ($7 != nil) {
         $$ = CTREE3(IfThenElseStmt, $3, $5, $7);
       } else {
         $$ = CTREE2(IfThenStmt, $3, $5);
       }
     }
   ;

for_statement
   : FOR identifier IN OPEN_PAR expr CLOSE_PAR statement {
       $$ = CTREE2(ForInStmt, $5, $7);
       [$$ setSymbol:$2];
     }
   ;

compound_statement
   : BEGIN_CS statement_list END_CS { $$ = $2;                                 }
   ;

expr
   : equal_expr                     { $$ = $1;                                 }
   ;

equal_expr
   : expr EQUAL assign_expr         { $$ = CTREE2(EqualExpr, $1, $3);          }
   | expr NEQUAL assign_expr        { $$ = CTREE2(NotEqualExpr, $1, $3);       }
   | assign_expr                    { $$ = $1;                                 }
   ;

assign_expr
   : identifier ASSIGN assign_expr  { $$ = CTREE1(AssignExpr, $3);
                                      [$$ setSymbol:$1];                       }
   | concat_expr                    { $$ = $1;                                 }
   ;

concat_expr
   : concat_expr CONCAT simple_expr { $$ = CTREE2(ConcatExpr, $1, $3);         }
   | simple_expr                    { $$ = $1;                                 }
   ;

simple_expr
   : identifier                     { $$ = CTREE(IdentExpr);
                                      [$$ setSymbol:$1];                       }
   | string                         { $$ = CTREE(StringExpr);
                                      [$$ setSymbol:$1];                       }
   | integer                        { $$ = CTREE(IntegerExpr);
                                      [$$ setSymbol:$1];                       }
   | boolean                        { $$ = CTREE(BooleanExpr);
                                      [$$ setSymbol:$1];                       } 
   | OPEN_PAR expr CLOSE_PAR        { $$ = $2;                                 }
   | method_call                    { $$ = $1;                                 }
   ;

identifier
   : ID {
       $$ = [root_symtab valueForSymbol:$1];
       if ($$ == nil) {
         $$ = CIDENT($1, SymbolObject);
         IINDENT($$);
       }
     }
   ;

integer
   : INTEGER {
       Number *num = nil;

       num = [[Number alloc] initWithInt:$1];
       $$ = CINT(num);
       IINT($$);
     }
   ;

boolean
   : BOOLEAN {
       Boolean *bool = nil;

       bool = [[Boolean alloc] initWithInt:$1];
       $$ = CBOOL(bool);
       IBOOL($$);
     }
   ;

class_name
   : ID { $$ = $1; }
   ;

method_name
   : ID { $$ = $1; }
   ;

method_call
   : OPEN_METH class_name method_name CLOSE_METH {
      Selector *sel = nil;
      Symbol   *sym = nil;

      sel = [[Selector alloc] initWithMethod:$3
                                    forClass:$2];

      if ([sel selector] == NULL) {
        yyerror("Unknown method call.");
      }

      sym = [[Symbol alloc] initWithData:sel
                                 andName:[sel stringValue]
                                 andType:SymbolSelector];
      $$ = CTREE(MethodCall);
      [$$ setSymbol:sym];
     }
   ;

string
   : STRING {
       $$ = CSYMB($1, make_symbol_name(), SymbolString);
       ISYMB($$);
     }
   ;

%%

/*
 * Make a name for a symbol.
 */
const char *
make_symbol_name(void)
{
  const char *name   = NULL;
  static int  count  = 0;
  char        num[4] = { 0 };

  sprintf(num, "%d", ++count);

  name = malloc(10 * sizeof *name);
  if (name == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  strcpy((char *)name, "strconst");
  strcat((char *)name, num);

  return name;
}

/*
 * Make a name for an immediate value.
 */
const char *
make_immediate_name(void)
{
  const char *name   = NULL;
  static int  count  = 0;
  char        num[4] = { 0 };

  sprintf(num, "%d", ++count);

  name = malloc(10 * sizeof *name);
  if (name == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  strcpy((char *)name, "immedval");
  strcat((char *)name, num);

  return name;
}

/* Grammar.y ends here */
/*
 * Local Variables: ***
 * mode: fundamental ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
