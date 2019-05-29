/* vim: set syntax=prolog */

 subset([], []).
 subset([X|T], [X|NT]) :- subset(T, NT).
 subset([_|T], NT) :- subset(T, NT).

 shortest([X], X).
 shortest([X,Y|Tail], R) :-
	 length(X, XL),
	 length(Y, YL),
	 XL =< YL,
	 shortest([X|Tail], R), !.
 shortest([_|Tail], R) :-
	 shortest(Tail, R), !.

 sum([], 0).
 sum([X], X).
 sum([X|T], S) :- sum(T, NextS), !, S is NextS + X.

 cashExchange(ValueList, Sum, ResultList) :-
	 setof(X, (subset(ValueList, X), sum(X, Sum)), S),
	 shortest(S, ResultList).
