/*
 * DbgInfoPanel.m  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Thu, 23 Feb 2017 16:40:22 +0000 (GMT)
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

#import "DbgInfoPanel.h"
#import "version.h"
#import "Version.h"
#import "UI.h"

#import <objc/Object.h>

@implementation DbgInfoPanel

- (id)initWithApp:(id)app
{
  set_rect(&_rect, 255, 761, 378, 240);

#ifdef PLATFORM_NEXTSTEP
  self = [super initContent:&_rect
                      style:NX_TITLEDSTYLE
                    backing:NX_BUFFERED
                 buttonMask:NX_CLOSEBUTTONMASK
                      defer:YES];
#else
  self = [super initWithContentRect:_rect
                          styleMask:(NX_TITLEDSTYLE | NX_CLOSEBUTTONMASK)
                            backing:NX_BUFFERED
                              defer:YES];
#endif

  if (self != nil) {
    Rect_t         rect;
    FontManager_t *fmgr = [FontManager_t new];
    Font_t        *fnt  = user_font_of_size(12.0);
    char          *buf  = NULL;

    buf = xmalloc(sizeof *buf * 512);

#ifdef PLATFORM_NEXTSTEP
    _appIcon = [[Image_t alloc] initFromSection:"app"];
#else
    // XXX - get icon from segment?
    _appIcon = [Image_t imageNamed:@"__ICON"];
#endif

    set_rect(&rect, 163, 185, 48, 48);
    _appIconBtn = make_button([self contentView],
                              &rect,
                              NULL,
                              NULL,
                              _appIcon,
                              _appIcon,
                              NX_ICONONLY,
                              NO,
                              NX_MOMENTARYCHANGE,
                              NULL);


    set_rect(&rect, 0, 156, 374, 30);
    _titleDarkText = make_label([self contentView],
                                &rect,
                                "NeXTconf Debugger",
                                NX_CENTERED,
                                NX_DKGRAY,
                                bold_system_font_of_size(24.0));

    set_rect(&rect, 0, 154, 378, 30);
    _titleLightText = make_label([self contentView],
                                 &rect,
                                 "NeXTconf Debugger",
                                 NX_CENTERED,
                                 NX_WHITE,
                                 bold_system_font_of_size(24.0));

    set_rect(&rect, 0, 155, 376, 30);
    _titleText = make_label([self contentView],
                            &rect,
                            "NeXTconf Debugger",
                            NX_CENTERED,
                            NX_BLACK,
                            bold_system_font_of_size(24.0));


    set_rect(&rect, 0, 135, 378, 18);
    _tagText = make_label([self contentView],
                          &rect,
                          "``Find all the bugs''",
                          NX_CENTERED,
                          NX_DKGRAY,
                          convert_to_have_trait(fmgr, fnt, NX_ITALIC));

    set_rect(&rect, 6, 25, 366, 110);
    [Version printToBuffer:buf
                  withSize:511];
    _infoText = make_textfield([self contentView],
                               &rect,
                               buf,
                               NO,
                               NO,
                               NX_LTGRAY,
                               user_fixed_font_of_size(12.0));
    xfree(buf);

    set_rect(&rect, 0, 5, 378, 15);
    _copyrightText = make_label([self contentView],
                                &rect,
                                [Version copyright],
                                NX_CENTERED,
                                NX_DKGRAY,
                                user_font_of_size(12.0));

    set_window_title(self, "Info");
    [self display];
  }

  return self;
}

- (id)free
{
  return [super free];
}

@end                            // DbgInfoPanel


/*

#ifdef PLATFORM_NEXTSTEP

TextField *
make_label(const char *text)
{
  TextField *res = [[TextField alloc] init];

  [res setStringValue:text];
  [res setBackgroundTransparent:YES];
  [res setEditable:NO];
  [res setBordered:NO];
  [res setBezeled:NO];

  return res;
}

TextField *
make_textfield(const char *text)
{
  TextField *res = [[TextField alloc] init];

  [res setStringValue:text];
  [res setBackgroundTransparent:NO];
  [res setEnabled:YES];
  [res setSelectable:YES];
  [res setEditable:YES];
  [res setBordered:YES];
  [res setBezeled:YES];

  return res;
}

@implementation DbgInfoPanel (NS3)

- (id)initWithApp:(id)app
{
  NXSetRect(&_rect, 225, 761, 378, 240);

  if ((self = [super initContent:&_rect
                           style:NX_TITLEDSTYLE
                         backing:NX_BUFFERED
                      buttonMask:NX_CLOSEBUTTONMASK
                           defer:YES]) != nil)
  {
    Rect_t       rect  = { 0 };
    FontManager *fmgr  = [FontManager new];
    Font        *fnt   = [Font userFontOfSize:12
                                       matrix:NX_FLIPPEDMATRIX];
    char        *buf   = NULL;

    buf      = xmalloc(sizeof *buf * 512);
    _appIcon = [[NXImage alloc] initFromSection:"app"];

    NXSetRect(&rect, 163, 185, 48, 48);
    _appIconBtn = [[Button alloc] init];
    [_appIconBtn setTitle:""];
    [_appIconBtn setIconPosition:NX_ICONONLY];
    [_appIconBtn setBordered:NO];
    [_appIconBtn setType:NX_MOMENTARYCHANGE];
    [_appIconBtn setImage:_appIcon];
    [_appIconBtn setAltImage:_appIcon];
    [_appIconBtn setTarget:NULL];
    [[self contentView] addSubview:_appIconBtn];
    [_appIconBtn setFrame:&rect];

    NXSetRect(&rect, 0, 156, 374, 30);
    _titleDarkText = make_label("NeXTconf Debugger");
    [_titleDarkText setTextGray:NX_DKGRAY];
    [_titleDarkText setFont:[Font boldSystemFontOfSize:24.0
                                                matrix:NX_FLIPPEDMATRIX]];
    [_titleDarkText setAlignment:NX_CENTERED];
    [[self contentView] addSubview:_titleDarkText];
    [_titleDarkText setFrame:&rect];

    NXSetRect(&rect, 0, 154, 378, 30);
    _titleLightText = make_label("NeXTconf Debugger");
    [_titleLightText setTextGray:NX_WHITE];
    [_titleLightText setFont:[Font boldSystemFontOfSize:24.0
                                                 matrix:NX_FLIPPEDMATRIX]];
    [_titleLightText setAlignment:NX_CENTERED];
    [[self contentView] addSubview:_titleLightText];
    [_titleLightText setFrame:&rect];

    NXSetRect(&rect, 0, 155, 376, 30);
    _titleText = make_label("NeXTconf Debugger");
    [_titleText setTextGray:NX_BLACK];
    [_titleText setFont:[Font boldSystemFontOfSize:24.0
                                            matrix:NX_FLIPPEDMATRIX]];
    [_titleText setAlignment:NX_CENTERED];
    [[self contentView] addSubview:_titleText];
    [_titleText setFrame:&rect];

    NXSetRect(&rect, 0, 135, 378, 18);
    _tagText = make_label("``Find all the bugs''");
    [_tagText setTextGray:NX_DKGRAY];
    [_tagText setFont:[fmgr convert:fnt toHaveTrait:NX_ITALIC]];
    [_tagText setAlignment:NX_CENTERED];
    [[self contentView] addSubview:_tagText];
    [_tagText setFrame:&rect];

    NXSetRect(&rect, 6, 25, 366, 110);
    [Version printToBuffer:buf
                  withSize:511];
    _infoText = make_textfield(buf);
    xfree(buf);
    [_infoText setFont:[Font userFixedPitchFontOfSize:12.0
                                               matrix:NX_FLIPPEDMATRIX]];
    [_infoText setEditable:NO];
    [_infoText setSelectable:NO];
    [_infoText setBackgroundGray:NX_LTGRAY];
    [[self contentView] addSubview:_infoText];
    [_infoText setFrame:&rect];

    NXSetRect(&rect, 0, 5, 378, 15);
    _copyrightText = make_label([Version copyright]
    );
    [_copyrightText setTextGray:NX_DKGRAY];
    [_copyrightText setFont:[Font userFontOfSize:12.0
                                          matrix:NX_FLIPPEDMATRIX]];
    [_copyrightText setAlignment:NX_CENTERED];
    [[self contentView] addSubview:_copyrightText];
    [_copyrightText setFrame:&rect];

    [self setTitle:"Info"];
    [self display];
  }

  return self;
}

@end

#endif

*/

/* DbgInfoPanel.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
