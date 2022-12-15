/*
 * Header.m  --- Header generator implementation.
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 18 Feb 2017 19:27:39 +0000 (GMT)
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

#import "Header.h"
#import "PropertyManager.h"
#import "Utils.h"

@implementation Header

- (id)init
{
  if ((self = [super init]) != nil) {
    ADD_PROPERTY_METHOD("addSymbol:");
    ADD_PROPERTY_METHOD("hasSymbol:");
  }

  return self;
}

- (id)free
{
  return [super free];
}

- (void)addSymbol:(String *)aSymbol
{
  // Nothing here yet!
}

- (Boolean *)hasSymbol:(String *)aSymbol
{
  return [[Boolean alloc] initWithBool:YES];
}

@end                            // Header

@implementation Header (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "Object does nothing yet.\n");
}

@end                            // Header (Debug)

/* Header.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
