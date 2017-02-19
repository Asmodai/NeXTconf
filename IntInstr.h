/*
 * IntInstr.h  --- Intermediate instruction interface.
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Wed,  1 Feb 2017 14:29:34 +0000 (GMT)
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

#import "Symbol.h"
#import "SymbolTable.h"
#import "SyntaxTree.h"

/*
 * These MUST be kept in sync with `op_name` in IntInstr.m!
 */
typedef enum {
  OP_NOP,
  OP_PUSH,
  OP_POP,
  OP_PRINT,
  OP_JMP,
  OP_JMPF,
  OP_EQL,
  OP_NEQ,
  OP_LAND,
  OP_LOR,
  OP_LXOR,
  OP_CONCAT,
  OP_CALL,
  OP_CALLA,
  OP_BLN2STR,
  JMPTGT
} Opcode;

/*
 * This class represents an `intermediate representation' instruction
 * which is passed to the VM for translation into opcode.
 */
@interface IntInstr : Object
{
  size_t    _lineNo;
  Opcode    _opcode;
  Symbol   *_symbol;
  IntInstr *_target;
  IntInstr *_next;
}

/*
 * Class methods.
 */
+ (IntInstr *)generate:(SyntaxTree *)tree;

/*
 * Initialisation.
 */
- (id)init;
- (id)initWithOpcode:(Opcode)anOpcode;
- (id)initWithOpcode:(Opcode)anOpcode
              atLine:(size_t)aLineNo;

/*
 * Destruction.
 */
- (id)free;

/*
 * Accessors.
 */
- (void)setLine:(size_t)number;
- (size_t)line;
- (Opcode)opcode;
- (void)setSymbol:(Symbol *)aSymbol;
- (Symbol *)symbol;
- (void)setTarget:(IntInstr *)aTarget;
- (IntInstr *)target;
- (void)setNext:(IntInstr *)aNext;
- (IntInstr *)next;

/*
 * Utilities.
 */
- (void)number:(size_t)origin;
- (size_t)length;

@end                            // IntInstr

@interface IntInstr (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // IntInstr (Debug)

/* IntInstr.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
