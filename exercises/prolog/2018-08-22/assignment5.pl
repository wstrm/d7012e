/* vim: set syntax=prolog */

% a)
p(X) :- !, a(X), b(X).
p(X) :- a(X).
% (A and B)

% b)
p(X) :- a(X), !, b(X).
p(X) :- a(X).
% (A and B)

% c)
p(X) :- a(X), !, b(X).
p(X) :- b(X).
% (A and B) or (not A and B)

% d)
p(X) :- a(X), b(X), !.
p(X) :- b(X).
% (A and B) or B
