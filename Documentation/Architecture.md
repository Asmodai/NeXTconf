# Architecture object
The `Architecture` object is used to determine architecture features
of the platform.  This includes the processor and machine types as
well as various features supported by the Developer tools (if
installed).

This object can also be used to ascertain if the Developer tools are indeed
installed.


## Methods

##### currentArchitecture [string]
Returns the current architecture name.

##### currentProcessor [string]
Returns the processor name.

##### isDeveloperInstalled [boolean]
Returns `true` if the Developer packages have been installed.

This might not be accurate.  We assume Developer is installed if there
are any spec files in `/lib/<arch>/specs` or
`/usr/libexec/<arch>/specs`, as these files are usually used by the C
compiler.

##### hasM68K [boolean]
Returns `true` if the Developer tools are capable of generating
Motorola 680x0 binaries.

##### hasIX86 [boolean]
Returns `true` if the Developer tools are capable of generating Intel
binaries.

##### hasSPARC [boolean]
Returns `true` if the Developer tools are capable of generating SPARC
binaries.

##### hasHPPA [boolean]
Returns `true` if the Developer tools are capable of generating HP
PA-RISC binaries.

##### hasPPC [boolean]
Returns `true` if the Developer tools are capable of generating
PowerPC binaries.
