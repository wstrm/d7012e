/* vim: set syntax=prolog */

% a)
 append([], List, List).
 append([Item|List1], List2, [Item|List3]) :-
	 append(List1, List2, List3).

% b)
 concat([], []).
 concat([List|Tail], Result) :-
	 concat(Tail, NextLists),
	 append(List, NextLists, Result).

% c)
% -? append(X, Y, [a, b, c, d]).
% X = [],
% Y = [a, b, c, d];
% X = [a],
% Y = [b, c, d];
% X = [a, b],
% Y = [c, d];
% X = [a, b, c],
% Y = [d];
% X = [a, b, c, d],
% Y = [];
% false.
% Y = [];
