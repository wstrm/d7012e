/* vim: set syntax=prolog */

length1([], 0).
length1([_|Tail], N) :- length(Tail, NextN), N is NextN + 1.

member1(X, [X|_]).
member1(X, [_|T]) :- member1(X, T).

head1([X|_], X).

tail1([_|T], T).

null1([]).

conc1([], L2, L2).
conc1([X|L1], L2, [X|L3]) :- conc1(L1, L2, L3).

subsets1([], []).
subsets1([X|Tail], [X|NextTail]) :- subsets1(Tail, NextTail).
subsets1([_|Tail], NextTail) :- subsets1(Tail, NextTail).

%     S1       S      S3
% |=========|=====|=========|
%           \_______________/
%                  S2
% \_________________________/
%             L
%
% S1 ^ S2 = L => S2 = L \ S1.
% S ^ S3 = S2.
% => S = L \ S1 \ S3.
sublists1(L, S) :- conc1(_S1, S2, L), conc1(S, _S3, S2), \+(length1(S, 0)).

del1(X, [X|Tail], Tail). % Remove X.
del1(X, [Y|Tail], [Y|NextTail]) :- del1(X, Tail, NextTail). % Keep Y.

member2(X, L) :- del1(X, L, _).

insert1(X, L, R) :- del1(X, R, L).

prepend1(X, L, [X|L]).

append1(X, [], [X]).
append1(X, [Y|Tail], [Y|NextTail]) :- append1(X, Tail, NextTail).

permutation1([], []).
% Insert X in the permuted list L1.
permutation1([X|L], P) :- permutation1(L, L1), insert1(X, L1, P).

permutation2([], []).
permutation2([X|L], P) :- permutation2(L, L1), del1(X, P, L1).
