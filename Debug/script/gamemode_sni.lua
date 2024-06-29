-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	round_time = 120000
	round_restart_delay  = 5000
	respawn="off"
	round_mode="on"
	teammatch = "true"
	contribution_point_rate = 2
	swap_spawn_pos="on"
	exist_team_score="yes"
	game_wait_buffer_time = 20000
	drone_delay=10000
	respawn_key_input_delay = 3000
	drone_timer_decrease_rate_attack = 200 -- 공격 계열 획득 점수
	drone_timer_decrease_rate_operation = 200 -- 작전 계열 획득 점수
	
	lua_call_set_team_role( "NAF", "sniper_player" )
	lua_call_set_team_role( "EDEN", "sniper_player" )
	-- 라스트캠 옵션 lua_call_lastcam_control ( [캠 재생여부],[캠 재생시간], [슬로모션 시작점], [슬로모션 종료점], [슬로모션 재생속도] 
	lua_call_lastcam_control(1, 7000, 6000, 6500, 40)
	
	force_loadout = 1 -- 1번 로드아웃으로 강제 설정한다
	lua_call_load_ui("hudsni")
end

function select_loadout()
end

function prepare_round()
end

function prepare_round_server()
end

function prepare_round_client()
	lua_call_set_observer_cam( "start_cam" )
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