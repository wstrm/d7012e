%% 171018: 6

select(_,[],[]).
select(X, [X|Xs], Xs).
select(X, [Y|Ys], [Y|Zs]) :- select(X, Ys, Zs).

pickTwoDifferent(L,E1,E2) :-
    select(E1,L,L1),select(E2,L1,_),\+E1=E2.
    

%% 171018: 7

c(0).  % change these to see how p1, p2, p3, p4 are effected
a(1).
b(1).

p1 :- a(1), b(1).
p1 :- c(1).

p2 :- a(1), !, b(1).
p2 :- c(1).

p3 :- c(1).
p3 :- a(1), !, b(1).

p4 :- !, c(1).
p4 :- a(1), b(1).


%% 171018: 8


subLists(L,R) :- findall(X,combinations(L,X),R).

combinations([],[]).
combinations([V|Vs],[V|S]) :- combinations(Vs, S).
combinations([_|Vs],S) :- combinations(Vs, S).

keep([],_,[]).
keep([H|T],Max,R) :- 
    keep(T,Max,R2),
    sum_list(H,S),
    (S =< Max -> R = [H | R2]; R = R2).

%% sum_list is built-in but should have been coded in a solution
