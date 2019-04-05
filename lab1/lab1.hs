type Size = Int

type Index = Int

type Set = [Int]

type Sets = [Set]

type List = [Int]

type PrintSets = [(Size, Index, Index, Set)]

-- makePrintSets :: Sets -> PrintSets
-- formatPrintSets :: PrintSets -> String
-- producePrintSets :: Sets -> String
-- producePrintSets = formatPrintSets . makePrintSets
sort :: Sets -> Sets
sort [] = []
sort (p:xs) = sort l ++ [p] ++ sort r
  where
    l = filter (cmp (<) p) xs
    r = filter (cmp (>=) p) xs
    cmp c x p = sum p `c` sum x

sets :: List -> Sets
sets l
  | length l > 1 = sets (tail l) ++ aux l
  | otherwise = [l]
  where
    aux s
      | length s > 1 = aux (init s) ++ [s]
      | otherwise = [s]

smallest k = take k . sort

kSmallestSet :: Int -> List -> Sets
kSmallestSet _ [] = error "empty list has no smallest k-sets"
kSmallestSet k l = smallest k (sets l)

main = do
  print $ kSmallestSet 3 [-1, 2, -3, 4, -5]
  print $ kSmallestSet 3 [x * (-1) ^ x | x <- [1 .. 100]] -- Test case 1
  print $ kSmallestSet 3 [24, -11, -34, 42, -24, 7, -19, 21] -- Test case 2
  print $ kSmallestSet 3 [3, 2, -4, 3, 2, -5, -2, 2, 3, -3, 2, -5, 6, -2, 2, 3] -- Test case 3
