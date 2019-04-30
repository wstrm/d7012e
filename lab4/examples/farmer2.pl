% A solution to the Farmer's problem of crossing a river
% By Sebastian Larsson

checkDirection(west, Direction) :- Direction=east.
checkDirection(east, Direction) :- Direction=west.

invalid(state(X, X, _, Y)) :- X \= Y. % fox left with goose
invalid(state(_, X, X, Y)) :- X \= Y. % goose left with beans
checkState(State) :- not(invalid(State)).

doMove(state(Fox, Goose, Bag, Boat), NewState, fox, Direction) :- % move fox
  checkDirection(Boat, Direction), 
  not(Fox=Direction), 
  not(Boat=Direction), 
  NewState=state(Direction, Goose, Bag, Direction), 
  checkState(NewState). 

doMove(state(Fox, Goose, Bag, Boat), NewState, goose, Direction) :- % move goose
  checkDirection(Boat, Direction), 
  not(Goose=Direction), 
  not(Boat=Direction), 
  NewState=state(Fox, Direction, Bag, Direction), 
  checkState(NewState). 

doMove(state(Fox, Goose, Bag, Boat), NewState, bag, Direction) :- % move bag
  checkDirection(Boat, Direction), 
  not(Bag=Direction), 
  not(Boat=Direction), 
  NewState=state(Fox, Goose, Direction, Direction), 
  checkState(NewState).

doMove(state(Fox, Goose, Bag, Boat), NewState, nothing, Direction) :- % move boat
  checkDirection(Boat, Direction), 
  not(Boat=Direction), 
  NewState=state(Fox, Goose, Bag, Direction), 
  checkState(NewState).

% state(Fox, Goose, Bag, Boat)
solvefgb(state(Dest, Dest, Dest, _), Dest, _, []). % fox, goose and bag on destination side => solution found

solvefgb(State, Dest, N, Trace) :- 
  N>0, 
  doMove(State, NewState, Item, Direction), 
  solvefgb(NewState, Dest, N-1, TraceDown), 
  Trace=[move(Item, Direction)|TraceDown].

start(Trace) :- 
  solvefgb(state(west, west, west, west), east, 8, Trace).

% start(T).
