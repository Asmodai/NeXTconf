/*
 * Header.m  --- Header generator implementation.
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 18 Feb 2017 19:27:39 +0000 (GMT)
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

#import "Header.h"
#import "PropertyManager.h"
#import "Utils.h"

#import <stdio.h>
#import <stdlib.h>

header_symbol_t *
new_header_symbol(String *name)
{
  header_symbol_t *symb = NULL;

  symb          = xmalloc(sizeof(struct header_symbol));
  symb->name    = name;
  symb->enabled = NO;

  return symb;
}

void
free_header_symbol(header_symbol_t *symb)
{
  xfree(symb->name);
  xfree(symb);
  symb = NULL;
}

void
debug_print_header_symbol(header_symbol_t *symb)
{
  if (symb == NULL) {
    return;
  }

  fprintf(stdout, "Name -> %s\n", [symb->name stringValue]);
  fprintf(stdout, "Set  -> %s\n", symb->enabled == YES ? "Yes" : "No");
}

@implementation Header

- (id)init
{
  if ((self = [super init]) != nil) {
    _symbols = [[List alloc] init];

    ADD_PROPERTY_METHOD("addSymbol:");
    ADD_PROPERTY_METHOD("enableSymbol:");
    ADD_PROPERTY_METHOD("disableSymbol:");
    ADD_PROPERTY_METHOD("hasSymbol:");
  }

  return self;
}

- (id)free
{
  MAYBE_FREE(_symbols);

  return [super free];
}

- (void)addSymbol:(String *)aSymbol
{
  [_symbols addObjectIfAbsent:(id)new_header_symbol(aSymbol)];
}

void
do_toggle(List *lst, String *sym, BOOL val)
{
  header_symbol_t *symb  = NULL;
  unsigned         count = [lst count];
  unsigned         i     = 0;

  for (i = 0; i < count; ++i) {
    symb = (header_symbol_t *)[lst objectAt:i];

    if (symb == NULL || (id)symb == nil) {
      continue;
    }

    if ([sym isEqual:symb->name]) {
      symb->enabled = val;
    }
  }
}

- (void)enableSymbol:(String *)aSymbol
{
  do_toggle(_symbols, aSymbol, YES);
}

 - (void)disableSymbol:(String *)aSymbol
{
  do_toggle(_symbols, aSymbol, NO);
}

- (Boolean *)hasSymbol:(String *)aSymbol
{
  header_symbol_t *symb  = NULL;
  unsigned         count = [_symbols count];
  unsigned         i     = 0;

  for (i = 0; i < count; ++i) {
    symb = (header_symbol_t *)[_symbols objectAt:i];

    if (symb == NULL || (id)symb == nil) {
      continue;
    }

    if ([aSymbol isEqual:symb->name]) {
      return [[Boolean alloc] initWithBool:YES];
    }
  }

  return [[Boolean alloc] initWithBool:NO];
}



@end                            // Header

@implementation Header (Debug)

- (void)_printDebugInfo:(int)indent
{
  header_symbol_t *symb  = NULL;
  unsigned         count = [_symbols count];
  unsigned         i     = 0;

  debug_print(indent, "type       = header definitions\n");
  debug_print(indent, "count      = %d\n", count);

  if (count > 0) {
    for (i = 0; i < count; ++i) {
      symb = (header_symbol_t *)[_symbols objectAt:i];

      if (symb == NULL || (id)symb == nil) {
        debug_print(indent, "define %03d = NULL!\n", i);
      } else {
        debug_print(indent, "define %03d = %s\n", i, [symb->name stringValue]);
      }
    }
  }
}

@end                            // Header (Debug)

/* Header.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
