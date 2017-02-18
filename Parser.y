/*
 * Grammar.y  --- Yacc grammar.
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
#import "Selector.h"
#import "SymbolTable.h"
#import "PropertyManager.h"
#import "SyntaxTree.h"
#import "IntInstr.h"
#import "Scanner.h"
#import "Utils.h"

extern SymbolTable *root_symtab;

void        errorf(char *fmt, ...);
void        yyerror(char *msg);
const char *make_symbol_name(void);
const char *make_immediate_name(void);

extern int yylex();

/* We want debugging. */
#define YYDEBUG 100

/* Tell Yacc/bison to be verbose. */
#define YYERROR_VERBOSE

/* Set the `yyparse' parameter. */
#define YYPARSE_PARAM syntree

/* No `yylex' param please. */
#undef YYLEX_PARAM

/* Nor do we need textual location. */
#undef YYLSP_NEEDED

#ifndef YYLTYPE
# define YYLTYPE yyltype
#endif

#define YY_DECL      int yylex(YYSTYPE *yylval)

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
%token IF                "if"
%token ELSE              "else"
%token FOR               "for"
%token IN                "in"
%token PRINT             "print"
%token INCLUDE           "include"
%token ASSIGN            "="
%token EQUAL             "=="
%token NEQUAL            "!="
%token CONCAT            "+"
%token LOGICAL_AND       "and"
%token LOGICAL_OR        "or"
%token LOGICAL_XOR       "xor"
%token END_STMT          ";"
%token OPEN_PAR          "("
%token CLOSE_PAR         ")"
%token OPEN_METH         "["
%token CLOSE_METH        "]"
%token METH_ARG          ":"
%token BEGIN_CS          "{"
%token END_CS            "}"

%token <str>    ID       "identifier"
%token <str>    STRING   "string"
%token <fixnum> INTEGER  "integer"
%token <fixnum> BOOLEAN  "boolean"

%type <symbol> identifier
%type <symbol> string
%type <symbol> integer
%type <symbol> boolean
%type <str>    class_name
%type <str>    method_name
%type <tnode>  program
%type <tnode>  statement_list
%type <tnode>  statement
%type <tnode>  include_statement
%type <tnode>  if_statement
%type <tnode>  compound_statement
%type <tnode>  for_statement
%type <tnode>  expr
%type <tnode>  equal_expr
%type <tnode>  assign_expr
%type <tnode>  concat_expr
%type <tnode>  simple_expr
%type <tnode>  method_call
%type <tnode>  logical_and_expr
%type <tnode>  logical_or_expr
%type <tnode>  logical_xor_expr

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%expect 1

%pure_parser

%%

program:        statement_list 
                {
                  register SyntaxTree *root   = (SyntaxTree *)syntree;
                  register SyntaxTree *parsed = (SyntaxTree *)$1; 

                  *root = *parsed;
                }
        ;

statement_list: statement statement_list
                { $$ = CTREE2(StmtList, $1, $2); }
        |       /* Empty */
                { $$ = CTREE(EmptyStmt); }
        ;

statement:      END_STMT
                { $$ = CTREE(EmptyStmt); }
        |       include_statement
                { $$ = $1; }
        |       expr END_STMT
                { $$ = CTREE1(ExprStmt, $1); }
        |       PRINT expr END_STMT
                { $$ = CTREE1(PrintStmt, $2); }
        |       if_statement
                { $$ = $1; }
        |       for_statement
                { $$ = $1; }
        |       compound_statement
                { $$ = $1; }
        |       error END_STMT
                { $$ = CTREE(ErrorStmt); }
        ;

include_statement:
                INCLUDE string
                { $$ = CTREE(IncludedFile); [$$ setSymbol:$2]; }
        ;

if_statement:   IF OPEN_PAR expr CLOSE_PAR statement %prec LOWER_THAN_ELSE
                { $$ = CTREE2(IfThenStmt, $3, $5); }
        |       IF OPEN_PAR expr CLOSE_PAR statement ELSE statement
                {
                  if ($7 != nil) {
                    $$ = CTREE3(IfThenElseStmt, $3, $5, $7);
                  } else {
                    $$ = CTREE2(IfThenStmt, $3, $5);
                  }
                }
        ;

for_statement:  FOR identifier IN OPEN_PAR expr CLOSE_PAR statement
                { $$ = CTREE2(ForInStmt, $5, $7); [$$ setSymbol:$2]; }
        ;

compound_statement:
                BEGIN_CS statement_list END_CS
                { $$ = $2; }
        ;

expr:           equal_expr
                { $$ = $1; }
        ;

equal_expr:     expr EQUAL assign_expr
                { $$ = CTREE2(EqualExpr, $1, $3); }
        |       expr NEQUAL assign_expr 
                { $$ = CTREE2(NotEqualExpr, $1, $3); }
        |       assign_expr 
                { $$ = $1; }
        ;

assign_expr:    identifier ASSIGN assign_expr
                { $$ = CTREE1(AssignExpr, $3); [$$ setSymbol:$1]; }
        |       concat_expr
                { $$ = $1; }
        ;

concat_expr:    concat_expr CONCAT simple_expr
                { $$ = CTREE2(ConcatExpr, $1, $3); }
        |       logical_and_expr
                { $$ = $1; }
        ;

logical_and_expr:
                logical_or_expr
                { $$ = $1; }
        |       logical_and_expr LOGICAL_AND logical_or_expr
                { $$ = CTREE2(LogicalAndExpr, $1, $3); }
        ;

logical_or_expr:
                logical_xor_expr
                { $$ = $1; }
        |       logical_or_expr LOGICAL_OR logical_xor_expr
                { $$ = CTREE2(LogicalOrExpr, $1, $3); }
        ;

logical_xor_expr:
                simple_expr
                { $$ = $1; }
        |       logical_xor_expr LOGICAL_XOR simple_expr
                { $$ = CTREE2(LogicalXorExpr, $1, $3); }
        ;

simple_expr:    identifier
                { $$ = CTREE(IdentExpr); [$$ setSymbol:$1]; }
        |       string
                { $$ = CTREE(StringExpr); [$$ setSymbol:$1]; }
        |       integer
                { $$ = CTREE(IntegerExpr); [$$ setSymbol:$1]; }
        |       boolean
                { $$ = CTREE(BooleanExpr); [$$ setSymbol:$1]; }
        |       OPEN_PAR expr CLOSE_PAR
                { $$ = $2; }
        |       method_call
                { $$ = $1; }
        ;

identifier:     ID
                {
                  $$ = [root_symtab valueForSymbol:$1];
                  if ($$ == nil) {
                    $$ = CIDENT($1, SymbolObject);
                    IINDENT($$);
                  }
                }
        ;

integer:        INTEGER
                {
                  Number *num = nil;

                  num = [[Number alloc] initWithInt:$1];
                  $$ = CINT(num);
                  IINT($$);
                }
        ;

boolean:        BOOLEAN
                {
                  Boolean *bool = nil;

                  bool = [[Boolean alloc] initWithInt:$1];
                  $$ = CBOOL(bool);
                  IBOOL($$);
                }
        ;

class_name:     ID
                { $$ = $1; }
        ;

method_name:    ID
                { $$ = $1; }
        ;

method_call:    OPEN_METH class_name method_name CLOSE_METH
                {
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
        |       OPEN_METH class_name method_name METH_ARG simple_expr CLOSE_METH
                {
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
                  $$ = CTREE1(MethodCall, $5);
                  [$$ setSymbol:sym];
                }
        ;

string:         STRING
                {
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

  name = xmalloc(10 * sizeof *name);

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

  name = xmalloc(10 * sizeof *name);

  strcpy((char *)name, "immedval");
  strcat((char *)name, num);

  return name;
}

/* Grammar.y ends here */
/*
 * Local Variables: ***
 * mode: bison ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
