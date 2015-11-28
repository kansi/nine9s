-module(count_handler).
-export([init/2]).

init(Req, Opts) ->
    Count = state_handler:get_hello_world_count(),
    BCount = integer_to_binary(Count),
    Req2 = cowboy_req:reply(200, [ {<<"content-type">>, 
                                    <<"text/plain">>} ], 
                            BCount, Req), 
    {ok, Req2, Opts}.
