%% 170816:5

append2([],L2,L2).
append2([H|T],L2,[H|L4]) :- append2(T,L2,L4).

%% ?- append2(X,Y,[1,2,3]).
%% X = [],
%% Y = [1, 2, 3] ;
%% X = [1],
%% Y = [2, 3] ;
%% X = [1, 2],
%% Y = [3] ;
%% X = [1, 2, 3],
%% Y = [] ;
%% false.

concat2([],[]).
concat2([H|T],L) :- concat2(T,L1), append2(H,L1,L).


%% ?- concat2([],B).
%% B = [].
%%
%% ?- concat2([[],[1,2],[3,4]],B).
%% B = [1, 2, 3, 4].
%%
%% ?- 


%% 170816:6

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


%% 170816:7 

pack(AvailableBags, SuitcaseVolume, BagsPacked):-
    findall(Combination, combinations(AvailableBags, Combination), CombList),
    cleanup(CombList, SuitcaseVolume, CleanCombList),
    findbest(CleanCombList, SuitcaseVolume, [], BagsPacked).

combinations([],[]).
combinations([Volume|Volumes],[Volume|Set]) :- combinations(Volumes, Set).
combinations([_|Volumes],Set) :- combinations(Volumes, Set).

cleanup([], _,[]).
cleanup([H | T ], SuitcaseVolume, List) :-
    cleanup(T, SuitcaseVolume, List1),
    (sum_list(H, HSum), HSum =< SuitcaseVolume -> List = [H|List1];
     List = List1).

findbest([], _, InitialBest, InitialBest).
findbest([H | T], SuitcaseVolume, InitialBest, BestSoFar) :-
    findbest(T, SuitcaseVolume, InitialBest, NewBestSoFar),
    sum_list(H, HSum), 
    sum_list(NewBestSoFar, NRSum), 
    (HSum > NRSum -> BestSoFar = H;
     BestSoFar = NewBestSoFar).

%% sum_list is built-in but should have been coded in a solution
