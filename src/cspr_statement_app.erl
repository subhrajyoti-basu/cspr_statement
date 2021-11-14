%%%-------------------------------------------------------------------
%% @doc cspr_statement public API
%% @end
%%%-------------------------------------------------------------------

-module(cspr_statement_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    cspr_statement_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
