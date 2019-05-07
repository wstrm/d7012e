/*
 Lab P2: Smallest k sets revisited
 Course: D7012E Declarative languages
 Student: William Wennerström <wenwil-5@student.ltu.se>
*/

% Calculates the sum of a list.
% sum :: List -> Int
sum([], 0).
sum([N], Sum) :- Sum is N, !. % Do not return 2 solutions w/ & w/o empty list.
sum([N|Tail], Sum) :-
	sum(Tail, NextSum),
	Sum is N + NextSum.

% Returns the sublist between two indices (inclusive).
% sublist :: List -> I -> J -> List
sublist([_Skip|Tail], I, J, NewList) :-
	I > 0, I < J,
	NextI is I - 1, NextJ is J - 1,
	sublist(Tail, NextI, NextJ, NewList).
sublist([Include|Tail], 0, J, NewList) :-
	0 < J,
	NextJ is J - 1,
	NewList = [Include|Rest],
	sublist(Tail, 0, NextJ, Rest).
sublist([Include|_], _, 0, [Include]). % Inclusive.

% Produces all possible subsets with their corresponding sum and indices.
% sets :: List -> Sets
sets([], []).
sets(List, Sets) :- aux(List, 0, 0, Sets).

% Auxiliary function for sets that increments I and J to every valid range of
% sublists.
% aux :: List -> Int -> Int -> Sets
aux(List, I, J, Sets) :- % When J < Length(List).
	length(List, Length), % ISO defined built-in.
	J < Length,
	sublist(List, I, J, Sublist),
	sum(Sublist, Sum),
	NextJ is J+1,
	aux(List, I, NextJ, NextSets),
	Sets = [[Sum, I, J, Sublist]|NextSets].
aux(List, I, J, Sets) :-
	length(List, Length),
	I < Length,
	sublist(List, I, J, Sublist),
	sum(Sublist, Sum),
	NextI is I+1,
	aux(List, NextI, NextI, NextSets),
	Sets = [[Sum, I, J, Sublist]|NextSets].
aux(_List, Same, Same, []).

remove(X,[X|Xs],Xs).
remove(X,[Y|Xs],[Y|Ys]) :-
    dif(X,Y),
    remove(X,Xs,Ys).

% Smallest sum in a list of sets.
% smallest :: Sets -> Set
smallest([Smallest], Smallest).
smallest([[S1, I1, J1, L1],[S2|_]|Tail], Smallest) :-
    S1 =< S2,
    smallest([[S1, I1, J1, L1]|Tail], Smallest).
smallest([[S1|_],[S2, I2, J2, L2]|Tail], Smallest) :-
    S1 > S2,
    smallest([[S2, I2, J2, L2]|Tail], Smallest).

kSmallest(Sets, K, KSets) :-
	K > 0,
	NextK is K-1,
	smallest(Sets, Set),
	remove(Set, Sets, NextSets),
	kSmallest(NextSets, NextK, NextSmallest),
	KSets = [Set|NextSmallest].
kSmallest([_Skip|Tail], K, KSets) :-
	K > 0,
	NextK is K-1,
	kSmallest(Tail, NextK, KSets).
kSmallest(Sets, _, Sets).

/* vim: set syntax=prolog */
