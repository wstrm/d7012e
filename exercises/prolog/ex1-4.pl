/* vim: set syntax=prolog */
parent(pam, bob).
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

female(pam).
female(liz).
female(ann).
female(pat).
male(tom).
male(bob).
male(jim).

grandchild(X, Z) :- % X is a grandchild of Z if,
	parent(Y, X), % Y is a parent of X, and,
	parent(Z, Y). % Z is a parent of Y.

% grandchild(ann, pam).
