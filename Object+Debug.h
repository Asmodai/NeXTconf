/*
 * Object+Debug.h  --- Debugging category.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/07 23:10:28 asmodai>
 * Revision:   6
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat,  7 Nov 2015 07:18:45 +0000 (GMT)
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

/*
 * Object category that adds debugging functionality.
 */
@interface Object (Debug)

/*
 * Indentation level.
 */
+ (int)debugIndentLevel;

/*
 * Print debugging information.
 */
- (void)_printDebugInfo:(int)indent;
- (void)printDebug:(const char *)label;
- (void)printDebug:(const char *)label
        withIndent:(int)indent;

@end /* Object (Debug) */

/* Object+Debug.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
