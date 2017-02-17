
/*  A Bison parser, made from Parser.y with Bison version GNU Bison version 1.24
  */

#define YYBISON 1  /* Identify Bison output.  */

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
#define	LOGICAL_NOT	272
#define	END_STMT	273
#define	OPEN_PAR	274
#define	CLOSE_PAR	275
#define	OPEN_METH	276
#define	CLOSE_METH	277
#define	METH_ARG	278
#define	BEGIN_CS	279
#define	END_CS	280
#define	ID	281
#define	STRING	282
#define	INTEGER	283
#define	BOOLEAN	284
#define	LOWER_THAN_ELSE	285

#line 27 "Parser.y"


#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>
#import <libc.h>
#import <string.h>
#import <errno.h>

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


#line 163 "Parser.y"
typedef union {
  char          *str;
  unsigned long  fixnum;
  Symbol        *symbol;
  SyntaxTree    *tnode;
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



#define	YYFINAL		80
#define	YYFLAG		-32768
#define	YYNTBASE	31

#define YYTRANSLATE(x) ((unsigned)(x) <= 285 ? yytranslate[x] : 53)

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
    26,    27,    28,    29,    30
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     2,     5,     6,     8,    10,    13,    17,    19,    21,
    23,    26,    29,    35,    43,    51,    55,    57,    61,    65,
    67,    71,    73,    77,    79,    81,    85,    87,    91,    93,
    97,    99,   101,   103,   105,   109,   111,   113,   115,   117,
   119,   121,   126,   133
};

static const short yyrhs[] = {    32,
     0,    33,    32,     0,     0,    18,     0,    34,     0,    38,
    18,     0,     8,    38,    18,     0,    35,     0,    36,     0,
    37,     0,     1,    18,     0,     9,    52,     0,     4,    19,
    38,    20,    33,     0,     4,    19,    38,    20,    33,     5,
    33,     0,     6,    46,     7,    19,    38,    20,    33,     0,
    24,    32,    25,     0,    39,     0,    38,    11,    40,     0,
    38,    12,    40,     0,    40,     0,    46,    10,    40,     0,
    41,     0,    41,    13,    45,     0,    42,     0,    43,     0,
    42,    14,    43,     0,    44,     0,    43,    15,    44,     0,
    45,     0,    44,    16,    45,     0,    46,     0,    52,     0,
    47,     0,    48,     0,    19,    38,    20,     0,    51,     0,
    26,     0,    28,     0,    29,     0,    26,     0,    26,     0,
    21,    49,    50,    22,     0,    21,    49,    50,    23,    45,
    22,     0,    27,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   207,   216,   217,   221,   222,   223,   224,   225,   226,   227,
   228,   232,   252,   255,   265,   272,   276,   280,   281,   282,
   286,   288,   292,   293,   297,   298,   304,   305,   311,   312,
   318,   320,   322,   324,   326,   327,   331,   341,   351,   361,
   365,   369,   386,   406
};

static const char * const yytname[] = {   "$","error","$undefined.","ERROR_TOKEN",
"IF","ELSE","FOR","IN","PRINT","INCLUDE","ASSIGN","EQUAL","NEQUAL","CONCAT",
"LOGICAL_AND","LOGICAL_OR","LOGICAL_XOR","LOGICAL_NOT","END_STMT","OPEN_PAR",
"CLOSE_PAR","OPEN_METH","CLOSE_METH","METH_ARG","BEGIN_CS","END_CS","ID","STRING",
"INTEGER","BOOLEAN","LOWER_THAN_ELSE","program","statement_list","statement",
"include_statement","if_statement","for_statement","compound_statement","expr",
"equal_expr","assign_expr","concat_expr","logical_and_expr","logical_or_expr",
"logical_xor_expr","simple_expr","identifier","integer","boolean","class_name",
"method_name","method_call","string",""
};
#endif

static const short yyr1[] = {     0,
    31,    32,    32,    33,    33,    33,    33,    33,    33,    33,
    33,    34,    35,    35,    36,    37,    38,    39,    39,    39,
    40,    40,    41,    41,    42,    42,    43,    43,    44,    44,
    45,    45,    45,    45,    45,    45,    46,    47,    48,    49,
    50,    51,    51,    52
};

static const short yyr2[] = {     0,
     1,     2,     0,     1,     1,     2,     3,     1,     1,     1,
     2,     2,     5,     7,     7,     3,     1,     3,     3,     1,
     3,     1,     3,     1,     1,     3,     1,     3,     1,     3,
     1,     1,     1,     1,     3,     1,     1,     1,     1,     1,
     1,     4,     6,     1
};

static const short yydefact[] = {     0,
     0,     0,     0,     0,     0,     4,     0,     0,     0,    37,
    44,    38,    39,     1,     0,     5,     8,     9,    10,     0,
    17,    20,    22,    24,    25,    27,    29,    31,    33,    34,
    36,    32,    11,     0,     0,     0,    12,     0,    40,     0,
     0,     2,     0,     0,     6,     0,     0,     0,     0,     0,
     0,     0,     7,    35,    41,     0,    16,    18,    19,    23,
    31,    26,    28,    30,    21,     0,     0,    42,     0,    13,
     0,     0,     0,     0,    43,    14,    15,     0,     0,     0
};

static const short yydefgoto[] = {    78,
    14,    15,    16,    17,    18,    19,    20,    21,    22,    23,
    24,    25,    26,    27,    28,    29,    30,    40,    56,    31,
    32
};

static const short yypact[] = {    49,
   -15,   -13,     5,    -7,   -16,-32768,    -7,    15,    78,-32768,
-32768,-32768,-32768,-32768,     9,-32768,-32768,-32768,-32768,    77,
-32768,-32768,    29,    33,    41,    43,-32768,    53,-32768,-32768,
-32768,-32768,-32768,    -7,    57,    80,-32768,    -4,-32768,    45,
    44,-32768,    -7,    -7,-32768,    -7,    -7,    -7,    -7,    -7,
    28,    55,-32768,-32768,-32768,     3,-32768,-32768,-32768,-32768,
-32768,    41,    43,-32768,-32768,   107,    -7,-32768,    -7,    67,
    40,    58,   107,   107,-32768,-32768,-32768,    81,    83,-32768
};

static const short yypgoto[] = {-32768,
    14,   -12,-32768,-32768,-32768,-32768,    -2,-32768,    50,-32768,
-32768,    38,    42,   -45,    -3,-32768,-32768,-32768,-32768,-32768,
    96
};


#define	YYLAST		136


static const short yytable[] = {    35,
    60,    36,    33,    64,    38,    34,    43,    44,    -3,     1,
    11,     7,     2,     8,     3,    54,     4,     5,    10,    11,
    12,    13,    41,    72,    68,    69,     6,     7,    42,     8,
    10,    51,     9,    -3,    10,    11,    12,    13,    43,    44,
    39,    46,    61,    61,    61,    61,    47,    66,    -3,     1,
    43,    44,     2,    70,     3,    48,     4,     5,    49,    74,
    76,    77,    50,    52,    71,    61,     6,     7,    57,     8,
    55,    73,     9,    67,    10,    11,    12,    13,     1,    75,
    79,     2,    80,     3,    62,     4,     5,    43,    44,    63,
    43,    44,    58,    59,    45,     6,     7,    53,     8,    65,
    37,     9,    -3,    10,    11,    12,    13,     1,     0,     0,
     2,     0,     3,     0,     4,     5,     0,     0,     0,     0,
     0,     0,     0,     0,     6,     7,     0,     8,     0,     0,
     9,     0,    10,    11,    12,    13
};

static const short yycheck[] = {     3,
    46,     4,    18,    49,     7,    19,    11,    12,     0,     1,
    27,    19,     4,    21,     6,    20,     8,     9,    26,    27,
    28,    29,     9,    69,    22,    23,    18,    19,    15,    21,
    26,    34,    24,    25,    26,    27,    28,    29,    11,    12,
    26,    13,    46,    47,    48,    49,    14,    20,     0,     1,
    11,    12,     4,    66,     6,    15,     8,     9,    16,    20,
    73,    74,    10,     7,    67,    69,    18,    19,    25,    21,
    26,     5,    24,    19,    26,    27,    28,    29,     1,    22,
     0,     4,     0,     6,    47,     8,     9,    11,    12,    48,
    11,    12,    43,    44,    18,    18,    19,    18,    21,    50,
     5,    24,    25,    26,    27,    28,    29,     1,    -1,    -1,
     4,    -1,     6,    -1,     8,     9,    -1,    -1,    -1,    -1,
    -1,    -1,    -1,    -1,    18,    19,    -1,    21,    -1,    -1,
    24,    -1,    26,    27,    28,    29
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
/* XXX this fixes annoyances with pure parsers. */
#if 0
int yyparse (void);
#endif
#endif

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(FROM,TO,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (from, to, count)
     char *from;
     char *to;
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
__yy_memcpy (char *from, char *to, int count)
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 192 "/usr/local/share/bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#else
#define YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#endif

int
yyparse(YYPARSE_PARAM)
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
      __yy_memcpy ((char *)yyss1, (char *)yyss, size * sizeof (*yyssp));
      yyvs = (YYSTYPE *) alloca (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs1, (char *)yyvs, size * sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) alloca (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls1, (char *)yyls, size * sizeof (*yylsp));
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
#line 207 "Parser.y"
{
        register SyntaxTree *root   = (SyntaxTree *)syntree;
        register SyntaxTree *parsed = (SyntaxTree *)yyvsp[0].tnode; 

        *root = *parsed;
     ;
    break;}
case 2:
#line 216 "Parser.y"
{ yyval.tnode = CTREE2(StmtList, yyvsp[-1].tnode, yyvsp[0].tnode);           ;
    break;}
case 3:
#line 217 "Parser.y"
{ yyval.tnode = CTREE(EmptyStmt);                   ;
    break;}
case 4:
#line 221 "Parser.y"
{ yyval.tnode = CTREE(EmptyStmt);                   ;
    break;}
case 5:
#line 222 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 6:
#line 223 "Parser.y"
{ yyval.tnode = CTREE1(ExprStmt, yyvsp[-1].tnode);               ;
    break;}
case 7:
#line 224 "Parser.y"
{ yyval.tnode = CTREE1(PrintStmt, yyvsp[-1].tnode);              ;
    break;}
case 8:
#line 225 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 9:
#line 226 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 10:
#line 227 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 11:
#line 228 "Parser.y"
{ yyval.tnode = CTREE(ErrorStmt);                   ;
    break;}
case 12:
#line 232 "Parser.y"
{
       String     *str = [yyvsp[0].symbol data];
       SyntaxTree *parsed = [[SyntaxTree alloc] init];

       printf("Including %s\n", [str stringValue]);

       if ((yyin = fopen([str stringValue], "r")) == NULL) {
         fprintf(stderr, "Could not open '%s': %s\n",
                 [str stringValue],
                 strerror(errno));
         exit(EXIT_FAILURE);
       }

       yyparse(parsed);

       yyval.tnode = parsed;
     ;
    break;}
case 13:
#line 252 "Parser.y"
{
       yyval.tnode = CTREE2(IfThenStmt, yyvsp[-2].tnode, yyvsp[0].tnode);
     ;
    break;}
case 14:
#line 255 "Parser.y"
{
       if (yyvsp[0].tnode != nil) {
         yyval.tnode = CTREE3(IfThenElseStmt, yyvsp[-4].tnode, yyvsp[-2].tnode, yyvsp[0].tnode);
       } else {
         yyval.tnode = CTREE2(IfThenStmt, yyvsp[-4].tnode, yyvsp[-2].tnode);
       }
     ;
    break;}
case 15:
#line 265 "Parser.y"
{
       yyval.tnode = CTREE2(ForInStmt, yyvsp[-2].tnode, yyvsp[0].tnode);
       [yyval.tnode setSymbol:yyvsp[-5].symbol];
     ;
    break;}
case 16:
#line 272 "Parser.y"
{ yyval.tnode = yyvsp[-1].tnode;                                 ;
    break;}
case 17:
#line 276 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 18:
#line 280 "Parser.y"
{ yyval.tnode = CTREE2(EqualExpr, yyvsp[-2].tnode, yyvsp[0].tnode);          ;
    break;}
case 19:
#line 281 "Parser.y"
{ yyval.tnode = CTREE2(NotEqualExpr, yyvsp[-2].tnode, yyvsp[0].tnode);       ;
    break;}
case 20:
#line 282 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 21:
#line 286 "Parser.y"
{ yyval.tnode = CTREE1(AssignExpr, yyvsp[0].tnode);
                                      [yyval.tnode setSymbol:yyvsp[-2].symbol];                       ;
    break;}
case 22:
#line 288 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 23:
#line 292 "Parser.y"
{ yyval.tnode = CTREE2(ConcatExpr, yyvsp[-2].tnode, yyvsp[0].tnode);         ;
    break;}
case 24:
#line 293 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 25:
#line 297 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 26:
#line 298 "Parser.y"
{
       yyval.tnode = CTREE2(LogicalAndExpr, yyvsp[-2].tnode, yyvsp[0].tnode);
     ;
    break;}
case 27:
#line 304 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 28:
#line 305 "Parser.y"
{
       yyval.tnode = CTREE2(LogicalOrExpr, yyvsp[-2].tnode, yyvsp[0].tnode);
     ;
    break;}
case 29:
#line 311 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode; ;
    break;}
case 30:
#line 312 "Parser.y"
{
       yyval.tnode = CTREE2(LogicalXorExpr, yyvsp[-2].tnode, yyvsp[0].tnode);
     ;
    break;}
case 31:
#line 318 "Parser.y"
{ yyval.tnode = CTREE(IdentExpr);
                                      [yyval.tnode setSymbol:yyvsp[0].symbol];                       ;
    break;}
case 32:
#line 320 "Parser.y"
{ yyval.tnode = CTREE(StringExpr);
                                      [yyval.tnode setSymbol:yyvsp[0].symbol];                       ;
    break;}
case 33:
#line 322 "Parser.y"
{ yyval.tnode = CTREE(IntegerExpr);
                                      [yyval.tnode setSymbol:yyvsp[0].symbol];                       ;
    break;}
case 34:
#line 324 "Parser.y"
{ yyval.tnode = CTREE(BooleanExpr);
                                      [yyval.tnode setSymbol:yyvsp[0].symbol];                       ;
    break;}
case 35:
#line 326 "Parser.y"
{ yyval.tnode = yyvsp[-1].tnode;                                 ;
    break;}
case 36:
#line 327 "Parser.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 37:
#line 331 "Parser.y"
{
       yyval.symbol = [root_symtab valueForSymbol:yyvsp[0].str];
       if (yyval.symbol == nil) {
         yyval.symbol = CIDENT(yyvsp[0].str, SymbolObject);
         IINDENT(yyval.symbol);
       }
     ;
    break;}
case 38:
#line 341 "Parser.y"
{
       Number *num = nil;

       num = [[Number alloc] initWithInt:yyvsp[0].fixnum];
       yyval.symbol = CINT(num);
       IINT(yyval.symbol);
     ;
    break;}
case 39:
#line 351 "Parser.y"
{
       Boolean *bool = nil;

       bool = [[Boolean alloc] initWithInt:yyvsp[0].fixnum];
       yyval.symbol = CBOOL(bool);
       IBOOL(yyval.symbol);
     ;
    break;}
case 40:
#line 361 "Parser.y"
{ yyval.str = yyvsp[0].str; ;
    break;}
case 41:
#line 365 "Parser.y"
{ yyval.str = yyvsp[0].str; ;
    break;}
case 42:
#line 369 "Parser.y"
{
      Selector *sel = nil;
      Symbol   *sym = nil;

      sel = [[Selector alloc] initWithMethod:yyvsp[-1].str
                                    forClass:yyvsp[-2].str];

      if ([sel selector] == NULL) {
        yyerror("Unknown method call.");
      }

      sym = [[Symbol alloc] initWithData:sel
                                 andName:[sel stringValue]
                                 andType:SymbolSelector];
      yyval.tnode = CTREE(MethodCall);
      [yyval.tnode setSymbol:sym];
     ;
    break;}
case 43:
#line 386 "Parser.y"
{
      Selector *sel = nil;
      Symbol   *sym = nil;

      sel = [[Selector alloc] initWithMethod:yyvsp[-3].str
                                    forClass:yyvsp[-4].str];

      if ([sel selector] == NULL) {
        yyerror("Unknown method call.");
      }

      sym = [[Symbol alloc] initWithData:sel
                                 andName:[sel stringValue]
                                 andType:SymbolSelector];
      yyval.tnode = CTREE1(MethodCall, yyvsp[-1].tnode);
      [yyval.tnode setSymbol:sym];
     ;
    break;}
case 44:
#line 406 "Parser.y"
{
       yyval.symbol = CSYMB(yyvsp[0].str, make_symbol_name(), SymbolString);
       ISYMB(yyval.symbol);
     ;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 487 "/usr/local/share/bison.simple"

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
#line 412 "Parser.y"


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
 * mode: fundamental ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
