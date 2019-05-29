/* vim: set syntax=prolog */

% a)
subLists(L, R) :- length(L, N), subLists(N, L, R).
subLists(0, _, [[]]).
subLists(N, L, R) :-
	NextN is N - 1,
	subLists(NextN, L, NextR),
	setof(X, comb(N, L, X), CurrentR), !,
	conc(CurrentR, NextR, R).

comb(0, _, []).
comb(N, [X|T], [X|Comb]) :-
	N > 0,
	N1 is N - 1,
	comb(N1, T, Comb).
comb(N, [_|T], Comb) :-
	N > 0,
	comb(N, T, Comb).

conc([], L, L).
conc([X|L1], L2, [X|L3]) :- conc(L1, L2, L3).

% a) Better variant.
comb1([], []).
comb1([X|T], [X|NT]) :- comb1(T, NT).
comb1([_|T], NT) :- comb1(T, NT).

subLists1(L, R) :-
	setof(S, comb1(L, S), R).

% b)
sum([], 0).
sum([X], X).
sum([X|T], S) :- sum(T, NS), !, S is NS + X.

keep([], _, []).
keep([L|T], Max, [L|R]) :-
	sum(L, N),
	N =< Max,
	keep(T, Max, R), !.
keep([_|T], Max, R) :- keep(T, Max, R), !.
