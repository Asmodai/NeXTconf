/*
 * Boolean.m  --- Boolean data type implementation.
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Thu,  2 Feb 2017 15:41:11 +0000 (GMT)
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

#import "Boolean.h"
#import "Utils.h"

#import <string.h>

const char *trueCStr  = "true";
const char *falseCStr = "false";

@implementation Boolean

- (id)init
{
  return [self initWithBool:NO];
}

- (id)initWithBool:(BOOL)value
{
  if ((self = [super init]) != nil) {
    _value = value;
  }
  
  return self;
}

- (id)initWithInt:(long_t)value
{
  if ((self = [super init]) != nil) {
    _value = (value > 0) ? YES : NO;
  }

  return self;
}

- (id)free
{
  return [super free];
}

/*
 * Boolean immediates should always be bound.
 */
- (BOOL)isBound
{
  return YES;
}

- (BOOL)boolValue
{
  return _value;
}

- (const char *)stringValue
{
  if (_value) {
    return trueCStr;
  }

  return falseCStr;
}

- (long_t)intValue
{
  return (long_t)_value;
}

- (void)setValueFromBool:(BOOL)aValue
{
  _value = aValue;
}

- (void)setValueFromString:(const char *)aString
{
  if (strncasecmp(aString, trueCStr, strlen(trueCStr)) == 0) {
    _value = YES;
  }

  _value = NO;
}

- (void)setValueFromInt:(int)aValue
{
  _value = (aValue > 0) ? YES : NO;
}

- (BOOL)isEqual:(id)anObject
{
  if (anObject == self) {
    return YES;
  }

  if ([anObject respondsTo:@selector(boolValue)]) {
    if (_value == [anObject boolValue]) {
      return YES;
    }
  }

  if ([anObject respondsTo:@selector(intValue)]) {
    if (_value == (BOOL)[anObject intValue]) {
      return YES;
    }
  }

  if ([anObject respondsTo:@selector(stringValue)]) {
    if (strncasecmp([anObject stringValue], trueCStr, strlen(trueCStr)) == 0) {
      return YES;
    }
  }

  return NO;
}

@end                            // Boolean

@implementation Boolean (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "bool = %d\n", _value);
}

@end                            // Boolean (Debug)

/* Boolean.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
