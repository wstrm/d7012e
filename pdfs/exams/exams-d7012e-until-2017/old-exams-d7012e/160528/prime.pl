% P31 (**) Determine whether a given integer number is prime. 

% is_prime(P) :- P is a prime number
%    (integer) (+)

is_prime(2).
is_prime(3).
is_prime(P) :- integer(P), P > 3, P mod 2 =\= 0, \+ has_factor(P,3).  

% has_factor(N,L) :- N has an odd factor F >= L.
%    (integer, integer) (+,+)

has_factor(N,L) :- N mod L =:= 0.
has_factor(N,L) :- L * L < N, L2 is L + 2, has_factor(N,L2).

% added by bson

prime_(2).
prime_(N):-
	prime_(M),
	N is M+1.

prime(N):-
	prime_(N),
	is_prime(N).
	
%broken:
%strange(N):-!,goldbach(N). %broken
%strange(N):-N<100,prime(N).
%strange(N):-N>1000,prime(N).