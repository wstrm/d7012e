% u2

% P4(X):-P1(X),!,P2(X).
% P4(X):-P3(X),P2(X).

% u3

conc([], L, L).
conc([X | L1], L2, [X | L3]):-
  conc(L1, L2, L3).

backtrack1(X,Y):-member(Z,[[1,2],[]]),conc(X,Y,Z).
backtrack2(X,Y):-member(Z,[[1,2],[]]),!,conc(X,Y,Z).

% u5

findValue(_,0,[]).
findValue(L,V,[X | RL]):-
	member(X,L),
	NewV is V-X,
	NewV >= 0,
	findValue(L,NewV,RL).

shortestList([H|Tl],R):-shortestList_([H|Tl],H,R).

shortestList_([], SL, SL).
shortestList_([H | Tl], SL, RL):-
	length(H,X),
	length(SL,Y),
	X<Y,
	!,
	shortestList_(Tl,H, RL).
shortestList_([_|Tl], SL, RL):-
	shortestList_(Tl, SL, RL).
	
exchange(L,V,Exchange):-
	findall(X,findValue(L,V,X),All),
	!,
	shortestList(All,Exchange).
	