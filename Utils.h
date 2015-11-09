/*
 * Utils.h  --- Various utilities.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/09 05:00:48 asmodai>
 * Revision:   4
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

#include <objc/objc.h>
#include <sys/types.h>

/* For S_ISREG and S_ISDIR */
#include <sys/stat.h>

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
void debug_print(size_t, const char *, ...);
BOOL file_exists(const char *);
BOOL directory_exists(const char *);

#endif /* !_UTILS_H_ */

/* Utils.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */

