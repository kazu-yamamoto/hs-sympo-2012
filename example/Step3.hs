module Fib where
import Control.Applicative



import Test.Hspec.ShouldBe
import Test.QuickCheck

-- | Calculate Fibonacci numbers.
--
-- >>> fib 10
-- 55
fib :: Int -> Integer
fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

-- small non-negative numbers
newtype Small = Small Int
  deriving Show

instance Arbitrary Small where
  arbitrary = Small . (`mod` 10) <$> arbitrary

main = hspec $ do
  describe "fib" $ do
    it "calculates arbitrary Fibonacci numbers" $ do
      property $ \(Small n) ->
        fib n == fib (n + 2) - fib (n + 1)
