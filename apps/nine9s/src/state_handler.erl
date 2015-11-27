-module(state_handler).

-behaviour(gen_server).

%% API functions
-export([
         hello_world/0,
         get_hello_world_count/0,
         start_link/0]).

%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-record(state, {count = 0}).

%%%===================================================================
%%% API functions
%%%===================================================================
hello_world() ->
    gen_server:cast(?MODULE, hello_world).

get_hello_world_count() ->
    gen_server:call(?MODULE, hello_world_count).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%%%===================================================================
%%% callback functions
%%%===================================================================
init([]) ->
    {ok, #state{}}.

handle_call(hello_world_count, _From, State) ->
    {reply, State#state.count, State};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(hello_world, State) ->
    Count = State#state.count,
    {noreply, State#state{count = Count + 1}};

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
