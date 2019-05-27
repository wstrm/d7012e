/* vim: set syntax=prolog */

arc(n1, n2).
arc(n6, n2).
arc(n2, n5).
arc(n2, n3).
arc(n3, n7).
arc(n3, n4).
arc(n6, n3).

% a)
path(A, A, []).
path(A, B, [arc(A, N) | T]) :-
	arc(A, N), path(N, B, T).

% b)
add(arc(A, A)) :- !, fail. % Cannot start and end at same node.
add(arc(A, B)) :- path(B, A, _), !, fail. % There must be no path B -> A and A -> B (cycle).
add(arc(A, B)) :- asserta(arc(A, B)).

% c)
allPaths(N, L) :-
	M is N - 1,
	findall(P, (path(_A, _B, P), length(P, M)), L).
