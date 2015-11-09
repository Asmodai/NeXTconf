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
#define	CONCAT	266
#define	END_STMT	267
#define	OPEN_PAR	268
#define	CLOSE_PAR	269
#define	OPEN_METH	270
#define	CLOSE_METH	271
#define	BEGIN_CS	272
#define	END_CS	273
#define	ID	274
#define	STRING	275
#define	INTEGER	276


extern YYSTYPE yylval;
