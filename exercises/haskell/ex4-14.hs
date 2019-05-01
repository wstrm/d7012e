-- Exercise 4.14 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
--
-- If n is even, 2 * m say, then:
-- 	2^n = 2^(2*m) = (2^m)^2
-- If n is odd, 2 * m + 1 say, then:
-- 	2^n = 2^(2*m+1) = ((2^m)^2)*2
powerOfTwo :: Int -> Int
powerOfTwo n
  | n `mod` 2 == 0 = (2 ^ (n `div` 2)) ^ 2
  | otherwise = ((2 ^ ((n - 1) `div` 2)) ^ 2) * 2

main = do
  print $ powerOfTwo 3
  print $ powerOfTwo 4
