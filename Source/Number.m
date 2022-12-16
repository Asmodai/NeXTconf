/*
 * Number.m  --- Numeric data type Implementation
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
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

#import <stdio.h>
#import <stdlib.h>
#import <string.h>

#define SET_FLOAT(__a, __b)  (__a)._n._f = (__b); (__a).type = Float
#define GET_FLOAT(__a)       (__a)._n._f

#define SET_INT(__a, __b)    (__a)._n._i = (__b); (__a).type = Integer
#define GET_INT(__a)         (__a)._n._i

#define SET_TYPE(__a, __b)   (__a).type = (__b)
#define GET_TYPE(__a)        (__a).type

#define FREE_CACHE()                \
  if (_cache != NULL) {             \
    xzonefree([self zone], _cache); \
    _cache = NULL;                  \
  }

#define MAX_NUMBER_LEN  64

inline
size_t
integer_size(long_t num)
{
  size_t len = 0;
  
  do {
    num /= 10;
    len++;
  } while (num > 0);

  return len;
}

@implementation Number

- (id)init
{
  _cache = NULL;

  return [self initWithInt:0];
}

- (id)initWithInt:(long_t)value
{
  if ((self = [super init]) != nil) {
    _cache = NULL;
    SET_INT(_number, value);
  }

  return self;
}

- (id)initWithFloat:(float_t)value
{
  if ((self = [super init]) != nil) {
    _cache = NULL;
    SET_FLOAT(_number, value);
  }

  return self;
}

- (id)initWithString:(const char *)string
{
  if ((self = [super init]) != nil) {
    _cache = NULL;
    [self setValueFromString:string];
  }

  return self;
}

- (id)free
{
  if (_cache != NULL) {
    xzonefree([self zone], _cache);
    _cache = NULL;
  }

  return [super free];
}

/*
 * Numerical immediates should always be bound.
 */
- (BOOL)isBound
{
  return YES;
}

/*
 * Oh this is a hack.
 */
- (size_t)length
{
  size_t len = 0;
  long_t n   = 0;
  
  switch (GET_TYPE(_number)) {
    case Float: n   = (long_t)GET_FLOAT(_number); len += 3;
    default:    len += integer_size(GET_INT(_number));
  }

  return len;
}

- (long_t)intValue
{
  if (GET_TYPE(_number) == Float) {
    return (long_t)GET_FLOAT(_number);
  }

  return GET_INT(_number);
}

- (float_t)floatValue
{
  if (GET_TYPE(_number) == Integer) {
    return (float_t)GET_INT(_number);
  }

  return GET_FLOAT(_number);
}

- (const char *)stringValue
{
  if (_cache == NULL) {
    _cache = xzonemalloc([self zone], MAX_NUMBER_LEN * sizeof *_cache);
    
    switch (GET_TYPE(_number)) {
      case Float: snprintf(_cache, MAX_NUMBER_LEN, "%0.2f", GET_FLOAT(_number)); break;
      default:    snprintf(_cache, MAX_NUMBER_LEN, "%lu",   GET_INT(_number));   break;
    }

    _cache[MAX_NUMBER_LEN] = '\0';
  }
  
  return (const char *)_cache;
}

- (void)setValueFromInt:(long_t)value
{
  SET_INT(_number, value);
  FREE_CACHE();
}

- (void)setValueFromFloat:(float_t)value
{
  SET_FLOAT(_number, value);
  FREE_CACHE();
}

- (void)setValueFromString:(const char *)string
{
  if (!string) {
    SET_INT(_number, 0);
    FREE_CACHE();
    return;
  }

  if (strchr(string, '.') != NULL) {
    SET_FLOAT(_number, (float_t)atof(string));
  } else {
    SET_INT(_number, (long_t)atoi(string));
  }

  FREE_CACHE();
}

- (number_t)internalValue
{
  return _number;
}

- (Number *)add:(Number *)aNumber
{
  Number   *ret    = nil;
  number_t  other  = [aNumber internalValue];
  number_t  result = { 0 };

  if (GET_TYPE(other) == Float) {
    if (GET_TYPE(_number) == Integer) {
      SET_FLOAT(result, (float_t)GET_INT(_number) + GET_FLOAT(other));
    } else {
      SET_FLOAT(result, GET_FLOAT(_number) + GET_FLOAT(other));
    }
  } else {
    if (GET_TYPE(_number) == Integer) {
      SET_INT(result, GET_INT(_number) + GET_INT(other));
    } else {
      SET_FLOAT(result, GET_FLOAT(_number) + (float_t)GET_INT(other));
    }
  }

  if (GET_TYPE(result) == Float) {
    ret = [[Number alloc] initWithFloat:GET_FLOAT(result)];
  } else {
    ret = [[Number alloc] initWithInt:GET_INT(result)];
  }

  FREE_CACHE();

  return ret;
}

- (Number *)subtract:(Number *)aNumber
{
  Number   *ret    = nil;
  number_t  other  = [aNumber internalValue];
  number_t  result = { 0 };

  if (GET_TYPE(other) == Float) {
    if (GET_TYPE(_number) == Integer) {
      SET_FLOAT(result, (float_t)GET_INT(_number) - GET_FLOAT(other));
    } else {
      SET_FLOAT(result, GET_FLOAT(_number) - GET_FLOAT(other));
    }
  } else {
    if (GET_TYPE(_number) == Integer) {
      SET_INT(result, GET_INT(_number) - GET_INT(other));
    } else {
      SET_FLOAT(result, GET_FLOAT(_number) - (float_t)GET_INT(other));
    }
  }

  if (GET_TYPE(result) == Float) {
    ret = [[Number alloc] initWithFloat:GET_FLOAT(result)];
  } else {
    ret = [[Number alloc] initWithInt:GET_INT(result)];
  }

  FREE_CACHE();

  return ret;
}

/* XXX Handle 0. */
- (Number *)multiply:(Number *)aNumber
{
  Number   *ret    = nil;
  number_t  other  = [aNumber internalValue];
  number_t  result = { 0 };

  if (GET_TYPE(other) == Float) {
    if (GET_TYPE(_number) == Integer) {
      SET_FLOAT(result, (float_t)GET_INT(_number) * GET_FLOAT(other));
    } else {
      SET_FLOAT(result, GET_FLOAT(_number) * GET_FLOAT(other));
    }
  } else {
    if (GET_TYPE(_number) == Integer) {
      SET_INT(result, GET_INT(_number) * GET_INT(other));
    } else {
      SET_FLOAT(result, GET_FLOAT(_number) * (float_t)GET_INT(other));
    }
  }

  if (GET_TYPE(result) == Float) {
    ret = [[Number alloc] initWithFloat:GET_FLOAT(result)];
  } else {
    ret = [[Number alloc] initWithInt:GET_INT(result)];
  }

  FREE_CACHE();

  return ret;
}

/* XXX Handle 0! */
- (Number *)divide:(Number *)aNumber
{
  Number   *ret    = nil;
  number_t  other  = [aNumber internalValue];
  number_t  result = { 0 };

  if (GET_TYPE(other) == Float) {
    if (GET_TYPE(_number) == Integer) {
      SET_FLOAT(result, (float_t)GET_INT(_number) / GET_FLOAT(other));
    } else {
      SET_FLOAT(result, GET_FLOAT(_number) / GET_FLOAT(other));
    }
  } else {
    if (GET_TYPE(_number) == Integer) {
      SET_INT(result, GET_INT(_number) / GET_INT(other));
    } else {
      SET_FLOAT(result, GET_FLOAT(_number) / (float_t)GET_INT(other));
    }
  }

  if (GET_TYPE(result) == Float) {
    ret = [[Number alloc] initWithFloat:GET_FLOAT(result)];
  } else {
    ret = [[Number alloc] initWithInt:GET_INT(result)];
  }

  FREE_CACHE();

  return ret;
}

- (BOOL)isEqual:(id)anObject
{
  if (anObject == self) {
    return YES;
  }

  if ([anObject respondsTo:@selector(internalValue)]) {
    number_t other = [anObject internalValue];

    if (GET_TYPE(_number) == GET_TYPE(other)) {

      if (GET_TYPE(_number) == Integer) {
        return (GET_INT(_number) == GET_INT(other)) ? YES : NO;
      }

      return (GET_FLOAT(_number) == GET_FLOAT(other)) ? YES : NO;

    } else {

      if (GET_TYPE(_number) == Integer && GET_TYPE(other) == Float) {
        return (GET_INT(_number) == (long_t)GET_FLOAT(other)) ? YES : NO;
      }

      return (GET_FLOAT(_number) == GET_INT(other)) ? YES : NO;

    }
  }

  return NO;
}

@end                            // Number

@implementation Number (Debug)

- (void)_printDebugInfo:(int)indent
{
  switch (_number.type) {
   case Integer:
     debug_print(indent, "type  = integer\n");
     debug_print(indent, "value = %lu\n", GET_INT(_number));
     break;

    case Float:
     debug_print(indent, "type  = float\n");
     debug_print(indent, "value = %f\n", GET_FLOAT(_number));
     break;
  }
}

@end                            // Number (Debug)

/* Number.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
