/* vim: set syntax=prolog */

% a)
 f(_, [], 0).
 f(X, [X|L], N) :- f(X, L, NextN), !, N is NextN + 1.
 f(X, [_|L], N) :- f(X, L, N).

% b)
 fL(L, FT) :- setof([E, F], (member(E, L), f(E, L, F)), FT).
