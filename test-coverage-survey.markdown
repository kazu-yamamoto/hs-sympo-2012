## Core libraries: provided by every ghc installation
## Summary

## Details

This is a list of all packages from the Haskell platform, excluding core
libraries that come with GHC.

We do not include core libraries, because some of the have tests of their own,
and some of them have tests in GHC's test suite.  And we did not make the
effort to properly survey this.

## cgi (the Haskell platform does not include new versions)

    git clone git://andersk.mit.edu/haskell/cgi.git
    git checkout 3001.1.7.4

r:examples

## fgl

  darcs get http://code.haskell.org/FGL/fgl-5

Repository contains a `test` directory.  But (besides some benchmark code), it
contains only very little code.  And it does not use HUnit, nor QuickCheck.  I
don't think this are automated tests, so I count it as "none".

r:none

## GLUT (the Haskell platform does not include new versions)

Version: Latest version on Hackage.  Package contains no

    git clone https://github.com/haskell-opengl/GLUT
    git checkout v2.3.0.0

r:examples

## haskell-src

Version: Latest version (cc981ea015e5c4c3efbfab2c4b89a10b75203e3a).  From the
commit message I'd guess this is 1.0.1.5.  Repository contains no tags.

    git clone git://github.com/haskell-pkg-janitors/haskell-src.git

r:examples

## html

    darcs get http://code.haskell.org/html/

r:none

## HUnit

    darcs get http://code.haskell.org/HUnit/

r:tests

## network

    git clone git://github.com/haskell/network.git
    git checkout v2.3.0.13

r:tests

## OpenGL (the Haskell platform does not include new versions)

## parallel

    git clone http://darcs.haskell.org/packages/parallel.git/

Tests depend on GHC's build infrastructure.

r:tests

## parsec

    darcs get http://code.haskell.org/parsec3

r:none

## QuickCheck

    darcs get http://code.haskell.org/QuickCheck/devel

r:examples

## regex-base

    darcs get http://code.haskell.org/regex-base/

r:examples

## regex-compat

    darcs get http://code.haskell.org/regex-compat/

r:none

## regex-posix

    darcs get http://code.haskell.org/regex-posix/

r:none

## stm

    git clone http://darcs.haskell.org/packages/stm.git/

Tests depend on GHC's build infrastructure.

r:tests

## syb

    git clone https://github.com/dreixel/syb

r:tests

## xhtml

    git clone https://github.com/haskell/xhtml

r:none

## zlib

    darcs get http://code.haskell.org/zlib/

r:tests

## HTTP

    git clone https://github.com/haskell/HTTP.git

r:tests

## deepseq

    git clone http://darcs.haskell.org/packages/deepseq.git/

r:none

## text

    git clone https://github.com/bos/text

r:tests

## transformers

    darcs get http://code.haskell.org/~ross/transformers

r:none

## mtl

    git clone https://github.com/ekmett/mtl

Latest version of mtl is not tagged, so I looked at master
(73d25d738904ade10ec31ad1a72c43f7d9749bc5).

r:none
