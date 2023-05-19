# JeffCore

This repo contains all resources for the creation of JeffCore, the next Strategic Language of LBG!!! (Not really, go away lawyers)

## Setup
### Machine
This was run on a VM running a Debian-11-bullseye image on GCP, but should be runnable on any x86 CPU with the correct packages installed.

### Required Instalation

Binaries:

- nasm
- ld (should be pre-installed on all linux distributions)


Python Packages:

- pyinstaller (this allows for python to be compiled)

## Running
### Writing JeffCore
To write your own JeffCore file, ./jeff_files/final_file.jeff can be used as a template.

JeffCore is whitespace agnostic. Any positive or negative integers can be etered after the commands
Terminate commands with a semi-colon

It's not that hard, figure it out yourself...


### Executing JeffCore

You can use either interpreter: `./bin/jeffcore_interpret file.jeff`

or the compiler: `./bin/jeffcore_compile file.jeff`

Compiler can take the optional arguments of:
- '-a' = keep assembly file
- '-o ./dir/path/' path to output dir
- '-e' = execute imidiatly after compilation

The source code for the compiler and interpreter is found in the ./python/ directory

NOTE: The jeffcore_compile file is actually a bash script on top of the actual executable `jeffcore_comp`. You can use jeffcore_comp by itself if you wish, but you then are required to link the object file manually, which is annoying.

## Update schedule
Fuck off, this is never getting an update
