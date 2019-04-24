-- test: [(\a -> a+1),(\a -> a+1)] -> (\a -> (a+1)+1)

comp :: [a -> a] -> a -> a

--comp fs i = foldr (\f1 f2 -> f1 f2) i fs
comp fs = foldr (.) id fs
