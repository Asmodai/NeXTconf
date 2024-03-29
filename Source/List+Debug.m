/*
 * List+Debug.m  --- List debugging category implementation.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Mon,  9 Nov 2015 01:09:03 +0000 (GMT)
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

#import "List+Debug.h"
#import "Utils.h"

@implementation List (Debug)

- (void)_printDebugInfo:(int)indent
{
  unsigned i       = 0;
  id       val     = nil;
  int      nindent = indent + [Object debugIndentLevel];

  for (i = 0; i < [self count]; i++) {
    val = [self objectAt:i];

    if ([val respondsTo:@selector(printDebug:withIndent:)]) {
      debug_print(nindent, "Element %d", i);
      [val printDebug:""
           withIndent:nindent];
    } else {
      debug_print(nindent, "Value = %s\n", [[val class] name]);
    }
  }
}

@end                            // List (Debug)

/* List+Debug.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
