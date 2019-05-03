/* vim: set syntax=prolog */
add(X, L, [X|L]).

del(X, [Y|Tail], Tail) :- X = Y.
del(X, [Y|Tail], [Y|Tail1]) :- del(X, Tail, Tail1).

insert(X, List, Bigger) :- del(X, Bigger, List).

member(X, List) :- del(X, List, _).

conc([], List, List).
conc([Head|Tail], List, [Head|Rest]) :- conc(Tail, List, Rest).

sublist(Sublist, List) :- conc(_, L2, List), conc(Sublist, _, L2).

permutation([], []).
permutation([X], [X]).
permutation([X|L], P) :- permutation(L, L1), insert(X, L1, P).

permutation_([], []).
permutation_([X], [X]).
permutation_(L, [X|P]) :- del(X,L, L1), permutation_(L1, P).

ordered([]).
ordered([_]).
ordered([A, B|T]) :- A =< B, ordered([B|T]).

pSort(I, R) :- permutation(I, R), ordered(R).

p :- p.
