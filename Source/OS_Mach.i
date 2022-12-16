/*
 * OS_Mach.m  --- Mach-specific functions.
 *
 * Copyright (c) 2015-2022 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sun,  8 Nov 2015 06:50:16 +0000 (GMT)
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

static
BOOL
impl__get_os_version(void)
{
  kern_return_t    kret                        = 0;
  kernel_version_t kver                        = "";
  size_t           idx                         = 0;
  size_t           len                         = 0;
  char             version[KERNEL_VERSION_MAX] = { 0 };

  kret = host_kernel_version(host_self(),kver);
  if (kret != KERN_SUCCESS) {
    mach_error("host_kernel_version() failed.", kret);
    return NO;
  }

  strncpy(version, kver, KERNEL_VERSION_MAX);
  len = strlen(version);

  if (version[len - 1] == '\n') {
    version[len - 1] = '\0';
  }

  for (idx = 0; idx < len; idx++) {
    /* version \d.\d: */
    if (isdigit(version[idx])     && version[idx + 1] == '.' &&
        isdigit(version[idx + 2]) && version[idx + 3] == ':')
    {
      _major_version = version[idx] - '0';
      _minor_version = version[idx + 2] - '0';
      break;
    }

    /* version \d.\d.\d: */
    if (isdigit(version[idx])     && version[idx + 1] == '.' &&
        isdigit(version[idx + 2]) && version[idx + 3] == '.' &&
        isdigit(version[idx + 4]) && version[idx + 5] == ':')
    {
      _major_version = version[idx] - '0';
      _minor_version = version[idx + 2] - '0';
      break;
    }
  }

  return YES;
}

/* OS_Mach.m ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
