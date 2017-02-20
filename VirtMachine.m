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
#import "ExtErrno.h"
#import "Constants.h"

#import <stdio.h>
#import <string.h>

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

        /* Clear errno. */
        errno = 0;

        if (argSymb != nil) {
          result = [sel evaluateWithArg:arg];
        } else {
          result = [sel evaluate];
        }

        if (result == nil) {
          switch (errno) {
            case 0:
              result = NilSymbol;
              break;

            case EXT_ENOCLASS:
              runtime_errorf(
                0,
                "Could not find a class named `%s'.",
                [[sel className] stringValue]
              );
              break;

            case EXT_ENOMETH:
              runtime_warningf(
                0,
                "Could not find method `%s' for class `%s'.",
                [[sel methodName] stringValue],
                [[sel className] stringValue]
              );
              break;

            case EXT_ENORESP:
              runtime_warningf(
                0,
                "Class `%s' does not respond to `%s'.",
                [[sel className] stringValue],
                [[sel methodName] stringValue]
              );
              break;

            default:
              runtime_errorf(
                0,
                "Call to `%s' in class `%s' failed: %s.",
                [[sel methodName] stringValue],
                [[sel className] stringValue],
                strerror(errno)
              );
              break;
          }

          result = NilSymbol;
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
      /* All these use the same opcode in the VM. */
      case OP_NOP:
      case OP_PRINT:
      case OP_EQL:
      case OP_NEQ:
      case OP_ADD:
      case OP_SUB:
      case OP_MUL:
      case OP_DIV:
      case OP_CONCAT:
      case OP_LAND:
      case OP_LOR:
      case OP_LXOR:
      case OP_BLN2STR:
        ADD_ISN1(i, [cinstr opcode]);
        break;
        
      case OP_PUSH:    ADD_ISN2(i, OP_PUSH, [cinstr symbol]);            break;
      case OP_POP:     ADD_ISN2(i, OP_POP, [cinstr symbol]);             break;
      case OP_JMP:     ADD_ISN2(i, OP_JMP, [[cinstr target] line] - i);  break;
      case OP_JMPF:    ADD_ISN2(i, OP_JMPF, [[cinstr target] line] - i); break;
      case OP_CALL:    ADD_ISN2(i, OP_CALL, [cinstr symbol]);            break;
      case OP_CALLA:   ADD_ISN2(i, OP_CALLA, [cinstr symbol]);           break;
      case JMPTGT:     ADD_ISN1(i, OP_NOP);                              break;
    }

    cinstr = [cinstr next];
  }
}

- (void)execute
{
  register id    (*popObj)(id, SEL);
  register id    (*pushObj)(id, SEL, id);
  register Stack  *stack                 = [[Stack alloc] init];
  register size_t  ip                    = 0;
  register size_t  ipc                   = 0;
  register id      i                     = nil;
  register id      j                     = nil;
  id               k                     = nil;
  int              op                    = 0;
  BOOL             b                     = NO;
  SEL              popSel                = @selector(popObject);
  SEL              pushSel               = @selector(pushObject:);

  popObj  = (id (*)(id, SEL))[stack methodFor:popSel];
  pushObj = (id (*)(id, SEL, id))[stack methodFor:pushSel];

#define STACK_POP        (*popObj)(stack, popSel)
#define STACK_PUSH(__a)  (*pushObj)(stack, pushSel, (__a))

  while (ip < _count) {
    ipc = 1;
    op  = [[_instrs objectAt:ip] opcode];

    switch (op) {
      case OP_NOP:
        break;

      case OP_PUSH:
        STACK_PUSH((id)[[_instrs objectAt:ip] operand]);
        break;

      case OP_POP:
        [(Symbol *)[[_instrs objectAt:ip] operand] setData:(id)STACK_POP];
        break;

      case OP_PRINT:
        i = resolveSymbol(STACK_POP, nil);
        fprintf(stdout, "%s\n", [i stringValue]);
        break;

      case OP_JMP:
        ipc = [[_instrs objectAt:ip] operand];
        break;

      case OP_JMPF:
        i = STACK_POP;

        if ([[i data] boolValue] == NO) {
          ipc = [[_instrs objectAt:ip] operand];
        }
        break;

      case OP_NEQ:
      case OP_EQL:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        k = [[Boolean alloc] init];
        b = [i isEqual:j];
        [k setValueFromBool:(op == OP_EQL) ? b : !b];
        STACK_PUSH([Symbol newFromBoolean:k]);
        break;

      case OP_CONCAT:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        k = [Symbol newFromString:[[[String alloc] init] 
                                    concatenate:j, i, nil]];
        STACK_PUSH(k);
        break;

      case OP_ADD:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        STACK_PUSH([Symbol newFromNumber:[j add:i]]);
        break;

      case OP_SUB:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        STACK_PUSH([Symbol newFromNumber:[j subtract:i]]);
        break;

      case OP_MUL:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        STACK_PUSH([Symbol newFromNumber:[j multiply:i]]);
        break;

      case OP_DIV:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        STACK_PUSH([Symbol newFromNumber:[j divide:i]]);
        break;

      case OP_LAND:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        k = [[Boolean alloc] init];
        b = [j boolValue] && [i boolValue];
        [k setValueFromBool:b];
        STACK_PUSH([Symbol newFromBoolean:k]);
        break;

      case OP_LOR:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        k = [[Boolean alloc] init];
        b = [j boolValue] || [i boolValue];
        [k setValueFromBool:b];
        STACK_PUSH([Symbol newFromBoolean:k]);
        break;

      case OP_LXOR:
        i = resolveSymbol(STACK_POP, nil);
        j = resolveSymbol(STACK_POP, nil);
        k = [[Boolean alloc] init];
        b = !([j boolValue]) != !([i boolValue]);
        [k setValueFromBool:b];
        STACK_PUSH([Symbol newFromBoolean:k]);
        break;

      case OP_CALL:
        i = (Symbol *)[[_instrs objectAt:ip] operand];
        STACK_PUSH(resolveSymbol(i, nil));
        break;

      case OP_CALLA:
        i = resolveSymbol(STACK_POP, nil);
        j = (Symbol *)[[_instrs objectAt:ip] operand];
        STACK_PUSH(resolveSymbol(j, i));
        break;

      case OP_BLN2STR:
        break;

      default:
        break;
    }

    ip += ipc;
  }

#undef STACK_POP
#undef STACK_PUSH
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
 * fill-column: 79 ***
 * End: ***
 */
