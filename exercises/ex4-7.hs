-- Exercise 4.7 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
--
-- a × b = b + ( a − 1) × b
multGuards, multCond, multPM :: Int -> Int -> Int
multGuards a b
  | a > 0 = b + (a - 1) `multGuards` b
  | otherwise = 0

multCond a b =
  if a > 0
    then b + (a - 1) `multCond` b
    else 0

multPM 0 _ = 0
multPM a b = b + (a - 1) `multPM` b

main = do
  print $ 5 `multGuards` 3
  print $ 4 `multGuards` 5
  print $ 5 `multPM` 3
  print $ 4 `multPM` 5
  print $ 5 `multCond` 3
  print $ 4 `multCond` 5
