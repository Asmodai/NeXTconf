/*
 * String.h  --- String.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/08 03:13:33 asmodai>
 * Revision:   22
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 01:26:55 +0000 (GMT)
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
 * This class is not meant as a replacement for MiscString or NSString,
 * but just as a simple string implementation that can be used on any
 * NeXT platform without having to have 
 */
/* }}} */

#import <objc/Object.h>
#import "Object+Debug.h"

#ifdef PLATFORM_NEXTSTEP
# import <appkit/Text.h>
#endif

#import <sys/types.h>

/*
 * We have to provide the following for non-NeXTSTEP platforms:
 *
 *  o MX_MALLOC     [-> malloc]
 *  o NX_REALLOC    [-> realloc]
 *  o NX_FREE       [-> free]
 *
 * The functions themselves are taken from AppKit's nextstd.h.
 */
#ifndef PLATFORM_NEXTSTEP
# import <objc/HashTable.h>
# import <objc/zone.h>

#define  NX_MALLOC( VAR, TYPE, NUM )                            \
  ((VAR) = (TYPE *) malloc((unsigned)(NUM)*sizeof(TYPE)))

#define  NX_REALLOC( VAR, TYPE, NUM )                           \
  ((VAR) = (TYPE *) realloc((VAR), (unsigned)(NUM)*sizeof(TYPE)))

#define  NX_FREE( PTR ) free((PTR))

#endif // !PLATFORM_NEXTSTEP

/*
 * Simple string class implementation.  This is partially based on the
 * MiscString implementation.
 *
 * It is not meant as a drop-in for either MiscString or NSString.
 */
@interface String : Object
{
  char   *_buffer;              // String buffer.
  size_t  _length;              // Length of string.
  size_t  _capacity;            // Capacity of buffer.
}

/*
 * Initialisation.
 */
- (id)init;
- (id)initWithCapacity:(size_t)capacity;
- (id)initWithCapacity:(size_t)capacity
              fromZone:(NXZone *)zone;
- (id)initWithString:(const char *)string;
- (id)initFromFormat:(const char *)fmt, ...;

/*
 * Allocation.
 */
- (id)allocateBuffer:(size_t)size;
- (id)allocateBuffer:(size_t)size
            fromZone:(NXZone *)zone;

/*
 * Copying.
 */
- (char *)getCopyInto:(char *)buf;

/*
 * Destruction.
 */
- (id)free;
- (id)freeString;

/*
 * Predicates.
 */
- (BOOL)isEmpty;

/*
 * Character methods.
 */
- (char)charAt:(int)index;
- (size_t)numOfChar:(char)aChar;
- (size_t)numOfChar:(char)aChar
      caseSensitive:(BOOL)sense;
- (size_t)numOfChars:(const char *)aString;
- (size_t)numOfChars:(const char *)aString
       caseSensitive:(BOOL)sense;
- (int)spotOf:(char)aChar;
- (int)spotOf:(char)aChar
caseSensitive:(BOOL)sense;
- (int)spotOf:(char)aChar
   occurrence:(int)occurrence
caseSensitive:(BOOL)sense;

/*
 * Length.
 */
- (size_t)length;
- (size_t)recalcLength;
- (id)fixStringLength;
- (id)fixStringLengthAt:(size_t)index;

/*
 * Capacity.
 */
- (id)setCapacity:(size_t)capacity;
- (size_t)capacity;

/*
 * Accessors.
 */
- (void)setStringValue:(const char *)string;
- (void)setStringValue:(const char *)string
              fromZone:(NXZone *)zone;
- (const char *)stringValue;
- (NXAtom)uniqueStringValue;
- (int)intValue;

/*
 * Equality.
 */
- (BOOL)isEqual:(id)anObject;

/*
 * Case conversion.
 */
- (id)toLower;
- (id)toUpper;

/*
 * Hash methods.
 */
- (unsigned int)hash;

@end /* String */

@interface String (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end /* String (Debug) */

/* String.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
