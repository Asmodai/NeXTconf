/*
 * UI.h  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Fri, 24 Feb 2017 04:16:47 +0000 (GMT)
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

#ifdef PLATFORM_NEXTSTEP
# import <dpsclient/event.h>
# import <appkit/graphics.h>
# import <appkit/Application.h>
# import <appkit/Menu.h>
# import <appkit/View.h>
# import <appkit/Font.h>
# import <appkit/FontManager.h>
# import <appkit/ButtonCell.h>
# import <appkit/Button.h>
# import <appkit/Text.h>
# import <appkit/TextField.h>
# import <appkit/NXImage.h>
# import <appkit/Window.h>
# import <appkit/Panel.h>

# define AutoreleasePool_t void
# define Color_t           float
# define Coord_t           NXCoord
# define Point_t           NXPoint
# define Size_t            NXSize
# define Rect_t            NXRect
# define Application_t     Application
# define Menu_t            Menu
# define MenuItem_t        MenuCell
# define Font_t            Font
# define FontManager_t     FontManager
# define View_t            View
# define TextField_t       TextField
# define Button_t          Button
# define Image_t           NXImage
# define Window_t          Window
# define Panel_t           Panel
#else
# import <Foundation/NSGeometry.h>
# import <Foundation/NSAutoreleasePool.h>
# import <AppKit/NSColor.h>
# import <AppKit/NSApplication.h>
# import <AppKit/NSMenu.h>
# import <AppKit/NSView.h>
# import <AppKit/NSFont.h>
# import <AppKit/NSFontManager.h>
# import <AppKit/NSButtonCell.h>
# import <AppKit/NSButton.h>
# import <AppKit/NSText.h>
# import <AppKit/NSTextField.h>
# import <AppKit/NSImage.h>
# import <AppKit/NSWindow.h>
# import <AppKit/NSPanel.h>

# define AutoreleasePool_t NSAutoreleasePool
# define Color_t           NSColor *
# define Coord_t           float
# define Point_t           NSPoint
# define Size_t            NSSize
# define Rect_t            NSRect
# define Application_t     NSApplication
# define Menu_t            NSMenu
# define MenuItem_t        NSMenuItem
# define Font_t            NSFont
# define FontManager_t     NSFontManager
# define View_t            NSView
# define TextField_t       NSTextField
# define Button_t          NSButton
# define Image_t           NSImage
# define Window_t          NSWindow
# define Panel_t           NSPanel
#endif

#ifndef PLATFORM_NEXTSTEP
# define NX_WHITE                 [NSColor whiteColor]
# define NX_LTGRAY                [NSColor lightGrayColor]
# define NX_DKGRAY                [NSColor darkGrayColor]
# define NX_BLACK                 [NSColor blackColor]

# define NX_MOMENTARYPUSH         NSMomentaryPushButton
# define NX_PUSHONPUSHOFF         NSPushOnPushOffButton
# define NX_TOGGLE                NSToggleButton
# define NX_SWITCH                NSSwitchButton
# define NX_RADIOBUTTON           NSRadioButton
# define NX_MOMENTARYCHANGE       NSMomentaryChangeButton
# define NX_ONOFF                 NSOnOffButton

# define NX_ITALIC                NSItalicFontMask
# define NX_BOLD                  NSBoldFontMask
# define NX_UNBOLD                NSUnboldFontMask
# define NX_NONSTANDARDCHARSET    NSNonStandardCharacterSetFontMask
# define NX_NARROW                NSNarrowFontMask
# define NX_EXPANDED              NSExpandedFontMask
# define NX_CONDENSED             NSCondensedFontMask
# define NX_SMALLCAPS             NSSmallCapsFontMask
# define NX_POSTER                NSPosterFontMask
# define NX_COMPRESSED            NSCompressedFontMask
# define NX_UNITALIC              NSUnitalicFontMask

# define NX_TITLEONLY             NSNoImage
# define NX_ICONONLY              NSImageOnly
# define NX_ICONLEFT              NSImageLeft
# define NX_ICONRIGHT             NSImageRight
# define NX_ICONBELOW             NSImageBelow
# define NX_ICONABOVE             NSImageAbove
# define NX_ICONOVERLAPS          NSImageOverlaps

# define NX_LEFTALIGNED           NSLeftTextAlignment
# define NX_RIGHTALIGNED          NSRightTextAlignment
# define NX_CENTERED              NSCenterTextAlignment
# define NX_JUSTIFIED             NSJustifiedTextAlignment

# define NX_PLAINSTYLE            NSBorderlessWindowMask
# define NX_TITLEDSTYLE           NSTitledWindowMask
# define NX_RESIZEBARSTYLE        NSResizableWindowMask

# define NX_CLOSEBUTTONMASK       NSClosableWindowMask
# define NX_MINIATURIZEBUTTONMASK NSMiniaturizableWindowMask

# define NX_NONRETAINED           NSBackingStoreNonretained
# define NX_RETAINED              NSBackingStoreRetained
# define NX_BUFFERED              NSBackingStoreBuffered
#endif

void set_rect(Rect_t *, Coord_t, Coord_t, Coord_t, Coord_t);

Font_t *user_font_of_size(float);
Font_t *system_font_of_size(float);
Font_t *bold_system_font_of_size(float);
Font_t *user_fixed_font_of_size(float);
Font_t *convert_to_have_trait(FontManager_t *, Font_t *, unsigned int);

void         run_application(Application_t *, AutoreleasePool_t *);
Menu_t      *make_menu(const char *title);
id           add_menu_item(Menu_t *, const char *, SEL , const char );
void         set_submenu(Menu_t *, Menu_t *, id);
void         set_windows_menu(Application_t *, Menu_t *);
void         set_main_menu(Application_t *, Menu_t *);
void         size_menu_to_fit(Menu_t *);
void         set_window_title(Window_t *wnd, const char *title);
TextField_t *make_label(View_t     *view,
                        Rect_t     *frame,
                        const char *text,
                        int         alignment,
                        Color_t     textGray,
                        Font_t     *font);
TextField_t *make_textfield(View_t     *view,
                            Rect_t     *frame,
                            const char *text,
                            BOOL        editable,
                            BOOL        selectable,
                            Color_t     backgroundGray,
                            Font_t     *font);
Button_t    *make_button(View_t     *view,
                         Rect_t     *frame,
                         const char *title,
                         const char *altTitle,
                         Image_t    *image,
                         Image_t    *altImage,
                         int         iconPosition,
                         BOOL        bordered,
                         int         buttonType,
                         SEL        *target);

/* UI.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * mode: objc ***
 * End: ***
 */
