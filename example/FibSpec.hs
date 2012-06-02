module FibSpec (main, spec) where

import Control.Applicative
import Control.Exception
import System.Timeout

import Test.QuickCheck
import Test.Hspec.ShouldBe

import Fib

-- small non-negative numbers
newtype Small = Small Int
  deriving Show

instance Arbitrary Small where
  arbitrary = Small . (`mod` 1000) <$> arbitrary

main = hspec spec

spec = do
  describe "fib" $ do
    it "calculates arbitrary Fibonacci numbers" $ do
      property $ \(Small n) ->
        fib n == fib (n + 2) - fib (n + 1)

    it "is efficient" $ do
      timeout 10000 (evaluate $ fib 32) `shouldReturn` Just 2178309

    it "returns 0 on negative input" $ do
      property $ \n -> n < 0 ==>
        fib n == 0
