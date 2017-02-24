/*
 * Number.h  --- Numeric data type interface.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
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
#import "Types.h"

/*
 * Numeric data class.
 */
@interface Number : Object
{
  number_t   _number;           // The number.
}

/*
 * Initialisation methods.
 */
- (id)init;
- (id)initWithInt:(long_t)value;
- (id)initWithFloat:(float_t)value;
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
- (long_t)intValue;
- (float_t)floatValue;
- (void)setValueFromInt:(long_t)value;
- (void)setValueFromFloat:(float_t)value;

/*
 * Arithmetic methods.
 */
- (Number *)add:(Number *)aNumber;
- (Number *)subtract:(Number *)aNumber;
- (Number *)multiply:(Number *)aNumber;
- (Number *)divide:(Number *)aNumber;

/*
 * Comparison methods.
 */
- (BOOL)isEqual:(id)anObject;

@end                            // Number

@interface Number (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // Number (Debug)

/* Number.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
