/* vim: set syntax=prolog */

 append([], List, List).
 append([Item|List1], List2, [Item|List3]) :-
	 append(List1, List2, List3).

 concat([], []).
 concat([List|Tail], Result) :-
	 concat(Tail, NextLists),
	 append(List, NextLists, Result).
