/*
 * Version.h  --- Program version class interface.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat,  7 Nov 2015 06:53:37 +0000 (GMT)
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

#import "Property.h"
#import "Number.h"
#import "Boolean.h"

/* Pull in version information. */
#import "version.h"

/*
 * Program version information.
 *
 * The data here is generated at compile-time by a script.
 */
@interface Version : Property

/*
 * Class methods.
 */
+ (const char *)copyright;
+ (const char *)versionString;
+ (const char *)versionShortString;
+ (const char *)buildString;
+ (const char *)buildSystemString;
+ (const char *)buildDateString;
+ (const char *)builtByString;
+ (void)printToBuffer:(char *)buf
             withSize:(size_t)size;
+ (void)print;

/*
 * Initialisation and destruction.
 */
- (id)init;
- (id)free;

/*
 * Instance methods.
 */
- (Number *)version;
- (Number *)major;
- (Number *)minor;
- (Number *)build;
- (Boolean *)isGreaterThan:(Number *)aVersion;
- (Boolean *)isGreaterThanOrEqualTo:(Number *)aVersion;

@end                            // Version

@interface Version (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // Version (Debug)

/* Version.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
