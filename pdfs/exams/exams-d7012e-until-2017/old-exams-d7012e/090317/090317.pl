load(WeightList, MaxWeight, ResultList):-
	WeightList == [] -> fail;
	WeightList == [A], A>MaxWeight -> fail;
	
	findall( Combination, combinations(WeightList, Combination), CombList),
	last(CombList, Last),
	subtract(CombList, Last, CombList1),
	addcomb(CombList1, WeightCombList),
	findbest(WeightCombList, MaxWeight, (_,ResultList)).
	
combinations([],[]).
combinations([Weight|Weights],[Weight|Set]):-
	combinations(Weights, Set).
combinations([_|Weights],Set):-
	combinations(Weights, Set).

addcomb([],[]).
addcomb([Comb|Combinations],[(Value, Comb)| Rest]):-
	addhelp(Comb, Value),
	addcomb(Combinations, Rest).

addhelp([], 0).
addhelp([Elem|Elems], Sum) :-
   addhelp(Elems, Rest),
   Sum is Elem + Rest.
   
findbest([(Weight|_), Ls], MaxW, Best):-
	Weight > MaxW,
	findbest(Ls, MaxW, Best).

findbest([(Weight|List), Ls], MaxW, (Weight, List)):-
	MaxW - Weight < MaxW - Best,
	findbest(Ls, MaxW, Best).

findbest([(Weight|_), Ls], MaxW, (Best, _)):-
	MaxW - Weight >= MaxW - Best,
	findbest(Ls, MaxW, Best).
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


			
dostuff' a = do
		putStr "give more nrs"
		b <- getLine
		if b == 0 then
			putstr show (calc [a|b])
		else
			dostuff' [a|b]
calc [] = 0
calc (x:xs) = x + calc xs 
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





