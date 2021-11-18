%%%-----------------------------------------------------------------------------
%%% @title cspr_statement_logic
%%% @doc
%%%
%%% @author Subhrajyoti
%%% @copyright <COPY_WRITE>
%%% @version 0.0.1
%%% @end
%%%-----------------------------------------------------------------------------

-module(cspr_statement_logic).
-author(subhrajyoti).

%%%=============================================================================
%%% Exports and Definitions
%%%=============================================================================
-export([currentPrice/0, transaction/1,reward/1,temp/1]).
-define(SERVER, ?MODULE).

%%%=============================================================================
%%% API
%%%=============================================================================
currentPrice() ->
    routeHandler({currentPrice}).

transaction(Address) ->
    routeHandler({transaction, Address}).

reward(Address) ->
    routeHandler({reward, Address}).

%%%===================================================================
%%% Internal functions
%%%===================================================================
routeHandler({currentPrice}) ->
    httpc:request(get,{"https://event-store-api-clarity-mainnet.make.services/rates/1/amount",[]},[],[])
;routeHandler({reward, Address}) ->
    httpc:request(get,{"https://event-store-api-clarity-mainnet.make.services/delegators/"++ Address ++"/rewards?with_amounts_in_currency_id=1&page=1&limit=100&order_direction=DESC",[]},[],[])
;routeHandler({transaction, Address}) ->
    httpc:request(get,{"https://event-store-api-clarity-mainnet.make.services/accounts/"++ Address ++"/transfers?page=1&limit=100&order_direction=DESC",[]},[],[]).

temp(Temp) -> 
    {ok,{_,_,C}} = Temp,
    D = jsx:decode(list_to_binary(C),[]),
    {ok,E} = maps:find(list_to_binary("pageCount"), D),
    E.


