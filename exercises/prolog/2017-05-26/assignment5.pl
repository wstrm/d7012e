/* vim: set syntax=prolog */

% a)
 member(X, [X|_]).
 member(X, [_|T]) :- member(X, T).

% b)
% ?- member(A, [a, b, c, a, d, a]).
% A = a;
% A = b;
% A = c;
% A = a;
% A = d;
% A = a;
% false.
