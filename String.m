/*
 * String.m  --- String implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 01:52:25 +0000 (GMT)
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

#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>
#import <libc.h>
#import <string.h>

#import <objc/objc-runtime.h>

#import "snprintf.h"
#import "String.h"
#import "Utils.h"

/*
 * Map NXToLower and NXToUpper to standard C library stuff.
 */
#ifndef PLATFORM_NEXTSTEP
# import <ctype.h>
# define NXToLower    tolower
# define NXToUpper    toupper
#endif

#define MIN_STRING_BUFFER_SIZE    15

@implementation String

/*
 * Initialise a string with no value.
 */
- (id)init
{
  if ((self = [super init]) != nil) {
    _length   = 0;
    _capacity = 0;
    _buffer   = NULL;

    [self allocateBuffer:MIN_STRING_BUFFER_SIZE
                fromZone:[self zone]];
  }

  return self;
}

/*
 * Initialise a string with a given capacity and no value.
 */
- (id)initWithCapacity:(size_t)capacity
{
  return [self initWithCapacity:capacity
                       fromZone:[self zone]];
}

/*
 * Initialise a string with a given capacity from the given memory
 * zone and no value.
 */
- (id)initWithCapacity:(size_t)capacity
              fromZone:(NXZone *)zone
{
  [self init];

  if (self) {
    [self allocateBuffer:capacity
                fromZone:zone];
  }

  return self;
}

/*
 * Initialise a string with a given C string value.
 */
- (id)initWithString:(const char *)string
{
  [self init];

  if (self) {
    [self setStringValue:string];
  }

  return self;
}

/*
 * Initialise a string with a given value from a format string.
 */
- (id)initFromFormat:(const char *)fmt, ...
{
  va_list  ap;
  char    *buf = NULL;

  buf = (char *)NXZoneMalloc([self zone], 1024);

  va_start(ap, fmt);
  vsnprintf(buf, 1024, fmt, ap);
  va_end(ap);

  [self initWithString:buf];
  NX_FREE(buf);

  return self;
}

/*
 * Allocate a buffer of a given size.
 */
- (id)allocateBuffer:(size_t)size
{
  return [self allocateBuffer:size
                     fromZone:[self zone]];
}

/*
 * Allocate a buffer of a given size from the given memory zone.
 */
- (id)allocateBuffer:(size_t)size
            fromZone:(NXZone *)zone
{
  if (size <= _capacity) {
    return self;
  }

  [self freeString];

  if (!size) {
    return self;
  }

  _capacity     = size + 1;
  _buffer       = (char *)NXZoneMalloc(zone, _capacity);
  _buffer[0]    = '\0';
  _buffer[size] = '\0';

  return self;
}

/*
 * Make a copy of a string into this string's buffer.
 */
- (char *)getCopyInto:(char *)buf
{
  if (!buf) {
    buf = NXZoneMalloc([self zone], (_length + 1) * sizeof *buf);
  }

  strncpy(buf, _buffer, _length);

  return buf;
}

/*
 * Free a string's value.
 */
- (id)freeString
{
  if (_buffer) {
    free(_buffer);
  }

  _buffer   = NULL;
  _length   = 0;
  _capacity = 0;

  return self;
}

/*
 * Free a string.
 */
- (id)free
{
  [self freeString];

  return [super free];
}

/*
 * Is the string empty?
 */
- (BOOL)isEmpty
{
  return _length > 0 ? NO : YES;
}

/*
 * Returns the character at a given index.
 *
 * If the index is out of bounds, then the null character is returned.
 */
- (char)charAt:(int)index
{
  if ((index < 0) || (index > _length - 1)) {
    return '\0';
  }

  return (char)_buffer[index];
}

/*
 * Count the number of the given character in the string.
 *
 * This method is case sensitive.
 */
- (size_t)numOfChar:(char)aChar
{
  return [self numOfChar:aChar
           caseSensitive:YES];
}

/*
 * Count the number of the given character in the string.
 */
- (size_t)numOfChar:(char)aChar
      caseSensitive:(BOOL)sense
{
  size_t idx = 0;
  size_t cnt = 0;

  if (sense) {
    for (idx = 0; idx < _length; idx++) {
      if (_buffer[idx] == aChar) {
        cnt++;
      }
    }
  } else {
    for (idx = 0; idx < _length; idx++) {
      if (NXToUpper(_buffer[idx]) == NXToUpper(aChar)) {
        cnt++;
      }
    }
  }

  return cnt;
}

/*
 * Count the number of given characters in the string.
 *
 * This method is case sensitive.
 */
- (size_t)numOfChars:(const char *)aString
{
  return [self numOfChars:aString
            caseSensitive:YES];
}

/*
 * Count the number of given characters in the string.
 */
- (size_t)numOfChars:(const char *)aString
       caseSensitive:(BOOL)sense
{
  size_t idx    = 0;
  size_t cnt    = 0;
  id     tmpStr = nil;

  if (!aString) {
    return 0;
  }

  tmpStr = [[String alloc] initWithString:aString];

  for (idx = 0; idx < _length; idx++) {
    if ([tmpStr spotOf:_buffer[idx] caseSensitive:sense] != -1) {
      cnt++;
    }
  }
  [tmpStr free];

  return cnt;
}

/*
 * Returns the length of the string.
 */
- (size_t)length
{
  return _length;
}

/*
 * Recalculates and returns the length of the string.
 */
- (size_t)recalcLength
{
  if (_buffer) {
    _length = strlen(_buffer);
  } else {
    _length = 0;
  }

  return _length;
}

/*
 * Fixes the length of the string.
 *
 * This is designed to be used after a string manipulation that changes
 * the bytes in the string's buffer.
 */
- (id)fixStringLength
{
  char *tmp = NULL;

  tmp = NXCopyStringBufferFromZone(_buffer, [self zone]);
  if (!tmp) {
    return nil;
  }

  [self freeString];

  _buffer   = tmp;
  _length   = strlen(_buffer);
  _capacity = _length + 1;

  return self;
}

/*
 * Fixes the length of the string, starting at the given offset.
 */
- (id)fixStringLengthAt:(size_t)index
{
  if (!_buffer) {
    return self;
  }

  if (_length <= index) {
    return self;
  }

  _buffer[index] = '\0';
  _length        = index;

  [self fixStringLength];

  return self;
}

/*
 * Sets the string's capacity to the given value.
 */
- (id)setCapacity:(size_t)capacity
{
  char *tmp = NULL;

  tmp = NXCopyStringBufferFromZone(_buffer, [self zone]);
  if (!tmp) {
    return nil;
  }

  [self allocateBuffer:capacity
              fromZone:[self zone]];

  [self setStringValue:tmp
              fromZone:[self zone]];

  free(tmp);

  return self;
}

/*
 * Returns the string's capacity.
 */
- (size_t)capacity
{
  return _capacity;
}

/*
 * Sets the string's value to the given C string.
 */
- (void)setStringValue:(const char *)string
{
  [self setStringValue:string
              fromZone:[self zone]];
}

/*
 * Sets the string's value to the given C string, with the resulting
 * string being stored in the given memory zone.
 */
- (void)setStringValue:(const char *)string
              fromZone:(NXZone *)zone
{
  int len;

  if (!string) {
    return;
  }

  len = strlen(string);
  [self allocateBuffer:(len + 1)
              fromZone:zone];

  strcpy(_buffer, string);
  _length = len;
}

/*
 * Reeturns the string's value.
 */
- (const char *)stringValue
{
  return _buffer;
}

/*
 * Returns the string's unique value.
 */
- (NXAtom)uniqueStringValue
{
  return NXUniqueString(_buffer);
}

/*
 * Returns the string's value as an integer.
 */
- (int)intValue
{
  if (!_buffer) {
    return 0;
  }

  return atoi(_buffer);
}

/*
 * Is the string equal to another object?
 */
- (BOOL)isEqual:(id)anObject
{
  if (anObject == self) {
    return YES;
  }

  if ([anObject respondsTo:@selector(stringValue)]) {
    if (strcmp(_buffer, [anObject stringValue]) == 0) {
      return YES;
    }
  }

  return NO;
}

/*
 * Compute the string's hash value.
 */
- (unsigned int)hash
{
  return NXStrHash(NULL, _buffer);
}

/*
 * Returns the location of the first occurrence of the given character.
 *
 * This method is case sensitive.
 */
- (int)spotOf:(char)aChar
{
  return [self spotOf:aChar
           occurrence:0
        caseSensitive:YES];
}

/*
 * Returns the location of the first occurrence of the given character.
 */
- (int)spotOf:(char)aChar
caseSensitive:(BOOL)sense
{
  return [self spotOf:aChar
           occurrence:0
        caseSensitive:YES];
}

/*
 * Returns the location of the next occurrence of the given character
 * after the given occurence.
 */
- (int)spotOf:(char)aChar
   occurrence:(int)occurrence
caseSensitive:(BOOL)sense
{
  int cur = -1;
  int cnt = 0;

  if (occurrence < 0) {
    return -1;
  }

  while ((cur < occurrence) && (cnt < _length)) {
    if (!sense) {
      if (NXToUpper(_buffer[cnt]) == NXToUpper(aChar)) {
        cur++;
      }
    } else {
      if (_buffer[cur] == aChar) {
        cur++;
      }
    }

    cnt++;
  }

  if (cur != occurrence) {
    return -1;
  }

  return cnt - 1;
}

/*
 * Converts the string to lower case.
 */
- (id)toLower
{
  if (_buffer) {
    size_t i = 0;

    for (i = 0; i < _length; i++) {
      _buffer[i] = NXToLower(_buffer[i]);
    }
  }

  return self;
}

/*
 * Converts the string to upper case.
 */
- (id)toUpper
{
  if (_buffer) {
    size_t i = 0;

    for (i = 0; i < _length; i++) {
      _buffer[i] = NXToUpper(_buffer[i]);
    }
  }

  return self;
}

- (id)left:(size_t)count
  fromZone:(NXZone *)zone
{
  char smash = 0;
  id   nstr  = nil;

  if ((count < 0) || (!_buffer)) {
    return nil;
  }

  if (count == 0) {
    return [String new];
  }

  if (count >= _length) {
    return [self copyFromZone:zone];
  }

  nstr           = [[[self class] allocFromZone:zone] init];
  smash          = _buffer[count];
  _buffer[count] = '\0';
  [nstr setStringValue:_buffer fromZone:zone];
  _buffer[count] = smash;

  return nstr;
}

- (id)right:(size_t)count
   fromZone:(NXZone *)zone
{
  id nstr = nil;

  if ((count < 0) || (!_buffer)) {
    return nil;
  }

  if (count == 0) {
    return [String new];
  }

  if (count >= _length) {
    return [self copyFromZone:zone];
  }

  nstr = [[[self class] allocFromZone:zone] init];
  [nstr setStringValue:&_buffer[_length - count] fromZone:zone];

  return nstr;
}

- (id)left:(size_t)count
{
  return [self left:count fromZone:[self zone]];
}

- (id)right:(size_t)count
{
  return [self right:count fromZone:[self zone]];
}

/*
 * Concatenate a string.
 */
- (id)cat:(const char *)aString
{
  if (!aString) {
    return nil;
  }

  return [self cat:aString
            length:strlen(aString)
          fromZone:[self zone]];
}

/*
 * Concatenate a string of a given length.
 */
- (id)cat:(const char *)aString
   length:(size_t)n
{
  return [self cat:aString
            length:n
          fromZone:[self zone]];
}


/*
 * Concatenate a string of a given length from a given memory zone.
 */
- (id)cat:(const char *)aString
   length:(size_t)n
 fromZone:(NXZone *)zone
{
  char   *nBuf  = NULL;
  size_t  nSize = 0;

  if (!(aString || _buffer)) {
    return nil;
  }

  if (!_buffer) {
    char *tBuf = (char *)NXZoneMalloc(zone, n + 1);

    if (!tBuf) {
      return nil;
    }

    strncpy(tBuf, aString, n);
    tBuf[n] = '\0';
    
    [self setStringValue:tBuf fromZone:zone];
    free(tBuf);
    
    return self;
  }

  if (!aString) {
    return self;
  }
 
  if (n > strlen(aString)) {
    n = strlen(aString);
  }

  nSize = _length + n + 1;
  if (nSize > _capacity) {
    nBuf    = (char *)NXZoneMalloc(zone, nSize);
    _capacity = nSize;
    nBuf[0] = '\0';

    strcat(nBuf, _buffer);
    strncat(nBuf, aString, n);
    free(_buffer);
    _buffer = nBuf;
  } else {
    strncat(_buffer, aString, n);
  }

  _length = strlen(_buffer);

  return self;
}

/*
 * Concatenate a list of strings.
 */
- (id)concatenate:(id)strings, ...
{
  id      aString;
  va_list ptr;

  va_start(ptr, strings);
  aString = strings;
  while (aString) {
    if ([aString respondsTo:@selector(stringValue)]) {
      const char *sptr = [aString stringValue];
      [self cat:sptr
         length:([aString respondsTo:@selector(length)]
                 ? [aString length]
                 : strlen(sptr))
       fromZone:[self zone]];
    }
    aString = va_arg(ptr, id);
  }
  va_end(ptr);

  return self;
}

/*
 * Insert a string at a given position.
 */
- (id)insert:(const char *)aString
          at:(size_t)index
{
  id t1 = nil;
  id t2 = nil;

  if ((aString == NULL) || (strlen(aString) <= 0)) {
    return self;
  }

  if (index < 0) {
    index = 0;
  }

  if (index >= _length) {
    return [self cat:aString];
  }

  t1 = [self left:index];
  if (!t1) {
    t1 = [[[self class] alloc] init];
  }

  t2 = [self right:_length - index];
  [[t1 cat:aString] concatenate:t2];
  [self setStringValue:[t1 stringValue]];

  [t1 free];
  [t2 free];

  return self;
}

/*
 * Insert a stringable thing at a given position.
 */
- (id)insertString:(id)sender
                at:(size_t)index
{
  if (![sender respondsTo:@selector(stringValue)]) {
    return self;
  }

  return [self insert:[sender stringValue] at:index];
}

/*
 * Insert a string.
 */
- (id)insert:(const char *)aString
{
  return [self insert:aString at:0];
}

/*
 * Insert a stringable thing.
 */
- (id)insertString:(id)sender
{
  return [self insertString:sender at:0];
}

/*
 * Insert a string with a format specifier.
 */
- (id)insertFromFormat:(const char *)format, ...
{
  va_list args;

  va_start(args, format);
  [self insertAt:0
     fromFormat:format
      arguments:args];
  va_end(args);

  return self;
}

/*
 * Insert a string at a given position using varargs.
 */
- (id)insertAt:(size_t)index
    fromFormat:(const char *)format, ...
{
  va_list args;

  va_start(args, format);
  [self insertAt:index
      fromFormat:format
       arguments:args];
  va_end(args);

  return self;
}

/*
 * Insert a string at a position with computed varargs.
 */
- (id)insertAt:(size_t)index
    fromFormat:(const char *)format
     arguments:(va_list)args
{
  char *buf = NULL;

  buf = (char *)NXZoneMalloc([self zone], 1024);

  vsnprintf(buf, 1024, format, args);

  [self insert:buf at:index];
  NX_FREE(buf);

  return self;
}

@end /* String */

@implementation String (Debug)

/*
 * Prints debugging information.
 */
- (void)_printDebugInfo:(int)indent
{
  debug_print(indent,
              "str       = [%s] (%#x)\n",
              _buffer,
              (unsigned int)_buffer);

  debug_print(indent, "len       = %d\n", _length);
  debug_print(indent, "allocated = %d\n", _capacity);
}

@end /* String (Debug) */

/* String.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
