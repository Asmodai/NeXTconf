typedef union {
  char          *str;
  unsigned long  fixnum;
  Symbol        *symbol;
  SyntaxTree    *tnode;
} YYSTYPE;
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


extern YYSTYPE yylval;
