/*
 * Number.h  --- Numeric data type.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 05:17:53 +0000 (GMT)
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
 * Numeric data class.
 */
@interface Number : Object
{
  unsigned int _number;
}

/*
 * Initialisation methods.
 */
- (id)init;
- (id)initWithInt:(int)value;
- (id)initWithString:(const char *)string;

/*
 * Destruction methods.
 */
- (id)free;

/*
 * Accessor methods.
 */
- (const char *)stringValue;
- (void)setValueFromString:(const char *)string;
- (int)intValue;
- (void)setValueFromInt:(int)value;

/*
 * Comparison methods.
 */
- (BOOL)isEqual:(id)anObject;

@end /* Number */


/*
 * Debugging methods added by the Debug category.
 */
@interface Number (Debug)

- (void)_printDebugInfo:(int)indent;

@end /* Number (Debug) */

/* Number.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
