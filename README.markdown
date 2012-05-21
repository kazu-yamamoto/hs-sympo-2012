> http://www.haskell.org/haskell-symposium/2012/

## Title: TBD

Author: Simon HENGEL and Kazuhiko YAMAMOTO

> @sol: Simon should be the first author because Simon did much more work than Kazu

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
typical usage or examples. They tend not to write tests at all. This is
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

> Let's pick some libraries from the Haskell Platform.  If it is hard to do HPC
> coverage for `base`, we can skip it.

 - process
 - HUnit
 - QuickCheck
 - Parsec (should we cover attoparsec, aeson?)
 - base

> Kazu would like to add container and bytestring because they provide many pure APIs.

## Tests not suitable with doctest

Following tests would not be suitable with doctest

  - Unusual usage of pure program
    > @kazu: What would be _unusual usage_ here?  Can you come up with an
    > example?

  - Properties and examples (unit tests) that are not useful user
    documentatation
    > @kazu: I think this applies to both properties and unit tests.  So I
    > adapted this.

  - Unit tests for IO which cannot be executed in doctest
    > @kazu: I think unit tests that require setup code do not work well, yet.
    > But I plan to add support for _setup code_ to doctest.  What did you have
    > in mind?

So, test frameworks are still necessary. A good candidates is hspec.

## Integrating multiple test suites

Now we can specify multiple test suites with Cabal. So, both doctest
and hspec can be integrated with Cabal.

## Syntax

Open lambda terms are supported. Type can be specified with expression
type-signature.

    sort (xs :: [Int]) == sort (sort xs)

## Best current practice on design

First, we write a signature and leave the function undefined.

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

## Terminology discussion

 - "unit test" has two meanings: one is test tools inspired by JUnit
   (e.g. hunit), the other is a test for a solo library which will be
   tested with join test, and so on). Kazu would take the second one
   and use assertion test for first one. So, HUnit is a tool for
   assertion test, QuickCheck is a tool for property test, and doctest
   is a tool for unit test.
