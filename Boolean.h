/*
 * Boolean.h  --- Boolean data type interface.
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Thu,  2 Feb 2017 15:28:35 +0000 (GMT)
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

#import "String.h"
#import "Types.h"

/*
 * This class defines a Boolean datatype.
 */
@interface Boolean : Object
{
  BOOL _value;                  // The boolean value.
}

/*
 * Initialisation.
 */
- (id)init;
- (id)initWithBool:(BOOL)value;
- (id)initWithInt:(long_t)value;

/*
 * Destruction.
 */
- (id)free;

/*
 * Accessor methods.
 */
- (BOOL)boolValue;
- (const char *)stringValue;
- (long_t)intValue;
- (void)setValueFromBool:(BOOL)aValue;
- (void)setValueFromString:(const char *)aString;
- (void)setValueFromInt:(int)aValue;

/*
 * Comparison methods.
 */
- (BOOL)isEqual:(id)anObject;

@end                            // Boolean

@interface Boolean (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // Boolean (Debug)

/* Boolean.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
