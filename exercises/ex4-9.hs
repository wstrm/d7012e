-- Exercise 4.9 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
f :: Int -> Int
f 0 = 0
f 1 = 44
f 2 = 17
f _ = 0

maxFAux, maxFGuards :: Int -> Int
maxFAux n = maximum (aux n)
  where
    aux x
      | x > 0 = f (n - x) : aux (x - 1)
      | otherwise = [f 0]

maxFGuards n
  | n > 0 = maximum (maxFGuards (n - 1) : [f n])
  | otherwise = f 0

main = do
  print $ maxFAux 10
  print $ maxFGuards 10
