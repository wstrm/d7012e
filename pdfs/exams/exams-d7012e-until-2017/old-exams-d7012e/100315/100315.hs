--1a
data BinTree a = Element a (BinTree a) (BinTree a)
				| Noth

--1b
countnodes :: BinTree a -> Int
countnodes Noth = 0    ---för djup rekursion..fuck
countnodes Element a n1 n2 = 1 + countnodes n1 + countnodes n2

--1c
issearchtree :: Ord a => BinTree a -> Bool
issearchtree (Element _ Noth Noth) = True
issearchtree (Element _ Noth b) = issearchtree b
issearchtree (Element _ b Noth) = issearchtree b
issearchtree (Element a (Element b c d) (Element e f g)) =
	if a < b then False
	else if a > e then False
	else 
		issearchtree (Element b c d) && issearchtree (Element e f g)


--1d
insert :: Ord a => BinTree a -> a -> BinTree a
insert (Noth) e = Node e Noth Noth
insert (Element a n1 n2) e
	| e <= n 	= (Element a (insert n1 e) n2)
	| otherwise = (Element a n1 (insert n2 e))

--assignment 3 - do an interface nomad that multiplies, do stuff on sent 1

dostuff = do
		putStr "This will be visible on screen: "
		a <- getInt
		if a == 1 then putStr "1"
		else dostuff' [a]
dostuff' a= do
		putStr "Okay, one more nr: "
		b <- getInt
		if b == 1 then
			putstr show (docalc [b|a])
		else 
			dostuff' [b|a]

docalc [] = 1
docalc [a|b] = a * docalc b


----------------------------------------


p :- c.
p :- a,!,b.
				 c or a and b
p :- a,!,b.
p :- c.
				a and b or not a and c
p :- a,b.
p :- c.
				a and b or c



---------------------------------------


findfirst (_, [] , _):- fail.
findfirst (E, [E|Ls] ,E):- !.
findfirst (E, [_|Ls] ,F):- findfirst (E, Ls, F).


red cut :
changes the programs behavior, example:

p:- a,!,b.		red cut, changes the below programs from (a and b or c) to (a and b or not a and c) since c cant be reached if a is True
p:- c.

p:- a,b.
p:- c.

-------------------------------------










