/*
 * Constants.m  --- Some title
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun, 19 Feb 2017 01:42:32 +0000 (GMT)
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

#import "SymbolTable.h"
#import "Symbol.h"
#import "String.h"
#import "Number.h"
#import "Boolean.h"
#import "Utils.h"

static const char *NilCName   = "nil";
static const char *TrueCName  = "true";
static const char *FalseCName = "false";

NilObject *NilValue     = nil;
Boolean   *BooleanTrue  = nil;
Boolean   *BooleanFalse = nil;

Symbol *NilSymbol   = nil;
Symbol *TrueSymbol  = nil;
Symbol *FalseSymbol = nil;

void
make_constants(void)
{
  NilValue     = [[NilObject alloc] init];
  BooleanTrue  = [[Boolean alloc] initWithBool:YES];
  BooleanFalse = [[Boolean alloc] initWithBool:NO];

  NilSymbol = [[Symbol alloc] initWithData:NilValue
                                   andName:NilCName
                                   andType:SymbolNil];

  TrueSymbol  = [[Symbol alloc] initWithData:BooleanTrue
                                     andName:TrueCName
                                     andType:SymbolBoolean];
  FalseSymbol = [[Symbol alloc] initWithData:BooleanFalse
                                     andName:FalseCName
                                     andType:SymbolBoolean];

  [NilSymbol setReadOnly:YES];
  [TrueSymbol setReadOnly:YES];
  [FalseSymbol setReadOnly:YES];

  ADD_SYMBOL(NilSymbol);
  ADD_SYMBOL(TrueSymbol);
  ADD_SYMBOL(FalseSymbol);
}

/* Constants.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
