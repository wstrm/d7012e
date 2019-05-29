/* vim: set syntax=prolog */

% a)
p :- a, b, c.
% a and b and c

% b)
p :- a, b.
p :- c.
% (a and b) or c

% c)
p :- a, !, b.
p :- c.
% (a and b) or (not a and c)

% d)
p :- c.
p :- a, !, b.
% c or (a and b)

% e)
p :- c, !.
p :- a, b.
% c or (not c and a and b)

% f)
p :- a, b, !.
p :- c.
% (a and b) or (not a and c) or (not b and c) =>
% (a and b) or c
