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
#define	END_STMT	272
#define	OPEN_PAR	273
#define	CLOSE_PAR	274
#define	OPEN_METH	275
#define	CLOSE_METH	276
#define	METH_ARG	277
#define	BEGIN_CS	278
#define	END_CS	279
#define	ID	280
#define	STRING	281
#define	INTEGER	282
#define	BOOLEAN	283
#define	LOWER_THAN_ELSE	284

