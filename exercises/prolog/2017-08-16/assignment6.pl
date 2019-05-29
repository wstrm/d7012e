/* vim: set syntax=prolog */

 p :- a, b.
 p :- c.
 % (a and b) or c

 p :- a, !, c.
 p :- c.
 % (a and c) or (not a and c)

 p :- c.
 p :- a, !, b.
 % c or (a and b)

 p :- !, c.
 p :- a, b.
 % c
