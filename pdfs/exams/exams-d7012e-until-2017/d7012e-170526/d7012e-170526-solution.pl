% 170526: 5

% some answers from students (some are not correct)
member2(X, [X | _]).
member2(X, [_ | T]) :- member2(X, T).


% 170526: 6

/*
a)  a and b and c

b)  (a and b)  or  c

c)  (a and b)  or  ((not a) and c)

d)  (a and b)  or  c
    =  c  or  (a and b)

e)  c  or  ((not c) and a and b)
    =  c  or  (a and b)
   (=  (a and b)  or  c)

f)  (a and b)  or  ((not(a and b)) and c)
    =  (a and b)  or  (((not a)  or  (not b)) and c)
    =  (a and b)  or  c
   (=  c  or  (a and b))
*/


% 170526: 7

findValue(_,0,[]).
findValue(L,V,[X | RL]) :-
    member(X,L),
    NewV is V-X,
    NewV >= 0, 
    findValue(L,NewV,RL).

shortestList([H|Tl],R):-shortestList_([H|Tl],H,R).
shortestList_([], SL, SL).
shortestList_([H | Tl], SL, RL) :- length(H,X), length(SL,Y), X<Y, !, shortestList_(Tl,H, RL).
shortestList_([_|Tl], SL, RL) :- shortestList_(Tl, SL, RL).
	
exchange(L,V,Exchange) :-
    findall(X,findValue(L,V,X),All),
    !,
    shortestList(All,Exchange).
