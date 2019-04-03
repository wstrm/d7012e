-- Exercise 4.8 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
integerSquareRoot :: Int -> Int
integerSquareRoot n = iSqrt n
  where
    iSqrt x
      | x * x > n = iSqrt (x - 1)
      | otherwise = x

main = do
  print $ integerSquareRoot 16
  print $ integerSquareRoot 128
  print $ integerSquareRoot 15
  print $ integerSquareRoot 14
