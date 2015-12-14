%% -*- mode: erlang; erlang-indent-level: 2 -*-
%%% Created :  9 Dec 2015 by mats cronqvist <masse@klarna.com>

%% @doc
%% @end

-module('fectors').
-author('mats cronqvist').
-export([go/1]).

go(N) ->
  recurs(N,[],N,fACS(N)).

fACS(1)-> [];
fACS(2)-> [2];
fACS(3)-> [3];
fACS(N)-> [N|[F || F <- lists:seq(2,N div 2), (N rem F) =:= 0]].

recurs(M,Stem,_,[]) ->
  case lists:foldl(fun(E,S) -> E*S end,1,Stem) =:= M of
    true -> [Stem];
    false -> []
  end;
recurs(M,Stem,N,[F|Factors]) ->
  recurs(M,[F|Stem],N div F,fACS(N div F))++recurs(M,Stem,N,Factors).
