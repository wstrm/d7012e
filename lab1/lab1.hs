type Size = Int

type Index = Int

type Set = [Int]

type List = [Int]

type Sets = [(Size, Index, Index, Set)]

-- makePrintSets :: Sets -> PrintSets
-- makePrintSets (x:xs)
--   | not (null xs) = (sum x, ) ++ makePrintSets xs
--   | otherwise = []
--
-- sort a list of sets using Quicksort.
sort :: Sets -> Sets
sort [] = []
sort (p:xs) = sort l ++ [p] ++ sort r
  where
    l = filter (< p) xs -- (<) compares with the first element of each tuple,
    r = filter (>= p) xs -- same goes for (>=) as above.

sublist :: Int -> Int -> List -> List
sublist i j = drop i . take (j + 1)

-- sets produces the different sets that is possible for the provided list and
-- returns the size, indices and set for each combination.
sets :: List -> Sets
sets [] = []
sets l = aux 0 0
  where
    aux i j
      | j < m = (sum s, i, j, s) : aux i (j + 1)
      | i < m = aux (i + 1) (i + 1)
      | otherwise = []
      where
        s = sublist i j l
        m = length l

-- smallest finds the smallest k sets from a list of sets.
smallest :: Int -> Sets -> Sets
smallest k = take k . sort

-- kSmallestSet returns the smallest k sets from a list.
kSmallestSet :: Int -> List -> Sets
kSmallestSet _ [] = error "empty list has no smallest k-sets"
kSmallestSet k l = smallest k (sets l)

main = do
  print $ kSmallestSet 3 [-1, 2, -3, 4, -5]
  print $ kSmallestSet 3 [x * (-1) ^ x | x <- [1 .. 100]] -- Test case 1
  print $ kSmallestSet 3 [24, -11, -34, 42, -24, 7, -19, 21] -- Test case 2
  print $ kSmallestSet 3 [3, 2, -4, 3, 2, -5, -2, 2, 3, -3, 2, -5, 6, -2, 2, 3] -- Test case 3
  print $ kSmallestSet 0 []
