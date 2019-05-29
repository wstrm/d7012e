/* vim: set syntax=prolog */

 % AvailableBags = [3, 1, 3, 5, 3],
 % SuitcaseVolume = 10,
 % BagsPacked = [3, 1, 3, 3]; (10)
 % BagsPacked = [3, 1, 5]; (9)
 % BagsPacked = [3, 5]; (8)
 % BagsPacked = [3, 1, 3]; (7)
 % ...

 subset([], []).
 % With the element X.
 subset([X|Tail], [X|NextTail]) :-
	 subset(Tail, NextTail).
 % Without the element X.
 subset([_X|Tail], NextTail) :-
	 subset(Tail, NextTail).

 sum([], 0).
 sum([X], X).
 sum([X|Tail], Sum) :-
	 sum(Tail, NextSum),
	 Sum is X + NextSum.

 % Find any combination of bags that equal volume.
 pack(AvailableBags, SuitcaseVolume, BagsPacked) :-
	 subset(AvailableBags, BagsPacked),
	 sum(BagsPacked, SuitcaseVolume).

 % Try with a lower suitcase volume.
 pack(AB, SV, BP) :- SV > 0, NSV is SV - 1, pack(AB, NSV, BP).
