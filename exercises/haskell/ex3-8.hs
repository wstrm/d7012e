-- Exercise 3.8 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
twoEqual :: Int -> Int -> Bool
threeEqual :: Int -> Int -> Int -> Bool
fourEqual :: Int -> Int -> Int -> Int -> Bool
twoEqual m n = m == n

threeEqual m n p = twoEqual m n && (n == p)

fourEqual m n p q = threeEqual m n p && (p == q)

main = do
  print $ twoEqual 1 1 -- True
  print $ threeEqual 1 1 1 -- True
  print $ fourEqual 1 1 1 1 -- True
  print $ twoEqual 1 2 -- False
  print $ threeEqual 1 2 1 -- False
  print $ fourEqual 1 2 1 1 -- False
