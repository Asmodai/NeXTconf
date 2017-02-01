/*
 * SyntaxTree.m  --- Syntax tree implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
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
#import "Interp.h"

/*
 * Default maximum number of children.
 */
#define DEFAULT_MAX_CHILD_SLOTS    3

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
  "Assign",
  "Concatenate",
  "Identifier",
  "Integer constant",
  "String constant",
  "Coercion to string",
  "Method call"
};

const char *return_types[] = {
  "void",
  "string",
  "number",
  "bool"
};

const int children_per_node[] = {
  2,                            // Statement list
  0,                            // Empty statement
  1,                            // Expression statement
  1,                            // PRINT statement
  2,                            // IF..THEN statement
  3,                            // IF..THEN..ELSE statement
  3,                            // FOR..IN statement
  0,                            // Error statement
  2,                            // Equals
  1,                            // Assign
  2,                            // Concatenate
  0,                            // Identifier
  0,                            // Integer constant
  0,                            // String constant
  1,                            // Coerce to string
  0                             // Method call
};

@implementation SyntaxTree

/*
 * Initialise a syntax tree with no children.
 */
- (id)init
{
  return [self initWithType:EmptyStmt
                  andChild1:nil
                  andChild2:nil
                  andChild3:nil];
}

/*
 * Initialise a syntax tree with a type and no children.
 */
- (id)initWithType:(STNodeType)type
{
  return [self initWithType:type
                  andChild1:nil
                  andChild2:nil
                  andChild3:nil];
}

/*
 * Initialise a syntax tree with a type and one child.
 */
- (id)initWithType:(STNodeType)type
         andChild1:(SyntaxTree *)child1
{
  return [self initWithType:type
                  andChild1:child1
                  andChild2:nil
                  andChild3:nil];
}

/*
 * Initialise a syntax tree with a type and two children.
 */
- (id)initWithType:(STNodeType)type
         andChild1:(SyntaxTree *)child1
         andChild2:(SyntaxTree *)child2
{
  return [self initWithType:type
                  andChild1:child1
                  andChild2:child2
                  andChild3:nil];
}

/*
 * Initialise a syntax tree with a type and three children.
 */
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
  }

  return self;
}

/*
 * Free a syntax tree.
 */
- (id)free
{
  /* Free the children if they exist. */
  if (_children) {
    [_children freeObjects];
    [_children free];
    _children = nil;
  }

  /* XXX don't free this. */
  _symbol = nil;

  return [super free];
}

/*
 * Sets the node type to the given type.
 */
- (void)setNodeType:(STNodeType)type
{
  _nodeType = type;
}

/*
 * Returns the node type.
 */
- (STNodeType)nodeType
{
  return _nodeType;
}

/*
 * Sets the return type to the given type.
 */
- (void)setReturnType:(STRetType)type
{
  _retType = type;
}

/*
 * Returns the return type.
 */
- (STRetType)returnType
{
  return _retType;
}

/*
 * Sets the symbol to the given value.
 */
- (void)setSymbol:(Symbol *)symb
{
  _symbol = symb;
}

/*
 * Returns the symbol.
 */
- (Symbol *)symbol
{
  return _symbol;
}

/*
 * Sets the child at the given index to the given value.
 *
 * If index is out of bounds, then nothing is done.
 */
- (void)setChildAtIndex:(int)index
                     to:(SyntaxTree *)child
{
  if (index > [_children count]) {
    return;
  }

  [_children replaceObjectAt:index
                        with:child];
}

/*
 * Returns the child at the given index.
 *
 * If the index does not exist, or there is no child at that index
 * then nil is returned.
 */
- (SyntaxTree *)childAtIndex:(int)index
{
  if (index > [_children count]) {
    return nil;
  }

  return [_children objectAt:index];
}

/*
 * Coerce the child to a string.
 */
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

- (void)interpret
{
  interpret(self);
}

/*
 * Check the syntax for this node.
 */
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

    case CoerceToString:
      _retType = ReturnString;
      break;

    case MethodCall:
      break;
  }

  /* Check whether the node is syntactically correct. */
  switch (_nodeType) {
    case IfThenStmt:
    case IfThenElseStmt:
      if ([[_children objectAt:0] returnType] != ReturnBool) {
        fprintf(stderr, "if: Condition should be boolean.");
      }
      break;

    case EqualExpr:
      if ([[_children objectAt:0] returnType] !=
          [[_children objectAt:1] returnType])
      {
        fprintf(stderr, "==: Different types.");
      }
      break;

    case ConcatExpr:
      if (![self coerceToString:0]) {
        fprintf(stderr, "+: Cannot coerce first argument to string.");
      }
      if (![self coerceToString:1]) {
        fprintf(stderr, "+: Cannot coerce second argument to string.");
      }
      break;

    case AssignExpr:
      if (![self coerceToString:0]) {
        fprintf(stderr, "=: Cannot coerce to string.");
      }
      break;

      /* Default case to keep the compiler happy. */
    default:
      break;
  }
}

@end /* SyntaxTree */

@implementation SyntaxTree (Debug)

/*
 * Print debugging information.
 */
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

@end /* SyntaxTree (Debug) */

/* SyntaxTree.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
