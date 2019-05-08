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
	I > 0, I =< J,
	NextI is I - 1, NextJ is J - 1,
	sublist(Tail, NextI, NextJ, NewList).
sublist([Include|Tail], 0, J, NewList) :-
	0 =< J,
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
	sublist(List, I, J, Sublist),
	sum(Sublist, Sum),
	NextJ is J+1,
	aux(List, I, NextJ, NextSets), !,
	Sets = [set(Sum, I, J, Sublist)|NextSets].
aux(List, I, _J, NextSets) :-
	length(List, Length), I < Length,
	NextI is I+1,
	aux(List, NextI, NextI, NextSets), !.
aux(_List, Same, Same, []).

% The sum of a set.
% setSum :: Set -> Int
setSum(set(Sum, _, _, _), Sum).

% Quicksort a list of sum(Sum, I, J, Sublist).
% quicksort :: Sets -> Sets
quicksort([], []).
quicksort([Pivot|Rest], SortedList) :-
	partition(Pivot, Rest, Left, Right),
	quicksort(Left, SortedLeft),
	quicksort(Right, SortedRight),
	append(SortedLeft, [Pivot|SortedRight], SortedList).

% Partition a list of sum(Sum, I, J, Sublist) into two recursively at a pivot.
% partition :: Set -> Sets -> Sets -> Sets
partition(_Pivot, [], [], []).
partition(Pivot, [Head|Tail], [Head|SortedLeft], SortedRight) :-
	setSum(Pivot, PivotSum), setSum(Head, HeadSum),
	HeadSum =< PivotSum,
	partition(Pivot, Tail, SortedLeft, SortedRight).
partition(Pivot, [Head|Tail], SortedLeft, [Head|SortedRight]) :-
	setSum(Pivot, PivotSum), setSum(Head, HeadSum),
	HeadSum  > PivotSum,
	partition(Pivot, Tail, SortedLeft, SortedRight).

% Take the first N items in a list.
% take :: List -> List
take(0, _, []).
take(N, [Head|Tail], Sublist) :-
	NextN is N-1,
	take(NextN, Tail, NextSublist),
	Sublist = [Head|NextSublist].

% The K smallest sets are the K smallest of all possible sets for a list.
% kSmallestSets :: Int -> List -> Sets
kSmallestSets(K, List, KSets) :-
	sets(List, Sets),
	quicksort(Sets, SortedSets),
	take(K, SortedSets, KSets).

printKSmallestSets() :-
	% Example from Lab H1.
	printKSmallestSets(
		3, [-1,2,-3,4,-5]), nl,

	% Test case 1.
	% [x*(-1)^x | x <- [1..100]]
	findall(X, (between(1,100, I), X is I*(-1)^I), TestCase1),
	printKSmallestSets(15, TestCase1), nl,

	% Test case 2.
	printKSmallestSets(
		6, [24,-11,-34,42,-24,7,-19,21]), nl,

	% Test case 3.
	printKSmallestSets(
		8, [3, 2, -4, 3, 2, -5, -2, 2, 3, -3, 2, -5, 6, -2, 2, 3]), nl.

printKSmallestSets(K, List) :-
	kSmallestSets(K, List, S),
	write('Entire list: '), write(List), nl, nl,
	write('size\ti\tj\tsublist'), nl,
	printKSmallestSets(S).

printKSmallestSets([]).
printKSmallestSets([set(Sum, I, J, Sublist)|Tail]) :-
	IncI is I+1, IncJ is J+1,
	write(Sum), write('\t'),
	write(IncI), write('\t'),
	write(IncJ), write('\t'),
	write(Sublist), nl,
	printKSmallestSets(Tail).

/* vim: set syntax=prolog */
