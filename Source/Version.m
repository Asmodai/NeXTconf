/*
 * Version.m  --- Program version implementation.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat,  7 Nov 2015 06:56:00 +0000 (GMT)
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

#import "Version.h"
#import "PropertyManager.h"

/* So we can run `strings' on the binary. */
const char COPYRIGHT[]       = __Copyright;
const char VERSIONSTR[]      = __VersionStr;
const char VERSIONSHORTSTR[] = __VersionShortStr;
const char BUILDSTR[]        = __BuildStr;
const char BUILDSYSFULL[]    = __BuildSysFull;
const char BUILDDATE[]       = __BuildDate;
const char BUILTBY[]         = __BuiltBy "@" __BuildHost;

@implementation Version

+ (const char *)copyright
{
  return COPYRIGHT;
}

+ (const char *)versionString
{
  return VERSIONSTR;
}

+ (const char *)versionShortString
{
  return VERSIONSHORTSTR;
}

+ (const char *)buildString
{
  return BUILDSTR;
}

+ (const char *)buildSystemString
{
  return BUILDSYSFULL;
}

+ (const char *)buildDateString
{
  return BUILDDATE;
}

+ (const char *)builtByString
{
  return BUILTBY;
}

+ (void)printToBuffer:(char *)buf
             withSize:(size_t)size
{
  snprintf(buf,
           size,
           "This is %s\n\n"
           "Build:        %s\n"
           "Built on:     %s\n"
           "Built by:     %s\n"
           "Build system: %s\n\n",
           VERSIONSHORTSTR,
           BUILDSTR,
           BUILDDATE,
           BUILTBY,
           BUILDSYSFULL);
}

+ (void)print
{
  char *buf = NULL;

  buf = xmalloc(sizeof *buf * 512);

  [Version printToBuffer:buf
                withSize:511];

  printf("%s", buf);

  xfree(buf);
}

- (id)init
{
  if ((self = [super init]) != nil) {
    ADD_PROPERTY_METHOD("version");
    ADD_PROPERTY_METHOD("major");
    ADD_PROPERTY_METHOD("minor");
    ADD_PROPERTY_METHOD("build");
    ADD_PROPERTY_METHOD("isGreaterThan:");
    ADD_PROPERTY_METHOD("isGreaterThanOrEqualTo:");
  }

  return self;
}

- (id)free
{
  return [super free];
}

- (Number *)version
{
  static Number *vers = nil;

  if (vers == nil) {
    vers = [[Number alloc] initWithInt:__Version];
  }

  return vers;
}

- (Number *)major
{
  static Number *vers = nil;

  if (vers == nil) {
    vers = [[Number alloc] initWithInt:__VersionMajor];
  }

  return vers;
}

- (Number *)minor
{
  static Number *vers = nil;

  if (vers == nil) {
    vers = [[Number alloc] initWithInt:__VersionMinor];
  }

  return vers;
}

- (Number *)build
{
  static Number *vers = nil;

  if (vers == nil) {
    vers = [[Number alloc] initWithInt:__VersionBuild];
  }

  return vers;  
}

- (Boolean *)isGreaterThan:(Number *)aVersion
{
  register unsigned long  ourVer   = __Version;
  register unsigned long  otherVer = 0;
  register BOOL           ret      = NO;

  if ([aVersion respondsTo:@selector(intValue)]) {
    otherVer = [aVersion intValue];

    ret = (ourVer > otherVer) ? YES : NO;
  }

  return [[Boolean alloc] initWithBool:ret];
}

- (Boolean *)isGreaterThanOrEqualTo:(Number *)aVersion
{
  register unsigned long  ourVer   = __Version;
  register unsigned long  otherVer = 0;
  register BOOL           ret      = NO;

  if ([aVersion respondsTo:@selector(intValue)]) {
    otherVer = [aVersion intValue];

    ret = (ourVer >= otherVer) ? YES : NO;
  }

  return [[Boolean alloc] initWithBool:ret];
}

@end                            // Version

@implementation Version (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "Version: %d\n", __Version);
  debug_print(indent, "Major:   %d\n", __VersionMajor);
  debug_print(indent, "Minor:   %d\n", __VersionMinor);
  debug_print(indent, "Build:   %d\n", __VersionBuild);
}

@end                            // Version (Debug)

/* Version.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
