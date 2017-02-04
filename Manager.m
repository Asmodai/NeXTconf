/*
 * Manager.m  --- Instance manager implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
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

#import "Manager.h"
#import "Utils.h"
#import "List+Debug.h"

@implementation Manager

/*
 * Obtain the singleton instance.
 */
+ (id)sharedInstance
{
  static Manager *instance = nil;

  if (instance == nil) {
    instance = [[self alloc] _initFromShared_];
  }

  return instance;
}

- (id)init
{
  [Object error:"Please do not call Manager's init method directly."];

  return nil;
}

/*
 * Initialise a new instance.
 */
- (id)_initFromShared_
{
  if ((self = [super init]) != nil) {
    _instances = [[HashTable alloc] initKeyDesc:"*"];
    _methods   = [[HashTable alloc] initKeyDesc:"@"];
  }

  return self;
}

/*
 * Free the instance.
 */
- (id)free
{
  if (_instances) {
    [_instances freeObjects];
    [_instances free];
    _instances = nil;
  }

  return [super free];
}

/*
 * Adds an instance to the manager.
 */
- (void)addInstance:(id)anObject
{
  [_instances insertKey:[[anObject class] name]
                  value:anObject];
}

/*
 * Removes an instance from the manager.
 */
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
  List *lst = nil;

  lst = [_methods valueForKey:aClass];
  if (lst == nil) {
    return NO;
  }

  if ([lst indexOf:aString] == 0) {
    return NO;
  }

  return YES;
}

- (id)findInstance:(String *)aClass
{
  return [_instances valueForKey:[aClass stringValue]];
}

@end /* Manager */

@implementation Manager (Debug)

/*
 * Print debugging information.
 */
- (void)_printDebugInfo:(int)indent
{
  const char  *ikey = NULL;
  String      *mkey = nil;
  id           val  = nil;
  NXHashState  state;

  if (_instances) {
    state = [_instances initState];

    debug_print(indent, "Instances:\n");
    debug_print(indent, "Num elements = %d\n", [_instances count]);

    while ([_instances nextState:&state
                             key:(void *)&ikey
                           value:(void *)&val])
    {
      debug_print(indent, "Key   = %s\n", ikey);

      if ([val respondsTo:@selector(printDebug:withIndent:)]) {
        [val printDebug:ikey
             withIndent:(indent + [Object debugIndentLevel])];
      } else {
        debug_print(indent, "Value = %s\n", [[val class] name]);
      }
    }
  }

  if (_methods) {
    state = [_methods initState];

    debug_print(indent, "Methods:\n");
    debug_print(indent, "Num elements = %d\n", [_methods count]);

    while ([_methods nextState:&state
                           key:(void *)&mkey
                         value:(void *)&val])
    {
      debug_print(indent, "Key   = %s\n", [mkey stringValue]);

      if ([val respondsTo:@selector(printDebug:withIndent:)]) {
        [val printDebug:[mkey stringValue]
             withIndent:(indent + [Object debugIndentLevel])];
      } else {
        debug_print(indent, "Value = %s\n", [[val class] name]);
      }
    }
  }
}

@end /* Manager (Debug) */

/* Manager.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
