/*
 * ExtErrno.h  --- Custom `errno' values.
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun, 19 Feb 2017 01:32:05 +0000 (GMT)
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

#ifndef _EXTERRNO_H_
#define _EXTERRNO_H_

#include <errno.h>

#define EXT_EISEMPTY   200      /* Thing is empty. */
#define EXT_EPARSER    201      /* Parser error. */
#define EXT_ENOCLASS   202      /* Class not found. */
#define EXT_ENOMETH    203      /* Method not found. */
#define EXT_ENORESP    204      /* Thing does not respond to method. */

#endif /* !_EXTERRNO_H_ */

/* ExtErrno.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
