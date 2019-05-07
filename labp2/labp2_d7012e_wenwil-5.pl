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

% aux :: List -> Int -> Int -> Sets
aux(List, I, J, Sets) :- % When J < Length(List).
	length(List, Length), % ISO defined built-in.
	J < Length,
	sublist(List, I, J, Sublist),
	sum(Sublist, Sum),
	NextJ is J + 1,
	aux(List, I, NextJ, NextSets),
	Sets = [[Sum, I, J, Sublist]|NextSets].
aux(List, I, J, Sets) :-
	length(List, Length),
	I < Length,
	sublist(List, I, J, Sublist),
	sum(Sublist, Sum),
	NextI is I + 1,
	aux(List, NextI, NextI, NextSets),
	Sets = [[Sum, I, J, Sublist]|NextSets].
aux(_, _, _, _).

/* vim: set syntax=prolog */
