
% consider code
% a, what will happen if we backtrack the predicate; what results will be returned?
% b, modify by placing a cut, so that only the smallest element will be returned
% c, can we modify in some other way, without using cut, in order to achieve the
% same result?

findMin([X|Xs],Res) :- findMin_([X|Xs], X, Res).

findMin_([], Result, Result).
findMin_([X|Xs], Acc, Result) :-
	X<Acc,
%	!,
	findMin_(Xs, X, Result).
findMin_([_|Xs], Acc, Result) :-
	findMin_(Xs, Acc, Result).
	
% 2 ?- findMin([2,5,7,1], N).
% N = 1 ;
% N = 2.

findMin2([X|Xs],Res) :- findMin2_([X|Xs], X, Res).

findMin2_([], Result, Result).
findMin2_([X|Xs], Acc, Result) :-
	X<Acc,
	findMin2_(Xs, X, Result).
findMin2_([X|Xs], Acc, Result) :-
	X >= Acc,
	findMin2_(Xs, Acc, Result).
