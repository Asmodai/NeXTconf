/*
 * IntInstr.m  --- Intermediate instruction implementation.
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Wed,  1 Feb 2017 13:35:41 +0000 (GMT)
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

#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>

#import "IntInstr.h"
#import "Utils.h"

/*
 * These MUST be kept in sync with `Opcode' in IntInstr.h!
 */
char *op_name[] = {
  "OP_NOP",
  "OP_PUSH",
  "OP_POP",
  "OP_PRINT",
  "OP_JMP",
  "OP_JMPF",
  "OP_EQL",
  "OP_NEQ",
  "OP_ADD",
  "OP_SUB",
  "OP_MUL",
  "OP_DIV",
  "OP_LAND",
  "OP_LOR",
  "OP_LXOR",
  "OP_CONCAT",
  "OP_CALL",
  "OP_CALLA",
  "OP_BLN2STR",
  "JMPTGT"
};

static
IntInstr *
concatenate(IntInstr *blk1, IntInstr *blk2)
{
  IntInstr *search = blk1;

  while ([search next] != nil) {
    search = [search next];
  }

  [search setNext:blk2];

  return blk1;
}

static
IntInstr *
prefixJT(IntInstr *blk, IntInstr *refInstr)
{
  IntInstr *jt = [[IntInstr alloc] initWithOpcode:JMPTGT];

  [jt setTarget:refInstr];
  [jt setNext:blk];

  return jt;
}

@implementation IntInstr

+ (IntInstr *)generate:(SyntaxTree *)tree
{
  register SyntaxTree *root     = tree;
  register IntInstr   *blk1     = nil;
  register IntInstr   *blk2     = nil;
  IntInstr            *cond     = nil;
  IntInstr            *jmp2else = nil;
  IntInstr            *thenpart = nil;
  IntInstr            *jmp2end  = nil;
  IntInstr            *elsepart = nil;
  IntInstr            *endif    = nil;

  switch ([root nodeType]) {
    case StmtList:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      return concatenate(blk1, blk2);

    case IncludedFile:
      {
        register SyntaxTree *inclusion = nil;

        [root processIncludedFile];
        inclusion = [root includedTree];

        if (inclusion) {
          blk1 = [IntInstr generate:[inclusion childAtIndex:0]];
          blk2 = [IntInstr generate:[inclusion childAtIndex:1]];
          return concatenate(blk1, blk2);
        }

        return [[IntInstr alloc] initWithOpcode:OP_NOP];
      }
      break;

    case EmptyStmt:
      return [[IntInstr alloc] initWithOpcode:OP_NOP];

    case ExprStmt:
      return [IntInstr generate:[root childAtIndex:0]];

    case PrintStmt:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [[IntInstr alloc] initWithOpcode:OP_PRINT];
      return concatenate(blk1, blk2);

    case IfThenStmt:
      cond     = [IntInstr generate:[root childAtIndex:0]];
      jmp2end  = [[IntInstr alloc] initWithOpcode:OP_JMPF];
      thenpart = [IntInstr generate:[root childAtIndex:1]];
      endif    = [[IntInstr alloc] initWithOpcode:JMPTGT];
      [endif setTarget:jmp2end];
      [jmp2end setTarget:endif];
      concatenate(cond, jmp2end);
      concatenate(jmp2end, thenpart);
      concatenate(thenpart, endif);
      return cond;

    case IfThenElseStmt:
      cond     = [IntInstr generate:[root childAtIndex:0]];
      jmp2else = [[IntInstr alloc] initWithOpcode:OP_JMPF];
      thenpart = [IntInstr generate:[root childAtIndex:1]];
      elsepart = prefixJT([IntInstr generate:[root childAtIndex:2]], jmp2else);
      [jmp2else setTarget:elsepart];
      jmp2end  = [[IntInstr alloc] initWithOpcode:OP_JMP];
      endif    = [[IntInstr alloc] initWithOpcode:JMPTGT];
      [endif setTarget:jmp2end];
      [jmp2end setTarget:endif];
      concatenate(cond, jmp2else);
      concatenate(jmp2else, thenpart);
      concatenate(thenpart, jmp2end);
      concatenate(jmp2end, elsepart);
      concatenate(elsepart, endif);
      return cond;

    case ErrorStmt:
      return [[IntInstr alloc] initWithOpcode:OP_NOP];

    case MethodCall:
      if ([root childAtIndex:0] != nil) {
        blk1 = [IntInstr generate:[root childAtIndex:0]];
        blk2 = [[IntInstr alloc] initWithOpcode:OP_CALLA];
        [blk2 setSymbol:[root symbol]];
        return concatenate(blk1, blk2);
      }
      blk1 = [[IntInstr alloc] initWithOpcode:OP_CALL];
      [blk1 setSymbol:[root symbol]];
      return blk1;

    case NotEqualExpr:
    case EqualExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk1, blk2);
      return concatenate(blk1,
                         [[IntInstr alloc]
                           initWithOpcode:
                             ([root nodeType] == NotEqualExpr)
                               ? OP_NEQ
                               : OP_EQL]);

    case AssignExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [[IntInstr alloc] initWithOpcode:OP_POP];
      [blk2 setSymbol:[root symbol]];
      return concatenate(blk1, blk2);

    case ConcatExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk1, blk2);
      return concatenate(blk1, [[IntInstr alloc] initWithOpcode:OP_CONCAT]);

    case LogicalAndExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk2, [[IntInstr alloc] initWithOpcode:OP_LAND]);
      return concatenate(blk1, blk2);

    case LogicalOrExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk2, [[IntInstr alloc] initWithOpcode:OP_LOR]);
      return concatenate(blk1, blk2);

    case LogicalXorExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk2, [[IntInstr alloc] initWithOpcode:OP_LXOR]);
      return concatenate(blk1, blk2);

    case AddExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk2, [[IntInstr alloc] initWithOpcode:OP_ADD]);
      return concatenate(blk1, blk2);

    case SubExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk2, [[IntInstr alloc] initWithOpcode:OP_SUB]);
      return concatenate(blk1, blk2);

    case MulExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk2, [[IntInstr alloc] initWithOpcode:OP_MUL]);
      return concatenate(blk1, blk2);

    case DivExpr:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [IntInstr generate:[root childAtIndex:1]];
      concatenate(blk2, [[IntInstr alloc] initWithOpcode:OP_DIV]);
      return concatenate(blk1, blk2);

    case IdentExpr:
    case NumberExpr:
    case StringExpr:
    case BooleanExpr:
      blk1 = [[IntInstr alloc] initWithOpcode:OP_PUSH];
      [blk1 setSymbol:[root symbol]];
      return blk1;

    case CoerceToString:
      blk1 = [IntInstr generate:[root childAtIndex:0]];
      blk2 = [[IntInstr alloc] initWithOpcode:OP_BLN2STR];
      return concatenate(blk1, blk2);

    default:
      return [[IntInstr alloc] initWithOpcode:OP_NOP];
  }
}

- (id)init
{
  return [self initWithOpcode:OP_NOP
                       atLine:0];
}

- (id)initWithOpcode:(Opcode)anOpcode
{
  return [self initWithOpcode:anOpcode
                       atLine:0];
}

- (id)initWithOpcode:(Opcode)anOpcode
              atLine:(size_t)aLineNo
{
  if ((self = [super init]) != nil) {
    _lineNo = aLineNo;
    _opcode = anOpcode;
    _symbol = nil;
    _target = nil;
    _next   = nil;
  }

  return self;
}

- (id)free
{
  [_symbol free];
  [_target free];
  [_next free];

  _symbol = nil;
  _target = nil;
  _next   = nil;

  return [super free];
}

- (void)setLine:(size_t)number
{
  _lineNo = number;
}

- (size_t)line
{
  return _lineNo;
}

- (Opcode)opcode
{
  return _opcode;
}

- (void)setSymbol:(Symbol *)aSymbol
{
  _symbol = aSymbol;
}

- (Symbol *)symbol
{
  return _symbol;
}

- (void)setTarget:(IntInstr *)aTarget
{
  _target = aTarget;
}

- (IntInstr *)target
{
  return _target;
}

- (void)setNext:(IntInstr *)aNext
{
  _next = aNext;
}

- (IntInstr *)next
{
  return _next;
}

- (void)number:(size_t)origin
{
  register IntInstr *num = self;

  while (num != nil) {
    [num setLine:origin++];
    num = [num next];
  }
}

- (size_t)length
{
  IntInstr *i   = _next;
  size_t    cnt = 0;

  while (i != nil) {
    cnt++;
    i = [i next];
  }

  return cnt;
}

@end                            // IntInstr

@implementation IntInstr (Debug)

- (void)_printDebugInfo:(int)indent
{
  debug_print(indent, "%8d: %s ", _lineNo, op_name[_opcode]);

  if (_symbol != nil) {
    debug_print(0, "\t%s ", [[_symbol symbolName] stringValue]);
  }

  if (_target != nil) {
    debug_print(0, "\t%d", [_target line]);
  }

  debug_print(0, "\n");

  if (_next != nil) {
    [_next _printDebugInfo:indent];
  }
}

@end                            // IntInstr (Debug)

/* IntInstr.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
