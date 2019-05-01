-- Exercise 5.10 from:
-- Simon Thompson: Haskell - The Craft of Functional Programming, 2/E
divisors :: Int -> [Int]
divisors n = [x | x <- [1..n], n `rem` x == 0]

isPrime :: Int -> Bool
isPrime n = (divisors n) == [1, n]

main = do
  print $ divisors 12
  print $ divisors 11
  print $ isPrime 12
  print $ isPrime 11
