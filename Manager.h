/*
 * Manager.h  --- Instance manager.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun,  8 Nov 2015 05:47:57 +0000 (GMT)
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
#import <objc/HashTable.h>
#import <objc/List.h>

#import "String.h"

#define MANAGER_ADD_METHOD(__m)                      \
  [[Manager sharedInstance]                          \
     addMethod:[[String alloc] initWithString:(__m)] \
      forClass:[self class]]

@interface Manager : Object
{
  HashTable *_instances;        /* Hash of instances. */
  HashTable *_methods;          /* Hash of method calls. */
}

/*
 * Singleton methods.
 */
+ (id)sharedInstance;

/*
 * Initialisation.
 */
- (id)init;
- (id)_initFromShared_;

/*
 * Class instances.
 */
- (void)addInstance:(id)anObject;
- (void)removeInstance:(id)anObject;

/*
 * Methods.
 */
- (void)addMethod:(String *)aMethod
         forClass:(id)aClass;

- (void)removeMethod:(String *)aMethod
            forClass:(id)aClass;

/*
 * Predicates.
 */
- (BOOL)haveInstanceOf:(String *)aClass;
- (BOOL)haveMethod:(String *)aString
          forClass:(String *)aClass;

@end /* Manager */

@interface Manager (Debug)

- (void)_printDebugInfo:(int)indent;

@end /* Manager (Debug) */


/* Manager.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
