:- [parent_relation].

% (a) ?- parent(X, pat).
%
% (b) ?- parent(liz, X).
%
% (c) ?- parent(X, Y), parent(Y, pat).

% ?- parent(X, pat).
% X = bob.
%
% ?- parent(liz, X).
% false.
%
% ?- parent(X, Y), parent(Y, pat).
% X = pam,
% Y = bob ;
% X = tom,
% Y = bob ;
% false.
