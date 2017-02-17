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

