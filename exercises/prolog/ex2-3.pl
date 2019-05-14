/* vim: set syntax=prolog */

% ?- point(A, B) = point(1,2)
% |    .
% A = 1,
% B = 2.
%
% ?- point(A, B) = point(X, Y, Z).
% false.
%
% ?- plus(2,2) = 4.
% false.
%
% ?- +(2,D) = +(E,2).
% D = E, E = 2.
%
% ?- triangle(point(-1,0), P2, P3) = triangle(P1, point(1,0), point(0,Y)).
% P2 = point(1, 0),
% P3 = point(0, Y),
% P1 = point(-1, 0).
%
% ?- ^D
% % halt
