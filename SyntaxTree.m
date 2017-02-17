/*
 * SyntaxTree.m  --- Syntax tree implementation.
 *
 * Copyright (c) 2015-2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Wed,  4 Nov 2015 05:02:56 +0000 (GMT)
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
#import <string.h>

#import "SyntaxTree.h"
#import "Utils.h"
#import "IntInstr.h"

/*
 * Default maximum number of children.
 */
#define DEFAULT_MAX_CHILD_SLOTS    3

/*
 * Thus MUST match `STNodeType' in SyntaxTree.h
 */
const char *node_types[] = {
  "Statement list",
  "Empty statement",
  "Expression statement",
  "PRINT statement",
  "IF..THEN statement",
  "IF..THEN..ELSE statement",
  "FOR..IN statement",
  "Error statement",
  "Equals",
  "Not Equals",
  "Assign",
  "Concatenate",
  "Logical AND",
  "Logical OR",
  "Logical XOR",
  "Identifier",
  "Integer constant",
  "String constant",
  "Boolean constant",
  "Coercion to string",
  "Method call"
};

/*
 * This MUST match `STRetType' in SyntaxTree.h
 */
const char *return_types[] = {
  "void",
  "string",
  "number",
  "bool"
};

/*
 * This MUST match `STNodeType' in SyntaxTree.h
 */
const int children_per_node[] = {
  2,                            // Statement list
  0,                            // Empty statement
  1,                            // Expression statement
  1,                            // PRINT statement
  2,                            // IF..THEN statement
  3,                            // IF..THEN..ELSE statement
  2,                            // FOR..IN statement
  0,                            // Error statement
  2,                            // Equals
  2,                            // Not-Equals
  1,                            // Assign
  2,                            // Concatenate
  2,                            // Logical AND
  2,                            // Logical OR
  2,                            // Logical XOR
  2,                            // Logical NOT
  0,                            // Identifier
  0,                            // Integer constant
  0,                            // String constant
  0,                            // Boolean constant
  1,                            // Coerce to string
  2                             // Method call
};

@implementation SyntaxTree

- (id)init
{
  return [self initWithType:EmptyStmt
                  andChild1:nil
                  andChild2:nil
                  andChild3:nil];
}

- (id)initWithType:(STNodeType)type
{
  return [self initWithType:type
                  andChild1:nil
                  andChild2:nil
                  andChild3:nil];
}

- (id)initWithType:(STNodeType)type
         andChild1:(SyntaxTree *)child1
{
  return [self initWithType:type
                  andChild1:child1
                  andChild2:nil
                  andChild3:nil];
}

- (id)initWithType:(STNodeType)type
         andChild1:(SyntaxTree *)child1
         andChild2:(SyntaxTree *)child2
{
  return [self initWithType:type
                  andChild1:child1
                  andChild2:child2
                  andChild3:nil];
}

- (id)initWithType:(STNodeType)type
         andChild1:(SyntaxTree *)child1
         andChild2:(SyntaxTree *)child2
         andChild3:(SyntaxTree *)child3
{
  if ((self = [super init]) != nil) {
    _nodeType = type;
    _retType  = ReturnVoid;
    _symbol   = nil;
    
    _children = [[List alloc] initCount:DEFAULT_MAX_CHILD_SLOTS];

    [_children insertObject:child1 at:0];
    [_children insertObject:child2 at:1];
    [_children insertObject:child3 at:2];

    [self checkSyntax];
  }

  return self;
}

/*
 * The reason why we do not free `_symbol' is so that when a syntax
 * tree is nuked, any symbols created and placed in the symbol manager
 * are left intact.  This is so we can, at some point, kill a syntax
 * tree's memory WITHOUT killing the associated symbols.
 */
- (id)free
{
  if (_children) {
    [_children freeObjects];
    [_children free];
    _children = nil;
  }

  /* XXX don't free this. */
  _symbol = nil;

  return [super free];
}

- (void)copyFrom:(SyntaxTree *)anOther
{
  size_t i = 0;

  if (_children) {
    [_children freeObjects];
    [_children free];
  }

  _nodeType = [anOther nodeType];
  _retType  = [anOther returnType];
  _symbol   = [anOther symbol];
  _children = [[List alloc] initCount:DEFAULT_MAX_CHILD_SLOTS];

  for (i = 0; i < [anOther childCount]; i++) {
    [self setChildAtIndex:i to:[anOther childAtIndex:i]];
  }
}

- (void)setNodeType:(STNodeType)type
{
  _nodeType = type;
}

- (STNodeType)nodeType
{
  return _nodeType;
}

- (void)setReturnType:(STRetType)type
{
  _retType = type;
}

- (STRetType)returnType
{
  return _retType;
}

- (void)setSymbol:(Symbol *)symb
{
  _symbol = symb;
}

- (Symbol *)symbol
{
  return _symbol;
}

- (void)setChildAtIndex:(int)index
                     to:(SyntaxTree *)child
{
  if (index > [_children count]) {
    return;
  }

  [_children replaceObjectAt:index
                        with:child];
}

- (SyntaxTree *)childAtIndex:(int)index
{
  if (index > [_children count]) {
    return nil;
  }

  return [_children objectAt:index];
}

- (BOOL)coerceToString:(int)child
{
  STRetType ret = ReturnVoid;

  if (child <= [_children count]) {
    ret = [[_children objectAt:child] returnType];
  }

  if (ret == ReturnString) {
    return YES;
  }

  if (ret != ReturnBool) {
    return NO;
  }

  [self setChildAtIndex:child
                     to:[[SyntaxTree alloc]
                          initWithType:CoerceToString
                             andChild1:[self childAtIndex:child]]];

  return YES;
}

- (int)childCount
{
  return [_children count];
}

- (void)checkSyntax
{
  /* First, set the required return type. */
  switch (_nodeType) {
    case StmtList:
    case EmptyStmt:
    case ExprStmt:
    case PrintStmt:
    case IfThenStmt:
    case IfThenElseStmt:
    case ForInStmt:
    case ErrorStmt:
      _retType = ReturnVoid;
      break;

    case NotEqualExpr:
    case EqualExpr:
      _retType = ReturnBool;
      break;

    case ConcatExpr:
    case AssignExpr:
      _retType = ReturnString;
      break;

    case IdentExpr:
    case StringExpr:
      _retType = ReturnString;
      break;

    case IntegerExpr:
      _retType = ReturnNumber;
      break;

    case LogicalAndExpr:
    case LogicalOrExpr:
    case LogicalXorExpr:
    case BooleanExpr:
      _retType = ReturnBool;
      break;

    case CoerceToString:
      _retType = ReturnString;
      break;

    case MethodCall:
      _retType = ReturnString;
      break;
  }

  /* Check whether the node is syntactically correct. */
  switch (_nodeType) {
    case IfThenStmt:
    case IfThenElseStmt:
      if ([[_children objectAt:0] returnType] != ReturnBool) {
        fprintf(stderr, "if: Condition should be boolean.\n");
      }
      break;

    case LogicalAndExpr:
    case LogicalOrExpr:
    case LogicalXorExpr:
      if (([[_children objectAt:0] returnType] != ReturnBool) &&
          ([[_children objectAt:1] returnType] != ReturnBool))
      {
        fprintf(stderr, "Logic operator: Both arguments should be boolean.\n");
      }
      break;

    case ConcatExpr:
      if (![self coerceToString:0]) {
        fprintf(stderr, "+: Cannot coerce first argument to string.\n");
      }
      if (![self coerceToString:1]) {
        fprintf(stderr, "+: Cannot coerce second argument to string.\n");
      }
      break;

      /* Default case to keep the compiler happy. */
    default:
      break;
  }
}

@end                            // SyntaxTree

@implementation SyntaxTree (Debug)

- (void)_printDebugInfo:(int)indent
{
  size_t i = 0;

  debug_print(indent, "Node type   = %s\n", node_types[_nodeType]);
  debug_print(indent, "Return type = %s\n", return_types[_retType]);

  if (_symbol) {
    [_symbol printDebug:"symbol ="
             withIndent:(indent + [Object debugIndentLevel])];
  }

  for (i = 0; i < children_per_node[_nodeType]; i++) {
    if ([_children objectAt:i]) {
      [[_children objectAt:i] printDebug:"child ="
                              withIndent:(indent + [Object debugIndentLevel])];
    }
  }
}

@end                            // SyntaxTree (Debug)

/* SyntaxTree.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
