-- 170816:1

append [] ys = ys
append (x:xs) ys = x : append xs ys

concat2 [] = []
concat2 (x:xs) = append x (concat2 xs )

-- 170816: 2

data TT a = Node a (TT a ) (TT a) (TT a) | Leaf deriving (Show, Ord, Eq)

t =
  Node   -- root node
    1      -- value store in the root
    (Node  -- first subtree of the root
      2
      Leaf
      Leaf
      Leaf
    )
    (Node  -- second subtree of the root
      3
      (Node
        4
        Leaf
        Leaf
        Leaf
      )
      (Node
        5
        Leaf
        Leaf
        Leaf
      )
      (Node
        6
        Leaf
        Leaf
        Leaf
      )
    )
    (Node  -- third subtree of the root
      7
      Leaf
      Leaf
      Leaf)

prune :: TT a -> TT a
prune Leaf = Leaf
prune (Node _ Leaf Leaf Leaf) = Leaf
prune (Node x t1 t2 t3) = Node x (prune t1) (prune t2) (prune t3)

-- *Main> t
-- Node 1 (Node 2 Leaf Leaf Leaf) (Node 3 (Node 4 Leaf Leaf Leaf) (Node 5 Leaf Leaf Leaf)
-- (Node 6 Leaf Leaf Leaf)) (Node 7 Leaf Leaf Leaf)
-- *Main> prune it
-- Node 1 Leaf (Node 3 Leaf Leaf Leaf) Leaf
-- *Main> prune it
-- Node 1 Leaf Leaf Leaf
-- *Main> prune it
-- Leaf
-- *Main>

pcount :: TT a -> Int
pcount Leaf = 0 :: Int
pcount (Node _ Leaf Leaf Leaf) = 1
pcount (Node _ t1 t2 t3) = 1 + myMax c1 (myMax c2 c3)
  where
    c1 = pcount t1
    c2 = pcount t2
    c3 = pcount t3
    myMax x y = if x>y then x else y

-- *Main> pcount t
-- 3
-- *Main> prune t
-- Node 1 Leaf (Node 3 Leaf Leaf Leaf) Leaf
-- *Main> pcount (prune (prune t))
-- 2
-- *Main> pcount (prune (prune (prune t)))
-- 1
-- *Main> pcount (prune (prune (prune (prune t))))
-- 0
-- *Main> pcount (prune (prune (prune (prune t))))
-- 0
-- *Main>


-- 170816: 3 

calculator = calculator' []
calculator' a =
  do
    putStr "Enter number: "
    b <- getLine
    if b == "e" then
      return ()
    else if b == "" then
      do
        putStr ("Numbers entered: " ++ format a ++ "\nAccumulated sum: " ++ show (calc a) ++ "\nSum reset.\n")
        calculator' []
    else
        calculator' (a ++ [read b])
  where
    format :: [Int] -> String
    format [] = "(none)"
    format [a] = show a
    format (x:xs) = show x ++ ", " ++ format xs
    calc :: [Int] -> Int
    calc [] = 0
    calc (x:xs) = x + calc xs


-- 170816: 4

test i = foldr (\x y -> x+y) 0 (map (^2)  [1..i])