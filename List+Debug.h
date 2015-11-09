/*
 * List+Debug.h  --- Some title
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/09 01:08:54 asmodai>
 * Revision:   1
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Mon,  9 Nov 2015 01:08:03 +0000 (GMT)
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
#import <objc/List.h>

@interface List (Debug)

- (void)_printDebugInfo:(int)indent;

@end /* List (Debug) */

/* List+Debug.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
