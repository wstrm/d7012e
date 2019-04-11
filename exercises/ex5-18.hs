-- Exercise 5.18 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
shift :: ((x, y), z) -> (x, (y, z))
shift ((x, y), z) = (x, (y, z))

main = do
  print $ shift ((1, 2), 3)
  print $ shift (("1", "2"), "3")
