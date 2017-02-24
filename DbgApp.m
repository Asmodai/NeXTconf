/*
 * DbgApp.m  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Thu, 23 Feb 2017 15:49:05 +0000 (GMT)
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

#import "DbgApp.h"
#import "GNUstep.h"
#import "UI.h"

@implementation DbgApp

- (id)init
{
#ifdef PLATFORM_NEXTSTEP
  _pool = NULL;
#else
  _pool = [NSAutoreleasePool new];
#endif

  if ((self = [super init]) != nil) {
    _app       = [Application_t new];
    _infoPanel = [[DbgInfoPanel alloc] initWithApp:_app];

    [self buildMenues];

    [_app setDelegate:self];
  }

  return self;
}

- (id)free
{
  [_infoPanel free];

#ifdef PLATFORM_NEXTSTEP
  [_app free];
#endif

  DESTROY(_infoPanel);
  DESTROY(_app);

  return [super free];
}

- (id)showInfoPanel:(id)sender
{
  [_infoPanel makeKeyAndOrderFront:self];

  return self;
}

- (void)buildMenues
{
  id infoCell  = nil;
  id docCell   = nil;
  id toolsCell = nil;
  id wndCell   = nil;

  _menu      = make_menu("NCdbg");
  _infoMenu  = make_menu("Info");
  _docMenu   = make_menu("Document");
  _toolsMenu = make_menu("Tools");
  _wndMenu   = make_menu("Windows");

  add_menu_item(_infoMenu, "Info...", @selector(showInfoPanel:), ' ');
  add_menu_item(_infoMenu, "Help...", @selector(showHelp:), '?');

  add_menu_item(_docMenu, "Open...", @selector(openFile:), '0');
  add_menu_item(_docMenu, "Close", @selector(closeFile:), ' ');

  add_menu_item(_toolsMenu,
                "Stack Browser",
                @selector(showStackBrowser:),
                ' ');
  add_menu_item(_toolsMenu,
                "Object Browser",
                @selector(showObjectBrowser:),
                ' ');
  add_menu_item(_toolsMenu,
                "Symbol Browser",
                @selector(showSymbolBrowser:),
                ' ');
  add_menu_item(_toolsMenu,
                "AST Browser",
                @selector(showASTBrowser:),
                ' ');

  set_windows_menu(_app, _wndMenu);

  infoCell  = add_menu_item(_menu, "Info", NULL, ' ');
  docCell   = add_menu_item(_menu, "Document", NULL, ' ');
  toolsCell = add_menu_item(_menu, "Tools", NULL, ' ');
  wndCell   = add_menu_item(_menu, "Windows", NULL, ' ');
  
  add_menu_item(_menu, "Hide", @selector(hide:), 'h');
  add_menu_item(_menu, "Quit", @selector(terminate:), 'q');

  set_submenu(_menu, _infoMenu, infoCell);
  set_submenu(_menu, _docMenu, docCell);
  set_submenu(_menu, _toolsMenu, toolsCell);
  set_submenu(_menu, _wndMenu, wndCell);

  size_menu_to_fit(_infoMenu);
  size_menu_to_fit(_docMenu);
  size_menu_to_fit(_toolsMenu);
  size_menu_to_fit(_wndMenu);
  size_menu_to_fit(_menu);

  set_main_menu(_app, _menu);
}

- (void)start
{
  run_application(_app, _pool);

  [self free];

  exit(EXIT_SUCCESS);
}

@end                            // DbgApp

/* DbgApp.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
