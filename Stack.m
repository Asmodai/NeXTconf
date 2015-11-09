/*
 * Stack.m  --- Stack implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/07 22:52:38 asmodai>
 * Revision:   9
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 16:50:37 +0000 (GMT)
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

#import "Stack.h"
#import "Utils.h"

#import <stdio.h>

@implementation Stack

/*
 * Push an object to the stack.
 */
- (id)pushObject:(id)anObject
{
  return [self addObject:anObject];
}

/*
 * Pop an object from the stack.
 */
- (id)popObject
{
  return [self removeLastObject];
}

/*
 * Get the top object on the stack.
 */
- (id)topObject
{
  return [self lastObject];
}

@end /* Stack */

@implementation Stack (Debug)

/*
 * Print debugging information.
 */
- (void)_printDebugInfo:(int)indent
{
  size_t idx = 0;

  debug_print(indent, "Num elements = %d\n", numElements);
  debug_print(indent, "Max elements = %d\n", maxElements);


  for (idx = 0; idx < numElements; idx++) {
    id thing = [self objectAt:idx];

    if (thing && [thing respondsTo:@selector(print:)]) {
      [thing printDebug:"List element"
             withIndent:(indent + [Object debugIndentLevel])];
    }
  }
}

@end /* Stack (Debug) */

/* Stack.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
