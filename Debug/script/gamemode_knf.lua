-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	round_time = 120000
	round_restart_delay  = 5000
	respawn="off"
	round_mode="on"
	teammatch = "true"
	drone_timer_decrease_rate = 200
	swap_spawn_pos="on"
	exist_team_score="yes"
	game_wait_buffer_time = 20000
	drone_delay=10000
	respawn_key_input_delay = 3000
	contribution_point_rate = 2
	
	-- PVP 모드에서 싱글미션 스폰 끄기
	lua_call_set_enable_all_spawn_pos( 1 )
	lua_call_set_enable_spawn_pos( "mis1_sp01", 0 )	
	lua_call_set_enable_spawn_pos( "mis1_sp02", 0 )	
	lua_call_set_enable_spawn_pos( "mis1_sp03", 0 )	
	lua_call_set_enable_spawn_pos( "mis1_sp04", 0 )	
	lua_call_set_enable_spawn_pos( "mis2_sp01", 0 )	
	lua_call_set_enable_spawn_pos( "mis2_sp02", 0 )	
	lua_call_set_enable_spawn_pos( "mis2_sp03", 0 )	
	lua_call_set_enable_spawn_pos( "mis2_sp04", 0 )	
	
	lua_call_set_team_role( "NAF", "knife_player" )
	lua_call_set_team_role( "EDEN", "knife_player" )
	-- 라스트캠 옵션 lua_call_lastcam_control ( [캠 재생여부],[캠 재생시간], [슬로모션 시작점], [슬로모션 종료점], [슬로모션 재생속도] 
	--lua_call_lastcam_control(1, 7000, 6000, 6500, 40)
	lua_call_load_ui("hudknf")
end	

function select_loadout()
end

function prepare_round()
	lua_call_set_observer_cam( "start_cam" )
end

function prepare_round_server()
end

function countdown()
end

function game_end()
end

function winning_shot()
end

function end_score_board()
end

function half_time()
end

function winner_ceremony()
end

function round_time_out( team_1, team_2 )
	if team_1.alive_count > team_2.alive_count
	then
		return 0	-- Team1 승리
	end
	if team_1.alive_count < team_2.alive_count
	then
		return 1	-- Team2 승리
	end
	return 2
end

function check_over_exp( total_get_exp, get_exp )
	if total_get_exp > 400
	then
		get_exp = math.pow( 400 / ( total_get_exp + get_exp ), 3.5 ) * get_exp
	end
	
	return get_exp
end

-- function random_spawn_pos ()
	-- local spawn_pos = math.random( 1, 3)
	-- if spawn_pos == 1 then
		-- spawn_pos_a ()
	-- elseif spawn_pos == 2 then
		-- spawn_pos_b ()
	-- else
		-- spawn_pos_c ()
	-- end
-- end

-- function spawn_pos_a ()
	-- lua_call_set_enable_all_spawn_pos( 0 )	
	-- lua_call_set_enable_spawn_pos( "naf_a1", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_a2", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_a3", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_a4", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_a5", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_a6", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_a7", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_a8", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_a1", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_a2", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_a3", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_a4", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_a5", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_a6", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_a7", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_a8", 1 )	
-- end

-- function spawn_pos_b ()
	-- lua_call_set_enable_all_spawn_pos( 0 )	
	-- lua_call_set_enable_spawn_pos( "naf_b1", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_b2", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_b3", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_b4", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_b5", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_b6", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_b7", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_b8", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_b1", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_b2", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_b3", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_b4", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_b5", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_b6", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_b7", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_b8", 1 )	
-- end

-- function spawn_pos_c ()
	-- lua_call_set_enable_all_spawn_pos( 0 )	
	-- lua_call_set_enable_spawn_pos( "naf_c1", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_c2", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_c3", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_c4", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_c5", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_c6", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_c7", 1 )	
	-- lua_call_set_enable_spawn_pos( "naf_c8", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_c1", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_c2", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_c3", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_c4", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_c5", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_c6", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_c7", 1 )	
	-- lua_call_set_enable_spawn_pos( "eden_c8", 1 )	
-- end
