/* vim: set syntax=prolog */

 arc(n1, n2).
 arc(n6, n2).
 arc(n2, n5).
 arc(n2, n3).
 arc(n3, n7).
 arc(n3, n4).
 arc(n6, n3).

 path(B, B, []). % Reached the end node.
 path(A, B, [arc(A, N)|Next]) :-
	 arc(A, N), % Find a node N that connects with A.
	 path(N, B, Next). % arc(A, N1) ~~~> arc(Nx, B).

 add(arc(A, A)) :- !, fail.
 add(arc(A, B)) :- path(B, A, _), !, fail.
 add(arc(A, B)) :- asserta(arc(A, B)).

 allPaths(N, L) :-
	 M is N - 1,
	 setof(P, A^B^(path(A, B, P), length(P, M)), L).
