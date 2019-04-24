-- 171018:1

tail2 [] = error "emptyList"
tail2 (_:ls) = ls

init2 [] = error "emptyList"
init2 [_] = []
init2 (x:ls) = x : init2 ls

suffixes2 [] = []
suffixes2 (x:ls) = (x:ls) : suffixes2 ls

suffixes3 [] = []
suffixes3 ls = ls : suffixes3 (tail2 ls)

prefixes [] = []
prefixes ls = ls : prefixes (init2 ls) 



-- 170816: 2

data Tree a = Node (Tree a ) (Tree a) | Leaf a deriving (Show, Ord, Eq)

t =
  Node
    (Node
      (Leaf 1)
      (Node
        (Node
          (Leaf 2)
          (Leaf 3)
        )
        (Leaf 4)
      )
    )
    (Node
      (Leaf 5)
      (Node
        (Leaf 6)
        (Node
          (Leaf 7)
          (Leaf 8)
        )
      )
    )
      
sumTree (Leaf x) = x
sumTree (Node left right) = sumTree left + sumTree right
-- *Main> sumTree t
-- 36
-- *Main> 



-- 171018: 3

isLetter 'a' = True
isLetter _ = False

-- *Main> :type "x"
-- "x" :: [Char]
-- *Main> :type (1,'x',[True])
-- (1,'x',[True]) :: Num t => (t, Char, [Bool])
-- *Main> :type ["x":[]]
-- ["x":[]] :: [[[Char]]]
-- *Main> :type not.not.isLetter
-- not.not.isLetter :: Char -> Bool
-- *Main> :type map not
-- map not :: [Bool] -> [Bool]
-- *Main> (+1).(0<)

-- <interactive>:1:2: error:
--     • Could not deduce (Num Bool) arising from an operator section
--       from the context: (Num a, Ord a)
--         bound by the inferred type of it :: (Num a, Ord a) => a -> Bool
--         at <interactive>:1:1
--     • In the first argument of ‘(.)’, namely ‘(+ 1)’
--       In the expression: (+ 1) . (0 <)
-- *Main> (+1).(0<)

-- <interactive>:37:2: error:
--     • Could not deduce (Num Bool) arising from an operator section
--       from the context: (Num a, Ord a)
--         bound by the inferred type of it :: (Num a, Ord a) => a -> Bool
--         at <interactive>:37:1-9
--     • In the first argument of ‘(.)’, namely ‘(+ 1)’
--       In the expression: (+ 1) . (0 <)
--       In an equation for ‘it’: it = (+ 1) . (0 <)
-- *Main> :type \x -> x + 1
-- \x -> x + 1 :: Num a => a -> a
-- *Main> :type [1,'2',"3"]

-- <interactive>:1:8: error:
--     • Couldn't match expected type ‘Char’ with actual type ‘[Char]’
--     • In the expression: "3"
--       In the expression: [1, '2', "3"]
-- *Main> [1,'2',"3"]

-- <interactive>:40:8: error:
--     • Couldn't match expected type ‘Char’ with actual type ‘[Char]’
--     • In the expression: "3"
--       In the expression: [1, '2', "3"]
--       In an equation for ‘it’: it = [1, '2', "3"]
-- *Main> 


-- 170816: 4 (=170816: 3)

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

-- some variants

test i = foldr (\x y -> x+y) 0 (map (^2)  [1..i])

evenCubeSum1 n = foldr (\x y -> x*x*x+y) 0 [2,4..n]

evenCubeSum2 n = foldr (\x y -> if x `mod` 2 == 0 then x*x*x+y else y) 0 [2,3..n]

evenCubeSum3 n = foldr (+) 0 ( (map (^3).filter ((==0).(`mod` 2))) [2..n])

t2 ls = foldr (\x y -> if x `mod` 2 == 0 then x*x*x+y else y) 0 [2,3.. 2*(ls `div`2)]