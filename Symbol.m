/*
 * Symbol.m  --- Symbol implementation.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Tue,  3 Nov 2015 00:42:56 +0000 (GMT)
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

#include <stdio.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#import "Symbol.h"
#import "Utils.h"
#import "snprintf.h"

/*
 * This MUST match `SymbolType' in Symbol.h.
 */
static const char *symbol_type_names[] = {
  "nil",
  "string",
  "number",
  "boolean",
  "pointer",
  "selector",
  "object"
};

/*
 * Default symbol type name.
 */
static const char default_symbol_type[] = "<invalid>";

/*
 * Default symbol name.
 */
static const char default_symbol_name[] = "<unnamed>";

static 
const char *
name_for_symbol_type(SymbolType type)
{
  if (type < SYMBOL_TYPE_MAX) {
    return symbol_type_names[type];
  }

  return default_symbol_type;
}

@implementation Symbol

+ (Symbol *)newFromString:(String *)aString
{
  static size_t  string_counter = 1;
  char          *name           = NULL;

  name = xmalloc(sizeof(char) * 128);
  snprintf(name, 128, "string%d", string_counter++);

  return [[Symbol alloc] initWithData:aString
                              andName:(const char *)name
                              andType:SymbolString];
}

+ (Symbol *)newFromNumber:(Number *)aNumber
{
  static size_t  number_counter = 1;
  char          *name           = NULL;

  name = xmalloc(sizeof(char*) * 128);
  snprintf(name, 128, "number%d", number_counter++);

  return [[Symbol alloc] initWithData:aNumber
                              andName:(const char *)name
                              andType:SymbolNumber];
}

+ (Symbol *)newFromBoolean:(Boolean *)aBoolean
{
  static size_t  bool_counter = 1;
  char          *name         = NULL;

  name = xmalloc(sizeof(char) * 128);
  snprintf(name, 128, "boolean%d", bool_counter++);

  return [[Symbol alloc] initWithData:aBoolean
                              andName:(const char *)name
                              andType:SymbolBoolean];
}

- (id)init
{
  return [self initWithData:nil
                    andName:default_symbol_name
                    andType:SymbolNil];
}

- (id)initWithData:(id)data
           andName:(const char *)name
           andType:(SymbolType)type
{
  if ((self = [super init]) != nil) {
    _data = data;
    _name = [[String alloc] initWithString:name];
    _type = type;
  }

  return self;
}

- (id)free
{
  if (_data) {
    [_data free];
    _data = nil;
  }

  return [super free];
}

- (void)setData:(id)data
{
  _data = data;
}

- (id)data
{
  return _data;
}

- (void)setType:(SymbolType)aType
{
  _type = aType;
}

- (SymbolType)type
{
  return _type;
}

- (void)setReadOnly:(BOOL)aFlag
{
  _readOnly = aFlag;
}

- (BOOL)readOnly
{
  return _readOnly;
}

- (const char *)typeName
{
  return name_for_symbol_type(_type);
}

- (void)setName:(String *)aName
{
  if (_name) {
    [_name free];
  }

  _name = [[String alloc]
            initWithString:[[aName toLower] stringValue]];

  [aName free];
}

- (void)setNameFromCString:(const char *)aName
{
  if (_name) {
    [_name free];
  }

  _name = [[String alloc] initWithString:aName];
  [_name toLower];
}

- (String *)symbolName
{
  return _name;
}

/*
 * NXUniqueString means that the returned value is unique in that it
 * is garaunteed to have just one string instance in memory during the
 * entire run time of the program.
 */
- (NXAtom)uniqueSymbolName
{
  return NXUniqueString([_name stringValue]);
}

@end                            // Symbol

@implementation Symbol (Debug)

- (void)_printDebugInfo:(int)indent
{
  if (_name) {
    debug_print(indent, "name      = [%s]\n", [_name stringValue]);
  }

  debug_print(indent, "Type      = %s\n", [self typeName]);
  debug_print(indent, "Read-only = %s\n", bool2string(_readOnly));

  if ([_data respondsTo:@selector(printDebug:withIndent:)]) {
    [_data printDebug:"Symbol data"
           withIndent:(indent + [Object debugIndentLevel])];
  }
}

@end                            //* Symbol (Debug)

/* Symbol.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
