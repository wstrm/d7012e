:- [parent_relation].

% (a) ?- parent(jim, X).
% 	: no.
%
% (b) ?- parent(X, jim).
% 	: X=pat.
%
% (c) ?- parent(pam, X), parent(X, pat).
% 	: X=bob.
%
% (d) ?- parent(pam, X), parent(X, Y), parent(Y, jim)
% 	: X=bob;
% 	: Y=pat.

% ?- parent(jim, X).
% false.
%
% ?- parent(X, jim).
% X = pat.
%
% ?- parent(pam, X), parent(X, pat).
% X = bob.
%
% ?- parent(pam, X), parent(X, Y), parent(Y, jim).
% X = bob,
% Y = pat.
%
% ?- ^D
% % halt
