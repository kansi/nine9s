-module(default_handler).
-export([init/2]).

init(Req, Opts) ->
    state_handler:hello_world(),
    Req2 = cowboy_req:reply(200, [ {<<"content-type">>, 
                                    <<"text/plain">>} ], 
                            <<"Hello world 2 !">>, Req), 
    {ok, Req2, Opts}.
