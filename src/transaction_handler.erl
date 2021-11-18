-module(transaction_handler).
-behaviour(cowboy_handler).
-export([init/2]).


init(Req0, State) ->
    #{bindings := #{address := Address}} = Req0,
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"application/json">>},
        transaction_handeler_logic(Address),
        Req0),
    {cowboy_rest, Req, State}.

transaction_handeler_logic(Address) ->
    Lst = binary_to_list(Address),
    {ok, {_,_,Docode}} = cspr_statement_serv:transaction(Lst),
    list_to_binary(lists:flatten(io_lib:format("~s", [Docode]))).