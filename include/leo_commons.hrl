%%======================================================================
%%
%% LeoFS Commons
%%
%% Copyright (c) 2012
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% ---------------------------------------------------------------------
%% Leo Commons -  Constant/Macro/Record
%%
%%======================================================================
-author('Yosuke Hara').
-vsn('0.9.1').

%% records.
%% -record(directories, {
%%           log    = "" :: string(),
%%           mnesia = "" :: string()
%%          }).

-record(cluster_node_status, {
          type                :: gateway | storage,
          version = ""        :: string(),
          dirs    = []        :: list(),
          avs     = []        :: list(), %% [{dir, # of avs}]
          num_of_read_metas   :: integer(),
          disk_sync_interval  :: integer(),
          ring_checksum       :: string(),
          statistics          :: record()
         }).

-record(system_conf, {
          version = 0         :: integer(),
          n       = 1         :: integer(),
          r       = 1         :: integer(),
          w       = 1         :: integer(),
          d       = 1         :: integer(),
          bit_of_ring = 128   :: integer()
         }).


%% macros.
-define(env_log_dir(ServerType),
        case application:get_env(ServerType, log_dir) of
            {ok, EnvLogDir} -> EnvLogDir;
            _ -> "log"
        end).

-define(env_listening_port(ServerType),
        case application:get_env(ServerType, port) of
            {ok, EnvListeningPort} -> EnvListeningPort;
            _ -> 10010
        end).

-define(env_num_of_acceptors(ServerType),
        case application:get_env(ServerType, num_of_acceptors) of
            {ok, EnvNumOfAcceptors} -> EnvNumOfAcceptors;
            _ -> 3
        end).

-define(env_manager_nodes(ServerType),
        case application:get_env(ServerType, managers) of
            {ok, EnvManagerNode} -> EnvManagerNode;
            _ ->
                %% for test-case.
                {ok, CHostname} = inet:gethostname(),
                NewCHostname = "manager_0@" ++ CHostname,
                [NewCHostname]
        end).

-define(env_queue_dir(ServerType),
        case application:get_env(ServerType, queue_dir) of
            {ok, EnvQueueDir} -> EnvQueueDir;
            _ -> "queue"
        end).

-define(env_log_level(ServerType),
        case application:get_env(ServerType, log_level) of
            {ok, EnvLogLevel} -> EnvLogLevel;
            _ -> 0
        end).

-define(S3_DEFAULT_ENDPOINT, "s3.amazonaws.com").

