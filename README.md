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


  
