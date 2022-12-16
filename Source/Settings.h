/*
 * Settings.h  --- NeXTconf runtime settings.
 *
 * Copyright (c) 2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Fri,  16 Dec 2022 02:33:55 +0000 (GMT)
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
#import <objc/List.h>
#import "Object+Debug.h"
#import "List+Debug.h"

#import "Property.h"
#import "String.h"
#import "Boolean.h"

@interface Settings : Property
{
  String  *_headerLocation;     // Location to generated header(s).
  String  *_makefileLocation;   // Location to generated makefiles.
  Boolean *_generateHeader;     // Should we generate a header?
  Boolean *_generateMakefile;   // Should we generate a makefile? 
}

/*
 * Initialisation and destruction.
 */
- (id)init;
- (id)free;

/*
 * Accessors.
 */
- (String *)headerLocation;
- (String *)makefileLocation;

- (void)setHeaderLocation:(String *)aString;
- (void)setMakefileLocation:(String *)aString;

- (void)setGenerateHeader:(Boolean *)aBool;
- (void)setGenerateMakefile:(Boolean *)aBool;

/*
 * Predicates.
 */
- (Boolean *)generateMakefile;
- (Boolean *)generateHeader;

@end

@interface Settings (Debug)

/*
 * Debugging.
 */
- (void)_printDebugInfo:(int)indent;

@end


/* Settings.h ends here */
/*
 * Local Variables: ***
 * mode: objc ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
