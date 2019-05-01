-- Exercise 5.2 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
orderTriple :: (Int, Int, Int) -> (Int, Int, Int)
orderTriple (a, b, c)
  | a <= b && b <= c = (a, b, c)
  | a <= c && c <= b = (a, c, b)
  | c <= a && a <= b = (c, a, b)
  | c <= b && b <= a = (c, b, a)
  | b <= a && a <= c = (b, a, c)
  | b <= c && c <= a = (b, c, a)
