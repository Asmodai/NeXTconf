Release 0.93  Copyleft (c)2017 by Paul Ward.  All Rights Reserved.

# Architecture

## Class Description

The `Architecture` object is used to determine architecture features of the platform.  This includes the processor and machine types as well as various features supported by the Developer tools (if installed).

This object can also be used to ascertain if the Developer tools are indeed installed.
```objc
	if ([Architecture isDeveloperInstalled] == false) {
	  print "You do not have the Developer packages installed.";
	}
```

## Instance Methods


### currentArchitecture

(String)**currentArchitecture**

Returns the current architecture name.


### currentProcessor

(String)**currentProcessor**

Returns the processor name.

### hasHPPA

(Boolean)**hasHPPA**

Returns true if the Developer tools are capable of generating HP PA-RISC binaries.


### hasIX86

(Boolean)**hasIX86**

Returns true if the Developer tools are capable of generating Intel binaries.


### hasM68K

(Boolean)**hasM68K**

Returns true if the Developer tools are capable of generating Motorola 680x0 binaries.


### hasPPC

(Boolean)**hasPPC**

Returns true if the Developer tools are capable of generating PowerPC binaries.


### hasSPARC

(Boolean)**hasSPARC**

Returns true if the Developer tools are capable of generating SPARC
binaries.


### isDeveloperInstalled

(Boolean)**isDeveloperInstalled**

Returns true if the Developer packages have been installed.

This might not be accurate.  We assume Developer is installed if there are any spec files in `/lib/<arch>/specs` or `/usr/libexec/<arch>/specs`, as these files are usually used by the C compiler.
