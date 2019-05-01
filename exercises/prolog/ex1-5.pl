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

different(X,Y) :- \+(X=Y).

sister(X, Y) :-
	parent(Z, X),
	parent(Z, Y),
	female(X),
	different(X, Y).

aunt(X, Y) :- % X is the aunt of Y if,
	sister(X, Z), % X is the sister of Z, and,
	parent(Z, Y). % Z is the parent of Y.

% Ann is the sister of Pat,
% Pat have the child Jim.
% => aunt(ann, jim).
