/*
 * UI.m  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Fri, 24 Feb 2017 00:24:37 +0000 (GMT)
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

#import "UI.h"
#import "GNUstep.h"
#import "Utils.h"

#ifdef PLATFORM_NEXTSTEP
# define DEREF(__t)   (__t)
#else
# define DEREF(__t)   *(__t)
#endif

void
set_rect(Rect_t  *rect,
        Coord_t  x,
        Coord_t  y,
        Coord_t  width,
        Coord_t  height)
{
  rect->origin.x    = x;
  rect->origin.y    = y;
  rect->size.width  = width;
  rect->size.height = height;
}

Font_t *
user_font_of_size(float size)
{
  return [Font_t userFontOfSize:size
#ifdef PLATFORM_NEXTSTEP
                         matrix:NX_FLIPPEDMATRIX
#endif
           ];
}

Font_t *
system_font_of_size(float size)
{
  return [Font_t systemFontOfSize:size
#ifdef PLATFORM_NEXTSTEP
                            matrix:NX_FLIPPEDMATRIX
#endif
           ];
}

Font_t *
bold_system_font_of_size(float size)
{
  return [Font_t boldSystemFontOfSize:size
#ifdef PLATFORM_NEXTSTEP
                               matrix:NX_FLIPPEDMATRIX
#endif
           ];
}

Font_t *
user_fixed_font_of_size(float size)
{
  return [Font_t userFixedPitchFontOfSize:size
#ifdef PLATFORM_NEXTSTEP
                                   matrix:NX_FLIPPEDMATRIX
#endif
           ];
}

Font_t *
convert_to_have_trait(FontManager_t *manager,
                      Font_t        *font,
                      unsigned int   trait)
{
#ifdef PLATFORM_NEXTSTEP
  return [manager convert:font
              toHaveTrait:trait];
#else
  return [manager convertFont:font
                  toHaveTrait:trait];
#endif
}

void
run_application(Application_t *app, AutoreleasePool_t *pool)
{
#ifdef PLATFORM_NEXTSTEP
  [app activateSelf:YES];
  [app run];
#else
  pool = [NSAutoreleasePool new];

  [app run];
#endif
}

Menu_t *
make_menu(const char *title)
{
  Menu_t *res = [[Menu_t alloc] init];

#ifdef PLATFORM_NEXTSTEP
  [res setTitle:title];
#else
  [res setTitle:[NSString stringWithCString:title]];
#endif

  return res;
}

id
add_menu_item(Menu_t     *menu,
              const char *title,
              SEL        target,
              const char  shortcut)
{
#ifdef PLATFORM_NEXTSTEP
  return [menu addItem:title
                action:(id)target
         keyEquivalent:(unsigned short)shortcut];
#else
  NSString *key = [NSString stringWithFormat:@"%c", shortcut];
  id        ret = nil;

  ret = [menu addItemWithTitle:[NSString stringWithCString:title]
                        action:target
                 keyEquivalent:[key copy]];

  RELEASE(key);

  return ret;
#endif
}

void
set_submenu(Menu_t *menu, Menu_t *submenu, id item)
{
  [menu setSubmenu:submenu forItem:item];
}

void
set_windows_menu(Application_t *app, Menu_t *menu)
{
  [app setWindowsMenu:menu];
}

void
set_main_menu(Application_t *app, Menu_t *menu)
{
  [app setMainMenu:menu];
}

void
size_menu_to_fit(Menu_t *menu)
{
#ifdef PLATFORM_NEXTSTEP
  [menu sizeToFit];
#endif
}

void
set_window_title(Window_t *wnd, const char *title)
{
#ifdef PLATFORM_NEXTSTEP
  [wnd setTitle:title];
#else
  [wnd setTitle:[NSString stringWithCString:title]];
#endif
}

TextField_t *
make_label(View_t     *view,
           Rect_t     *frame,
           const char *text,
           int         alignment,
           Color_t     textGray,
           Font_t     *font)
{
  TextField_t *res = AUTORELEASE([[TextField_t alloc] init]);

#ifdef PLATFORM_NEXTSTEP
  [res setStringValue:text];
#else
  [res setStringValue:[NSString stringWithCString:text]];
#endif

  [res setEditable:NO];
  [res setSelectable:NO];
  [res setBordered:NO];
  [res setBezeled:NO];
  [res setAlignment:alignment];

#ifdef PLATFORM_NEXTSTEP
  [res setBackgroundTransparent:YES];
  [res setTextGray:textGray];
#else
  [res setDrawsBackground:NO];
  [res setTextColor:textGray];
#endif

  if (font != nil) {
    [res setFont:font];
  }

  [view addSubview:res];
  [res setFrame:DEREF(frame)];

  return res;
}

TextField_t *
make_textfield(View_t     *view,
               Rect_t     *frame,
               const char *text,
               BOOL        editable,
               BOOL        selectable,
               Color_t     backgroundGray,
               Font_t     *font)
{
  TextField_t *res = AUTORELEASE([[TextField_t alloc] init]);

#ifdef PLATFORM_NEXTSTEP
  [res setStringValue:text];
#else
  [res setStringValue:[NSString stringWithCString:text]];
#endif

  [res setEditable:editable];
  [res setSelectable:selectable];
  [res setBordered:YES];
  [res setBezeled:YES];

#ifdef PLATFORM_NEXTSTEP
  [res setAlignment:NX_LEFTALIGN];
  [res setBackgroundTransparent:NO];
  [res setBackgroundGray:backgroundGray];
#else
  [res setAlignment:NSLeftTextAlignment];
  [res setDrawsBackground:YES];
  [res setBackgroundColor:backgroundGray];
#endif


  if (font != nil) {
    [res setFont:font];
  }

  [view addSubview:res];
  [res setFrame:DEREF(frame)];

  return res;
}

Button_t *
make_button(View_t     *view,
            Rect_t     *frame,
            const char *title,
            const char *altTitle,
            Image_t    *image,
            Image_t    *altImage,
            int         iconPosition,
            BOOL        bordered,
            int         buttonType,
            SEL        *target)
{
  Button_t *res = AUTORELEASE([[Button_t alloc] init]);

  if (title != NULL) {
#ifdef PLATFORM_NEXTSTEP
    [res setTitle:title];
#else
    [res setTitle:[NSString stringWithCString:title]];
#endif
  }

  if (altTitle != NULL) {
#ifdef PLATFORM_NEXTSTEP
    [res setAltTitle:altTitle];
#else
    [res setAlternateTitle:[NSString stringWithCString:altTitle]];
#endif
  }

  if (image != nil) {
    [res setImage:image];
  }

  if (altImage != nil) {
#ifdef PLATFORM_NEXTSTEP
    [res setAltImage:altImage];
#else
    [res setAlternateImage:altImage];
#endif
  }

  if (target != NULL) {
    [res setTarget:(id)target];
  }

#ifdef PLATFORM_NEXTSTEP
  [res setIconPosition:iconPosition];
  [res setType:buttonType];
#else
  [res setImagePosition:iconPosition];
  [res setButtonType:buttonType];
#endif

  [res setBordered:bordered];

  [view addSubview:res];
  [res setFrame:DEREF(frame)];

  return res;
}

/* UI.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
