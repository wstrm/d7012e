type Size = Int

type Index = Int

type List = [Int]

type Sublist = List

type Set = (Size, Index, Index, Sublist)

type Sets = [Set]

-- sort a list of sets using Quicksort.
sort :: Sets -> Sets
sort [] = []
sort (p:xs) = sort l ++ [p] ++ sort r
  where
    l = filter (< p) xs -- (<) compares with the first element of each tuple,
    r = filter (>= p) xs -- same goes for (>=) as above.

-- sublist produces the sub list between the provided indices (inclusive).
sublist :: Int -> Int -> List -> Sublist
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

-- kSmallestSets returns the smallest k sets from a list.
kSmallestSets :: Int -> List -> Sets
kSmallestSets _ [] = error "empty list has no smallest k-sets"
kSmallestSets k l = smallest k (sets l)

-- showSet stringifies a set.
showSet :: Set -> String
showSet (s, i, j, l) =
  show s ++ "\t" ++ show (i + 1) ++ "\t" ++ show (j + 1) ++ "\t" ++ show l

-- formatSets stringifies a list of sets.
formatSets :: Sets -> String
formatSets [] = ""
formatSets (x:xs) = showSet x ++ "\n" ++ formatSets xs

-- printKSmallestSets produces the k smallest sets of the provided list and
-- prints them to the console with a header.
printKSmallestSets :: Int -> List -> IO ()
printKSmallestSets k l =
  putStrLn $
  "Entire list: " ++
  show l ++
  "\n\nsize\ti\tj\tsublist\n" ++ formatSets (kSmallestSets k l) ++ "\n"

main :: IO ()
main = do
  printKSmallestSets 15 [x * (-1) ^ x | x <- [1 .. 100]]
  printKSmallestSets 6 [24, -11, -34, 42, -24, 7, -19, 21]
  printKSmallestSets 8 [3, 2, -4, 3, 2, -5, -2, 2, 3, -3, 2, -5, 6, -2, 2, 3]
