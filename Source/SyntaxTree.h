/*
 * SyntaxTree.h  --- Syntax tree class interface.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Wed,  4 Nov 2015 04:41:44 +0000 (GMT)
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
#import <objc/List.h>

#import "Symbol.h"

typedef enum {
  StmtList,                     // Statement list.
  IncludedFile,                 // Included file.
  EmptyStmt,                    // Empty statement.
  ExprStmt,                     // Expression statement.
  PrintStmt,                    // Print statement.
  IfThenStmt,                   // If..Then statement.
  IfThenElseStmt,               // If..Then..Else statement.
  ForInStmt,                    // For..In statement.
  ErrorStmt,                    // Error statement.
  EqualExpr,                    // Equal expression.
  NotEqualExpr,                 // Not-Equal expression.
  AssignExpr,                   // Assign expression.
  AddExpr,                      // Numeric addition expression.
  SubExpr,                      // Numeric subtraction expression.
  MulExpr,                      // Numeric multiplication expression.
  DivExpr,                      // Numeric division expression.
  ConcatExpr,                   // Concatenation expression.
  LogicalAndExpr,               // Logical `and' expression.
  LogicalOrExpr,                // Logical `or' expression.
  LogicalXorExpr,               // Logical `xor' expression.
  IdentExpr,                    // Identifier expression.
  NumberExpr,                   // Integer constant expression.
  StringExpr,                   // String constant expression.
  BooleanExpr,                  // Boolean constant expression.
  CoerceToString,               // Coerce a boolean to a string.
  MethodCall                    // Method call.
} STNodeType;

typedef enum {
  ReturnVoid,                   // Returns void (i.e. nothing.)
  ReturnString,                 // Returns a string.
  ReturnNumber,                 // Returns a number.
  ReturnBool                    // Returns a boolean.
} STRetType;

/*
 * This class implements a syntax tree object with up to 3
 * children.
 *
 * If the number of children is changed, then you must create
 * explicit init methods and change DEFAULT_MAX_CHILD_SLOTS in
 * SyntaxTree.m too!
 */
@interface SyntaxTree : Object
{
  STNodeType  _nodeType;        // Node type.
  STRetType   _retType;         // Return type.
  Symbol     *_symbol;          // Symbol.
  List       *_children;        // Children.
  SyntaxTree *_included;        // Included file syntax tree.
  size_t      _lineNumber;      // Line number.
}

/*
 * Class methods.
 */
+ (id)newFromFile:(String *)aFile
           atLine:(size_t)aLine;
+ (id)newFromFile:(String *)aFile
           atLine:(size_t)aLine
        withDebug:(int)debugFlag;

/*
 * Initialisation.
 */
- (id)init;
- (id)initWithType:(STNodeType)type
            atLine:(size_t)aLine;
- (id)initWithType:(STNodeType)type
            atLine:(size_t)aLine
         andChild1:(SyntaxTree *)child1;
- (id)initWithType:(STNodeType)type
            atLine:(size_t)aLine
         andChild1:(SyntaxTree *)child1
         andChild2:(SyntaxTree *)child2;
- (id)initWithType:(STNodeType)type
            atLine:(size_t)aLine
         andChild1:(SyntaxTree *)child1
         andChild2:(SyntaxTree *)child2
         andChild3:(SyntaxTree *)child3;

/*
 * Destruction.
 */
- (id)free;

/*
 * Accessors.
 */
- (void)setNodeType:(STNodeType)type;
- (STNodeType)nodeType;
- (void)setReturnType:(STRetType)type;
- (STRetType)returnType;
- (void)setSymbol:(Symbol *)symb;
- (Symbol *)symbol;
- (SyntaxTree *)includedTree;
- (void)setChildAtIndex:(int)index
                     to:(SyntaxTree *)child;
- (SyntaxTree *)childAtIndex:(int)index;
- (void)setLineNumber:(size_t)aLine;
- (size_t)lineNumber;

/*
 * Utilities.
 */
- (BOOL)coerceToString:(int)child;
- (void)checkSyntax;
- (void)processIncludedFile;

@end                            // SyntaxTree

@interface SyntaxTree (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end                            // SyntaxTree (Debug)

/* SyntaxTree.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
