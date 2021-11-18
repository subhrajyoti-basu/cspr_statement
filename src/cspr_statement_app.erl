%%%-------------------------------------------------------------------
%% @doc cspr_statement public API
%% @end
%%%-------------------------------------------------------------------

-module(cspr_statement_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/transaction/:address", transaction_handler, []},
                {"/rewards/:address", rewards_handler, []},
                {"/currentprice", cprice_handler, []}            
            ]}
    ]),
    {ok, _} = cowboy:start_clear(my_http_listener,
        [{port, 8080}],
        #{env => #{dispatch => Dispatch}}
    ),
    cspr_statement_serv:start_link(),
    cspr_statement_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
