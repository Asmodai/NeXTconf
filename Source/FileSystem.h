/*
 * FileSystem.h  --- File System class interface.
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 18 Feb 2017 17:53:07 +0000 (GMT)
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

#import "Property.h"
#import "String.h"
#import "Number.h"
#import "Boolean.h"

/*
 * This class defines methods that allow scripts to interact with
 * the underlaying file system.
 */
@interface FileSystem : Property

/*
 * Initialisation and destruction.
 */
- (id)init;
- (id)free;

/*
 * Predicates.
 */
- (Boolean *)fileExists:(String *)aFile;
- (Boolean *)directoryExists:(String *)aDirectory;

@end                            // FileSystem

@interface FileSystem (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // FileSystem (Debug)

/* FileSystem.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * mode: objc ***
 * End: ***
 */
