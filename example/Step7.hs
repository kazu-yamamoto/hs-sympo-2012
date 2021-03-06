module Fib where
import Control.Applicative
import Control.Exception
import Data.List
import System.Timeout
import Test.Hspec.ShouldBe
import Test.QuickCheck

-- | Calculate Fibonacci numbers.
--
-- >>> fib 10
-- 55
fib :: Int -> Integer
fib n | n < 0     = 0
      | otherwise = fibs !! n

fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- small non-negative numbers
newtype Small = Small Int
  deriving Show

instance Arbitrary Small where
  arbitrary = Small . (`mod` 1000) <$> arbitrary

main = hspec $ do
  describe "fib" $ do
    it "calculates arbitrary Fibonacci numbers" $ do
      property $ \(Small n) ->
        fib n == fib (n + 2) - fib (n + 1)

    it "is efficient" $ do
      timeout 10000 (evaluate $ fib 32) `shouldReturn` Just 2178309

    it "returns 0 on negative input" $ do
      property $ \n -> n < 0 ==>
        fib n == 0
