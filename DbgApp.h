/*
 * DbgApp.h  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Thu, 23 Feb 2017 15:41:40 +0000 (GMT)
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

#import "version.h"

#import <objc/Object.h>

#import "UI.h"
#import "DbgInfoPanel.h"

@interface DbgApp : Object
{
  AutoreleasePool_t *_pool;
  Application_t     *_app;

  /* Menues. */
  Menu_t *_menu;
  Menu_t *_infoMenu;
  Menu_t *_docMenu;
  Menu_t *_toolsMenu;
  Menu_t *_wndMenu;

  /* Panels. */
  id _infoPanel;
  id _stackPanel;
  id _objectPanel;
  id _symbolPanel;
  id _syntaxPanel;
}

- (id)init;
- (id)free;

- (id)showInfoPanel:(id)sender;

- (void)buildMenues;
- (void)start;

@end                            // DbgApp

/* DbgApp.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * mode: objc ***
 * End: ***
 */
