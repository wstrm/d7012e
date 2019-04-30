/* vim: set syntax=prolog */

 :- use_module(library(http/thread_httpd)).
 :- use_module(library(http/http_dispatch)).

 :- http_handler(root(hello_world), say_hi, []).

 server(Port) :-
	 http_server(http_dispatch, [port(Port)]).

 say_hi(_Request) :-
	 format('Content-Type: text/plain~n~n'),
	 format('Hello World!~n').
