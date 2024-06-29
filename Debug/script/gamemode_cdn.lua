round_time = 120000
round_restart_delay  = 5000
game_pre_loading_countdown = 30000
respawn="off"
round_mode="on"
teammatch = "true"

function init_mode()
end

function start_round_mode()
end

function start_round_mode_server()
	random_spawn_pos ()
end

function start_round_mode_client()
end

function random_spawn_pos ()
	local spawn_pos = math.random( 1, 3)
	if spawn_pos == 1 then
		spawn_pos_a ()
	elseif spawn_pos == 2 then
		spawn_pos_b ()
	else
		spawn_pos_c ()
	end
end

function spawn_pos_a ()
	lua_call_set_enable_all_spawn_pos( 0 )	
	lua_call_set_enable_spawn_pos( "naf_a1", 1 )	
	lua_call_set_enable_spawn_pos( "naf_a2", 1 )	
	lua_call_set_enable_spawn_pos( "naf_a3", 1 )	
	lua_call_set_enable_spawn_pos( "naf_a4", 1 )	
	lua_call_set_enable_spawn_pos( "naf_a5", 1 )	
	lua_call_set_enable_spawn_pos( "naf_a6", 1 )	
	lua_call_set_enable_spawn_pos( "naf_a7", 1 )	
	lua_call_set_enable_spawn_pos( "naf_a8", 1 )	
	lua_call_set_enable_spawn_pos( "eden_a1", 1 )	
	lua_call_set_enable_spawn_pos( "eden_a2", 1 )	
	lua_call_set_enable_spawn_pos( "eden_a3", 1 )	
	lua_call_set_enable_spawn_pos( "eden_a4", 1 )	
	lua_call_set_enable_spawn_pos( "eden_a5", 1 )	
	lua_call_set_enable_spawn_pos( "eden_a6", 1 )	
	lua_call_set_enable_spawn_pos( "eden_a7", 1 )	
	lua_call_set_enable_spawn_pos( "eden_a8", 1 )	
end

function spawn_pos_b ()
	lua_call_set_enable_all_spawn_pos( 0 )	
	lua_call_set_enable_spawn_pos( "naf_b1", 1 )	
	lua_call_set_enable_spawn_pos( "naf_b2", 1 )	
	lua_call_set_enable_spawn_pos( "naf_b3", 1 )	
	lua_call_set_enable_spawn_pos( "naf_b4", 1 )	
	lua_call_set_enable_spawn_pos( "naf_b5", 1 )	
	lua_call_set_enable_spawn_pos( "naf_b6", 1 )	
	lua_call_set_enable_spawn_pos( "naf_b7", 1 )	
	lua_call_set_enable_spawn_pos( "naf_b8", 1 )	
	lua_call_set_enable_spawn_pos( "eden_b1", 1 )	
	lua_call_set_enable_spawn_pos( "eden_b2", 1 )	
	lua_call_set_enable_spawn_pos( "eden_b3", 1 )	
	lua_call_set_enable_spawn_pos( "eden_b4", 1 )	
	lua_call_set_enable_spawn_pos( "eden_b5", 1 )	
	lua_call_set_enable_spawn_pos( "eden_b6", 1 )	
	lua_call_set_enable_spawn_pos( "eden_b7", 1 )	
	lua_call_set_enable_spawn_pos( "eden_b8", 1 )	
end

function spawn_pos_c ()
	lua_call_set_enable_all_spawn_pos( 0 )	
	lua_call_set_enable_spawn_pos( "naf_c1", 1 )	
	lua_call_set_enable_spawn_pos( "naf_c2", 1 )	
	lua_call_set_enable_spawn_pos( "naf_c3", 1 )	
	lua_call_set_enable_spawn_pos( "naf_c4", 1 )	
	lua_call_set_enable_spawn_pos( "naf_c5", 1 )	
	lua_call_set_enable_spawn_pos( "naf_c6", 1 )	
	lua_call_set_enable_spawn_pos( "naf_c7", 1 )	
	lua_call_set_enable_spawn_pos( "naf_c8", 1 )	
	lua_call_set_enable_spawn_pos( "eden_c1", 1 )	
	lua_call_set_enable_spawn_pos( "eden_c2", 1 )	
	lua_call_set_enable_spawn_pos( "eden_c3", 1 )	
	lua_call_set_enable_spawn_pos( "eden_c4", 1 )	
	lua_call_set_enable_spawn_pos( "eden_c5", 1 )	
	lua_call_set_enable_spawn_pos( "eden_c6", 1 )	
	lua_call_set_enable_spawn_pos( "eden_c7", 1 )	
	lua_call_set_enable_spawn_pos( "eden_c8", 1 )	
end
