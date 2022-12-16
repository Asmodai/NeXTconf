/*
 * HeaderGenerator.m  --- Header generation.
 *
 * Copyright (c) 2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 18 Feb 2017 19:11:24 +0000 (GMT)
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

#import "Header.h"

@implementation Header (Generator)

static const char   *guard_start  = "#ifdef _NEXTCONF_H_\n#define _NEXTCONF_H_\n\n";
static const char   *guard_end    = "\n#endif /* _NEXTCONF_H_ */\n";
static const char   *undef_prefix = "#undef  ";
static const char   *defn_prefix  = "#define ";
static const char   *defn_postfix = " 1";
static const size_t  defn_length  = 12;

- (void)generate:(String *)aPath
{
  header_symbol_t *obj   = NULL;
  char            *buf   = NULL;
  unsigned         count = 0;
  unsigned         i     = 0;
  size_t           size  = 0;

  if (aPath == nil || [aPath length] == 0) {
    return;
  }

  count = [_symbols count];

  for (i = 0; i < count; ++i) {
    obj = (header_symbol_t*)[_symbols objectAt:i];

    if (obj == NULL || (id)obj == nil) {
      continue;
    }

    size += ([obj->name length] + defn_length) + 1;
  }

  buf = xmalloc((sizeof *buf * size) + 1);

  for (i = 0; i < count; ++i) {
    obj = (header_symbol_t*)[_symbols objectAt:i];

    if (obj == NULL || (id)obj == nil) {
      continue;
    }

    switch (obj->enabled) {
      case YES:
	snprintf(buf,
                 size,
                 "%s%s%s%s\n\0",
                 buf,
                 defn_prefix,
                 [obj->name stringValue],
                 defn_postfix);
	break;

      default:
	snprintf(buf,
                 size,
                 "%s%s%s\n\0",
                 buf,
                 undef_prefix,
                 [obj->name stringValue]);
    }
  }

  buf[size] = '\0';

  printf("%s%s%s", guard_start, buf, guard_end);
  xfree(buf);
}

@end				// Header (Generator)

/* HeaderGenerator.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * mode: objc ***
 * End: ***
 */

