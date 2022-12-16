/*
 * Types.h  --- Some title
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun, 19 Feb 2017 20:50:03 +0000 (GMT)
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

#ifndef _TYPES_H_
#define _TYPES_H_

/*
 * Common types.
 */
typedef unsigned long  long_t;
typedef float          float_t;

/*
 * Numeric value types.
 */
typedef enum {
  Integer = 1,
  Float
} NumberType;

/*
 * Internal numeric representation.
 */
typedef struct {
  NumberType type;
  union {
    float_t  _f;
    long_t   _i;
  } _n;
} number_t;

#endif /* !_TYPES_H_ */

/* Types.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
