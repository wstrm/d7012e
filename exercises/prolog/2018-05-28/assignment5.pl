/* vim: set syntax=prolog */
fib(0, 0).
fib(1, 1).
fib(N, FN) :-
	N1 is N - 1,
	N2 is N - 2,
	fib(N1, FN1), !,
	fib(N2, FN2), !,
	FN is FN1 + FN2.

fibs(N, L) :-
	N >= 0,
	NextN is N - 1,
	fibs(NextN, NextL), !,
	fib(N, FN),
	append(NextL, [FN], L).
fibs(_N, []).
