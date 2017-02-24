/*
 * DbgInfoPanel.h  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Thu, 23 Feb 2017 16:37:56 +0000 (GMT)
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
#import "Types.h"
#import "UI.h"


@interface DbgInfoPanel : Panel_t
{
  Rect_t  _rect;

  /* UI elements. */
  id _appIcon;
  id _appIconBtn;
  
  id _titleDarkText;
  id _titleLightText;
  id _titleText;
  id _tagText;
  id _infoText;
  id _copyrightText;
}

/*
 * Initialisation and destruction.
 */
- (id)initWithApp:(id)app;
- (id)free;

@end                            // DbgInfoPanel

/*
#ifdef PLATFORM_NEXTSTEP
@interface DbgInfoPanel (NS3)

- (id)initWithApp:(id)app;

@end
#endif
*/

/* DbgInfoPanel.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * mode: objc ***
 * End: ***
 */
