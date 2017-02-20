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

