-- Exercise 5.11 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
import Prelude hiding (elem)

matches, matchesLC :: Int -> [Int] -> [Int]
-- Recursive approach
matches _ [] = []
matches k (x:xs)
  | x == k = k : matches k xs
  | otherwise = matches k xs

-- List comprehension
matchesLC k xs = [x | x <- xs, x == k]

elem, elemLC :: Int -> [Int] -> Bool
elem k xs = length (matches k xs) > 0

elemLC k xs = length (matchesLC k xs) > 0

main = do
  print $ matches 1 [1, 2, 1, 4, 5, 1]
  print $ matches 1 [2, 3, 4, 5, 6]
  print $ matchesLC 1 [1, 2, 1, 4, 5, 1]
  print $ matchesLC 1 [2, 3, 4, 5, 6]
  print $ elem 1 [1, 2, 1, 4, 5, 1]
  print $ elem 1 [2, 3, 4, 5, 6]
  print $ elemLC 1 [1, 2, 1, 4, 5, 1]
  print $ elemLC 1 [2, 3, 4, 5, 6]
