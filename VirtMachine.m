/*
 * VM.m  --- Virtual machine implementation.
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Thu,  2 Feb 2017 12:13:13 +0000 (GMT)
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

#import "VirtMachine.h"
#import "Selector.h"

static
id
resolveSymbol(id symb, id argSymb)
{
  register id  result = symb;
  register id  arg    = argSymb;
  register int type   = -1;

  if ([symb respondsTo:@selector(data)]) {
    result = [symb data];
    type   = [symb type];
  }

  if (argSymb != nil) {
    if ([argSymb respondsTo:@selector(data)]) {
      arg = [argSymb data];
    }
  }

  switch (type) {
    case SymbolObject:
      return resolveSymbol(result, nil);

    case SymbolSelector:
      {
        register Selector *sel = (Selector *)result;

        if (argSymb != nil) {
          result = [sel evaluateWithArg:arg];
        } else {
          result = [sel evaluate];
        }
      }

    default:
      return result;
  }
}

@implementation Instruction

- (id)init
{
  return [self initWithOpcode:OP_NOP
                   andOperand:0];
}

- (id)initWithOpcode:(Opcode)anOpcode
{
  return [self initWithOpcode:anOpcode
                   andOperand:0];
}

- (id)initWithOpcode:(Opcode)anOpcode
          andOperand:(u_int_t)anOperand
{
  if ((self = [super init]) != nil) {
    _opcode  = anOpcode;
    _operand = anOperand;
  }

  return self;
}

- (id)free
{
  return [super free];
}

- (void)setOpcode:(Opcode)anOpcode
{
  _opcode = anOpcode;
}

- (Opcode)opcode
{
  return _opcode;
}

- (void)setOperand:(u_int_t)anOperand
{
  _operand = anOperand;
}

- (u_int_t)operand
{
  return _operand;
}

@end                            // Instruction

@implementation VirtualMachine

- (id)init
{
  if ((self = [super init]) != nil) {
    _count   = 0;
    _instrs  = [[List alloc] init];
  }
  
  return self;
}

- (id)free
{
  [self reset];

  return [super free];
}

/* Add an instruction with just an opcode. */
#define ADD_ISN1(Place, OpCode)                                       \
  [_instrs insertObject:[[Instruction alloc] initWithOpcode:(OpCode)] \
                     at:(Place)]

/* Add an instruction with an opcode and an operand. */
#define ADD_ISN2(Place, OpCode, Operand)                       \
  [_instrs insertObject:[[Instruction alloc]                   \
                            initWithOpcode:(OpCode)            \
                                andOperand:(u_int_t)(Operand)] \
                     at:(Place)]

- (void)read:(IntInstr *)code
{
  register size_t    i      = 0;
  register IntInstr *cinstr = nil;

  _count  = [code length] + 1;
  cinstr  = code;
  _instrs = [[List alloc] initCount:(_count + 1)];

  for (i = 0; i < _count; i++) {
    switch ([cinstr opcode]) {
      case OP_NOP:     ADD_ISN1(i, OP_NOP);                              break;
      case OP_PUSH:    ADD_ISN2(i, OP_PUSH, [cinstr symbol]);            break;
      case OP_POP:     ADD_ISN2(i, OP_POP, [cinstr symbol]);             break;
      case OP_PRINT:   ADD_ISN1(i, OP_PRINT);                            break;
      case OP_JMP:     ADD_ISN2(i, OP_JMP, [[cinstr target] line] - i);  break;
      case OP_JMPF:    ADD_ISN2(i, OP_JMPF, [[cinstr target] line] - i); break;
      case OP_EQL:     ADD_ISN1(i, OP_EQL);                              break;
      case OP_NEQ:     ADD_ISN1(i, OP_NEQ);                              break;
      case OP_CONCAT:  ADD_ISN1(i, OP_CONCAT);                           break;
      case OP_LAND:    ADD_ISN1(i, OP_LAND);                             break;
      case OP_LOR:     ADD_ISN1(i, OP_LOR);                              break;
      case OP_LXOR:    ADD_ISN1(i, OP_LXOR);                             break;
      case OP_CALL:    ADD_ISN2(i, OP_CALL, [cinstr symbol]);            break;
      case OP_CALLA:   ADD_ISN2(i, OP_CALLA, [cinstr symbol]);           break;
      case OP_BLN2STR: ADD_ISN1(i, OP_BLN2STR);                          break;
      case JMPTGT:     ADD_ISN1(i, OP_NOP);                              break;
    }

    cinstr = [cinstr next];
  }
}

- (void)execute
{
  register size_t  ip    = 0;
  register size_t  ipc   = 0;
  register Stack  *stack = [[Stack alloc] init];
  register id      i     = nil;
  register id      j     = nil;
  register id      k     = nil;
  register BOOL    b     = NO;
  register int     op    = 0;

  while (ip < _count) {
    ipc = 1;
    op  = [[_instrs objectAt:ip] opcode];

    switch (op) {
      case OP_NOP:
        break;

      case OP_PUSH:
        [stack pushObject:(id)[[_instrs objectAt:ip] operand]];
        break;

      case OP_POP:
        [(Symbol *)[[_instrs objectAt:ip] operand] setData:(id)[stack popObject]];
        break;

      case OP_PRINT:
        i = resolveSymbol([stack popObject], nil);
        fprintf(stdout, "%s\n", [i stringValue]);
        break;

      case OP_JMP:
        ipc = [[_instrs objectAt:ip] operand];
        break;

      case OP_JMPF:
        i = [stack popObject];

        if ([[i data] boolValue] == NO) {
          ipc = [[_instrs objectAt:ip] operand];
        }
        break;

      case OP_NEQ:
      case OP_EQL:
        i = resolveSymbol([stack popObject], nil);
        j = resolveSymbol([stack popObject], nil);
        k = [[Boolean alloc] init];
        b = [i isEqual:j];
        [k setValueFromBool:(op == OP_EQL) ? b : !b];
        [stack pushObject:[Symbol newFromBoolean:k]];
        break;

      case OP_CONCAT:
        i = resolveSymbol([stack popObject], nil);
        j = resolveSymbol([stack popObject], nil);
        [stack pushObject:[Symbol newFromString:
                                    [[[String alloc] init]
                                      concatenate:j, i, nil]]];
        break;

      case OP_LAND:
        i = resolveSymbol([stack popObject], nil);
        j = resolveSymbol([stack popObject], nil);
        k = [[Boolean alloc] init];
        b = [i boolValue] && [j boolValue];
        [k setValueFromBool:b];
        [stack pushObject:[Symbol newFromBoolean:k]];
        break;

      case OP_LOR:
        i = resolveSymbol([stack popObject], nil);
        j = resolveSymbol([stack popObject], nil);
        k = [[Boolean alloc] init];
        b = [i boolValue] || [j boolValue];
        [k setValueFromBool:b];
        [stack pushObject:[Symbol newFromBoolean:k]];
        break;

      case OP_LXOR:
        i = resolveSymbol([stack popObject], nil);
        j = resolveSymbol([stack popObject], nil);
        k = [[Boolean alloc] init];
        b = !([i boolValue]) != !([j boolValue]);
        [k setValueFromBool:b];
        [stack pushObject:[Symbol newFromBoolean:k]];
        break;

      case OP_CALL:
        i = (Symbol *)[[_instrs objectAt:ip] operand];
        [stack pushObject:resolveSymbol(i, nil)];
        break;

      case OP_CALLA:
        i = resolveSymbol([stack popObject], nil);
        j = (Symbol *)[[_instrs objectAt:ip] operand];
        [stack pushObject:resolveSymbol(j, i)];
        break;

      case OP_BLN2STR:
        break;

      default:
        break;
    }

    ip += ipc;
  }
}

- (void)reset
{
  if (_instrs) {
    [_instrs freeObjects];
    [_instrs free];
    _instrs = nil;
  }

  _count = 0;

  [_stack empty];
}

@end                            // VirtualMachine

/* VM.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
