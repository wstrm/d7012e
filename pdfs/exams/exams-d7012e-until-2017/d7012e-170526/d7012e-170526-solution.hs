-- 170526:1

-- variants

prefix1 _ [] = []
prefix1 n (x:xs) =
  if n<=0
    then []
    else x : prefix1 (n-1) xs


prefix2 n xs = prefix22 n xs []
  where
    prefix22 i [] l = l
    prefix22 i (x:xs) l =
      if i<1
        then l
        else prefix22 (i-1) xs (l ++[x])

prefix3 i [] = []
prefix3 i (x:xs) = [x|i>0] ++ prefix3 (i-1) xs

prefix4 _ [] = []
prefix4 n xs 
  | n < 1 = []
  | n >= length xs = xs
  | otherwise = prefix4 n (init xs)


suffix1 n xs = drop (length xs - n) xs
  where
    drop _ [] = []
    drop n (y:ys) =
      if n<=0
      then (y:ys)
      else drop (n-1) ys
    
suffix2 _ [] = []
suffix2 n xs
  | n > 0     = suffix2 (n-1) (init xs) ++ [(last xs)]
  | otherwise = []

suffix3 n xs = reverse (prefix1 n (reverse xs))

suffix4 _ [] = []
suffix4 i (x:xs) =
  if length (x:xs) > i
    then suffix4 i xs
    else x:xs

suffix5 i lst = snd (suffix52 i lst)
  where
    suffix52 _ [] = (0, [])
    suffix52 i (x:xs) =
      if i>fst res
        then (fst res + 1, x:xs)
        else res
      where
        res = suffix52 i xs

suffix6 _ [] = []
suffix6 n (x:xs) =
  if length xs <= n-1
    then x : suffix6 (n-1) xs
    else suffix6 n xs

suffix7 _ [] = []
suffix7 n (x:xs)
  | n <= 0 = []
  | n > length xs = x : xs
  | otherwise = suffix7 n xs

suffix8 n xs = suffix82 n xs []
  where
    suffix82 i [] l = l
    suffix82 i xs l =
      if i<1
        then l
        else suffix82 (i-1) (init xs) (last xs : l)


suffix9 i [] = []
suffix9 i (x:xs) = [x|length(x:xs) <= i] ++ suffix9 i xs

-- 170526:2

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving (Show, Eq, Ord)

t = Node (Node (Node (Leaf 1) (Node (Leaf 2) (Leaf 3))) (Leaf 4)) (Node (Leaf 5) (Leaf 6))

flatten t = inorder t
  where
    inorder (Leaf x) = [x]
    inorder (Node lt rt) = inorder lt ++ inorder rt

balance t = b (flatten t)
  where
    b [] = error "tom lista"
    b [x] = Leaf x
    b xs = Node (b lt) (b rt)
      where
        ll = (length xs) `div` 2
        rl = (length xs) - ll
        lt = prefix1 ll xs
        rt = suffix1 rl xs


-- 170526: 3

--cashreg :: IO [Char]
cashreg = cashreg' 0
cashreg' sum =
  do s <- getLine
     case s of
        ""  -> do print sum
                  putStr "-------\n"
                  cashreg' 0  -- just cashreg works too
        "e" -> return ()
        _   -> cashreg' ((read s)+sum)

-- 170526: 4

map2 f xs = foldr (\a b -> f a : b) [] xs

map3 f = foldr (\a b -> f a : b) []


