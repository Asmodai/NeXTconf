
/*  A Bison parser, made from Grammar.y with Bison version GNU Bison version 1.24
  */

#define YYBISON 1  /* Identify Bison output.  */

#define	ERROR_TOKEN	258
#define	IF	259
#define	ELSE	260
#define	FOR	261
#define	IN	262
#define	PRINT	263
#define	ASSIGN	264
#define	EQUAL	265
#define	NEQUAL	266
#define	CONCAT	267
#define	END_STMT	268
#define	OPEN_PAR	269
#define	CLOSE_PAR	270
#define	OPEN_METH	271
#define	CLOSE_METH	272
#define	METH_ARG	273
#define	BEGIN_CS	274
#define	END_CS	275
#define	ID	276
#define	STRING	277
#define	INTEGER	278
#define	BOOLEAN	279
#define	LOWER_THAN_ELSE	280

#line 27 "Grammar.y"


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


#line 146 "Grammar.y"
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



#define	YYFINAL		68
#define	YYFLAG		-32768
#define	YYNTBASE	26

#define YYTRANSLATE(x) ((unsigned)(x) <= 280 ? yytranslate[x] : 44)

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
    16,    17,    18,    19,    20,    21,    22,    23,    24,    25
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     2,     5,     6,     8,    11,    15,    17,    19,    21,
    24,    30,    38,    46,    50,    52,    56,    60,    62,    66,
    68,    72,    74,    76,    78,    80,    82,    86,    88,    90,
    92,    94,    96,    98,   103,   110
};

static const short yyrhs[] = {    27,
     0,    28,    27,     0,     0,    13,     0,    32,    13,     0,
     8,    32,    13,     0,    29,     0,    30,     0,    31,     0,
     1,    13,     0,     4,    14,    32,    15,    28,     0,     4,
    14,    32,    15,    28,     5,    28,     0,     6,    37,     7,
    14,    32,    15,    28,     0,    19,    27,    20,     0,    33,
     0,    32,    10,    34,     0,    32,    11,    34,     0,    34,
     0,    37,     9,    34,     0,    35,     0,    35,    12,    36,
     0,    36,     0,    37,     0,    43,     0,    38,     0,    39,
     0,    14,    32,    15,     0,    42,     0,    21,     0,    23,
     0,    24,     0,    21,     0,    21,     0,    16,    40,    41,
    17,     0,    16,    40,    41,    18,    36,    17,     0,    22,
     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   184,   188,   189,   193,   194,   195,   196,   197,   198,   199,
   203,   206,   216,   223,   227,   231,   232,   233,   237,   239,
   243,   244,   248,   250,   252,   254,   256,   257,   261,   271,
   281,   291,   295,   299,   316,   336
};

static const char * const yytname[] = {   "$","error","$undefined.","ERROR_TOKEN",
"IF","ELSE","FOR","IN","PRINT","ASSIGN","EQUAL","NEQUAL","CONCAT","END_STMT",
"OPEN_PAR","CLOSE_PAR","OPEN_METH","CLOSE_METH","METH_ARG","BEGIN_CS","END_CS",
"ID","STRING","INTEGER","BOOLEAN","LOWER_THAN_ELSE","program","statement_list",
"statement","if_statement","for_statement","compound_statement","expr","equal_expr",
"assign_expr","concat_expr","simple_expr","identifier","integer","boolean","class_name",
"method_name","method_call","string",""
};
#endif

static const short yyr1[] = {     0,
    26,    27,    27,    28,    28,    28,    28,    28,    28,    28,
    29,    29,    30,    31,    32,    33,    33,    33,    34,    34,
    35,    35,    36,    36,    36,    36,    36,    36,    37,    38,
    39,    40,    41,    42,    42,    43
};

static const short yyr2[] = {     0,
     1,     2,     0,     1,     2,     3,     1,     1,     1,     2,
     5,     7,     7,     3,     1,     3,     3,     1,     3,     1,
     3,     1,     1,     1,     1,     1,     3,     1,     1,     1,
     1,     1,     1,     4,     6,     1
};

static const short yydefact[] = {     0,
     0,     0,     0,     0,     4,     0,     0,     0,    29,    36,
    30,    31,     1,     0,     7,     8,     9,     0,    15,    18,
    20,    22,    23,    25,    26,    28,    24,    10,     0,     0,
     0,     0,    32,     0,     0,     2,     0,     0,     5,     0,
     0,     0,     0,     6,    27,    33,     0,    14,    16,    17,
    21,    23,    19,     0,     0,    34,     0,    11,     0,     0,
     0,     0,    35,    12,    13,     0,     0,     0
};

static const short yydefgoto[] = {    66,
    13,    14,    15,    16,    17,    18,    19,    20,    21,    22,
    23,    24,    25,    34,    47,    26,    27
};

static const short yypact[] = {    42,
   -10,    -9,    -5,    94,-32768,    94,     3,    66,-32768,-32768,
-32768,-32768,-32768,     9,-32768,-32768,-32768,    49,-32768,-32768,
    14,-32768,    12,-32768,-32768,-32768,-32768,-32768,    94,    29,
    58,    -4,-32768,    17,    27,-32768,    94,    94,-32768,    94,
    94,    24,    35,-32768,-32768,-32768,    34,-32768,-32768,-32768,
-32768,-32768,-32768,    90,    94,-32768,    94,    39,    30,    56,
    90,    90,-32768,-32768,-32768,    57,    75,-32768
};

static const short yypgoto[] = {-32768,
     0,   -42,-32768,-32768,-32768,    -2,-32768,    40,-32768,   -39,
    -3,-32768,-32768,-32768,-32768,-32768,-32768
};


#define	YYLAST		118


static const short yytable[] = {    30,
    51,    31,    28,    32,    29,    37,    38,    35,    -3,     1,
    45,    58,     2,    36,     3,     9,     4,    60,    64,    65,
    41,     5,     6,    33,     7,    40,    42,     8,    -3,     9,
    10,    11,    12,    37,    38,    43,    52,    46,    54,    37,
    38,    -3,     1,    61,    62,     2,    48,     3,    55,     4,
    56,    57,    59,    52,     5,     6,    67,     7,    37,    38,
     8,    39,     9,    10,    11,    12,     1,    37,    38,     2,
    44,     3,    63,     4,    68,     0,    49,    50,     5,     6,
    53,     7,     0,     0,     8,    -3,     9,    10,    11,    12,
     1,     0,     0,     2,     0,     3,     0,     4,     0,     0,
     0,     0,     5,     6,     0,     7,     0,     6,     8,     7,
     9,    10,    11,    12,     9,    10,    11,    12
};

static const short yycheck[] = {     3,
    40,     4,    13,     6,    14,    10,    11,     8,     0,     1,
    15,    54,     4,    14,     6,    21,     8,    57,    61,    62,
     9,    13,    14,    21,    16,    12,    29,    19,    20,    21,
    22,    23,    24,    10,    11,     7,    40,    21,    15,    10,
    11,     0,     1,     5,    15,     4,    20,     6,    14,     8,
    17,    18,    55,    57,    13,    14,     0,    16,    10,    11,
    19,    13,    21,    22,    23,    24,     1,    10,    11,     4,
    13,     6,    17,     8,     0,    -1,    37,    38,    13,    14,
    41,    16,    -1,    -1,    19,    20,    21,    22,    23,    24,
     1,    -1,    -1,     4,    -1,     6,    -1,     8,    -1,    -1,
    -1,    -1,    13,    14,    -1,    16,    -1,    14,    19,    16,
    21,    22,    23,    24,    21,    22,    23,    24
};
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
int yyparse (void);
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
#line 184 "Grammar.y"
{ root_syntree = yyvsp[0].tnode;                       ;
    break;}
case 2:
#line 188 "Grammar.y"
{ yyval.tnode = CTREE2(StmtList, yyvsp[-1].tnode, yyvsp[0].tnode);           ;
    break;}
case 3:
#line 189 "Grammar.y"
{ yyval.tnode = CTREE(EmptyStmt);                   ;
    break;}
case 4:
#line 193 "Grammar.y"
{ yyval.tnode = CTREE(EmptyStmt);                   ;
    break;}
case 5:
#line 194 "Grammar.y"
{ yyval.tnode = CTREE1(ExprStmt, yyvsp[-1].tnode);               ;
    break;}
case 6:
#line 195 "Grammar.y"
{ yyval.tnode = CTREE1(PrintStmt, yyvsp[-1].tnode);              ;
    break;}
case 7:
#line 196 "Grammar.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 8:
#line 197 "Grammar.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 9:
#line 198 "Grammar.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 10:
#line 199 "Grammar.y"
{ yyval.tnode = CTREE(ErrorStmt);                   ;
    break;}
case 11:
#line 203 "Grammar.y"
{
       yyval.tnode = CTREE2(IfThenStmt, yyvsp[-2].tnode, yyvsp[0].tnode);
     ;
    break;}
case 12:
#line 206 "Grammar.y"
{
       if (yyvsp[0].tnode != nil) {
         yyval.tnode = CTREE3(IfThenElseStmt, yyvsp[-4].tnode, yyvsp[-2].tnode, yyvsp[0].tnode);
       } else {
         yyval.tnode = CTREE2(IfThenStmt, yyvsp[-4].tnode, yyvsp[-2].tnode);
       }
     ;
    break;}
case 13:
#line 216 "Grammar.y"
{
       yyval.tnode = CTREE2(ForInStmt, yyvsp[-2].tnode, yyvsp[0].tnode);
       [yyval.tnode setSymbol:yyvsp[-5].symbol];
     ;
    break;}
case 14:
#line 223 "Grammar.y"
{ yyval.tnode = yyvsp[-1].tnode;                                 ;
    break;}
case 15:
#line 227 "Grammar.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 16:
#line 231 "Grammar.y"
{ yyval.tnode = CTREE2(EqualExpr, yyvsp[-2].tnode, yyvsp[0].tnode);          ;
    break;}
case 17:
#line 232 "Grammar.y"
{ yyval.tnode = CTREE2(NotEqualExpr, yyvsp[-2].tnode, yyvsp[0].tnode);       ;
    break;}
case 18:
#line 233 "Grammar.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 19:
#line 237 "Grammar.y"
{ yyval.tnode = CTREE1(AssignExpr, yyvsp[0].tnode);
                                      [yyval.tnode setSymbol:yyvsp[-2].symbol];                       ;
    break;}
case 20:
#line 239 "Grammar.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 21:
#line 243 "Grammar.y"
{ yyval.tnode = CTREE2(ConcatExpr, yyvsp[-2].tnode, yyvsp[0].tnode);         ;
    break;}
case 22:
#line 244 "Grammar.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 23:
#line 248 "Grammar.y"
{ yyval.tnode = CTREE(IdentExpr);
                                      [yyval.tnode setSymbol:yyvsp[0].symbol];                       ;
    break;}
case 24:
#line 250 "Grammar.y"
{ yyval.tnode = CTREE(StringExpr);
                                      [yyval.tnode setSymbol:yyvsp[0].symbol];                       ;
    break;}
case 25:
#line 252 "Grammar.y"
{ yyval.tnode = CTREE(IntegerExpr);
                                      [yyval.tnode setSymbol:yyvsp[0].symbol];                       ;
    break;}
case 26:
#line 254 "Grammar.y"
{ yyval.tnode = CTREE(BooleanExpr);
                                      [yyval.tnode setSymbol:yyvsp[0].symbol];                       ;
    break;}
case 27:
#line 256 "Grammar.y"
{ yyval.tnode = yyvsp[-1].tnode;                                 ;
    break;}
case 28:
#line 257 "Grammar.y"
{ yyval.tnode = yyvsp[0].tnode;                                 ;
    break;}
case 29:
#line 261 "Grammar.y"
{
       yyval.symbol = [root_symtab valueForSymbol:yyvsp[0].str];
       if (yyval.symbol == nil) {
         yyval.symbol = CIDENT(yyvsp[0].str, SymbolObject);
         IINDENT(yyval.symbol);
       }
     ;
    break;}
case 30:
#line 271 "Grammar.y"
{
       Number *num = nil;

       num = [[Number alloc] initWithInt:yyvsp[0].fixnum];
       yyval.symbol = CINT(num);
       IINT(yyval.symbol);
     ;
    break;}
case 31:
#line 281 "Grammar.y"
{
       Boolean *bool = nil;

       bool = [[Boolean alloc] initWithInt:yyvsp[0].fixnum];
       yyval.symbol = CBOOL(bool);
       IBOOL(yyval.symbol);
     ;
    break;}
case 32:
#line 291 "Grammar.y"
{ yyval.str = yyvsp[0].str; ;
    break;}
case 33:
#line 295 "Grammar.y"
{ yyval.str = yyvsp[0].str; ;
    break;}
case 34:
#line 299 "Grammar.y"
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
case 35:
#line 316 "Grammar.y"
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
case 36:
#line 336 "Grammar.y"
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
#line 342 "Grammar.y"


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
