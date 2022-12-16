/*
 * VM.h  --- Virtual machine interface.
 *
 * Copyright (c) 2017-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Thu,  2 Feb 2017 12:05:06 +0000 (GMT)
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

#import "Stack.h"
#import "String.h"
#import "SyntaxTree.h"
#import "IntInstr.h"

#import <stdio.h>
#import <stdlib.h>

typedef unsigned int u_int_t;

/*
 * This class implements a VM instruction.
 */
@interface Instruction : Object
{
  Opcode  _opcode;              // Opcode.
  u_int_t _operand;             // Operand.
}

- (id)init;
- (id)initWithOpcode:(Opcode)anOpcode;
- (id)initWithOpcode:(Opcode)anOpcode
          andOperand:(u_int_t)anOperand;

- (id)free;

- (void)setOpcode:(Opcode)anOpcode;
- (Opcode)opcode;
- (void)setOperand:(u_int_t)anOperand;
- (u_int_t)operand;

@end                            // Instruction

/*
 * This class implements a virtual machine.
 */
@interface VirtualMachine : Object
{
  size_t  _count;               // Count of instructions.
  List   *_instrs;              // List of instructions.
  Stack  *_stack;               // Program stack.
}

/*
 * Initialisation.
 */
- (id)init;

/*
 * Destruction.
 */
- (id)free;

/*
 * Methods.
 */
- (void)read:(IntInstr *)code;
- (void)execute;
- (void)reset;

@end                            // VirtualMachine

/* VM.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
