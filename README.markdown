> http://www.haskell.org/haskell-symposium/2012/

## Title: Behavior Driven Development in Haskell

We can decide title at the last moment but let's enumerates candidates:

1. Design Driven Development in Haskell
1. Best Current Practice for Design, Documentation and Test in Haskell
1. Behavior Driven Development in Haskell

Author: Simon HENGEL, Trystan SPANGLER and Kazuhiko YAMAMOTO

## Purpose of the paper

Encourage Haskllers to write usage/examples/properties in their
libraries with doctest/QuickCheck/hspec.

## Contribution

1. Introduced doctest from Python community to Haskell community
1. Introduced *spec from Ruby community to Haskell community
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

## Tests suitable with doctest

  1. Examples and properties that are useful for users

Note: there are two kinds of program in Haskell, pure and IO.

It is not difficult to test pure code and to find invariants
(properties). Programmers would write typical examples and properties
in document with doctest. So, it is important to integrate doctest and
QuickCheck. (Equation type of property is now nicely integrated in
QuickCheck by Nick Smallbone.)

It is not easy to test IO. But Programmers would write typical example
with doctest.

## Tests suitable with hspec

Following tests would not be suitable with doctest

  1. Examples and properties that are not useful for users

    > e.g. unused cases of partial functions, coner cases reported in a bug track system

  2. Example tests for IO which cannot be executed in doctest

    > note: doctest will implement setup an dtear-down

For this kind of documents and tests, we use hspec.

## Integrating multiple test suites

Now we can specify multiple test suites with Cabal. So, both doctest
and hspec can be integrated with Cabal.

## Syntax of properties in doctest

Open lambda terms are supported. Type can be specified with expression
type-signature.

    sort (xs :: [Int]) == sort (sort xs)

## Best current practice on design

First, we write a signature and leave the function undefined.

    fromList :: Ord a => [a] -> Set a
    fromList = undefined

Then think about properties and examples the function should satisfy.

Include properties and examples, that are useful user documentation, in a
Haddock comment.

    {-| Creating a set from a list. O(N log N)

    >>> fromList [5,3,5] == fromList [5,3]
    True
    prop> empty == fromList []
    prop> singleton (x :: Char) == fromList [x]
    -}

    fromList :: Ord a => [a] -> Set a
    fromList = undefined

Use hspec for properties and examples that are not useful user documentation.

    main = hspecX $ do
      describe "fromList" $ do

        it "ignores duplicate elements" $
          fromList [5,3,5] == fromList [5,3]

        it "creates an empty set when given an empty list" $
          empty == fromList []

        it "creates a singleton set, when given a list with one element" $ property $
          \x -> singleton (x :: Char) == fromList [x]

> Can we come up with a better hspec example here?

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

   > @kazu: Yes, I mostly agree.  But I'd use _example_ instead of _assertion
   > test_.  We already use this in doctest.  And it is used in the BDD world
   > (RSpec, etc.).
