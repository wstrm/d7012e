/* vim: set syntax=prolog */
:- [parent_relation].

aunt(X, Y) :- % X is the aunt of Y if,
	sister(X, Z), % X is the sister of Z, and,
	parent(Z, Y). % Z is the parent of Y.

% Ann is the sister of Pat,
% Pat have the child Jim.
% => aunt(ann, jim).
