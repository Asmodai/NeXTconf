# NeXTconf
NeXTconf is a system for configuring various files when building software --
think of it as a mix of autotools, CMake, and an Objective-C-like scripting
language.

It is meant to be called early on by 'make' (or via script), and is designed to
help ease development when targetting multiple NeXT platforms.

# Building
To build on a NeXT platform, we must first initialise the build system, such as:

```sh
./init nextstep
```

The supported build platforms are:

    nextstep          NeXTSTEP 3.x
    openstep          OPENSTEP 4.x
    wof               OPENSTEP 4.x with WebObjects
    rhapsody          Apple's Rhapsody

Once the build system has been initialised, you can make NeXTconf with one of
the below commands:

    NeXTSTEP          make
    OPENSTEP          gnumake
    wof               gnumake
    rhapsody          make

In order to build for multiple platforms, you can use the following:

    NeXTSTEP          TARGET_ARCHS="i386 m68k sparc hppa" make
    OPENSTEP          TARGET_ARCHS="i386 m68k sparc" gnumake
    wof               RC_ARCHS="i386 m68k sparc" gnumake
    rhapsody          RC_ARCHS="i386 ppc" make

# Generating the grammar
To generate the grammar, first ensure that you have flex and bison installed and
then simply run `./make_parser.sh`.

You do *not* have to build the grammar files in order to compile NeXTconf.  The
output of flex and bison are included in the project -- `Parser.m`, `Parser.h`,
and `Scanner.m`.

You will want bison *1.25* and flex *2.5.4* in order to generate the parser and
scanner.

# Syntax
NeXTconf uses a C-like syntax with Objective-C-like method calls.

The following is an example of the syntax:

```objc
wanted = "NEXTSTEP";

if ([Platform platform] == wanted) {
  print "Platform is " + wanted;
} else {
  print "Platform is not what we wanted.";
}
```

Please see the _Documentation_ folder for more details.

# Performance
All performance tests were performed on NEXTSTEP 3.3, with the m68k tests
performed on the Previous emulator, with a fresh build from source for each CPU.

Intel i7 results are inconsequential, and are included for completeness only.

| CPU             | System         | Time taken to run tests                  |
|:----------------|:---------------|:-----------------------------------------|
| 68030 @ 25MHz   | NeXT Computer  | 10.002s real, 3.405s user, 1.779s system |
| 68040 @ 25MHz   | NeXTcube       | 3.300s real, 1.030s user, 0.624s system  |
| 68040 @ 33MHz   | NeXTcube Turbo | 2.555s real, 0.843s user, 0.390s system  |
| i7 6950X @ 4GHz | Intel          | 0.079s real, 0.000s user, 0.039s system  |

It is worth noting that the cause of the 'slowness' with the m68k builds is
printing to standard output causing Terminal.app to scroll.  With output
redirected to `/dev/null`, the tests execute faster.

I would welcome numbers from actual NeXT hardware!

# Special `make` targets
The `Makefile` for this project supports two special targets: `dist` and
`distclean`.

These work in a similar manner to their GNU brethren, and ought to be used when
compiling source releases for placing on websites, FTP archives, and the like.

# Reporting bugs
Please report any bugs via the Issue tracker on GitHub.  If you have a fix, then
please be sure to mention this in the issue first. Do *not* blindly submit a PR
and expect it to be merged.

# Contributing
If you would like to contribute to this project, you are more than welcome.
Please contact me at asmodai@gmail.com to announce your intention.
