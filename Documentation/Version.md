Release 0.93  Copyleft (c)2017 by Paul Ward.  All Rights Reserved.

#Version
## Class Description
The `Version' object holds version information about NeXTconf itself.  It can be
used to ensure a script works with particular--or ranges of--versions.

## Instance Methods
### version
(Number)**version**

Returns the current version numbers encoded as a single numeric value.

The algorithm used is:  (*major* * 100000000) + (*minor* * 1000000) + *build*.

### major
(Number)**major**

Returns the major version number.

### minor
(Number)**minor**

Returns the minor version number.

### build
(Number)**build**

Returns the build number.

### isGreaterThan:
(Boolean)**isGreaterThan:**(Number)*aVersion*

Returns true if the supplied version is greater than the current NeXTconf
version.  This uses the encoded version number returned by **version**.

### isGreaterThanOrEqualTo:
(Boolean)**isGreaterThanOrEqualTo:**(Number)*aVersion*

Returns true if the supplied version is greater than or equal to the current
NeXTconf version.  This uses the encoded version number returned by **version**.

