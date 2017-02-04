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
#define	BEGIN_CS	273
#define	END_CS	274
#define	ID	275
#define	STRING	276
#define	INTEGER	277
#define	BOOLEAN	278


extern YYSTYPE yylval;
