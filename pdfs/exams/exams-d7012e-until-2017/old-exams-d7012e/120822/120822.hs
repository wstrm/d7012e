-- 1a
data ETree = Number Int
			| Minus ETree
			| Add ETree ETree
			
--1b
Minus(Plus (Number 4) (Minus (Number 6)))

--1c
eval (Number n) = n
eval (Minus f) = - eval f 
eval (Plus t1 t2) = eval t1 + eval t2

--1d
data CTree a= Numb a
			| UnOP (a->a) (CTree a)
			| BinOP (a->a->a) (CTree a) (CTree a)

--1e
conv (Number n) = Numb n
conv (Minus t)  = UnOP (\n -> -n) (conv f) -- (\n -> -n) can be replaced by    negate
conv (Add t1 t2)= BinOP (+) (conv t1) (conv t2) -- (+) can be replaced by (\a b -> a+b)

--1f
ce (Numb n) = n
ce (UnOP f t) = f (ce t)
ce (BinOP f t1 t2) = f (ce t1) (ce t2)

ceval = ce . conv









