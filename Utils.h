/*
 * Utils.h  --- Various utilities.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Wed,  4 Nov 2015 02:55:58 +0000 (GMT)
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
/* {{{ Commentary: */
/*
 *
 */
/* }}} */

#ifndef _UTILS_H_
#define _UTILS_H_

#import <objc/objc.h>
#import <objc/zone.h>
#import <sys/types.h>

/* For S_ISREG and S_ISDIR */
#import <sys/stat.h>

/*
 * Define this if you want to use the NXZone* memory allocation
 * functions instead of the regular C library ones.
 */
#define USE_ZONES 1

/*
 * We get to provide the following for non-NeXTSTEP platforms:
 *
 *  o MX_MALLOC     [-> malloc]
 *  o NX_REALLOC    [-> realloc]
 *  o NX_FREE       [-> free]
 *
 * The functions themselves are taken from AppKit's nextstd.h.
 */
#ifndef PLATFORM_NEXTSTEP

#define  NX_MALLOC( VAR, TYPE, NUM )                            \
  ((VAR) = (TYPE *)xmalloc((unsigned)(NUM) * sizeof(TYPE)))

#define  NX_REALLOC( VAR, TYPE, NUM )                           \
  ((VAR) = (TYPE *)xrealloc((VAR), (unsigned)(NUM) * sizeof(TYPE)))

#define  NX_FREE( PTR ) free((PTR))

#endif // !PLATFORM_NEXTSTEP

/*
 * Utility to compute the size of an array.
 */
#define ARRAYSIZE(a) (sizeof (a) / sizeof *(a))

/*
 * Because NeXT requires POSIX for this, and linking with the POSIX
 * library is messy and I just can't be bothered with all that.
 */
#ifndef S_ISDIR
# define S_ISDIR(m) (((m) & (_S_IFMT)) == (_S_IFDIR))
#endif

/*
 * Same with this one.
 */
#ifndef S_ISREG
# define S_ISREG(m) (((m) & (_S_IFMT)) == (_S_IFREG))
#endif

/*
 * Convert a boolean value to a string value.
 */
#define bool2string(__b)    ((__b) ? "Yes" : "No")

/*
 * Function prototypes.
 */
void *xzonemalloc(NXZone *, size_t);
void *xzoneralloc(NXZone *, void *, size_t);
void *xzonecealloc(NXZone *, size_t, size_t);
void  xzonefree(NXZone *, void *ptr);

void *xmalloc(size_t);
void *xrealloc(void *, size_t);
void *xcalloc(size_t, size_t);

char *rstrip(char *);
char *strip(char *);
char *lskip(const char *);

void  debug_print(size_t, const char *, ...);

BOOL  file_exists(const char *);

BOOL  directory_exists(const char *);

extern size_t errors;

void errorf(char *, ...);
void error_summary(void);

void yyerror(char *);
int  yywrap(void);

char *strdup(const char *);

#endif /* !_UTILS_H_ */

/* Utils.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */

