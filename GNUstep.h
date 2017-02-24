/*
 * GNUstep.h  --- Some title
 *
 * Copyright (c) 2017 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Fri, 24 Feb 2017 00:32:20 +0000 (GMT)
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

/*
 * Platform is NEXTSTEP.
 */

# ifndef RETAIN
#  define RETAIN(__o)              (__o)
# endif
# ifndef RELEASE
#  define RELEASE(__o)
# endif
# ifndef AUTORELEASE
#  define AUTORELEASE(__o)         (__o)
# endif
# ifndef TEST_RETAIN
#  define TEST_RETAIN(__o)         (__o)
# endif
# ifndef TEST_RELEASE
#  define TEST_RELEASE(__o)
# endif
# ifndef TEST_AUTORELEASE
#  define TEST_AUTORELEASE(__o)    (__o)
# endif
# ifndef ASSIGN
#  define ASSIGN(__o, __v)         __o = (__v)
# endif
# ifndef ASSIGNCOPY
#  define ASSIGNCOPY(__o, __v)     __o = [(__v) copy]
# endif
# ifndef DESTROY
#  define DESTROY(__o)             __o = nil
# endif

#else

/*
 * Platform is an OpenStep.
 */

# ifndef RETAIN
#  define RETAIN(__o)              [(__o) retain]
# endif
# ifndef RELEASE
#  define RELEASE(__o)             [(__o) release]
# endif
# ifndef AUTORELEASE
#  define AUTORELEASE(__o)         [(__o) autorelease]
# endif
# ifndef TEST_RETAIN
#  define TEST_RETAIN(__o)         ({\
  id __obj = (__o); (__obj != nil) ? [__obj retain] : nil; })
# endif
# ifndef TEST_RELEASE
#  define TEST_RELEASE(__o)        ({\
  id __obj = (_o); if (__obj != nil) [__obj release]; })
# endif
# ifndef TEST_AUTORELEASE
#  define TEST_AUTORELEASE(__o)    ({\
  id __obj = (__o); (__obj != nil) ? [__obj autorelease] : nil; })
# endif
# ifndef ASSIGN
#  define ASSIGN(__o, __v)         ({\
  id __obj = __o; __o = [(__v) retain]; [__obj release]; })
# endif
# ifndef ASSIGNCOPY
#  define ASSIGNCOPY(__o, __v)     ({\
  id __obj = __o; __o = [(__v) copy]; [__obj release]; })
# endif
# ifndef DESTROY
#  define DESTROY(__o)             ({\
  id __obj = __o; __o = nil; [__obj release]; })
# endif

#endif // PLATFORM_NEXTSTEP

/* GNUstep.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * mode: objc ***
 * End: ***
 */
