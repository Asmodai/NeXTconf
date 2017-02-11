Release 0.91  Copyleft (c)2017 by Paul Ward.  All Rights Reserved.

# Platform

## Class Description

The `Platform` object is used to determine version information of the platform.

Please be aware that it will not consider NeXTSTEP with Foundation (from EOF) to be OpenStep.

You also should not assume that a product of `NEXTSTEP` means it is not an OpenStep, as this software considers OPENSTEP 4.0 PR 1 to be NEXTSTEP 4.0 (so there are no collisions with OPENSTEP 4.0).

For example, the following would not do what you assume it does:
```objc
	if ([Platform platform] == "NEXTSTEP") {
	  print "This is not an OpenStep implementation";
	}

	if ([Platform isOpenStep] == true) {
	  print "Ah, but it is";
	}
```
It would evaluate to the following on NeXTSTEP 3.3:
```
	This is not an OpenStep implementation
```
but would evaluate to the following on OPENSTEP 4.0 PR 1:
```
	This is not an OpenStep implementation
	Ah, but it is
```

## Instance Methods

### isOpenStep

(Boolean)isOpenStep

Returns true if the platform is an implementation of the OpenStep specification.


### majorVersion

(Number)majorVersion

Returns the major version number.

### minorVersion

(Number)minorVersion

Returns the minor version number.


### platform

(String)platform

Returns the product name, e.g. `NEXTSTEP 3.x`.


### product

(String)hasM68K

Returns the platform name, e.g. `NEXTSTEP`.


### versionString

(String)versionString

Returns the version string, e.g. `3.3`.
