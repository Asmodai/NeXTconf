/*
 * MakeFile.h  --- Makefile generator interface.
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 18 Feb 2017 19:37:05 +0000 (GMT)
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
#import "List+Debug.h"

#import "Property.h"
#import "String.h"
#import "Number.h"
#import "Boolean.h"

/*
 * This class defines an object that stores various flags
 * and information that is then written to a Makefile.
 */
@interface MakeFile : Property
{
  List *_libraries;
  List *_paths;
}

/*
 * Initialisation and destruction.
 */
- (id)init;
- (id)free;

/*
 * Accessors.
 */
- (void)addLibrary:(String *)aLibrary;
- (void)addLibraryPath:(String *)aPath;

/*
 * Predicates.
 */

@end                            // MakeFile

@interface MakeFile (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // MakeFile (Debug)

@interface MakeFile (Generator)

- (void)generate:(String *)aPath;

@end				// MakeFile (Generator)

/* MakeFile.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * mode: objc ***
 * End: ***
 */
