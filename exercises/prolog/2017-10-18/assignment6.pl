/* vim: set syntax=prolog */

% a)
select1(X, [X|R], R).
select1(X, [Y|Tail], R) :-
	select1(X, Tail, NextR),
	R = [Y|NextR].

select2(X, [X|R], R).
select2(X, [Y|Tail], R) :-
	select2(X, Tail, NextR),
	R = [Y|NextR].
select2(_, R, R).

% b)
pickTwoDifferent(L, E1, E2) :-
	select1(E1, L, _),
	select1(E2, L, _),
	E1 =\= E2.
