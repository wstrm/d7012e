/* ------------------------------------------------------- */
 %
 %    D7012E Declarative languages
 %    Luleå University of Technology
 %
 %    Student full name: <TO BE FILLED IN BEFORE THE GRADING>
 %    Student user id  : <TO BE FILLED IN BEFORE THE GRADING>
 %
 /* ------------------------------------------------------- */



  %do not chagne the follwoing line!
  :- ensure_loaded('play.pl').


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% /* ------------------------------------------------------ */
%               IMPORTANT! PLEASE READ THIS SUMMARY:
%       This files gives you some useful helpers (set &get).
%       Your job is to implement several predicates using
%       these helpers. Feel free to add your own helpers if
%       needed, as long as you write comments (documentation)
%       for all of them.
%
%       Implement the following predicates at their designated
%       space in this file. You might like to have a look at
%       the file  ttt.pl  to see how the implementations is
%       done for game tic-tac-toe.
%
%          * initialize(InitialState,InitialPlyr).
%          * winner(State,Plyr)
%          * tie(State)
%          * terminal(State)
%          * moves(Plyr,State,MvList)
%          * nextState(Plyr,Move,State,NewState,NextPlyr)
%          * validmove(Plyr,State,Proposed)
%          * h(State,Val)  (see question 2 in the handout)
%          * lowerBound(B)
%          * upperBound(B)
% /* ------------------------------------------------------ */







% /* ------------------------------------------------------ */

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% We use the following State Representation:
% [Row0, Row1 ... Rown] (ours is 6x6 so n = 5 ).
% each Rowi is a LIST of 6 elements '.' or '1' or '2' as follows:
%    . means the position is  empty
%    1 means player one has a stone in this position
%    2 means player two has a stone in this position.





% DO NOT CHANGE THE COMMENT BELOW.
%
% given helper: Inital state of the board

initBoard([ [.,.,.,.,.,.],
[.,.,.,.,.,.],
[.,.,1,2,.,.],
[.,.,2,1,.,.],
[.,.,.,.,.,.],
[.,.,.,.,.,.] ]).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%% IMPLEMENT: initialize(...)%%%%%%%%%%%%%%%%%%%%%
%%% Using initBoard define initialize(InitialState,InitialPlyr).
%%%  holds iff InitialState is the initial state and
%%%  InitialPlyr is the player who moves first.
initialize(InitialState, 1) :- initBoard(InitialState).

% pieces :: [[Atom]] -> Int -> Int
% pieces is the relation between pieces on the game board and their player.
pieces(State, Plyr, Pieces) :- pieces(State, Plyr, Pieces, 0, 0).

% Stop recursion when both X and Y is out of bounds.
pieces(_State, _Plyr, [], X, Y) :- X > 5, Y > 5.

% If Y is out of bounds, reset Y and increment X.
pieces(State, Plyr, Pieces, X, Y) :- Y > 5,
	pieces(State, Plyr, Pieces, X + 1, 0), !.

% Check if player has a piece at the [X, Y] coordinate, if so, add the
% coordinate to the list of pieces.
pieces(State, Plyr, Pieces, X, Y) :-
	Xi is X, Yi is Y,
	(get(State, [Xi, Yi], Plyr) ->
		Pieces = [[Xi, Yi]|NextPieces]
	;
		Pieces = NextPieces
	),
	pieces(State, Plyr, NextPieces, X, Y + 1), !. % Continue recursion.

% score :: [[Atom]] -> Int -> Int
% score is the relation between a game state, a player, and their score.
score(State, Plyr, Score) :-
	pieces(State, Plyr, Pieces),
	length(Pieces, Score).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%winner(...)%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define winner(State,Plyr) here.
%     - returns winning player if State is a terminal position and
%     Plyr has a higher score than the other player
winner(State, Plyr) :-
	terminal(State),
	score(State, 1, Score1),
	score(State, 2, Score2),
	Score1 =\= Score2,
	((Score1 < Score2) ->
		Plyr = 1;
		Plyr = 2).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%tie(...)%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define tie(State) here.
%    - true if terminal State is a "tie" (no winner)
% tie :: [[Atom]]
tie(State) :-
	terminal(State),
	score(State, 1, SameScore),
	score(State, 2, SameScore).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%terminal(...)%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define terminal(State).
%   - true if State is a terminal
% terminal :: [[Atom]]
terminal(State) :-
	moves(1, State, []),
	moves(2, State, []).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%showState(State)%%%%%%%%%%%%%%%%%%%%%%%%%%
%% given helper. DO NOT  change this. It's used by play.pl
%%

showState( G ) :-
	printRows( G ).

printRows( [] ).
printRows( [H|L] ) :-
	printList(H),
	nl,
	printRows(L).

printList([]).
printList([H | L]) :-
	write(H),
	write(' '),
	printList(L).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%moves(Plyr,State,MvList)%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define moves(Plyr,State,MvList).
%   - returns list MvList of all legal moves Plyr can make in State
% moves :: Int -> [[Atom]] -> [[Int, Int]]
moves(Plyr, State, MvList) :-
	pieces(State, Plyr, Pieces),
	moves(Plyr, State, Pieces, UnsortedMvList),
	quicksort(UnsortedMvList, MvList).

% Recurse through the pieces and check for valid moves.
moves(Plyr, State, [Coord|Tail], MvList) :-
	getOpponent(Plyr, Opp),
	moves(Plyr, State, Tail, NextMvs), !,
	(findMoves(State, Plyr, Opp, Coord, Mvs) ->
		append(Mvs, NextMvs, MvList) % Found moves, append to list.
	;
		MvList = NextMvs). % No moves found.

% Stop recursion on empty piece list.
moves(_Plyr, _State, [], []).

% Quicksort a list of coordinates.
% quicksort :: [[Int, Int]] -> [[Int, Int]]
quicksort([], []).
quicksort([Pivot|Rest], SortedList) :-
	partition(Pivot, Rest, Left, Right), !,
	quicksort(Left, SortedLeft), !,
	quicksort(Right, SortedRight), !,
	append(SortedLeft, [Pivot|SortedRight], SortedList).

% Partition a list of coordinates into two recursively at a pivot.
% partition :: [Int, Int] -> [[Int, Int]] -> [[Int, Int]] -> [[Int, Int]]
partition(_Pivot, [], [], []).
partition(Pivot, [Head|Tail], [Head|SortedLeft], SortedRight) :-
	getXY(Pivot, PivotX, PivotY), getXY(Head, HeadX, HeadY),
	(HeadX < PivotX; HeadX = PivotX, HeadY =< PivotY),
	partition(Pivot, Tail, SortedLeft, SortedRight).
partition(Pivot, [Head|Tail], SortedLeft, [Head|SortedRight]) :-
	partition(Pivot, Tail, SortedLeft, SortedRight).

% getXY is a helper for partition to extract the X and Y values.
getXY([X, Y], X, Y).

% getOpponent is a helper function that returns the opponent.
getOpponent(Plyr, Opp) :- ((Plyr = 1, Opp is 2); (Plyr = 2, Opp is 1)).

% nextCoord :: [Int, Int] -> Atom -> [Int, Int]
% nextCoord increments the X and Y coordinate according to the provided
% direction.
nextCoord([X, Y], 'N', [X, Yi]) :- Yi is Y - 1.
nextCoord([X, Y], 'S', [X, Yi]) :- Yi is Y + 1.
nextCoord([X, Y], 'E', [Xi, Y]) :- Xi is X + 1.
nextCoord([X, Y], 'W', [Xi, Y]) :- Xi is X - 1.
nextCoord([X, Y], 'NW', [Xi, Yi]) :- Xi is X - 1, Yi is Y - 1.
nextCoord([X, Y], 'NE', [Xi, Yi]) :- Xi is X + 1, Yi is Y - 1.
nextCoord([X, Y], 'SW', [Xi, Yi]) :- Xi is X - 1, Yi is Y + 1.
nextCoord([X, Y], 'SE', [Xi, Yi]) :- Xi is X + 1, Yi is Y + 1.

% findMoves :: [[Atom]] -> Int -> Int -> [[Int, Int]] -> [[Int, Int]]
% findMoves finds all legal moves in every direction for a provided slot.
findMoves(State, Plyr, Opp, Coord, Mvs) :-
	findMoves(State, Plyr, Opp, Coord, Mvs,
	['N', 'S', 'E', 'W', 'NW', 'NE', 'SW', 'SE']).
findMoves(State, Plyr, Opp, Coord, Mvs, [Wind|Tail]) :-
	findMoves(State, Plyr, Opp, Coord, NextMvs, Tail),
	(findMove(State, Plyr, Opp, Coord, Wind, Plyr, Mv) ->
		Mvs = [Mv|NextMvs] % Found move, add to list.
	;
		Mvs = NextMvs). % No move.
findMoves(_State, _Plyr, _Opp, _Coord, [], []).

% findMove ::
% 	[[Atom]] -> Int -> Int -> [Int, Int] -> Atom -> Atom -> [[Int, Int]]
% findMove finds a legal move from the provided slot for a direction.
findMove(State, Plyr, Opp, [X, Y], Wind, Prev, Mv) :-
	nextCoord([X, Y], Wind, [Xi, Yi]),
	get(State, [Xi, Yi], Slot),
	\+(Slot = Plyr), % The next slot must not be the same as the player.
	(
		% If the slot is the opponent, look further for an empty slot.
		(Slot = Opp),
		findMove(State, Plyr, Opp, [Xi, Yi], Wind, Opp, Mv)
	;
		% If the slot is empty, and the previous the opponent, it's a
		% valid move.
		(Slot = ., Prev = Opp),
		Mv = [Xi, Yi]
	).

makeMove(State, Plyr, Move, NewState) :-
	getOpponent(Plyr, Opp),
	set(State, S, Move, Plyr),
	makeMove(S, Plyr, Opp, Move,
	['N', 'S', 'E', 'W', 'NW', 'NE', 'SW', 'SE'], NewState).

makeMove(State, Plyr, Opp, Move, [Wind|Tail], NewState) :-
	flipSlots(State, Plyr, Opp, Move, Wind, S),
	makeMove(S, Plyr, Opp, Move, Tail, NewState).
makeMove(State, _Plyr, _Opp, _Move, [], State).

flipSlots(State, Plyr, Opp, [X, Y], Wind, NewState) :-
	nextCoord([X, Y], Wind, [Xi, Yi]),
	get(State, [Xi, Yi], Slot),
	(
		((Slot = Opp),  % Opponent found, should flip.
		set(State, S, [Xi, Yi], Plyr), % Make flip.
		flipSlots(S, Plyr, Opp, [Xi, Yi], Wind, NewState)) % Keep going
	;
		NewState = State
	).


% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%nextState(Plyr,Move,State,NewState,NextPlyr)%%%%%%%%%%%%%%%%%%%%
%%
%% define nextState(Plyr,Move,State,NewState,NextPlyr).
%   - given that Plyr makes Move in State, it determines NewState (i.e. the next
%     state) and NextPlayer (i.e. the next player who will move).
nextState(Plyr, [X, Y], State, NewState, NextPlyr) :-
	makeMove(State, Plyr, [X, Y], NewState),
	getOpponent(Plyr, Opp),
	\+terminal(NewState),
	(moves(Opp, NewState, []) ->
		NextPlyr = Plyr
	;
		NextPlyr = Opp).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%validmove(Plyr,State,Proposed)%%%%%%%%%%%%%%%%%%%%
%%
%% define validmove(Plyr,State,Proposed).
%   - true if Proposed move by Plyr is valid at State.
validmove(Plyr, State, Proposed) :-
	moves(Plyr, State, MvList),
	member(Proposed, MvList), !.

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%h(State,Val)%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define h(State,Val).
%   - given State, returns heuristic Val of that state
%   - larger values are good for Max, smaller values are good for Min
%   NOTE1. If State is terminal h should return its true value.
%   NOTE2. If State is not terminal h should be an estimate of
%          the value of state (see handout on ideas about
%          good heuristics.





% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%lowerBound(B)%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define lowerBound(B).
%   - returns a value B that is less than the actual or heuristic value
%     of all states.





% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%upperBound(B)%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% define upperBound(B).
%   - returns a value B that is greater than the actual or heuristic value
%     of all states.





% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                       %
%                                                                       %
%                Given   UTILITIES                                      %
%                   do NOT change these!                                %
%                                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get(Board, Point, Element)
%    : get the contents of the board at position column X and row Y
% set(Board, NewBoard, [X, Y], Value):
%    : set Value at column X row Y in Board and bind resulting grid to NewBoard
%
% The origin of the board is in the upper left corner with an index of
% [0,0], the upper right hand corner has index [5,0], the lower left
% hand corner has index [0,5], the lower right hand corner has index
% [5,5] (on a 6x6 board).
%
% Example
% ?- initBoard(B), showState(B), get(B, [2,3], Value).
%. . . . . .
%. . . . . .
%. . 1 2 . .
%. . 2 1 . .
%. . . . . .
%. . . . . .
%
%B = [['.', '.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.', '.'],
%     ['.', '.', 1, 2, '.', '.'], ['.', '.', 2, 1, '.'|...],
%     ['.', '.', '.', '.'|...], ['.', '.', '.'|...]]
%Value = 2
%Yes
%?-
%
% Setting values on the board
% ?- initBoard(B),  showState(B),set(B, NB1, [2,4], 1),
%         set(NB1, NB2, [2,3], 1),  showState(NB2).
%
% . . . . . .
% . . . . . .
% . . 1 2 . .
% . . 2 1 . .
% . . . . . .
% . . . . . .
%
% . . . . . .
% . . . . . .
% . . 1 2 . .
% . . 1 1 . .
% . . 1 . . .
% . . . . . .
%
%B = [['.', '.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.', '.'], ['.', '.',
%1, 2, '.', '.'], ['.', '.', 2, 1, '.'|...], ['.', '.', '.', '.'|...], ['.', '.',
% '.'|...]]
%NB1 = [['.', '.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.', '.'], ['.', '.'
%, 1, 2, '.', '.'], ['.', '.', 2, 1, '.'|...], ['.', '.', 1, '.'|...], ['.', '.
%', '.'|...]]
%NB2 = [['.', '.', '.', '.', '.', '.'], ['.', '.', '.', '.', '.', '.'], ['.', '.'
%, 1, 2, '.', '.'], ['.', '.', 1, 1, '.'|...], ['.', '.', 1, '.'|...], ['.',
%'.', '.'|...]]

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% get(Board, Point, Element): get the value of the board at position
% column X and row Y (indexing starts at 0).
% Do not change get:

get( Board, [X, Y], Value) :-
	nth0( Y, Board, ListY),
	nth0( X, ListY, Value).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% set( Board, NewBoard, [X, Y], Value): set the value of the board at position
% column X and row Y to Value (indexing starts at 0). Returns the new board as
% NewBoard. Do not change set:

set( [Row|RestRows], [NewRow|RestRows], [X, 0], Value) :-
	setInList(Row, NewRow, X, Value).

set( [Row|RestRows], [Row|NewRestRows], [X, Y], Value) :-
	Y > 0,
	Y1 is Y-1,
	set( RestRows, NewRestRows, [X, Y1], Value).

% DO NOT CHANGE THIS BLOCK OF COMMENTS.
%
% setInList( List, NewList, Index, Value): given helper to set. Do not
% change setInList:

setInList( [_|RestList], [Value|RestList], 0, Value).

setInList( [Element|RestList], [Element|NewRestList], Index, Value) :-
	Index > 0,
	Index1 is Index-1,
	setInList( RestList, NewRestList, Index1, Value).
