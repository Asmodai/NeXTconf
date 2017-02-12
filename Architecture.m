/*
 * Architecture.m  --- Architecture detection implementation.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
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

/*
 * Location for 'specs' files.
 */
static const char *arch_dirs[] = {
  "/lib/",
  "/usr/libexec/"
};

/*
 * Determine whether we have support for an architecture by looking
 * for its spec file.  If there's a spec file, the compiler supports
 * the architecture, thus we can claim to support it.
 */
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

    _hasIX86  = [[Boolean alloc] initWithBool:have_arch("i386")];
    _hasM68K  = [[Boolean alloc] initWithBool:have_arch("m68k")];
    _hasSPARC = [[Boolean alloc] initWithBool:have_arch("sparc")];
    _hasHPPA  = [[Boolean alloc] initWithBool:have_arch("hppa")];
    _hasPPC   = [[Boolean alloc] initWithBool:have_arch("ppc")];

    _hasDeveloper = [[Boolean alloc] initWithBool:(([_hasIX86 boolValue]  ||
                                                    [_hasM68K boolValue]  ||
                                                    [_hasSPARC boolValue] ||
                                                    [_hasHPPA boolValue]  ||
                                                    [_hasPPC boolValue])
                                                   ? YES
                                                   : NO)];
    
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

  [_hasIX86 free];
  [_hasM68K free];
  [_hasSPARC free];
  [_hasHPPA free];
  [_hasPPC free];
  [_hasDeveloper free];

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

- (Boolean *)isDeveloperInstalled
{
  return _hasDeveloper;
}

- (Boolean *)hasM68K
{
  return _hasM68K;
}

- (Boolean *)hasIX86
{
  return _hasIX86;
}

- (Boolean *)hasSPARC
{
  return _hasSPARC;
}

- (Boolean *)hasHPPA
{
  return _hasHPPA;
}

- (Boolean *)hasPPC
{
  return _hasPPC;
}

- (void)print
{
  fprintf(stdout, "Architecture Information\n");
  fprintf(stdout, "\tProcessor:      %s\n", [_processor stringValue]);
  fprintf(stdout, "\tMachine:        %s\n", [_machine stringValue]);
  fprintf(stdout, "\tHave Intel:     %s\n", [_hasIX86 stringValue]);
  fprintf(stdout, "\tHave Motorola:  %s\n", [_hasM68K stringValue]);
  fprintf(stdout, "\tHave SPARC:     %s\n", [_hasSPARC stringValue]);
  fprintf(stdout, "\tHave HPPA:      %s\n", [_hasHPPA stringValue]);
  fprintf(stdout, "\tHave PowerPC:   %s\n", [_hasPPC stringValue]);
  fprintf(stdout, "\tHave Developer: %s\n", [_hasDeveloper stringValue]);
  fprintf(stdout, "\n");
}

@end                            // Architecture

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

  debug_print(indent, "Have ix86      = %s\n", [_hasIX86 stringValue]);
  debug_print(indent, "Have M680x0    = %s\n", [_hasM68K stringValue]);
  debug_print(indent, "Have SPARC     = %s\n", [_hasSPARC stringValue]);
  debug_print(indent, "Have PA-RISC   = %s\n", [_hasHPPA stringValue]);
  debug_print(indent, "Have PowerPC   = %s\n", [_hasPPC stringValue]);
  debug_print(indent, "Have developer = %s\n", [_hasDeveloper stringValue]);
}

@end                            // Architecture (Debug)

/* Architecture.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
