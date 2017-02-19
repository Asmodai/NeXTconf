/*
 * MakeFile.m  --- Makefile generator implementation.
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 18 Feb 2017 19:39:06 +0000 (GMT)
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

#import "MakeFile.h"
#import "PropertyManager.h"
#import "Utils.h"

@implementation MakeFile

- (id)init
{
  if ((self = [super init]) != nil) {
    ADD_PROPERTY_METHOD("addLibrary:");
    ADD_PROPERTY_METHOD("addLibraryPath:");
  }

  return self;
}

- (id)free
{
  return [super free];
}

- (void)addLibrary:(String *)aLibrary
{
}

- (void)addLibraryPath:(String *)aPath
{
}

@end                            // MakeFile

@implementation MakeFile (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "Object does nothing yet.\n");
}

@end                            // MakeFile (Debug)

/* MakeFile.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
