/* vim: set syntax=prolog */

% a)
f(_, [], 0).
f(X, [X|Tail], N) :-
	f(X, Tail, NextN), !,
	N is NextN + 1.
f(X, [_|Tail], N) :- f(X, Tail, N).

% b)
fL(L, FL) :- setof([S, D], (member(S, L), f(S, L, D)), FL).
