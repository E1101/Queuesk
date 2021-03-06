-module(queuesk_pool_sup).
-behaviour(supervisor).

-export([start_link/0,
	 add_scheduler/1,
	 init/1]).

%%===================================================================
%% Supervisor API
%%===================================================================

%%--------------------------------------------------------------------
%% start_link
%%--------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%--------------------------------------------------------------------
%% add_scheduler
%%--------------------------------------------------------------------
add_scheduler(Queue) ->
    supervisor:start_child(?MODULE, [Queue]).

%%===================================================================
%% Supervisor Callbacks
%%===================================================================

%%--------------------------------------------------------------------
%% init
%%--------------------------------------------------------------------
init([]) ->
    {ok, {{simple_one_for_one, 5, 10},
	  [
	   {queuesk_pool_scheduler,
	    {queuesk_pool_scheduler, start_link, []},
	    permanent,
	    3000,
	    worker,
	    [queuesk_pool_scheduler]}
	  ]}}.
