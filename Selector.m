/*
 * Selector.m  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Wed,  1 Feb 2017 18:52:48 +0000 (GMT)
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

#import "Selector.h"
#import "Manager.h"
#import "Utils.h"
#import "snprintf.h"

#import <stdio.h>
#import <stdlib.h>

#import <objc/objc-runtime.h>

@implementation Selector

/*
 * Initialise a new instance.
 */
- (id)init
{
  return [self initWithMethod:NULL
                     forClass:NULL];
}

/*
 * Initialise a new instance with a class and method.
 *
 * This builds a selector using gnarly low-level stuff that might not
 * be portable across Objective-C implementations.
 */
- (id)initWithMethod:(const char *)aMethod
            forClass:(const char *)aClass
{
  if ((self = [super init]) != nil) {
    _method   = [[String alloc] initWithString:aMethod];
    _class    = [[String alloc] initWithString:aClass];
    _selector = NULL;

    if ([_method length] > 0) {
      _selector = sel_registerName([_method stringValue]);
    }
  }

  return self;
}

/*
 * Free the instance.
 */
- (id)free
{
  [_method free];
  [_class free];

  _method   = nil;
  _class    = nil;
  _selector = NULL;

  return [super free];
}

/*
 * Get the selector.
 */
- (SEL)selector
{
  return _selector;
}

- (const char *)stringValue
{
  if (_selector == NULL) {
    return NULL;
  }

  return sel_getName(_selector);
}

- (String *)method
{
  return [_method copy];
}

- (String *)class
{
  return [_class copy];
}

- (id)evaluate
{
  id class = nil;

  if ([[Manager sharedInstance] haveMethod:_method
                                  forClass:_class])
  {
    class = [[Manager sharedInstance] findInstance:_class];

    if (class == nil) {
      fprintf(stderr,
              "Could not find the class '%s', are you missing something?",
              [_class stringValue]);
      exit(EXIT_FAILURE);
    }
  }

  if ([class respondsTo:_selector]) {
    return [class perform:_selector];
  }  

  fprintf(stderr,
          "Class '%s' [%s] does not respond to method '%s'.\n",
          [_class stringValue],
          [class name],
          [_method stringValue]);

  return nil;
}


@end /* Selector */

@implementation Selector (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "class    = %s\n", [_class stringValue]);
  debug_print(indent, "method   = %s\n", [_method stringValue]);

  if (_selector != NULL) {
    debug_print(indent, "selector = %s\n", sel_getName(_selector));
  }
}

@end /* Selector (Debug) */


/* Selector.m ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
