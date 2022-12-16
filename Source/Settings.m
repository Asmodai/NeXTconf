/*
 * Settings.m  --- Runtime settings implementation.
 *
 * Copyright (c) 2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Fri,  16 Dec 2022 02:34:55 +0000 (GMT)
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

#define _POSIX_SOURCE
#define __STRICT_ANSI__
#import <unistd.h>
#import <sys/types.h>
#import <pwd.h>

#import "Settings.h"
#import "PropertyManager.h"
#import "Utils.h"

const char *
user_homedir()
{
  static const char *defhome = "/me";
  static const char *home    = NULL;
  struct passwd     *pw      = getpwuid(getuid());

  if (pw == NULL) {
    return defhome;
  }

  if (home == NULL) {
    home = strdup(pw->pw_dir);
  }

  return home;
}

@implementation Settings

- (id)init
{
  if ((self = [super init]) != nil) {
    _makefileLocation = [[String alloc] initWithString:user_homedir()];
    _headerLocation   = [[String alloc] initWithString:user_homedir()];
    _generateHeader   = [[Boolean alloc] initWithBool:NO];
    _generateMakefile = [[Boolean alloc] initWithBool:NO];

    ADD_PROPERTY_METHOD("generateHeader");
    ADD_PROPERTY_METHOD("generateMakefile");

    ADD_PROPERTY_METHOD("setMakefileLocation:");
    ADD_PROPERTY_METHOD("setHeaderLocation:");

    ADD_PROPERTY_METHOD("setGenerateMakefile:");
    ADD_PROPERTY_METHOD("setGenerateHeader:");
  }

  return self;
}

- (id)free
{
  MAYBE_FREE(_headerLocation);
  MAYBE_FREE(_makefileLocation);
  MAYBE_FREE(_generateHeader);
  MAYBE_FREE(_generateMakefile);
  
  return [super free];
}

- (String *)headerLocation
{
  return _headerLocation;
}

- (String *)makefileLocation
{
  return _makefileLocation;
}

- (Boolean *)generateMakefile
{
  return _generateMakefile;
}

- (Boolean *)generateHeader
{
  return _generateHeader;
}

- (void)setHeaderLocation:(String *)aString
{
  _headerLocation = aString;
}

- (void)setMakefileLocation:(String *)aString
{
  _makefileLocation = aString;
}

- (void)setGenerateHeader:(Boolean *)aBool
{
  _generateHeader = aBool;
}

- (void)setGenerateMakefile:(Boolean *)aBool
{
  _generateMakefile = aBool;
}

@end				// Settings

@implementation Settings (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "type = runtime settings\n");

  debug_print(indent, "Makefile location = %s\n", [_makefileLocation stringValue]);
  debug_print(indent, "Header location   = %s\n", [_headerLocation stringValue]);

  debug_print(indent, "Generate makefile = %s\n", [_generateMakefile stringValue]);
  debug_print(indent, "Generate header   = %s\n", [_generateHeader stringValue]);
}

@end				// Settings (Debug)

/* Settings.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
