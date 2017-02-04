/*
 * Symbol.m  --- Symbol implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
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
 * String names for symbol types.
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

/*
 * Translate a symbol type to a string value for pretty printing.
 */
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

  name = malloc(sizeof(char) * 128);
  if (name == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  snprintf(name, 128, "string%d", string_counter++);

  return [[Symbol alloc] initWithData:aString
                              andName:(const char *)name
                              andType:SymbolString];
}

+ (Symbol *)newFromNumber:(Number *)aNumber
{
  static size_t  number_counter = 1;
  char          *name           = NULL;

  name = malloc(sizeof(char*) * 128);
  if (name == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  snprintf(name, 128, "number%d", number_counter++);

  return [[Symbol alloc] initWithData:aNumber
                              andName:(const char *)name
                              andType:SymbolNumber];
}

+ (Symbol *)newFromBoolean:(Boolean *)aBoolean
{
  static size_t  bool_counter = 1;
  char          *name         = NULL;

  name = malloc(sizeof(char) * 128);
  if (name == NULL) {
    perror("malloc");
    exit(EXIT_FAILURE);
  }

  snprintf(name, 128, "boolean%d", bool_counter++);

  return [[Symbol alloc] initWithData:aBoolean
                              andName:(const char *)name
                              andType:SymbolBoolean];
}

/*
 * Initialisa a symbol with no name or value.
 */
- (id)init
{
  return [self initWithData:nil
                    andName:default_symbol_name
                    andType:SymbolNil];
}

/*
 * Initialise a symbol with the given name, type, and data.
 */
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

/*
 * Free a symbol.
 */
- (id)free
{
  if (_data) {
    [_data free];
    _data = nil;
  }

  return [super free];
}

/*
 * Sets the symbol's data.
 */
- (void)setData:(id)data
{
  _data = data;
}

/*
 * Returns the symbol's data.
 */
- (id)data
{
  return _data;
}

/*
 * Sets the symbol's type.
 */
- (void)setType:(SymbolType)aType
{
  _type = aType;
}

/*
 * Gets the symbol's type.
 */
- (SymbolType)type
{
  return _type;
}

/*
 * Sets the read-only status of the symbol.
 */
- (void)setReadOnly:(BOOL)aFlag
{
  _readOnly = aFlag;
}

/*
 * Gets the read-only status of the symbol.
 */
- (BOOL)readOnly
{
  return _readOnly;
}

/*
 * Gets the symbol's type as a printable string.
 */
- (const char *)typeName
{
  return name_for_symbol_type(_type);
}

/*
 * Sets the symbol's name.
 */
- (void)setName:(String *)aName
{
  if (_name) {
    [_name free];
  }

  _name = [[String alloc]
            initWithString:[[aName toLower] stringValue]];

  [aName free];
}

/*
 * Sets the symbol's name from a C string.
 */
- (void)setNameFromCString:(const char *)aName
{
  if (_name) {
    [_name free];
  }

  _name = [[String alloc] initWithString:aName];
  [_name toLower];
}

/*
 * Returns the symbol's name.
 */
- (String *)symbolName
{
  return _name;
}

/*
 * Returns the symbol's unique name.
 *
 * It is unique in that it is garaunteed to have just one string
 * instance in memory during the entire run time of the program.
 */
- (NXAtom)uniqueSymbolName
{
  return NXUniqueString([_name stringValue]);
}

@end /* Symbol */

@implementation Symbol (Debug)

/*
 * Print debugging information.
 */
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

@end /* Symbol (Debug) */

/* Symbol.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
