/*
 * Selector.h  --- Selector data type interface.
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Wed,  1 Feb 2017 18:31:40 +0000 (GMT)
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
#import "String.h"
#import "Object+Debug.h"

/*
 * This class implements a Selector data type.  This works in the same
 * way as an Objective-C selector, but associates a class as well as a
 * method.
 */
@interface Selector : Object
{
  String *_method;              // The method.
  String *_class;               // The owning class.
  SEL     _selector;            // The constructed selector.
}

/*
 * Initialisation methods.
 */
- (id)init;
- (id)initWithMethod:(const char *)aMethod
            forClass:(const char *)aClass;

/*
 * Destruction methods.
 */
- (id)free;

/*
 * Accessor methods.
 */
- (SEL)selector;
- (const char *)stringValue;
- (String *)methodName;
- (String *)className;

/*
 * Utility methods.
 */
- (int)isValid;

/*
 * Selector calling.
 */
- (id)evaluate;
- (id)evaluateWithArg:(id)anArg;

@end                            // Selector

@interface Selector (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // Selector (Debug)

/* Selector.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
