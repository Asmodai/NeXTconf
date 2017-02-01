/*
 * Architecture.m  --- Architecture detection implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Mon,  9 Nov 2015 03:14:50 +0000 (GMT)
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

#import <unistd.h>
#import <stdio.h>
#import <libc.h>
#import <ctype.h>

#import <sys/types.h>

#import <mach/mach.h>
#import <mach/host_info.h>
#import <mach/mach_host.h>
#import <mach/mach_error.h>

#import "Manager.h"
#import "Architecture.h"
#import "Utils.h"
#import "snprintf.h"

static const char *arch_dirs[] = {
  "/lib/",
  "/usr/libexec/"
};

BOOL
have_arch(const char *arch)
{
  size_t i                   = 0;
  char   buf[MAXPATHLEN + 1] = { 0 };

  for (i = 0; i < ARRAYSIZE(arch_dirs); i++) {
    snprintf(buf,
             MAXPATHLEN,
             "%s%s/specs",
             arch_dirs[i],
             arch);

    if (file_exists(buf)) {
      return YES;
    }
  }

  return NO;
}

void
detect_hardware(String *machine, String *processor)
{
  kern_return_t           kret  = 0;
  struct host_basic_info  kbi   = { 0 };
  unsigned int            count = HOST_BASIC_INFO_COUNT;
  char                   *mach  = NULL;
  char                   *proc  = NULL;

  kret = host_info(host_self(),
                   HOST_BASIC_INFO,
                   (host_info_t)&kbi,
                   &count);

  if (kret != KERN_SUCCESS) {
    mach_error("host_info() failed.", kret);
  } else {
    slot_name(kbi.cpu_type,
              kbi.cpu_subtype,
              &mach,
              &proc);

    [machine setStringValue:mach];
    [processor setStringValue:proc];

  }
}

@implementation Architecture

- (id)init
{
  if ((self = [super init]) != nil) {
    _processor = [[String alloc] init];
    _machine   = [[String alloc] init];

    detect_hardware(_machine, _processor);

    _hasIX86  = have_arch("i386");
    _hasM68K  = have_arch("m68k");
    _hasSPARC = have_arch("sparc");
    _hasHPPA  = have_arch("hppa");
    _hasPPC   = have_arch("ppc");

    MANAGER_ADD_METHOD("currentArchitecture");
    MANAGER_ADD_METHOD("currentProcessor");
    MANAGER_ADD_METHOD("isDeveloperInstalled");
    MANAGER_ADD_METHOD("hasM68K");
    MANAGER_ADD_METHOD("hasIX86");
    MANAGER_ADD_METHOD("hasSPARC");
    MANAGER_ADD_METHOD("hasHPPA");
    MANAGER_ADD_METHOD("hasPPC");
  }

  return self;
}

- (id)free
{
  if (_processor) {
    [_processor free];
    _processor = nil;
  }

  if (_machine) {
    [_machine free];
    _machine = nil;
  }

  return [super free];
}

- (String *)currentArchitecture;
{
  return _machine;
}

- (String *)currentProcessor;
{
  return _processor;
}

- (BOOL)isDeveloperInstalled
{
  static BOOL value = -1;

  if (value == -1) {
    value = (_hasIX86 || _hasM68K  || _hasSPARC || _hasHPPA  || _hasPPC);
  }

  return value;
}

- (BOOL)hasM68K
{
  return _hasM68K;
}

- (BOOL)hasIX86
{
  return _hasIX86;
}

- (BOOL)hasSPARC
{
  return _hasSPARC;
}

- (BOOL)hasHPPA
{
  return _hasHPPA;
}

- (BOOL)hasPPC
{
  return _hasPPC;
}

@end /* Architecture */

@implementation Architecture (Debug)

- (void)_printDebugInfo:(int)indent
{
  if (_processor) {
    [_processor printDebug:"Processor"
                withIndent:indent];
  }

  if (_machine) {
    [_machine printDebug:"Machine"
              withIndent:indent];
  }

  debug_print(indent, "Have ix86      = %s\n", bool2string(_hasIX86));
  debug_print(indent, "Have M680x0    = %s\n", bool2string(_hasM68K));
  debug_print(indent, "Have SPARC     = %s\n", bool2string(_hasSPARC));
  debug_print(indent, "Have PA-RISC   = %s\n", bool2string(_hasHPPA));
  debug_print(indent, "Have PowerPC   = %s\n", bool2string(_hasPPC));
  
  debug_print(indent,
              "Have developer = %s\n",
              bool2string([self isDeveloperInstalled]));
}

@end /* Architecture (Debug) */

/* Architecture.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
