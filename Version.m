/*
 * Version.m  --- Program version implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
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

/* So we can run `strings' on the binary. */
const char VERSIONSTR[]      = __VersionStr;
const char VERSIONSHORTSTR[] = __VersionShortStr;
const char BUILDSTR[]        = __BuildStr;
const char BUILDSYSFULL[]    = __BuildSysFull;
const char BUILDDATE[]       = __BuildDate;
const char BUILTBY[]         = __BuiltBy "@" __BuildHost;

@implementation Version

/*
 * Returns the version string.
 */
+ (const char *)versionString
{
  return VERSIONSTR;
}

/*
 * Returns the short version string.
 */
+ (const char *)versionShortString
{
  return VERSIONSHORTSTR;
}

/*
 * Returns the build string.
 */
+ (const char *)buildString
{
  return BUILDSTR;
}

/*
 * Returns the build system string.
 */
+ (const char *)buildSystemString
{
  return BUILDSYSFULL;
}

/*
 * Returns the build date.
 */
+ (const char *)buildDateString
{
  return BUILDDATE;
}

/*
 * Returns the `built by' string.
 */
+ (const char *)builtByString
{
  return BUILTBY;
}

/*
 * Print program version details to standard output.
 */
+ (void)print
{
  printf("This is %s\n\n"
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

@end

/* Version.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
