/* vim: set syntax=prolog */

% a)
% T1:
a1.
b1.
c1 :- fail.
p1 :- a1, b1.
p1 :- c1.
% => false.

% T2:
a2 :- fail.
b2 :- fail.
c2.
p2 :- a2, b2.
p2 :- c2.
% => false.

% T3:
a3.
b3 :- fail.
c3.
p3 :- a3, b3.
p3 :- c3.
% => true.

% T4:
a4.
b4 :- fail.
c4 :- fail.
p4 :- a4, b4.
p4 :- c4.
% => false.

% b)
% T5:
a5.
b5.
c5 :- fail.
p5 :- a5, !, b5.
p5 :- c5.
% => true.

% T6:
a6 :- fail.
b6 :- fail.
c6.
p6 :- a6, !, b6.
p6 :- c6.
% => true.

% T7:
a7.
b7 :- fail.
c7.
p7 :- a7, !, b7.
p7 :- c7.
% => false.

% T8:
a8.
b8 :- fail.
c8 :- fail.
p8 :- a8, !, b8.
p8 :- c8.
% => false.

% c)
% T9:
a9.
b9.
c9 :- fail.
p9 :- c9.
p9 :- a9, !, b9.
% => true.

% T10:
a10 :- fail.
b10 :- fail.
c10.
p10 :- c10.
p10 :- a10, !, b10.
% => true.

% T11:
a11.
b11 :- fail.
c11.
p11 :- c11.
p11 :- a11, !, b11.
% => true.

% T12:
a12.
b12 :- fail.
c12 :- fail.
p12 :- c12.
p12 :- a12, !, b12.
% => false.

% d)
% T13:
a13.
b13.
c13 :- fail.
p13 :- !, c13.
p13 :- a13, b13.
% => false.

% T14:
a14 :- fail.
b14 :- fail.
c14.
p14 :- !, c14.
p14 :- a14, b14.
% => true.

% T15:
a15.
b15 :- fail.
c15.
p15 :- !, c15.
p15 :- a15, b15.
% => true.

% T16:
a16.
b16 :- fail.
c16 :- fail.
p16 :- !, c16.
p16 :- a16, b16.
% => false.
