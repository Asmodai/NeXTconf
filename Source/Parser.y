/*
 * Grammar.y  --- Yacc grammar.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
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

#import "String.h"
#import "Symbol.h"
#import "Selector.h"
#import "SymbolTable.h"
#import "PropertyManager.h"
#import "SyntaxTree.h"
#import "IntInstr.h"
#import "Scanner.h"
#import "Utils.h"
#import "ExtErrno.h"
#import "Types.h"

void        errorf(char *fmt, ...);
void        yyerror(char *msg);
const char *make_symbol_name(void);
const char *make_immediate_name(void);
Symbol     *make_method_call(const char *, const char *, BOOL);

extern int yylex();
extern int lineno;

/* We want debugging. */
#define YYDEBUG 100

/* Tell Yacc/bison to be verbose. */
#define YYERROR_VERBOSE

/* Set the `yyparse' parameter. */
#define YYPARSE_PARAM syntree

/* No `yylex' param please. */
#undef YYLEX_PARAM

/* We need locational information. */
#ifdef YYLSP_NEEDED
# undef YYLSP_NEEDED
#endif
#define YYLSP_NEEDED 1

#define YY_DECL      int yylex(YYSTYPE *yylval, YYLTYPE *yylloc)

/*
 * Insert a number into the root symbol table.
 */
#define INUM(__a)                                   \
  [[SymbolTable sharedInstance] insertSymbol:(__a)]

/*
 * Insert an identifier into the root symbol table.
 */
#define IINDENT(__a)                                \
  [[SymbolTable sharedInstance] insertSymbol:(__a)]

/*
 * Insert a symbol into the root symbol table.
 */
#define ISYMB(__a)                                  \
  [[SymbolTable sharedInstance] insertSymbol:(__a)]

/*
 * Create a number symbol.
 */
#define CNUM(__a)                                                  \
  [[Symbol alloc] initWithData:(__a)                               \
                       andName:(const char *)make_immediate_name() \
                       andType:SymbolNumber];

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
#define CTREE(__a, __l)                  \
  [[SyntaxTree alloc] initWithType:(__a) \
                            atLine:(__l)]

/*
 * Create a syntax tree with 1 child node.
 */
#define CTREE1(__a, __b, __l)            \
  [[SyntaxTree alloc] initWithType:(__a) \
                            atLine:(__l) \
                         andChild1:(__b)]

/*
 * Create a syntax tree with 2 child nodes.
 */
#define CTREE2(__a, __b, __c, __l)       \
  [[SyntaxTree alloc] initWithType:(__a) \
                            atLine:(__l) \
                         andChild1:(__b) \
                         andChild2:(__c)]

/*
 * Create a syntax tree with 3 child nodes.
 */
#define CTREE3(__a, __b, __c, __d, __l)  \
  [[SyntaxTree alloc] initWithType:(__a) \
                            atLine:(__l) \
                         andChild1:(__b) \
                         andChild2:(__c) \
                         andChild3:(__d)]

%}

%union {
  char        *str;
  long_t      fixnum;
  float_t     flonum;
  Symbol     *symbol;
  SyntaxTree *tnode;
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
%token CONCAT            "."
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
%token ARITH_ADD         "+"
%token ARITH_SUB         "-"
%token ARITH_MUL         "*"
%token ARITH_DIV         "/"

%token <str>    ID       "identifier"
%token <str>    STRING   "string"
%token <fixnum> INTEGER  "integer"
%token <fixnum> BOOLEAN  "boolean"
%token <flonum> FLOAT    "float"

%type <symbol> identifier
%type <symbol> string
%type <symbol> integer
%type <symbol> float
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
%type <tnode>  arith_expr
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
                { $$ = CTREE2(StmtList, $1, $2, @1.first_line); }
        |       /* Empty */
                { $$ = CTREE(EmptyStmt, @1.first_line); }
        ;

statement:      END_STMT
                { $$ = CTREE(EmptyStmt, @1.first_line); }
        |       include_statement
                { $$ = $1; }
        |       expr END_STMT
                { $$ = CTREE1(ExprStmt, $1, @1.first_line); }
        |       PRINT expr END_STMT
                { $$ = CTREE1(PrintStmt, $2, @1.first_line); }
        |       if_statement
                { $$ = $1; }
        |       for_statement
                { $$ = $1; }
        |       compound_statement
                { $$ = $1; }
        |       error END_STMT
                { $$ = CTREE(ErrorStmt, @1.first_line); }
        ;

include_statement:
                INCLUDE string
                {
                  $$ = CTREE(IncludedFile, @1.first_line);
                  [$$ setSymbol:$2];
                }
        ;

if_statement:   IF OPEN_PAR expr CLOSE_PAR statement %prec LOWER_THAN_ELSE
                { $$ = CTREE2(IfThenStmt, $3, $5, @1.first_line); }
        |       IF OPEN_PAR expr CLOSE_PAR statement ELSE statement
                {
                  if ($7 != nil) {
                    $$ = CTREE3(IfThenElseStmt, $3, $5, $7, @1.first_line);
                  } else {
                    $$ = CTREE2(IfThenStmt, $3, $5, @1.first_line);
                  }
                }
        ;

for_statement:  FOR identifier IN OPEN_PAR expr CLOSE_PAR statement
                {
                  $$ = CTREE2(ForInStmt, $5, $7, @1.first_line);
                  [$$ setSymbol:$2];
                }
        ;

compound_statement:
                BEGIN_CS statement_list END_CS
                { $$ = $2; }
        ;

expr:           equal_expr
                { $$ = $1; }
        ;

equal_expr:     expr EQUAL assign_expr
                { $$ = CTREE2(EqualExpr, $1, $3, @1.first_line); }
        |       expr NEQUAL assign_expr 
                { $$ = CTREE2(NotEqualExpr, $1, $3, @1.first_line); }
        |       assign_expr 
                { $$ = $1; }
        ;

assign_expr:    identifier ASSIGN assign_expr
                {
                  $$ = CTREE1(AssignExpr, $3, @1.first_line);
                  [$$ setSymbol:$1];
                }
        |       arith_expr
                { $$ = $1; }
        ;

arith_expr:     arith_expr ARITH_ADD concat_expr
                { $$ = CTREE2(AddExpr, $1, $3, @1.first_line); }
        |       arith_expr ARITH_SUB concat_expr
                { $$ = CTREE2(SubExpr, $1, $3, @1.first_line); }
        |       arith_expr ARITH_MUL concat_expr
                { $$ = CTREE2(MulExpr, $1, $3, @1.first_line); }
        |       arith_expr ARITH_DIV concat_expr
                { $$ = CTREE2(DivExpr, $1, $3, @1.first_line); }
        |       concat_expr
                { $$ = $1; }
        ;

concat_expr:    concat_expr CONCAT simple_expr
                { $$ = CTREE2(ConcatExpr, $1, $3, @1.first_line); }
        |       logical_and_expr
                { $$ = $1; }
        ;

logical_and_expr:
                logical_or_expr
                { $$ = $1; }
        |       logical_and_expr LOGICAL_AND logical_or_expr
                { $$ = CTREE2(LogicalAndExpr, $1, $3, @1.first_line); }
        ;

logical_or_expr:
                logical_xor_expr
                { $$ = $1; }
        |       logical_or_expr LOGICAL_OR logical_xor_expr
                { $$ = CTREE2(LogicalOrExpr, $1, $3, @1.first_line); }
        ;

logical_xor_expr:
                simple_expr
                { $$ = $1; }
        |       logical_xor_expr LOGICAL_XOR simple_expr
                { $$ = CTREE2(LogicalXorExpr, $1, $3, @1.first_line); }
        ;

simple_expr:    identifier
                { $$ = CTREE(IdentExpr, @1.first_line); [$$ setSymbol:$1]; }
        |       string
                { $$ = CTREE(StringExpr, @1.first_line); [$$ setSymbol:$1]; }
        |       integer
                { $$ = CTREE(NumberExpr, @1.first_line); [$$ setSymbol:$1]; }
        |       float
                { $$ = CTREE(NumberExpr, @1.first_line); [$$ setSymbol:$1]; }
        |       boolean
                { $$ = CTREE(BooleanExpr, @1.first_line); [$$ setSymbol:$1]; }
        |       OPEN_PAR expr CLOSE_PAR
                { $$ = $2; }
        |       method_call
                { $$ = $1; }
        ;

identifier:     ID
                {
                  $$ = [[SymbolTable sharedInstance] valueForSymbol:$1];
                  if ($$ == nil) {
                    $$ = CIDENT($1, SymbolObject);
                    IINDENT($$);
                  }
                }
        ;

integer:        INTEGER
                {
                  Number *num = nil;

                  num = [[Number alloc] initWithInt:(long_t)$1];
                  $$ = CNUM(num);
                  INUM($$);
                }
        ;

float:          FLOAT
                {
                  Number *num = nil;

                  num = [[Number alloc] initWithFloat:(float_t)$1];
                  $$ = CNUM(num);
                  INUM($$);
                }
        ;

boolean:        BOOLEAN
                {
                  extern Symbol *TrueSymbol;
                  extern Symbol *FalseSymbol;

                  if ($1 == YES) {
                    $$ = TrueSymbol;
                  } else {
                    $$ = FalseSymbol;
                  }
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
                  $$ = CTREE(MethodCall, @1.first_line);
                  [$$ setSymbol:make_method_call($2, $3, NO)];
                }
        |       OPEN_METH class_name method_name METH_ARG simple_expr CLOSE_METH
                {
                  $$ = CTREE1(MethodCall, $5, @1.first_line);
                  [$$ setSymbol:make_method_call($2, $3, YES)];
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
 * Create a selector.
 */
Symbol *
make_method_call(const char *aClass,
                 const char *aMethod,
                 BOOL        withArg)
{
  Selector   *sel   = nil;
  Symbol     *sym   = nil;
  String     *meth  = nil;
  const char *name  = NULL;
  String     *msg   = nil;
  int         valid = 0;

  meth = [[String alloc] initWithString:aMethod];

  if (withArg == YES) {
    [meth cat:":"];
  }

  name = strdup([meth stringValue]);
  [meth free];

  sel = [[Selector alloc] initWithMethod:name
                                forClass:aClass];

  if ([sel selector] == NULL) {
    yyerror("Could not create selector!");
  }

  valid = [sel isValid];
  switch (valid) {
    case EXT_ENOCLASS:
      msg = [[String alloc]
              initFromFormat:"Could not find a class named `%s'.",
                             aClass];
      break;

    case EXT_ENOMETH:
      msg = [[String alloc]
              initFromFormat:"Could not find method `%s' for class `%s'.",
                             name,
                             aClass];
      break;

    case EXT_ENORESP:
      msg = [[String alloc]
              initFromFormat:"Class `%s' does not respond to `%s'.",
                             aClass,
                             name];
      break;

    default:
      break;
  }

  if (msg != nil) {
    yyerror((char *)[msg stringValue]);
    [msg free];
  }

  sym = [[Symbol alloc] initWithData:sel
                             andName:[sel stringValue]
                             andType:SymbolSelector];

  return sym;
}

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
 * fill-column: 79 ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
