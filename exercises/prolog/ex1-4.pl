/* vim: set syntax=prolog */
:- [parent_relation].

grandchild(X, Z) :- % X is a grandchild of Z if,
	parent(Y, X), % Y is a parent of X, and,
	parent(Z, Y). % Z is a parent of Y.

% grandchild(ann, pam).
