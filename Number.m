/*
 * Number.m  --- Numeric data type Implementation
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 05:22:45 +0000 (GMT)
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

#import "Number.h"
#import "Utils.h"
#import "snprintf.h"

#import <stdio.h>
#import <stdlib.h>

@implementation Number

/*
 * Initialise a new instance.
 *
 * The initial value defaults to 0.
 */
- (id)init
{
  return [self initWithInt:0];
}

/*
 * Initialise an instance using the given integer value.
 */
- (id)initWithInt:(int)value
{
  if ((self = [super init]) != nil) {
    _number = value;
  }

  return self;
}

/*
 * Initialise an instance using the given string value.
 *
 * The string is converted into an integer.
 */
- (id)initWithString:(const char *)string
{
  if ((self = [super init]) != nil) {
    _number = 0;

    [self setValueFromString:string];
  }

  return self;
}

/*
 * Free the instance.
 */
- (id)free
{
  return [super free];
}

/*
 * Returns the integer value.
 */
- (int)intValue
{
  return _number;
}

/*
 * Returns the string representation of the number.
 *
 * This value MUST be freed.
 */
- (const char *)stringValue
{
  char *buf = NULL;

  buf = malloc(256 * sizeof *buf);
  if (buf == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  snprintf(buf, 256, "%d", _number);

  return (const char *)buf;
}

/*
 * Sets the value from the given integer.
 */
- (void)setValueFromInt:(int)value
{
  _number = value;
}

/*
 * Sets the value from the given string.
 */
- (void)setValueFromString:(const char *)string
{
  if (!string) {
    _number = 0;
    return;
  }

  _number = atoi(string);
}

/*
 * Is this object equal to another?
 */
- (BOOL)isEqual:(id)anObject
{
  if (anObject == self) {
    return YES;
  }

  if ([anObject respondsTo:@selector(intValue)]) {
    if (_number == [anObject intValue]) {
      return YES;
    }
  }

  return NO;
}

@end /* Number */

@implementation Number (Debug)

/*
 * Display debugging information.
 */
- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "int = %d\n", _number);
}

@end /* Number (Debug) */

/* Number.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
