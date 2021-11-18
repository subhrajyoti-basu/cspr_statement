-module(cprice_handler).
-behaviour(cowboy_handler).
-export([init/2]).


init(Req0, State) ->
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        cprice_handeler_logic(),
        Req0),
    {ok, Req, State}.

cprice_handeler_logic() ->
    {ok, Docode} = cspr_statement_serv:currentPrice(),
    list_to_binary(lists:flatten(io_lib:format("~p", [Docode]))).