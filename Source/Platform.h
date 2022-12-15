/*
 * Platform.h  --- Platform detection interface.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun,  8 Nov 2015 04:43:45 +0000 (GMT)
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
#import "Number.h"
#import "String.h"
#import "Boolean.h"

/*
 * This class implements an operating system version property.
 */
@interface Platform : Property
{
  Number  *_major;              // Major version number.
  Number  *_minor;              // Minor version number.
  String  *_product;            // Product name.
  String  *_platform;           // Platform name.
  Boolean *_OpenStep;           // Is the platform an OpenStep?
}

/*
 * Initialisation and destruction.
 */
- (id)init;
- (id)free;

/*
 * Accessors.
 */
- (Number *)majorVersion;
- (Number *)minorVersion;
- (String *)versionString;
- (String *)product;
- (String *)platform;

/*
 * Predicates.
 */
- (Boolean *)isOpenStep;

/*
 * Utilities.
 */
- (void)print;

@end                            // Platform

@interface Platform (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // Platform (Debug)

/* Platform.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
