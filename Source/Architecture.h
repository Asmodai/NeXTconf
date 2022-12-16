/*
 * Architecture.h  --- Architecture detection.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
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
#import "Boolean.h"

/*
 * This class defines an object that stores various system
 * architecture properties.
 */
@interface Architecture : Property
{
  String  *_processor;          // Processor type.
  String  *_machine;            // Machine type.
  Boolean *_hasIX86;            // Can compiler do Intel?
  Boolean *_hasM68K;            // Can compiler do m68k?
  Boolean *_hasSPARC;           // Can compiler do SPARC?
  Boolean *_hasHPPA;            // Can compiler do PA-RISC?
  Boolean *_hasPPC;             // Can compiler to PPC?
  Boolean *_hasDeveloper;       // Is Developer installed?
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
- (Boolean *)isDeveloperInstalled;
- (Boolean *)hasM68K;
- (Boolean *)hasIX86;
- (Boolean *)hasSPARC;
- (Boolean *)hasHPPA;
- (Boolean *)hasPPC;

/*
 * Utilities.
 */
- (void)print;

@end                            // Architecture

@interface Architecture (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // Architecture (Debug)

/* Architecture.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
