/*
 * PropertyManager.m  --- Property manager implementation.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun,  8 Nov 2015 06:17:28 +0000 (GMT)
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

#import "PropertyManager.h"
#import "Utils.h"
#import "List+Debug.h"
#import "Property.h"
#import "Utils.h"

#import <objc/Object.h>
#import <objc/Protocol.h>

#import <objc/objc-class.h>
#import <objc/objc-runtime.h>

#import <stdio.h>
#import <stdlib.h>

@implementation PropertyManager

+ (id)sharedInstance
{
  static PropertyManager *instance = nil;

  if (instance == nil) {
    instance = [[self alloc] _init_];
  }

  return instance;
}

- (id)init
{
  [Object error:"Please do not call PropertyManager's init method directly."];

  return nil;
}

- (id)_init_
{
  if ((self = [super init]) != nil) {
    _instances = [[HashTable alloc] initKeyDesc:"*"];
    _methods   = [[HashTable alloc] initKeyDesc:"@"];
  }

  return self;
}

- (id)free
{
  if (_instances) {
    [_instances freeObjects];
    [_instances free];
    _instances = nil;
  }

  return [super free];
}

- (void)addInstance:(id)anObject
{
  [_instances insertKey:[[anObject class] name]
                  value:anObject];
}

- (void)removeInstance:(id)anObject
{
  id obj = nil;

  obj = [_instances valueForKey:[[anObject class] name]];
  if (obj != nil) {
    [_instances removeKey:obj];
  }
}

- (void)addMethod:(String *)aMethod
         forClass:(id)aClass
{
  List   *lst = nil;
  String *cls = nil;

  cls = [[String alloc] initWithString:[[aClass class] name]];
  lst = [_methods valueForKey:cls];

  if ([self haveInstanceOf:cls] == NO) {
    runtime_warningf(
      0,
      "Trying to add method `%s' for non-existing class `%s'!",
      [aMethod stringValue],
      [cls stringValue]
    );
  }

  if (lst == nil) {
    lst = [[List alloc] init];
  } else {
    [_methods removeKey:cls];
  }

  [lst addObjectIfAbsent:aMethod];
  [_methods insertKey:cls
                value:lst];
}

- (void)removeMethod:(String *)aMethod
            forClass:(id)aClass
{
  List   *lst = nil;
  String *cls = nil;

  cls = [[String alloc] initWithString:[[aClass class] name]];
  lst = [_methods valueForKey:cls];

  if (lst) {
    [_methods removeKey:cls];
  }
}

- (BOOL)haveInstanceOf:(String *)aClass
{
  return [_instances valueForKey:[aClass stringValue]] == nil
           ? NO
           : YES;
}

- (BOOL)haveMethod:(String *)aString
          forClass:(String *)aClass
{
  register List   *lst = nil;
  register size_t  idx = 0;

  lst = [_methods valueForKey:aClass];
  if (lst == nil) {
    return NO;
  }

  for (idx = 0; idx < [lst count]; idx++) {
    if ([aString isEqual:[lst objectAt:idx]]) {
      return YES;
    }
  }

  return NO;
}

- (id)findInstance:(String *)aClass
{
  return [_instances valueForKey:[aClass stringValue]];
}

- (void)instantiateAllClasses
{
  NXHashTable       *classes = objc_getClasses();
  NXHashState        state   = NXInitHashState(classes);
  Class              cls     = NULL;
  static const char *parent  = "Property";

  while (NXNextHashState(classes, &state, (void *)&cls) != 0) {
    if (strcmp(parent, object_getClassName((id)cls->super_class)) == 0) {
      [[cls alloc] init];
    }
  }

  // Do not free `classes' :)  
}

@end                            // PropertyManager

@implementation PropertyManager (Debug)

- (void)_printDebugInfo:(int)indent
{
  const char  *ikey = NULL;
  String      *mkey = nil;
  id           val  = nil;
  NXHashState  state;

  if (_instances) {
    state = [_instances initState];

    debug_print(indent, "Instances:\n");
    debug_print(indent + 2, "Num elements = %d\n", [_instances count]);

    while ([_instances nextState:&state
                             key:(void *)&ikey
                           value:(void *)&val])
    {
      putchar('\n');
      debug_print(indent + 2, "Key = `%s'\n", ikey);

      if ([val respondsTo:@selector(printDebug:withIndent:)]) {
        [val printDebug:ikey
             withIndent:(indent + 2 + [Object debugIndentLevel])];
      } else {
        debug_print(indent + 2, "Value = `%s'\n", [[val class] name]);
      }
    }
  }


  if (_methods) {
    state = [_methods initState];

    putchar('\n');
    debug_print(indent, "Methods:\n");
    debug_print(indent + 2, "Num elements = %d\n", [_methods count]);

    while ([_methods nextState:&state
                           key:(void *)&mkey
                         value:(void *)&val])
    {
      putchar('\n');
      debug_print(indent + 2, "Key = `%s'\n", [mkey stringValue]);

      if ([val respondsTo:@selector(printDebug:withIndent:)]) {
        [val printDebug:[mkey stringValue]
             withIndent:(indent + 2 + [Object debugIndentLevel])];
      } else {
        debug_print(indent + 2, "Value = `%s'\n", [[val class] name]);
      }
    }
  }
}

@end                            // PropertyManager (Debug)

/* PropertyManager.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
