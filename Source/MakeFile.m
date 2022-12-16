/*
 * MakeFile.m  --- Makefile generator implementation.
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
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
    _libraries = [[List alloc] init];
    _paths     = [[List alloc] init];

    ADD_PROPERTY_METHOD("addLibrary:");
    ADD_PROPERTY_METHOD("addLibraryPath:");
  }

  return self;
}

- (id)free
{
  [_libraries free];
  [_paths free];

  return [super free];
}

- (void)addLibrary:(String *)aLibrary
{
  [_libraries addObjectIfAbsent:aLibrary];
}

- (void)addLibraryPath:(String *)aPath
{
  [_paths addObjectIfAbsent:aPath];
}

@end                            // MakeFile

@implementation MakeFile (Debug)

- (void)_printDebugInfo:(int)indent
{
  unsigned  lcount = [_libraries count];
  unsigned  pcount = [_paths count];
  unsigned  i      = 0;

  debug_print(indent, "type          = makefile definitions\n");
  debug_print(indent, "library count = %d\n", lcount);
  debug_print(indent, "path count    = %d\n", pcount);

  if (lcount > 0) {
    for (i = 0; i < lcount; ++i) {
      debug_print(indent, "library %03d   = %s\n", i, [[_libraries objectAt:i] stringValue]);
    }
  }

  if (pcount > 0) {
    for (i = 0; i < pcount; ++i) {
      debug_print(indent, "path %03d      = %s\n", i, [[_paths objectAt:i] stringValue]);
    }
  }
}

@end                            // MakeFile (Debug)

/* MakeFile.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
