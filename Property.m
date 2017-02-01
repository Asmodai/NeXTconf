/*
 * Property.m  --- Property base class implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun,  8 Nov 2015 05:09:36 +0000 (GMT)
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

#import "Property.h"
#import "Utils.h"
#import "Manager.h"

@implementation Property

/*
 * Initialise a new instance.
 */
- (id)init
{
  if ((self = [super init]) != nil) {
    [[Manager sharedInstance] addInstance:self];
  }

  return self;
}

/*
 * Free an instance.
 */
- (id)free
{
  [[Manager sharedInstance] removeInstance:self];

  return [super free];
}

@end /* Property */

@implementation Property (Debug)

/*
 * Print debugging information.
 */
- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "property = %s\n", [[self class] name]);
}

@end /* Property (Debug) */

/* Property.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
