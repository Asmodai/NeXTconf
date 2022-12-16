/*
 * FileSystem.m  --- File system class implementation.
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 18 Feb 2017 17:56:52 +0000 (GMT)
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

#import "FileSystem.h"
#import "PropertyManager.h"
#import "Utils.h"

#import <unistd.h>
#import <stdio.h>
#import <stdlib.h>
#import <libc.h>
#import <errno.h>

#import <sys/types.h>
#import <sys/param.h>
#import <sys/dir.h>
#import <sys/stat.h>

@implementation FileSystem

- (id)init
{
  if ((self = [super init]) != nil) {
    ADD_PROPERTY_METHOD("fileExists:");
    ADD_PROPERTY_METHOD("directoryExists:");
  }

  return self;
}

- (id)free
{
  return [super free];
}

- (Boolean *)fileExists:(String *)aFile
{
  Boolean *ret = [[Boolean alloc] initWithBool:NO];

  if (aFile && [aFile length] > 0) {
    [ret setValueFromBool:file_exists([aFile stringValue])];
  }

  return ret;
}

- (Boolean *)directoryExists:(String *)aDirectory
{
  Boolean *ret = [[Boolean alloc] initWithBool:NO];

  if (aDirectory && [aDirectory length] > 0) {
    [ret setValueFromBool:directory_exists([aDirectory stringValue])];
  }

  return ret;
}

@end                            // FileSystem

@implementation FileSystem (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "Object just provides functions.\n");
}

@end                            // FileSystem (Debug)

/* FileSystem.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
