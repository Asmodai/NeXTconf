/*
 * ConfParser.h  --- File parser.
 *
 * Copyright (c) 2015 Paul Ward <asmodai@gmail.com>
 *
 * Author:     Paul Ward <asmodai@gmail.com>
 * Maintainer: Paul Ward <asmodai@gmail.com>
 * Created:    Sat, 24 Oct 2015 14:17:13 +0100 (BST)
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

#ifndef _PARSER_H_
#define _PARSER_H_

#include <sys/types.h>
#include <sys/file.h>
#include <objc/objc.h>

/**
 * Number of characters for a line.
 */
#define PARSER_MAX_LINE             200

/**
 * Define if the parser should stop when it comes across the first
 * error.
 */
#define PARSER_STOP_ON_FIRST_ERRROR

/**
 * Parser input handler function pointer type definition.
 */
typedef BOOL (*parser_handler)(void *, const char *, const char *);

/**
 * Parser input reader function pointer type definition.
 */
typedef char *(*parser_reader)(char *, size_t, void *);

/*
 * Function prototypes.
 */
int parser_parse(const char *, parser_handler, void *);
int parser_parse_file(FILE *, parser_handler, void *);
int parser_parse_stream(parser_reader, void *, parser_handler, void *);

#endif /* !_PARSER_H_ */

/* ConfParser.h ends here */
/*
 * Local Variables: ***
 * indent-tabs-mode: nil ***
 * End: ***
 */
