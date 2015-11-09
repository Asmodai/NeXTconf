/*
 * SymbolTable.h  --- Symbol table.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/07 23:12:11 asmodai>
 * Revision:   6
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Mon,  2 Nov 2015 23:06:58 +0000 (GMT)
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

#import <objc/Object.h>
#import "Object+Debug.h"
#import <objc/HashTable.h>

#import <sys/types.h>

#import "Symbol.h"

/*
 * This class implements a table of symbols.
 *
 * The symbols are stored in a hash table where their unique name is
 * the key.  This means there should be no duplicate symbols.
 *
 * The parser looks up symbol values and, if non exist, creates one.
 */
@interface SymbolTable : Object
{
  HashTable *_tbl;
}

/*
 * Initialisation and destruction.
 */
- (id)init;
- (id)free;

/*
 * Counting.
 */
- (size_t)count;

/*
 * Accessors.
 */
- (BOOL)isSymbol:(const char *)key;
- (Symbol *)valueForSymbol:(const char *)symbol;
- (Symbol *)insertSymbol:(Symbol *)value;
- (Symbol *)removeSymbol:(const char *)symbol;

@end /* SymbolTable */

@interface SymbolTable (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end /* SymbolTable (Debug) */

/* SymbolTable.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
