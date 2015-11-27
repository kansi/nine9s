%%%-------------------------------------------------------------------
%% @doc nine9s top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module('nine9s_sup').

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

-define(CHILD(Id, Mod, Args, Restart, Type), {Id, {Mod, start_link, Args},
                                              Restart, 60000, Type, [Mod]}).


%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    State_Handler = ?CHILD(state_handler, state_handler, [], transient, worker),
    {ok, { {one_for_all, 0, 1}, [State_Handler]} }.


%%====================================================================
%% Internal functions
%%====================================================================
