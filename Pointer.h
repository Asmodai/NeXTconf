/*
 * Pointer.h  --- Pointer container.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/03 18:42:26 asmodai>
 * Revision:   2
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 18:37:45 +0000 (GMT)
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

#import <objc/Object.h>
#import "Object+Debug.h"

/*
 * This class implements a pointer container.
 */
@interface Pointer : Object
{
  void *_ptr;
}

/*
 * Initialisation.
 */
- (id)init;
- (id)initWithPointer:(void *)ptr;

/*
 * Destruction.
 */
- (id)free;

/*
 * Accessors.
 */
- (void)setPointer:(void *)ptr;
- (void *)pointer;
- (void)invalidate;

@end /* Pointer */

@interface Pointer (Debug)

- (void)_printDebugInfo:(int)indent;

@end /* Pointer (Debug) */

/* Pointer.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
