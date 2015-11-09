/*
 * Platform.m  --- Some title
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/09 01:28:11 asmodai>
 * Revision:   5
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun,  8 Nov 2015 06:50:16 +0000 (GMT)
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

#include <unistd.h>
#include <stdio.h>
#include <libc.h>
#include <ctype.h>

#include <mach/mach.h>
#include <mach/host_info.h>
#include <mach/mach_host.h>
#include <mach/mach_error.h>

#import "Manager.h"
#import "Platform.h"
#import "Utils.h"
#import "snprintf.h"

/**
 * Maximum number of characters in a line.
 *
 * This is used when loading in the software version file.
 */
#define DETECT_MAX_LINE    200

static int _major_version = 0;

static int _minor_version = 0;

static String *_version_string = nil;



/**
 * Platform information structure.
 */
typedef struct platform_s {
  char   *name;                 /* Platform pretty name. */
  char   *platform;             /* Platform name. */
  int     major;                /* Major version matcher. */
  int     minor;                /* Minor version matcher. -1 to ignore. */
  char   *versionFile;          /* Version file name. */
  char   *codename;             /* Platform codename. */
  BOOL    isOpenStep;           /* Is the platform OpenStep-compliant? */
} platform_t;

/*
 * `Supported' platforms.
 */
static const platform_t known_platforms[] = {
  {
    "NEXTSTEP 3.x",
    "NEXTSTEP",
    3,
    -1,
    "/usr/lib/NextStep/software_version",
    NULL,
    NO
  }, {
    "NEXTSTEP 4.0 Preview Release 1",
    "NEXTSTEP",
    4,
    0,
    "/usr/lib/NextStep/software_version",
    "Lantern2S",
    YES
  }, {
    "OPENSTEP 4.x",
    "OPENSTEP",
    4,
    -1,
    "/usr/lib/NextStep/software_version",
    NULL,
    YES
  }, {
    "Rhapsody Operating System",
    "Rhapsody",
    5,
    -1,
    "/System/Library/CoreServices/software_version",
    NULL,
    YES
  }
};

/*
 * Attempt to match the given platform using the software version's
 * codename.
 */
static
BOOL
codename_match(const platform_t *platform)
{
  BOOL  rval = NO;
  char *line = NULL;
  FILE *file = NULL;

  /* If the platform given is not valid, exit. */
  if (!platform) {
    return NO;
  }

  /* Attempt to allocate buffer for the line. */
  line = (char *)malloc(DETECT_MAX_LINE *sizeof *line);
  if (!line) {
    perror("Out of memory");
    exit(EXIT_FAILURE);
  }

  /*
   * Does the platform structure have a valid `versionfile' entry?
   */
  if (platform->versionFile == NULL) {
    return NO;
  }

  /*
   * Does the platform have a valid `codename' entry?
   */
  if (platform->codename == NULL) {
    return NO;
  }

  /*
   * Can we open the version file?
   */
  if ((file = fopen(platform->versionFile, "r")) == NULL) {
    return NO;
  }

  /* Ignore the first line. */
  (void)fgets(line, DETECT_MAX_LINE, file);

  /* Read and process the second line. */
  if ((fgets(line, DETECT_MAX_LINE, file)) != NULL) {
    if (strncmp(platform->codename,
                line,
                strlen(platform->codename)) == 0)
    {
      /* All good */
      rval = YES;
    }
  }

  return rval;
}

/*
 * Attempt to match a major and minor version number to a platform.
 */
static
const platform_t *
get_platform(int major, int minor)
{
  size_t            i    = 0;
  const platform_t *best = NULL;

  for (i = 0; i < ARRAYSIZE(known_platforms); i++) {
    /* Well, here we get to look at the major version first. */
    if (major == known_platforms[i].major) {
      /*
       * Now, things here get somewhat interesting... if the known
       * platform has a minor version of -1, then we don't care about
       * matching on the minor version number.
       */
      if (known_platforms[i].minor == -1) {
        best = &known_platforms[i];
      } else {
        /* Ok, we need to match on the minor version. */
        if (minor == known_platforms[i].minor) {
          best = &known_platforms[i];
        }
      }

      /*
       * Now things get tricky.  Once we've checked the major and
       * minor, we must also check the codename... else we could run
       * into the situation where OPENSTEP 4.x is considered NEXTSTEP
       * 4.0.
       */
      if (codename_match(&known_platforms[i])) {
        /* We want to immediately exit now. */
        return &known_platforms[i];
      }
    }
  }
  
  return best;
}

/*
 * Get the operating system version from the Mach kernel.
 */
static
BOOL
get_os_version(void)
{
  kern_return_t    kret                        = 0;
  kernel_version_t kver                        = "";
  size_t           idx                         = 0;
  size_t           len                         = 0;
  char             version[KERNEL_VERSION_MAX] = { 0 };

  kret = host_kernel_version(host_self(),kver);
  if (kret != KERN_SUCCESS) {
    mach_error("host_kernel_version() failed.", kret);
    return NO;
  }

  strncpy(version, kver, KERNEL_VERSION_MAX);
  len = strlen(version);

  if (version[len - 1] == '\n') {
    version[len - 1] = '\0';
  }

  for (idx = 0; idx < len; idx++) {
    /* version \d.\d: */
    if (isdigit(version[idx])     && version[idx + 1] == '.' &&
        isdigit(version[idx + 2]) && version[idx + 3] == ':')
    {
      _major_version = version[idx] - '0';
      _minor_version = version[idx + 2] - '0';
      break;
    }

    /* version \d.\d.\d: */
    if (isdigit(version[idx])     && version[idx + 1] == '.' &&
        isdigit(version[idx + 2]) && version[idx + 3] == '.' &&
        isdigit(version[idx + 4]) && version[idx + 5] == ':')
    {
      _major_version = version[idx] - '0';
      _minor_version = version[idx + 2] - '0';
      break;
    }
  }

  return YES;
}

@implementation Platform

/*
 * Initialise a new instance.
 */
- (id)init
{
  if ((self = [super init]) != nil) {
    const platform_t *platform = NULL;

    /*
     * First, get the version numbers from the Mach kernel.
     */
    if (get_os_version() == NO) {
      fprintf(stderr, "Could not get kernel version from Mach.\n");
      exit(EXIT_FAILURE);
    }

    /*
     * Now we can use them to get the right entry from the platform
     * structure.
     */
    platform = get_platform(_major_version, _minor_version);

    _major = [[Number alloc] initWithInt:_major_version];
    _minor = [[Number alloc] initWithInt:_minor_version];

    /* Grab the platform details. */
    if (platform) {
      _product  = [[String alloc] initWithString:platform->name];
      _platform = [[String alloc] initWithString:platform->platform];
      _OpenStep = platform->isOpenStep;
    } else {
      _product  = [[String alloc] initWithString:"Unknown"];
      _platform = [[String alloc] initWithString:"Unknown"];
      _OpenStep = NO;
    }

    MANAGER_ADD_METHOD("majorVersion");
    MANAGER_ADD_METHOD("minorVersion");
    MANAGER_ADD_METHOD("versionString");
    MANAGER_ADD_METHOD("product");
    MANAGER_ADD_METHOD("platform");
    MANAGER_ADD_METHOD("isOpenStep");
  } 

  return self;
}

/*
 * Free an instance.
 */
- (id)free
{
  if (_version_string) {
    [_version_string free];
    _version_string = nil;
  }

  [_major free];
  [_minor free];
  [_product free];
  [_platform free];
      
  return [super free];
}

/*
 * Returns the major version.
 */
- (Number *)majorVersion
{
  return _major;
}

/*
 * Returns the minor version.
 */
- (Number *)minorVersion
{
  return _minor;
}

/*
 * Returns the version string.
 */
- (String *)versionString
{
  if (_version_string == nil) {
    _version_string = [[String alloc] initFromFormat:"%d.%d",
                                      [_major intValue],
                                      [_minor intValue]];
  }

  return _version_string;
}

/*
 * Returns the product name.
 */
- (String *)product
{
  return _product;
}

/*
 * Returns the platform name.
 */
- (String *)platform
{
  return _platform;
}

/*
 * Is the platform an implementation of the OpenStep specification?
 */
- (BOOL)isOpenStep
{
  return _OpenStep;
}

@end /* Platform */

@implementation Platform (Debug)

/*
 * Print debugging info.
 */
- (void)_printDebugInfo:(int)indent
{
  if (_major) {
    [_major printDebug:"Major version"
            withIndent:indent];
  }

  if (_minor) {
    [_minor printDebug:"Minor version"
            withIndent:indent];
  }

  if (_product) {
    [_product printDebug:"Product name"
              withIndent:indent];
  }

  if (_platform) {
    [_platform printDebug:"Platform name"
               withIndent:indent];
  }

  debug_print(indent,
              "OpenStep = %s\n",
              bool2string(_OpenStep));
}

@end /* Platform (Debug) */

/* Platform.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */