/* vim: set syntax=prolog */
 parent(tom, nils).
 parent(nils, maria).
 parent(maria, karin).
 parent(tom, per).
 parent(per, anna).
 parent(catrin, nils).

 siblings(X, Y) :-
	 parent(Z, X),
	 parent(Z, Y).

 cousins(X, Y) :-
	 parent(XP, X),
	 parent(YP, Y),
	 siblings(XP, YP).
