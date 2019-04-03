-- Exercise 3.17 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
smallerRoot, largerRoot :: Float -> Float -> Float -> Float
smallerRoot a b c = (-b + (sqrt b ^ 2 - 4 * a * c)) / (2 * a)

largerRoot a b c = (-b - (sqrt b ^ 2 - 4 * a * c)) / (2 * a)

main = do
  print $ smallerRoot 1 2 3
  print $ largerRoot 1 2 3
