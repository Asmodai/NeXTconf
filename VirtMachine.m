/*
 * VM.m  --- Some title
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
#import "Interp.h"
#import "Selector.h"

const size_t MAX_STRINGS = 100;

static
id
resolveSymbol(id symb)
{
  id  result = symb;
  int type   = -1;

  if ([symb respondsTo:@selector(data)]) {
    result = [symb data];
    type   = [symb type];
  }

  switch (type) {
    case SymbolObject:
      return resolveSymbol(result);

    case SymbolSelector:
      {
        Selector *sel = (Selector *)result;

        result = [sel evaluate];
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
    _strings = [[List alloc] initCount:MAX_STRINGS];
  }
  
  return self;
}

- (id)free
{
  [self reset];

  return [super free];
}

#define ADD_ISN1(Place, OpCode)                                       \
  [_instrs insertObject:[[Instruction alloc] initWithOpcode:(OpCode)] \
                     at:(Place)]

#define ADD_ISN2(Place, OpCode, Operand)                       \
  [_instrs insertObject:[[Instruction alloc]                   \
                            initWithOpcode:(OpCode)            \
                                andOperand:(u_int_t)(Operand)] \
                     at:(Place)]

- (void)read:(IntInstr *)code
{
  size_t i         = 0;
  IntInstr *cinstr = nil;

  _count = [code length] + 1;
  cinstr = code;
  _instrs = [[List alloc] initCount:(_count + 1)];

  for (i = 0; i < _count; i++) {
    switch ([cinstr opcode]) {
      case OP_NOP:     ADD_ISN1(i, OP_NOP);                              break;
      case OP_PUSH:    ADD_ISN2(i, OP_PUSH, [cinstr symbol]);            break;
      case OP_POP:     ADD_ISN2(i, OP_POP, [cinstr symbol]);             break;
      case OP_PRINT:   ADD_ISN1(i, OP_PRINT);                            break;
      case OP_JMP:     ADD_ISN2(i, OP_JMP, [[cinstr target] line] - i);  break;
      case OP_JMPF:    ADD_ISN2(i, OP_JMPF, [[cinstr target] line] - i); break;
      case OP_STREQL:  ADD_ISN1(i, OP_STREQL);                           break;
      case OP_NUMEQL:  ADD_ISN1(i, OP_NUMEQL);                           break;
      case OP_BLNEQL:  ADD_ISN1(i, OP_BLNEQL);                           break;
      case OP_CONCAT:  ADD_ISN1(i, OP_CONCAT);                           break;
      case OP_CALL:    ADD_ISN2(i, OP_CALL, [cinstr symbol]);            break;
      case OP_BLN2STR: ADD_ISN1(i, OP_BLN2STR);                          break;
      case JMPTGT:     ADD_ISN1(i, OP_NOP);                              break;
    }

    cinstr = [cinstr next];
  }
}

- (void)execute
{
  size_t  ip    = 0;
  size_t  ipc   = 0;
  Stack  *stack = [[Stack alloc] init];
  id      i     = nil;
  id      j     = nil;

  while (ip < _count) {
    ipc = 1;

    switch ([[_instrs objectAt:ip] opcode]) {
      case OP_NOP:
        break;

      case OP_PUSH:
        [stack pushObject:(id)[[_instrs objectAt:ip] operand]];
        break;

      case OP_POP:
        [(Symbol *)[[_instrs objectAt:ip] operand] setData:(id)[stack popObject]];
        break;

      case OP_PRINT:
        i = resolveSymbol([stack popObject]);
        fprintf(stdout, "%s\n", [i stringValue]);
        break;

      case OP_JMP:
        ipc = [[_instrs objectAt:ip] operand];
        break;

      case OP_JMPF:
        i = [stack popObject];

        // XXX
        if ([[i data] boolValue] == NO) {
          ipc = [[_instrs objectAt:ip] operand];
        }
        break;

      case OP_STREQL:
      case OP_NUMEQL:
      case OP_BLNEQL:
        {
          Boolean *b = [[Boolean alloc] init];

          i = resolveSymbol([stack popObject]);
          j = resolveSymbol([stack popObject]);
          [b setValueFromBool:[i isEqual:j]];

          [stack pushObject:[Symbol newFromBoolean:b]];
        }
        break;

      case OP_CONCAT:
        i = resolveSymbol([stack popObject]);
        j = resolveSymbol([stack popObject]);

        [stack pushObject:[Symbol newFromString:
                                    [[[String alloc] init]
                                      concatenate:j, i, nil]]];
        break;

      case OP_CALL:
        i = (Symbol *)[[_instrs objectAt:ip] operand];
        [stack pushObject:resolveSymbol(i)];
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
  if (_strings) {
    [_strings freeObjects];
    [_strings free];
    _strings = nil;
  }

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
