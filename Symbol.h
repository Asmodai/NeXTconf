/*
 * Symbol.h  --- Symbol.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 00:37:31 +0000 (GMT)
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

#import "Number.h"
#import "String.h"
#import "Pointer.h"

typedef enum {
  SymbolNil,                    // Nil symbol.
  SymbolString,                 // String.
  SymbolNumber,                 // Number.
  SymbolPointer,                // Pointer.
  SymbolSelector,               // Selector.
  SymbolObject,                 // Object.
  SYMBOL_TYPE_MAX
} SymbolType;

/*
 * This class implements a symbol.
 *
 * Symbols are a way of binding a name to a value.
 */
@interface Symbol : Object
{
  String     *_name;            // Symbol name.
  id          _data;            // Symbol data.
  SymbolType  _type;            // Data type.
  BOOL        _readOnly;        // Read only?
}

/*
 * Initialisation.
 */
- (id)init;
- (id)initWithData:(id)data
           andName:(const char *)name
           andType:(SymbolType)type;

/*
 * Destruction.
 */
- (id)free;

/*
 * Accessors.
 */
- (void)setData:(id)object;
- (id)data;
- (void)setType:(SymbolType)aType;
- (SymbolType)type;
- (void)setReadOnly:(BOOL)aFlag;
- (BOOL)readOnly;
- (const char *)typeName;
- (void)setName:(String *)name;
- (void)setNameFromCString:(const char *)name;
- (String *)symbolName;
- (NXAtom)uniqueSymbolName;

@end /* Symbol */

@interface Symbol (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end /* Symbol (Debug) */

/* Symbol.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
