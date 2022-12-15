/*
 * Pointer.m  --- Pointer container implementation.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 18:39:15 +0000 (GMT)
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

#import "Pointer.h"
#import "Utils.h"

@implementation Pointer

- (id)init
{
  return [self initWithPointer:NULL];
}

- (id)initWithPointer:(void *)ptr
{
  if ((self = [super init]) != nil) {
    _ptr = ptr;
  }

  return self;
}

- (id)free
{
  /* Do NOT free the pointer. */
  _ptr = NULL;

  return [super free];
}

- (void)setPointer:(void *)ptr
{
  _ptr = ptr;
}

- (void *)pointer
{
  return _ptr;
}

- (void)invalidate
{
  /* Do NOT modify the pointer. */
  _ptr = NULL;
}

@end                            // Pointer

@implementation Pointer (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "ptr = %p\n", _ptr);
}

@end                            // Pointer (Debug)

/* Pointer.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
