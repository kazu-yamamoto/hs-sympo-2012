> http://www.haskell.org/haskell-symposium/2012/

## Purpose of the paper

Encourage Haskllers to write usage/examples/properties in their
libraries with doctest/QuickCheck.

## Contribution

1. Introduced doctest from Python community to Haskell community
1. Integrated doctest and QuickCheck
1. Show best current practice of design/documentation/tests

## Background

Haskellers tend to depend on its strong type system too much. They
tend to just show signatures as documentation instead of writing
tyical usage or examples. They tend not to write tests at all. This is
probably because programming is fun but writing tests is not fun.

The strong type system ensures that program does not contain errors
relating to types. But the program might contain errors relating to
values.

Haskellers should write more tests. Since writing test is not fun, we
should have a system which makes writing tests fun. doctest developed
in Python community would be one solution.

## Observation

There are two kinds of program in Haskell, pure and IO.

It is not difficult to test pure code and to find invariants
(properties).  Programmers would write typical usage and properties in
document with doctest. So, it is important to integrate doctest and
QuickCheck.  (Equation type of property is now nicely integrated in
QuickCheck by Nick Smallbone.)

It is not easy to test IO. But Programmers would write typical usage
with doctest.

## Current state

Give a short survey on the test coverage of existing libraries.

 - process
 - HUnit
 - QuickCheck
 - Parsec (should we cover attoparsec, aeson?)
 - base

## Tests not suitable with doctest

Following tests would not be suitable with doctest

  - Unusual usage of pure program
  - Property test which is not useful for readers
  - Unit tests for IO which cannot be executed in doctest

So, test frameworks are still necessary. A good candidates is hspec.

## Integrating multiple test suites

Now we can specify multiple test suites with Cabal. So, both doctest
and hspec can be integrated with Cabal.

## Syntax

Open lambda terms are supported. Type can be specified with expression
type-signature.

    sort (xs :: [Int]) == sort (sort xs)

## Best current practive on design

Firt, we write a signature and leave the function undefined.

    fromList :: Ord a => [a] -> Set a
    fromList = undefined

Then write its document with properties:

    {-| Creating a set from a list. O(N log N)

    >>> fromList [5,3,5] == fromList [5,3]
    True
    prop> empty == fromList []
    prop> singleton (x :: Char) == fromList [x]
    -}

    fromList :: Ord a => [a] -> Set a
    fromList = undefined

Then implement it and run tests with doctest.

## Implementation status

Nick Smallbone improved QuickCheck so that boolean property is tested
just once. (version 2.4.3 ?)

David Waern is working to introduce the "prop>" syntax to haddock.

The authors integrated QuickCheck into doctest. (version 0.7)

   - Probably we should talk about "speed up". Old doctest executes
     GHCi per example, but new one does per module.

   - How to translate open lambda terms to close lambda terms.

## Open problems / Future work

 - Bridging the gap between HUnit and QuickCheck

 - Feedback for failing QuickCheck properties is not always as useful as it
   could be -> combinators that use QuickCheck's Result type could help

 - We do not get source locations for failing tests.  Doctest solves this.  For
   Hspec/QuickCheck/HUnit something like JHC's `SRCLOC_ANNOTATE` pragma could
   help.

 - Are more high-lever approaches to BDD, akin to Ruby's Cucumber, applicable
   to Haskell?  (Observation: Cucumber's approach is tightly tied to OO)
