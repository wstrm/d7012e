/* vim: set syntax=prolog */

parent(tom, nils).
parent(nils, maria).
parent(maria, karin).
parent(tom, per).
parent(per, anna).
parent(catrin, nils).

% a)
siblings(X, Y) :-
	parent(P, X),
	parent(P, Y).

% b)
cousins(X, Y) :-
	parent(P1, X),
	parent(P2, Y),
	siblings(P1, P2).
