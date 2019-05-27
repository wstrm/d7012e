/* vim: set syntax=prolog */

% a)
factorial(0, 1). % 1 if n = 0.
factorial(N, FN) :-
	NextN is N - 1,
	factorial(NextN, NextFN), !,
	FN is NextFN * N.

% b)
factorials(N, L) :-
	N >= 0,
	factorial(N, FN),
	NextN is N - 1,
	factorials(NextN, NextL), !,
	append(NextL, [FN], L).
factorials(_N, []).
