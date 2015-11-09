/*
 * Utils.c  --- Utility implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/09 05:01:49 asmodai>
 * Revision:   2
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat,  7 Nov 2015 22:47:55 +0000 (GMT)
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

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <libc.h>
#include <string.h>
#include <errno.h>

#include <sys/types.h>
#include <sys/param.h>
#include <sys/dir.h>
#include <sys/stat.h>

#include "Utils.h"

/*
 * Print debug information to standard output.
 *
 * The output will be preceeded by a given amount of indentation.
 */
void
debug_print(size_t indent, const char *fmt, ...)
{
  va_list ap;
  size_t  i  = 0;
  
  for (i = 0; i < indent; ++i) {
    fputc(' ', stderr);
  }

  va_start(ap, fmt);
  vfprintf(stderr, fmt, ap);
  va_end(ap);
}

/**
 * Helper function that determines the presence of a filesystem
 * entity.
 *
 * The entity is either a file or a directory depending on `wantDir'.
 */
BOOL
fs_thing_exists(const char *path, BOOL wantDir)
{
  struct stat s   = { 0 };
  int         err = 0;

  err = stat(path, &s);
  if (err == -1) {
    if (errno == ENOENT) {
    } else {
      perror("stat");
      exit(EXIT_FAILURE);
    }
  } else {
    if (wantDir && S_ISDIR(s.st_mode)) {
      return YES;
    } else if (S_ISREG(s.st_mode)) {
      return YES;
    }
  }

  return NO;
}

/**
 * Determine whether the given file exists.
 */
BOOL
file_exists(const char *path)
{
  return fs_thing_exists(path, NO);
}

/**
 * Determine whether the given directory exists.
 */
BOOL
directory_exists(const char *path)
{
  return fs_thing_exists(path, YES);
} 

/* Utils.c ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
