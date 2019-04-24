-- 1a
data ETree = Number Int
			| Minus ETree
			| Add ETree ETree
			
--1b
Minus(Add (Number 4) (Minus (Number 6)))

--1c
eval (Number n) = n
eval (Minus f) = - eval f 
eval (Add t1 t2) = eval t1 + eval t2

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

-----------------------------------------
%2a
p:- a,b.
p:- c.

a and b or c

%2b
p:- a,!,b.
p:- c.

(a and b) or ( not(a) and c)

%2c
p:- c.
p:- a,!,b.

c or (a and b)
------------------------------------------
%3a
count(_,[],0).
count(E,[E|L],N):-
	!,     			%this means that in the one below, E != _
	count(E,L,M),
	N is M+1.
count(E,[_|L],N):-
	count(E,L,N).


%3b
count(A,[a,b,a,a,c,d,a],N)

	N=4,
	A=a;
	
	A=b,
	N=1;
	
fuck all....

--------------------------------------
%4

	palin = do  putStr ">>"
				s <- getLine
				if s == [] then return () else
					do putStr (s++reverse s ++"\n")
					palin

--------------------------------------
%5

%combinepads(+PadList, +PillarHeight, -ResultList)
combinepads(Pads, Height, [Pad|R]):-
	findall(L, pick(Pads,L),Q)
	best(Q,Height,R,_)
.

pick([],[]).
pick([X|L],[X,K]):- pick(L,K).
pick([_|L],K):- pick(L,K).

best([],Height,[],Height).
best([R|Picks],Height,R,N):- 
	best(Picks, Height, R1, N1), %N1 is the sum of something, missed it
	abs(N1-Height,N), 
	N <= N1.
best([R|Picks]Height,R1,N1):-
	best(...),
	N<N1.




%combinepads(+PadList, +PillarHeight, -ResultList)

combinepads(PadList, PillarHeight, ResultList):-
	findall(Combinations, pick(PadList,Combinations),Picks),
	addelements(Picks, ValueofPicks)
	findbest(ValueofPicks, PillarHeight, ResultList).


pick([],[])
pick([Pad|PadList],[Pad|Combinations]):- %add pad to combinations
	pick(PadList,Combinations).
pick([_|PadList], Combinations):-		%dont add pad to combinations
	pick(PadList, Combinations).

	
findbest([],_,[],_).
findbest([(Value,Pick)|Picks], PillarHeight, Result, Close):-
	abs(Value, AbsValue),
	Closeness is AbsValue-Pillarheight,
	
	findbest(Picks,PillarHeight,Result,Closeness)
	%else dont, continue recursion.

addelements([],[]).
addelements([Pick|Picks], [(Value,Pick)|ValuedList]):-
	add(Pick,ValueofPick),
	Value is ValueofPick,
	addelements(Picks,ValuedList).

add([], 0).
add([X|Xs],Y):-
	Y is Y1 + X,
	add(Xs,Y1).
	












