#!/bin/sh
# -*- Mode: Shell-script -*-
#
# version.sh --- Builds version information.
#
# Copyright (c) 2013-2015 Paul Ward <asmodai@gmail.com>
#
# Time-stamp: <15/11/07 23:56:09 asmodai>
# Revision:   11
#
# Author:     Paul Ward <asmodai@gmail.com>
# Maintainer: Paul Ward <asmodai@gmail.com>
# Created:    21 Sep 2012 01:39:35
# Keywords:   
# URL:        not distributed yet
#
# {{{ License:
#
# This program is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any
# later version.
#
# This program isdistributed in the hope that it will be
# useful, but WITHOUT ANY  WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public
# License along with this program.  If not, see
# <http://www.gnu.org/licenses/>.
#
# }}}
# {{{ Commentary:
#
# }}}

# ==================================================================
# {{{ Variables et al:

#
# Location of the version header.
_header_file="../version.h"

#
# Files containing version information.
_product_name="product_name"
_major_file="major_version"
_minor_file="minor_version"
_build_file="build_number"

# }}}
# ==================================================================

# ==================================================================
# {{{ Testing for files:

#
# Test for the header file and delete it if found.
test -f ${_header_file} && rm ${_header_file}

#
# Test for the version files
test -f ${_major_file} || echo 0 >${_major_file}
test -f ${_minor_file} || echo 1 >${_minor_file}
test -f ${_build_file} || echo 0 >${_build_file}

if [ -f ${_product_name} ]
then
    _product=`cat ${_product_name}`
else
    _product="Unknown"
fi

# }}}
# ==================================================================

# ==================================================================
# {{{ Build version numbers:

#
# Both major and minor are just read from their files.
_major=`sed 's/^ *//' ${_major_file}`
_minor=`sed 's/^ *//' ${_minor_file}`

_build=`sed 's/^ *//' ${_build_file}`
if [ ! -f ../.freeze ]
then
    #
    # The build number is incremented.
    _build=`echo 1+${_build} | bc`
fi

#
# Build a single numeric value from the version numbers.
_version=`echo "(${_major}*100000000)+(${_minor}*1000000)+${_build}" | bc`

# }}}
# ==================================================================

# ==================================================================
# {{{ Build the header:

_verStr="${_major}.${_minor} (build ${_build}, `date -u`)"

cat >>$_header_file <<EOF
/*
 * Imagine the GPLv3 here.
 */

#ifndef _version_h_
#define _version_h_

#ifndef ${_product}_VERSION_DEFINED
# define __Version          ${_version}
# define __VersionStr      "${_product} ${_verStr}"
# define __VersionShortStr "${_product} ${_major}.${_minor}"
# define __VersionMajor     ${_major}
# define __VersionMinor     ${_minor}
# define __VersionBuild     ${_build}
# define __BuildStr        "${_build}"
# define __BuildSys        "`uname -s`"
# define __BuildSysFull    "`uname -srm`"
# define __BuildArch       "`(arch || mach || machine) 2>/dev/null`"
# define __BuildDate       "`date -u`"
# define __BuildHost       "${HOSTNAME}"
# define __BuiltBy         "${USER}"
# define ${_product}_VERSION_DEFINED

#define PLATFORM_`uname -s`
#endif

#endif /* !_version_h_ */
EOF

cat >${_product}.version <<EOF
PROJECTNAME=${_product}
MAJOR_VERSION=${_major}
MINOR_VERSION=${_minor}
PRODUCTVERSION=${_major}.${_minor}
EOF

# }}}
# ==================================================================

#
# Save the incremented build number.
echo ${_build} >${_build_file}

#
# Echo our version information to standard output.
echo "Product:           ${_product}"
echo "Version number:    ${_major}.${_minor}"
echo "Build number:      ${_build}"
echo "Build date:        `date -u`"

# version.sh ends here
