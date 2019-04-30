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

haschild(X) :- parent(X, _).
hastwochildren(X) :- parent(X, Y), sister(Y, _).

happy(X) :- haschild(X).
