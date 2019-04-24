count(E,L,N):-count_h(E,L,0,N).

count_h(E, [E | T], N, R) :- !, count_h(E, T, N+1, R).
count_h(E, [_ | T], N, R) :- count_h(E, T, N, R).
count_h(_, [], N, R) :- R is N.

count1(E, [E|T], N) :-
	!,
	count1(E, T, N1),
	N is N1 + 1.
count1(E, [_|T], N) :- count1(E, T, N).
count1(_, [], 0).
