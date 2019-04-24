:-consult(prime).

prime2(M,N):-
	prime(K),
	(
		(K>M,!,fail)
		;
		(K=N)
	).

%prime2(_,N):-
%	prime(N).

goldbach(N, X,Y):-
	prime2(N,X),
	prime2(N,Y),
	N is X+Y.
	
primetest(M,N):-
	prime(N),
	N<M.