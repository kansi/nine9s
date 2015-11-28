%%%-------------------------------------------------------------------
%% @doc nine9s public API
%% @end
%%%-------------------------------------------------------------------

-module('nine9s_app').

-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

-export([set_routes_new/0
        ,set_routes_old/0
        ]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([{'_', get_new_routes()}]),
    {ok, _}  = cowboy:start_http(http, 10, [{port, 9090}], 
                                 [{env, [{dispatch, Dispatch}]}]),

    'nine9s_sup':start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.


get_new_routes() ->
    [{"/count", count_handler, []}] ++ get_old_routes().

get_old_routes() ->
    [{"/", default_handler, []}].

%%====================================================================
%% upgrade functions
%%====================================================================
set_routes_new() ->
    CompileRoutes = cowboy_router:compile([{'_', get_new_routes() }]),
    cowboy:set_env(http, dispatch, CompileRoutes).


set_routes_old() ->
    CompileRoutes = cowboy_router:compile([{'_', get_old_routes() }]),
    cowboy:set_env(http, dispatch, CompileRoutes).    


%%====================================================================
%% Internal functions
%%====================================================================
