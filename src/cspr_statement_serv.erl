-module(cspr_statement_serv).

-behaviour(gen_server).

-export([start_link/0, currentPrice/0,transaction/1,reward/1]).

%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-record(state, {}).



% API's to manipulate with data


start_link() ->
    gen_server:start_link({global, ?MODULE}, ?MODULE, [], []).

currentPrice() ->
    gen_server:call({global, ?MODULE}, {currentprice}).

transaction(Address) ->
    gen_server:call({global, ?MODULE}, {transaction, Address}).

reward(Address) ->
    gen_server:call({global, ?MODULE}, {reward, Address}).

% Callback functions

init([]) ->
    io:format("ssl: ~w \n", [ssl:start()]),
    io:format("inets: ~w \n", [application:start(inets)]),
    
    {ok, #state{}}.

handle_call({transaction, Address}, _From, State) ->
    {reply, cspr_statement_logic:transaction(Address), State}

;handle_call({reward, Address}, _From, State) ->
    {reply, cspr_statement_logic:reward(Address), State}

;handle_call({currentprice}, _From, State) ->
    {reply, cspr_statement_logic:currentPrice(), State}

;handle_call(_Request, _From, State) ->
    {reply, ignored, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.