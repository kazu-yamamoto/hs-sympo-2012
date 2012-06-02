module Fib (fib) where

-- | Calculate Fibonacci numbers.
--
-- >>> fib 10
-- 55
fib :: Int -> Integer
fib n | n < 0     = 0
      | otherwise = fibs !! n

fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
