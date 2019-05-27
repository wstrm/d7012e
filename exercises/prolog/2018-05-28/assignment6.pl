P :- !, A, B, C.
P :- A.
% A and B and C

P :- A, !, B, C.
P :- B.
% (A and B and C) or (not A and B)

P :- A, B, !, C.
P :- C.
% (A and B and C) or (not (A and B) and C) => C

P :- A, B, C, !.
P :- B.
% (A and B and C) or (not A and B) or (not C and B) =>
% (A and B and C) or B => B
