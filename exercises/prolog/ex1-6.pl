/* vim: set syntax=prolog */
:- [parent_relation].

relatives(X, Y) :- % X is a relative of Y, if,
	predecessor(X, Y). % X is a predecessor of Y,
relatives(X, Y) :- % or,
	predecessor(Y, X). % Y is a predecessor of X.

% => predecessor(ann, jim).
% => predecessor(jim, ann).
