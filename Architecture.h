/*
 * Architecture.h  --- Architecture detection.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/09 07:22:22 asmodai>
 * Revision:   7
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat,  7 Nov 2015 07:00:55 +0000 (GMT)
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
#import <objc/List.h>
#import "Object+Debug.h"
#import "List+Debug.h"

#import "Property.h"
#import "String.h"
#import "Number.h"

@interface Architecture : Property
{
  String *_processor;
  String *_machine;
  BOOL    _hasIX86;
  BOOL    _hasM68K;
  BOOL    _hasSPARC;
  BOOL    _hasHPPA;
  BOOL    _hasPPC;
}

/*
 * Initialisation and destruction.
 */
- (id)init;
- (id)free;

/*
 * Accessors.
 */
- (String *)currentArchitecture;
- (String *)currentProcessor;

/*
 * Predicates.
 */
- (BOOL)isDeveloperInstalled;
- (BOOL)hasM68K;
- (BOOL)hasIX86;
- (BOOL)hasSPARC;
- (BOOL)hasHPPA;
- (BOOL)hasPPC;

@end /* Architecture */

@interface Architecture (Debug)

- (void)_printDebugInfo:(int)indent;

@end /* Architecture (Debug) */

/* Architecture.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
