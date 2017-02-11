# NeXTconf

NeXTconf is a system for configuring various files when building
software -- think of it as a mix of autotools, CMake, and your
favourite templating language (i.e Jinja.)

It is meant to be called early on by 'make' (or via script), and is
designed to help ease development when targetting multiple NeXT
platforms.


# Building

To build on a NeXT platform, we must first initialise the build
system, such as:

```sh
./init nextstep
```

The supported build platforms are:

    nextstep          NeXTSTEP 3.x
    openstep          OPENSTEP 4.x
    wof               OPENSTEP 4.x with WebObjects
    rhapsody          Apple's Rhapsody

Once the build system has been initialised, you can make NeXTconf with
one of the below commands:

    NeXTSTEP          make
    OPENSTEP          gnumake
    wof               gnumake
    rhapsody          make


# Generating the grammar

To generate the grammar, first ensure that you have flex and bison
installed and then simply run `./make_parser.sh`.

You do *not* have to build the grammar files in order to compile
NeXTconf.  The output of flex and bison are included in the project --
`Parse.m`, `Parse.h`, and `Lexer.m`.


# Syntax

NeXTconf uses a C-like syntax with Objective-C like method calls.

The following is an example of the syntax:

```objc
name = "Dave";

if ([Platform platform]) == "NEXTSTEP") {
  print "Welcome, " + name + ", to NEXTSTEP.";
} else {
  print "Welcome, " + name + ", to something that is not NEXTSTEP.";
}
```
