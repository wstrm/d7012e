count(_, [], 0).
count(E, [H|Tl], N):-
	E=H,
	!,
	count(E, Tl, M),
	N is M +1.
count(E, [_|Tl], N):-
	count(E, Tl, N).