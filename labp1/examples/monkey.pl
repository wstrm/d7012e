% A solution to the problem "Monkey and Banana"
% From the prolog book by Ivan Bratko/in Håkan's slides
% Adapted by Håkan so it returns the actions in a list
% Note that there is no limit on the number of
% recursive steps

move( state( middle, onbox, middle, hasnot),
      grasp,
      state( middle, onbox, middle, has) ).

move( state( P, onfloor, P, H),
      climb,
      state( P, onbox, P, H) ).

move( state( P1, onfloor, P1, H),
      push( P1, P2),
      state( P2, onfloor, P2, H) ).

move( state( P1, onfloor, B, H),
      walk( P1, P2),
      state( P2, onfloor, B, H) ).

canget( state( _, _, _, has), [done| []]).

canget( State1, [Move| Trace2])  :-
    move( State1, Move, State2),
    canget( State2, Trace2).

% canget(state(atdoor,onfloor,atwindow,hasnot), R).
