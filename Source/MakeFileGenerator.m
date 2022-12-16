/*
 * MakefileGenerator.m  --- Makefile generation,
 *
 * Copyright (c) 2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Fri,  16 Dec 2022 03:54:55 +0000 (GMT)
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

#import "MakeFile.h"

#import <stdio.h>
#import <stdlib.h>

@implementation MakeFile (Generator)

static const char *prefix  = "OTHER_LDFLAGS =";

- (void)generate:(String *)aPath
{
  char     *buf    = NULL;
  unsigned  lcount = 0;
  unsigned  pcount = 0;
  unsigned  i      = 0;
  size_t    size   = 0;

  if (aPath == nil || [aPath length] == 0) {
    return;
  }

  lcount = [_libraries count];
  pcount = [_paths count];

  /* Get size of libraries list. */
  for (i = 0; i < lcount; ++i) {
    size += ([[_libraries objectAt:i] length] + 3);
  }

  /* Get size of paths list. */
  for (i = 0; i < pcount; ++i) {
    size += ([[_paths objectAt:i] length] + 3);
  }

  /* Allocate result buffer. */
  buf = xmalloc((sizeof *buf * size) + 1);

  /* Populate library flags. */
  for (i = 0; i < pcount; ++i) {
    snprintf(buf, size, "%s -L%s", buf, [[_paths objectAt:i] stringValue]);
  }
 
  /* Populate link-libraries flags. */ 
  for (i = 0; i < lcount; ++i) {
    snprintf(buf, size, "%s -l%s", buf, [[_libraries objectAt:i] stringValue]);
  }

  buf[size] = '\0';

  printf("%s%s\n", prefix, buf);
  xfree(buf);
}

@end				// MakeFile (Generator)

/* MakefileGenerator.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */

