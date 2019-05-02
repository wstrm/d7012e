% A solution to the Farmer's Problem of crossing a river
% By Nicklas Gavelin

invalid(state(_,A,A,B)) :-
    A \== B.
invalid(state(A,A,_,B)) :-
    A \== B.

newmove(west, Move) :-
    Move = east.
newmove(east, Move) :-
    Move = west.

move(state(Fox, Goose, Bag, X), State, TheMove):-
    State = state(Fox, Goose, Bag, Y),
    newmove(X, Y),
    TheMove = [nothing, Y].

move(state(X, Goose, Bag, X), State, TheMove):-
    State = state(Y, Goose, Bag, Y),
    newmove(X, Y),
    TheMove = [fox, Y].

move(state(Fox, X, Bag, X), State, TheMove):-
    State = state(Fox, Y, Bag, Y),
    newmove(X, Y),
    TheMove = [goose, Y].

move(state(Fox, Goose, X, X), State, TheMove):-
    State = state(Fox, Goose, Y, Y),
    newmove(X, Y),
    TheMove = [bag, Y].

solvefgb(state(Dest, Dest, Dest, _), Dest, _, []).
solvefgb(State, Dest, N, Trace) :-
    N > 0,
    move(State, NewState, [Animal, Direction]),
    \+(invalid(NewState)),
    solvefgb(NewState, Dest, N-1, TraceCo),
    Trace = [move(Animal, Direction) | TraceCo].

temp(state(west,west,west,west)).
start(T) :- temp(X), solvefgb(X, east, 8, T).

% start(T).
