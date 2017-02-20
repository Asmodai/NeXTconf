
/*  A Bison parser, made from Parser.y
 by  GNU Bison version 1.25
  */

#define YYBISON 1  /* Identify Bison output.  */

#define YYLSP_NEEDED

#define	ERROR_TOKEN	258
#define	IF	259
#define	ELSE	260
#define	FOR	261
#define	IN	262
#define	PRINT	263
#define	INCLUDE	264
#define	ASSIGN	265
#define	EQUAL	266
#define	NEQUAL	267
#define	CONCAT	268
#define	LOGICAL_AND	269
#define	LOGICAL_OR	270
#define	LOGICAL_XOR	271
#define	END_STMT	272
#define	OPEN_PAR	273
#define	CLOSE_PAR	274
#define	OPEN_METH	275
#define	CLOSE_METH	276
#define	METH_ARG	277
#define	BEGIN_CS	278
#define	END_CS	279
#define	ARITH_ADD	280
#define	ARITH_SUB	281
#define	ARITH_MUL	282
#define	ARITH_DIV	283
#define	ID	284
#define	STRING	285
#define	INTEGER	286
#define	BOOLEAN	287
#define	FLOAT	288
#define	LOWER_THAN_ELSE	289

#line 28 "Parser.y"


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

extern SymbolTable *root_symtab;

void        errorf(char *fmt, ...);
void        yyerror(char *msg);
const char *make_symbol_name(void);
const char *make_immediate_name(void);
Symbol     *make_method_call(const char *, const char *, BOOL);

extern int yylex();

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
#define INUM(__a)                   \
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
 * Create a number symbol.
 */
#define CNUM(__a)                                                  \
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


#line 172 "Parser.y"
typedef union {
  char        *str;
  long_t      fixnum;
  float_t     flonum;
  Symbol     *symbol;
  SyntaxTree *tnode;
} YYSTYPE;

#ifndef YYLTYPE
typedef
  struct yyltype
    {
      int timestamp;
      int first_line;
      int first_column;
      int last_line;
      int last_column;
      char *text;
   }
  yyltype;

#define YYLTYPE yyltype
#endif

#include <stdio.h>

#ifndef __cplusplus
#ifndef __STDC__
#define const
#endif
#endif



#define	YYFINAL		91
#define	YYFLAG		-32768
#define	YYNTBASE	35

#define YYTRANSLATE(x) ((unsigned)(x) <= 289 ? yytranslate[x] : 59)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     2,     3,     4,     5,
     6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
    16,    17,    18,    19,    20,    21,    22,    23,    24,    25,
    26,    27,    28,    29,    30,    31,    32,    33,    34
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     2,     5,     6,     8,    10,    13,    17,    19,    21,
    23,    26,    29,    35,    43,    51,    55,    57,    61,    65,
    67,    71,    73,    77,    81,    85,    89,    91,    95,    97,
    99,   103,   105,   109,   111,   115,   117,   119,   121,   123,
   125,   129,   131,   133,   135,   137,   139,   141,   143,   148,
   155
};

static const short yyrhs[] = {    36,
     0,    37,    36,     0,     0,    17,     0,    38,     0,    42,
    17,     0,     8,    42,    17,     0,    39,     0,    40,     0,
    41,     0,     1,    17,     0,     9,    58,     0,     4,    18,
    42,    19,    37,     0,     4,    18,    42,    19,    37,     5,
    37,     0,     6,    51,     7,    18,    42,    19,    37,     0,
    23,    36,    24,     0,    43,     0,    42,    11,    44,     0,
    42,    12,    44,     0,    44,     0,    51,    10,    44,     0,
    45,     0,    45,    25,    46,     0,    45,    26,    46,     0,
    45,    27,    46,     0,    45,    28,    46,     0,    46,     0,
    46,    13,    50,     0,    47,     0,    48,     0,    47,    14,
    48,     0,    49,     0,    48,    15,    49,     0,    50,     0,
    49,    16,    50,     0,    51,     0,    58,     0,    52,     0,
    53,     0,    54,     0,    18,    42,    19,     0,    57,     0,
    29,     0,    31,     0,    33,     0,    32,     0,    29,     0,
    29,     0,    20,    55,    56,    21,     0,    20,    55,    56,
    22,    50,    21,     0,    30,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   247,   256,   258,   262,   264,   266,   268,   270,   272,   274,
   276,   280,   288,   290,   300,   307,   312,   316,   318,   320,
   324,   329,   333,   335,   337,   339,   341,   345,   347,   351,
   354,   358,   361,   365,   368,   372,   374,   376,   378,   380,
   382,   384,   388,   398,   408,   418,   428,   432,   436,   441,
   448
};
#endif


#if YYDEBUG != 0 || defined (YYERROR_VERBOSE)

static const char * const yytname[] = {   "$","error","$undefined.","ERROR_TOKEN",
"\"if\"","\"else\"","\"for\"","\"in\"","\"print\"","\"include\"","\"=\"","\"==\"",
"\"!=\"","\".\"","\"and\"","\"or\"","\"xor\"","\";\"","\"(\"","\")\"","\"[\"",
"\"]\"","\":\"","\"{\"","\"}\"","\"+\"","\"-\"","\"*\"","\"/\"","\"identifier\"",
"\"string\"","\"integer\"","\"boolean\"","\"float\"","LOWER_THAN_ELSE","program",
"statement_list","statement","include_statement","if_statement","for_statement",
"compound_statement","expr","equal_expr","assign_expr","arith_expr","concat_expr",
"logical_and_expr","logical_or_expr","logical_xor_expr","simple_expr","identifier",
"integer","float","boolean","class_name","method_name","method_call","string", NULL
};
#endif

static const short yyr1[] = {     0,
    35,    36,    36,    37,    37,    37,    37,    37,    37,    37,
    37,    38,    39,    39,    40,    41,    42,    43,    43,    43,
    44,    44,    45,    45,    45,    45,    45,    46,    46,    47,
    47,    48,    48,    49,    49,    50,    50,    50,    50,    50,
    50,    50,    51,    52,    53,    54,    55,    56,    57,    57,
    58
};

static const short yyr2[] = {     0,
     1,     2,     0,     1,     1,     2,     3,     1,     1,     1,
     2,     2,     5,     7,     7,     3,     1,     3,     3,     1,
     3,     1,     3,     3,     3,     3,     1,     3,     1,     1,
     3,     1,     3,     1,     3,     1,     1,     1,     1,     1,
     3,     1,     1,     1,     1,     1,     1,     1,     4,     6,
     1
};

static const short yydefact[] = {     0,
     0,     0,     0,     0,     0,     4,     0,     0,     0,    43,
    51,    44,    46,    45,     1,     0,     5,     8,     9,    10,
     0,    17,    20,    22,    27,    29,    30,    32,    34,    36,
    38,    39,    40,    42,    37,    11,     0,     0,     0,    12,
     0,    47,     0,     0,     2,     0,     0,     6,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,     7,
    41,    48,     0,    16,    18,    19,    23,    36,    24,    25,
    26,    28,    31,    33,    35,    21,     0,     0,    49,     0,
    13,     0,     0,     0,     0,    50,    14,    15,     0,     0,
     0
};

static const short yydefgoto[] = {    89,
    15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
    25,    26,    27,    28,    29,    30,    31,    32,    33,    43,
    63,    34,    35
};

static const short yypact[] = {    55,
   -14,   -12,   -15,    50,    -4,-32768,    50,    25,    88,-32768,
-32768,-32768,-32768,-32768,-32768,     7,-32768,-32768,-32768,-32768,
     6,-32768,-32768,    17,    19,    48,    54,    44,-32768,    61,
-32768,-32768,-32768,-32768,-32768,-32768,    50,    67,    90,-32768,
    10,-32768,    66,    69,-32768,    50,    50,-32768,    50,    50,
    50,    50,    50,    50,    50,    50,    50,    22,    72,-32768,
-32768,-32768,    45,-32768,-32768,-32768,    19,-32768,    19,    19,
    19,-32768,    54,    44,-32768,-32768,   121,    50,-32768,    50,
    95,    46,    82,   121,   121,-32768,-32768,-32768,   104,   109,
-32768
};

static const short yypgoto[] = {-32768,
     3,    14,-32768,-32768,-32768,-32768,    -2,-32768,   -37,-32768,
    64,-32768,    56,    68,   -52,    -3,-32768,-32768,-32768,-32768,
-32768,-32768,   119
};


#define	YYLAST		154


static const short yytable[] = {    38,
    72,    39,    36,    75,    41,    37,    -3,     1,    65,    66,
     2,    44,     3,    10,     4,     5,    46,    47,    45,    76,
    46,    47,    48,     6,     7,    11,     8,    83,    61,     9,
    -3,    53,    46,    47,    58,    10,    11,    12,    13,    14,
    77,    49,    50,    51,    52,    68,    68,    68,    68,    68,
    68,    68,    68,    42,    -3,     1,    46,    47,     2,    56,
     3,    54,     4,     5,    85,    79,    80,     7,    55,     8,
    57,     6,     7,    59,     8,    82,    68,     9,    10,    11,
    12,    13,    14,    10,    11,    12,    13,    14,     1,    78,
    81,     2,    64,     3,    62,     4,     5,    87,    88,    84,
    46,    47,    86,    90,     6,     7,    60,     8,    91,    73,
     9,    -3,    67,    69,    70,    71,    10,    11,    12,    13,
    14,     1,    74,    40,     2,     0,     3,     0,     4,     5,
     0,     0,     0,     0,     0,     0,     0,     6,     7,     0,
     8,     0,     0,     9,     0,     0,     0,     0,     0,    10,
    11,    12,    13,    14
};

static const short yycheck[] = {     3,
    53,     4,    17,    56,     7,    18,     0,     1,    46,    47,
     4,     9,     6,    29,     8,     9,    11,    12,    16,    57,
    11,    12,    17,    17,    18,    30,    20,    80,    19,    23,
    24,    13,    11,    12,    37,    29,    30,    31,    32,    33,
    19,    25,    26,    27,    28,    49,    50,    51,    52,    53,
    54,    55,    56,    29,     0,     1,    11,    12,     4,    16,
     6,    14,     8,     9,    19,    21,    22,    18,    15,    20,
    10,    17,    18,     7,    20,    78,    80,    23,    29,    30,
    31,    32,    33,    29,    30,    31,    32,    33,     1,    18,
    77,     4,    24,     6,    29,     8,     9,    84,    85,     5,
    11,    12,    21,     0,    17,    18,    17,    20,     0,    54,
    23,    24,    49,    50,    51,    52,    29,    30,    31,    32,
    33,     1,    55,     5,     4,    -1,     6,    -1,     8,     9,
    -1,    -1,    -1,    -1,    -1,    -1,    -1,    17,    18,    -1,
    20,    -1,    -1,    23,    -1,    -1,    -1,    -1,    -1,    29,
    30,    31,    32,    33
};
#define YYPURE 1

/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "/usr/local/share/bison.simple"

/* Skeleton output parser for bison,
   Copyright (C) 1984, 1989, 1990 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

#ifndef alloca
#ifdef __GNUC__
#define alloca __builtin_alloca
#else /* not GNU C.  */
#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi)
#include <alloca.h>
#else /* not sparc */
#if defined (MSDOS) && !defined (__TURBOC__)
#include <malloc.h>
#else /* not MSDOS, or __TURBOC__ */
#if defined(_AIX)
#include <malloc.h>
 #pragma alloca
#else /* not MSDOS, __TURBOC__, or _AIX */
#ifdef __hpux
#ifdef __cplusplus
extern "C" {
void *alloca (unsigned int);
};
#else /* not __cplusplus */
void *alloca ();
#endif /* not __cplusplus */
#endif /* __hpux */
#endif /* not _AIX */
#endif /* not MSDOS, or __TURBOC__ */
#endif /* not sparc.  */
#endif /* not GNU C.  */
#endif /* alloca not defined.  */

/* This is the parser code that is written into each bison parser
  when the %semantic_parser declaration is not specified in the grammar.
  It was written by Richard Stallman by simplifying the hairy parser
  used when %semantic_parser is specified.  */

/* Note: there must be only one dollar sign in this file.
   It is replaced by the list of actions, each action
   as one case of the switch.  */

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	return(0)
#define YYABORT 	return(1)
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.
   This remains here temporarily to ease the
   transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(token, value) \
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    { yychar = (token), yylval = (value);			\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { yyerror ("syntax error: cannot back up"); YYERROR; }	\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

#ifndef YYPURE
#define YYLEX		yylex()
#endif

#ifdef YYPURE
#ifdef YYLSP_NEEDED
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, &yylloc, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval, &yylloc)
#endif
#else /* not YYLSP_NEEDED */
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval)
#endif
#endif /* not YYLSP_NEEDED */
#endif

/* If nonreentrant, generate the variables here */

#ifndef YYPURE

int	yychar;			/*  the lookahead symbol		*/
YYSTYPE	yylval;			/*  the semantic value of the		*/
				/*  lookahead symbol			*/

#ifdef YYLSP_NEEDED
YYLTYPE yylloc;			/*  location data for the lookahead	*/
				/*  symbol				*/
#endif

int yynerrs;			/*  number of parse errors so far       */
#endif  /* not YYPURE */

#if YYDEBUG != 0
int yydebug;			/*  nonzero means print parse trace	*/
/* Since this is uninitialized, it does not stop multiple parsers
   from coexisting.  */
#endif

/*  YYINITDEPTH indicates the initial size of the parser's stacks	*/

#ifndef	YYINITDEPTH
#define YYINITDEPTH 200
#endif

/*  YYMAXDEPTH is the maximum size the stacks can grow to
    (effective only if the built-in stack extension method is used).  */

#if YYMAXDEPTH == 0
#undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
#define YYMAXDEPTH 10000
#endif

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
/*int yyparse (void);*/
#endif

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(TO,FROM,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (to, from, count)
     char *to;
     char *from;
     int count;
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#else /* __cplusplus */

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (char *to, char *from, int count)
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 196 "/usr/local/share/bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#ifdef __cplusplus
#define YYPARSE_PARAM_ARG void *YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#else /* not __cplusplus */
#define YYPARSE_PARAM_ARG YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#endif /* not __cplusplus */
#else /* not YYPARSE_PARAM */
#define YYPARSE_PARAM_ARG
#define YYPARSE_PARAM_DECL
#endif /* not YYPARSE_PARAM */

int
yyparse(YYPARSE_PARAM_ARG)
     YYPARSE_PARAM_DECL
{
  register int yystate;
  register int yyn;
  register short *yyssp;
  register YYSTYPE *yyvsp;
  int yyerrstatus;	/*  number of tokens to shift before error messages enabled */
  int yychar1 = 0;		/*  lookahead token as an internal (translated) token number */

  short	yyssa[YYINITDEPTH];	/*  the state stack			*/
  YYSTYPE yyvsa[YYINITDEPTH];	/*  the semantic value stack		*/

  short *yyss = yyssa;		/*  refer to the stacks thru separate pointers */
  YYSTYPE *yyvs = yyvsa;	/*  to allow yyoverflow to reallocate them elsewhere */

#ifdef YYLSP_NEEDED
  YYLTYPE yylsa[YYINITDEPTH];	/*  the location stack			*/
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;

#define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
#define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  int yystacksize = YYINITDEPTH;

#ifdef YYPURE
  int yychar;
  YYSTYPE yylval;
  int yynerrs;
#ifdef YYLSP_NEEDED
  YYLTYPE yylloc;
#endif
#endif

  YYSTYPE yyval;		/*  the variable used to return		*/
				/*  semantic values from the action	*/
				/*  routines				*/

  int yylen;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Starting parse\n");
#endif

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss - 1;
  yyvsp = yyvs;
#ifdef YYLSP_NEEDED
  yylsp = yyls;
#endif

/* Push a new state, which is found in  yystate  .  */
/* In all cases, when you get here, the value and location stacks
   have just been pushed. so pushing a state here evens the stacks.  */
yynewstate:

  *++yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Give user a chance to reallocate the stack */
      /* Use copies of these so that the &'s don't force the real ones into memory. */
      YYSTYPE *yyvs1 = yyvs;
      short *yyss1 = yyss;
#ifdef YYLSP_NEEDED
      YYLTYPE *yyls1 = yyls;
#endif

      /* Get the current used size of the three stacks, in elements.  */
      int size = yyssp - yyss + 1;

#ifdef yyoverflow
      /* Each stack pointer address is followed by the size of
	 the data in use in that stack, in bytes.  */
#ifdef YYLSP_NEEDED
      /* This used to be a conditional around just the two extra args,
	 but that might be undefined if yyoverflow is a macro.  */
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yyls1, size * sizeof (*yylsp),
		 &yystacksize);
#else
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yystacksize);
#endif

      yyss = yyss1; yyvs = yyvs1;
#ifdef YYLSP_NEEDED
      yyls = yyls1;
#endif
#else /* no yyoverflow */
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	{
	  yyerror("parser stack overflow");
	  return 2;
	}
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;
      yyss = (short *) alloca (yystacksize * sizeof (*yyssp));
      __yy_memcpy ((char *)yyss, (char *)yyss1, size * sizeof (*yyssp));
      yyvs = (YYSTYPE *) alloca (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs, (char *)yyvs1, size * sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) alloca (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls, (char *)yyls1, size * sizeof (*yylsp));
#endif
#endif /* no yyoverflow */

      yyssp = yyss + size - 1;
      yyvsp = yyvs + size - 1;
#ifdef YYLSP_NEEDED
      yylsp = yyls + size - 1;
#endif

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Stack size increased to %d\n", yystacksize);
#endif

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Entering state %d\n", yystate);
#endif

  goto yybackup;
 yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Reading a token: ");
#endif
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Now at end of input.\n");
#endif
    }
  else
    {
      yychar1 = YYTRANSLATE(yychar);

#if YYDEBUG != 0
      if (yydebug)
	{
	  fprintf (stderr, "Next token is %d (%s", yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise meaning
	     of a token, for further debugging info.  */
#ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
#endif
	  fprintf (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting token %d (%s), ", yychar, yytname[yychar1]);
#endif

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* count tokens shifted since error; after three, turn off error status.  */
  if (yyerrstatus) yyerrstatus--;

  yystate = yyn;
  goto yynewstate;

/* Do the default action for the current state.  */
yydefault:

  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;

/* Do a reduction.  yyn is the number of a rule to reduce with.  */
yyreduce:
  yylen = yyr2[yyn];
  if (yylen > 0)
    yyval = yyvsp[1-yylen]; /* implement default value of the action */

#if YYDEBUG != 0
  if (yydebug)
    {
      int i;

      fprintf (stderr, "Reducing via rule %d (line %d), ",
	       yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (i = yyprhs[yyn]; yyrhs[i] > 0; i++)
	fprintf (stderr, "%s ", yytname[yyrhs[i]]);
      fprintf (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif


  switch (yyn) {

case 1:
#line 248 "Parser.y"
{
                  register SyntaxTree *root   = (SyntaxTree *)syntree;
                  register SyntaxTree *parsed = (SyntaxTree *)yyvsp[0].tnode; 

                  *root = *parsed;
                ;
    break;}
case 2:
#line 257 "Parser.y"
{ yyval.tnode = CTREE2(StmtList, yyvsp[-1].tnode, yyvsp[0].tnode, yylsp[-1].first_line); ;
    break;}
case 3:
#line 259 "Parser.y"
{ yyval.tnode = CTREE(EmptyStmt, yylsp[1].first_line); ;
    break;}
case 4:
#line 263 "Parser.y"
{ yyval.tnode = CTREE(EmptyStmt, yylsp[0].first_line); ;
    break;}
case 5:
#line 265 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 6:
#line 267 "Parser.y"
{ yyval.tnode = CTREE1(ExprStmt, yyvsp[-1].tnode, yylsp[-1].first_line); ;
    break;}
case 7:
#line 269 "Parser.y"
{ yyval.tnode = CTREE1(PrintStmt, yyvsp[-1].tnode, yylsp[-2].first_line); ;
    break;}
case 8:
#line 271 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 9:
#line 273 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 10:
#line 275 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 11:
#line 277 "Parser.y"
{ yyval.tnode = CTREE(ErrorStmt, yylsp[-1].first_line); ;
    break;}
case 12:
#line 282 "Parser.y"
{
                  yyval.tnode = CTREE(IncludedFile, yylsp[-1].first_line);
                  [yyval.tnode setSymbol:yyvsp[0].symbol];
                ;
    break;}
case 13:
#line 289 "Parser.y"
{ yyval.tnode = CTREE2(IfThenStmt, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-4].first_line); ;
    break;}
case 14:
#line 291 "Parser.y"
{
                  if (yyvsp[0].tnode != nil) {
                    yyval.tnode = CTREE3(IfThenElseStmt, yyvsp[-4].tnode, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-6].first_line);
                  } else {
                    yyval.tnode = CTREE2(IfThenStmt, yyvsp[-4].tnode, yyvsp[-2].tnode, yylsp[-6].first_line);
                  }
                ;
    break;}
case 15:
#line 301 "Parser.y"
{
                  yyval.tnode = CTREE2(ForInStmt, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-6].first_line);
                  [yyval.tnode setSymbol:yyvsp[-5].symbol];
                ;
    break;}
case 16:
#line 309 "Parser.y"
{ yyval.tnode = yyvsp[-1].tnode; ;
    break;}
case 17:
#line 313 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 18:
#line 317 "Parser.y"
{ yyval.tnode = CTREE2(EqualExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 19:
#line 319 "Parser.y"
{ yyval.tnode = CTREE2(NotEqualExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 20:
#line 321 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 21:
#line 325 "Parser.y"
{
                  yyval.tnode = CTREE1(AssignExpr, yyvsp[0].tnode, yylsp[-2].first_line);
                  [yyval.tnode setSymbol:yyvsp[-2].symbol];
                ;
    break;}
case 22:
#line 330 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 23:
#line 334 "Parser.y"
{ yyval.tnode = CTREE2(AddExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 24:
#line 336 "Parser.y"
{ yyval.tnode = CTREE2(SubExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 25:
#line 338 "Parser.y"
{ yyval.tnode = CTREE2(MulExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 26:
#line 340 "Parser.y"
{ yyval.tnode = CTREE2(DivExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 27:
#line 342 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 28:
#line 346 "Parser.y"
{ yyval.tnode = CTREE2(ConcatExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 29:
#line 348 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 30:
#line 353 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 31:
#line 355 "Parser.y"
{ yyval.tnode = CTREE2(LogicalAndExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 32:
#line 360 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 33:
#line 362 "Parser.y"
{ yyval.tnode = CTREE2(LogicalOrExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 34:
#line 367 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 35:
#line 369 "Parser.y"
{ yyval.tnode = CTREE2(LogicalXorExpr, yyvsp[-2].tnode, yyvsp[0].tnode, yylsp[-2].first_line); ;
    break;}
case 36:
#line 373 "Parser.y"
{ yyval.tnode = CTREE(IdentExpr, yylsp[0].first_line); [yyval.tnode setSymbol:yyvsp[0].symbol]; ;
    break;}
case 37:
#line 375 "Parser.y"
{ yyval.tnode = CTREE(StringExpr, yylsp[0].first_line); [yyval.tnode setSymbol:yyvsp[0].symbol]; ;
    break;}
case 38:
#line 377 "Parser.y"
{ yyval.tnode = CTREE(NumberExpr, yylsp[0].first_line); [yyval.tnode setSymbol:yyvsp[0].symbol]; ;
    break;}
case 39:
#line 379 "Parser.y"
{ yyval.tnode = CTREE(NumberExpr, yylsp[0].first_line); [yyval.tnode setSymbol:yyvsp[0].symbol]; ;
    break;}
case 40:
#line 381 "Parser.y"
{ yyval.tnode = CTREE(BooleanExpr, yylsp[0].first_line); [yyval.tnode setSymbol:yyvsp[0].symbol]; ;
    break;}
case 41:
#line 383 "Parser.y"
{ yyval.tnode = yyvsp[-1].tnode; ;
    break;}
case 42:
#line 385 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 43:
#line 389 "Parser.y"
{
                  yyval.symbol = [root_symtab valueForSymbol:yyvsp[0].str];
                  if (yyval.symbol == nil) {
                    yyval.symbol = CIDENT(yyvsp[0].str, SymbolObject);
                    IINDENT(yyval.symbol);
                  }
                ;
    break;}
case 44:
#line 399 "Parser.y"
{
                  Number *num = nil;

                  num = [[Number alloc] initWithInt:(long_t)yyvsp[0].fixnum];
                  yyval.symbol = CNUM(num);
                  INUM(yyval.symbol);
                ;
    break;}
case 45:
#line 409 "Parser.y"
{
                  Number *num = nil;

                  num = [[Number alloc] initWithFloat:(float_t)yyvsp[0].flonum];
                  yyval.symbol = CNUM(num);
                  INUM(yyval.symbol);
                ;
    break;}
case 46:
#line 419 "Parser.y"
{
                  Boolean *bool = nil;

                  bool = [[Boolean alloc] initWithInt:yyvsp[0].fixnum];
                  yyval.symbol = CBOOL(bool);
                  IBOOL(yyval.symbol);
                ;
    break;}
case 47:
#line 429 "Parser.y"
{ yyval.str = yyvsp[0].str; ;
    break;}
case 48:
#line 433 "Parser.y"
{ yyval.str = yyvsp[0].str; ;
    break;}
case 49:
#line 437 "Parser.y"
{
                  yyval.tnode = CTREE(MethodCall, yylsp[-3].first_line);
                  [yyval.tnode setSymbol:make_method_call(yyvsp[-2].str, yyvsp[-1].str, NO)];
                ;
    break;}
case 50:
#line 442 "Parser.y"
{
                  yyval.tnode = CTREE1(MethodCall, yyvsp[-1].tnode, yylsp[-5].first_line);
                  [yyval.tnode setSymbol:make_method_call(yyvsp[-4].str, yyvsp[-3].str, YES)];
                ;
    break;}
case 51:
#line 449 "Parser.y"
{
                  yyval.symbol = CSYMB(yyvsp[0].str, make_symbol_name(), SymbolString);
                  ISYMB(yyval.symbol);
                ;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 498 "/usr/local/share/bison.simple"

  yyvsp -= yylen;
  yyssp -= yylen;
#ifdef YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;

#ifdef YYLSP_NEEDED
  yylsp++;
  if (yylen == 0)
    {
      yylsp->first_line = yylloc.first_line;
      yylsp->first_column = yylloc.first_column;
      yylsp->last_line = (yylsp-1)->last_line;
      yylsp->last_column = (yylsp-1)->last_column;
      yylsp->text = 0;
    }
  else
    {
      yylsp->last_line = (yylsp+yylen-1)->last_line;
      yylsp->last_column = (yylsp+yylen-1)->last_column;
    }
#endif

  /* Now "shift" the result of the reduction.
     Determine what state that goes to,
     based on the state we popped back to
     and the rule number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;

yyerrlab:   /* here on detecting error */

  if (! yyerrstatus)
    /* If not already recovering from an error, report this error.  */
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  int size = 0;
	  char *msg;
	  int x, count;

	  count = 0;
	  /* Start X at -yyn if nec to avoid negative indexes in yycheck.  */
	  for (x = (yyn < 0 ? -yyn : 0);
	       x < (sizeof(yytname) / sizeof(char *)); x++)
	    if (yycheck[x + yyn] == x)
	      size += strlen(yytname[x]) + 15, count++;
	  msg = (char *) malloc(size + 15);
	  if (msg != 0)
	    {
	      strcpy(msg, "parse error");

	      if (count < 5)
		{
		  count = 0;
		  for (x = (yyn < 0 ? -yyn : 0);
		       x < (sizeof(yytname) / sizeof(char *)); x++)
		    if (yycheck[x + yyn] == x)
		      {
			strcat(msg, count == 0 ? ", expecting `" : " or `");
			strcat(msg, yytname[x]);
			strcat(msg, "'");
			count++;
		      }
		}
	      yyerror(msg);
	      free(msg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exceeded");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror("parse error");
    }

  goto yyerrlab1;
yyerrlab1:   /* here on error raised explicitly by an action */

  if (yyerrstatus == 3)
    {
      /* if just tried and failed to reuse lookahead token after an error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Discarding token %d (%s).\n", yychar, yytname[yychar1]);
#endif

      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token
     after shifting the error token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;

yyerrdefault:  /* current state does not do anything special for the error token. */

#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */
  yyn = yydefact[yystate];  /* If its default is to accept any token, ok.  Otherwise pop it.*/
  if (yyn) goto yydefault;
#endif

yyerrpop:   /* pop the current state because it cannot handle the error token */

  if (yyssp == yyss) YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#ifdef YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "Error: state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

yyerrhandle:

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting error token, ");
#endif

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;
}
#line 455 "Parser.y"


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
