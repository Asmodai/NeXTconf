/*
 * ConfParser.c  --- File parser implementation.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Time-stamp: <15/11/09 05:34:47 asmodai>
 * Revision:   3
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 24 Oct 2015 14:16:58 +0100 (BST)
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
#include <ctype.h>
#include <string.h>

#include "ConfParser.h"
#include "utils.h"

#define MAX_NAME 50

/**
 * Find either the first instance of the character given in `c' or a
 * comment character in the string `s'.
 */
static
char *
find_char_or_comment(const char *s, char c)
{
  BOOL ws = false;

  while (*s && *s != c && !(ws && *s == '#')) {
    ws = (BOOL)isspace((unsigned char)(*s));
    s++;
  }

  return (char *)s;
}

/**
 * Perform a string copy with length limit and append a null
 * terminator.
 */
static
char *
strncpy0(char *dest, const char *src, size_t size)
{
  strncpy(dest, src, size);
  dest[size - 1] = '\0';

  return dest;
}

/**
 * Parse a config from a stream.
 */
int
parser_parse_stream(parser_reader   reader,
                    void           *stream,
                    parser_handler  handler,
                    void           *user)
{
  char    prev_name[MAX_NAME] = "";
  char   *line                = NULL;
  char   *start               = NULL;
  char   *end                 = NULL;
  char   *name                = NULL;
  char   *value               = NULL;
  size_t  lineno              = 0;
  int     err                 = 0;

  line = (char *)malloc(PARSER_MAX_LINE * sizeof *line);
  if (!line) {
    perror("Out of memory!");
    exit(EXIT_FAILURE);
  }

  while (reader(line, PARSER_MAX_LINE, stream) != NULL) {
    lineno++;
    start = lskip(rstrip(line));

    if (*start == '#') {
    } else if (*prev_name && *start && start > line) {
      if (!handler((void *)user, prev_name, start) && !err) {
        err = lineno;
      }
    } else if (*start && *start != '#') {
      end = find_char_or_comment(start, ':');
      if (*end == ':') {
        *end  = '\0';
        name  = rstrip(start);
        value = lskip(end + 1);
        end   = find_char_or_comment(value, '\0');

        if (*end == '#') {
          *end = '\0';
        }

        rstrip(value);

        strncpy0(prev_name, name, sizeof(prev_name));
        if (!handler((void *)user, name, value) && !err) {
          err = lineno;
        }
      } else if (!err) {
        err = lineno;
      }
    }

#if PARSER_STOP_ON_FIRST_ERROR
    if (err) {
      break;
    }
#endif
  }

  free(line);

  return err;
}

/**
 * Parse a config from a file.
 */
int
parser_parse_file(FILE *file, parser_handler handler, void *user)
{
  return parser_parse_stream((parser_reader)fgets,
                             file,
                             handler,
                             (void *)user);
}

/**
 * Parse a config.
 */
int
parser_parse(const char *filename, parser_handler handler, void *user)
{
  FILE *file = NULL;
  int   err  = 0;

  if ((file = fopen(filename, "r")) == NULL) {
    perror("fopen");
    return -1;
  }

  err = parser_parse_file(file, handler, (void *)user);

  fclose(file);

  return err;
}

/* ConfParser.c ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
