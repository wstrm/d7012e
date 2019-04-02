-- Exercise 3.7 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E

threeDifferent1 :: Int -> Int -> Int -> Bool
threeDifferent1 m n p = if m /= n && n /= p && m /= p then True else False

threeDifferent2 :: Int -> Int -> Int -> Bool
threeDifferent2 m n p
  | m /= n && n /= p && m /= p = True
  | otherwise = False

main = do
  print $ threeDifferent1 1 2 3 -- True
  print $ threeDifferent1 1 2 1 -- False
  print $ threeDifferent2 1 2 3 -- True
  print $ threeDifferent2 1 2 1 -- False
