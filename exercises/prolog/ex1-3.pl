/* vim: set syntax=prolog */
:- [parent_relation].

haschild(X) :- parent(X, _).
hastwochildren(X) :- parent(X, Y), sister(Y, _).

happy(X) :- haschild(X).
