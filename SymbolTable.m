/*
 * SymbolTable.m  --- Symbol table implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/08 00:08:10 asmodai>
 * Revision:   41
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Mon,  2 Nov 2015 23:25:14 +0000 (GMT)
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

#import "SymbolTable.h"
#import "Utils.h"

/* Default hash table capacity. */
#define DEFAULT_HASHTABLE_CAPACITY   32

@implementation SymbolTable

/*
 * Initialise a symbol table.
 */
- (id)init
{
  if ((self = [super init]) != nil) {
    _tbl = [[HashTable alloc] initKeyDesc:"%"
                                valueDesc:"@"
                                 capacity:DEFAULT_HASHTABLE_CAPACITY];
  }

  return self;
}

/*
 * Free a symbol table.
 */
- (id)free
{
  /* Free any objects if they exist. */
  if (_tbl) {
    [_tbl freeObjects];
    [_tbl free];
    _tbl = nil;
  }

  return [super free];
}

/*
 * Returns the number of items inside the symbol table.
 */
- (size_t)count
{
  return (size_t)[_tbl count];
}

/*
 * Is the given symbol name a symbol that is present in the
 * symbol table?
 */
- (BOOL)isSymbol:(const char *)symbol
{
  return [_tbl isKey:symbol];
}

/*
 * Returns any value for the given symbol name.
 */
- (Symbol *)valueForSymbol:(const char *)symbol
{
  return (Symbol *)[_tbl valueForKey:symbol];
}

/*
 * Insert a symbol into the symbol table.
 *
 * If the symbol already exists, then the value is updated.
 */
- (Symbol *)insertSymbol:(Symbol *)value
{
  Symbol *exists = nil;

  exists = [self valueForSymbol:[value uniqueSymbolName]];
  if (exists && [exists readOnly]) {
    return nil;
  }

  return (Symbol *)[_tbl insertKey:[value uniqueSymbolName]
                             value:value];
}

/*
 * Remove a symbol from the symbol table.
 */
- (Symbol *)removeSymbol:(const char *)symbol
{
  return (Symbol *)[_tbl removeKey:symbol];
}

@end /* SymbolTable */

@implementation SymbolTable (Debug)

/*
 * Print debugging information.
 */
- (void)_printDebugInfo:(int)indent
{
  const char  *key   = NULL;
  Symbol      *val   = nil;
  NXHashState  state;

  if (_tbl) {
    state = [_tbl initState];

    debug_print(indent, "Num elements = %d\n", [_tbl count]);

    while ([_tbl nextState:&state
                       key:(void *)&key
                     value:(void *)&val])
    {
      if ([val respondsTo:@selector(printDebug:withIndent:)]) {
        debug_print(indent, "Key = %s\n", key);
        [val printDebug:key
             withIndent:(indent + [Object debugIndentLevel])];
      } else {
        debug_print(indent, "<invalid symbol table value>\n");
      }
    }
  }
}

@end /* SymbolTable (Debug) */

/* SymbolTable.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */