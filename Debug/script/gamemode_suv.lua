-- 미션 실패 처리
winning_rule_for_timeout = "draw"
winning_rule_for_death = "draw"

function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group.xml'
	wave_group_name = 'sg_pve_single_def_outpost2'
	respawn = "off"
	enable_revive = "true"
	revive_distance = 250 -- 살려주기 가능 거리
	revive_action_time = 3000 -- 살려주기 F키 유지 시간
	player_health_regeneration = 250 -- 플레이어 회복량 증가
	site_object_prefix = "t_hud_"
	site_icon_prefix = "object"
	game_limit_time = 9000000
	game_pre_loading_countdown = 40000
	score_per_kill		=	0
	force_team_id = "naf"
	show_npc_debug_info = true
	contribution_point_rate = 2
	finish_game_after_all_die = "true"
	lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
	lua_call_set_name_tag_by_category("HUD_Enemy_NPC", 1, 1, 1, 15000, 0)
	lua_call_lastcam_control(0, 0, 0, 0, 0)
	
	lua_call_load_ui("hudsuv")
	lua_call_result_score_ui(0)
	drone_timer_decrease_rate_attack = 0 -- 공격 계열 획득 점수
	drone_timer_decrease_rate_operation = 0 -- 작전 계열 획득 점수
end

function select_loadout()
    start_survival_1()
end

function prepare_round()
    start_survival_1()
	lua_call_set_observer_cam( "start_cam" )
end

function prepare_round_server()
	-- 미션 성공 처리
	lua_call_add_team_score( 0, 1 )
	start_survival_1()
end

function start_survival_1() -- 서바이벌에 필요한 명령 실행
	lua_call_set_enable_all_spawn_pos( 0 )
	lua_call_set_enable_spawn_pos( "suv_sp01", 1 )
	lua_call_set_enable_spawn_pos( "suv_sp02", 1 )
	lua_call_set_enable_spawn_pos( "suv_sp03", 1 )
	lua_call_set_enable_spawn_pos( "suv_sp04", 1 )
end

function countdown()
	lua_call_active_trigger( "main_start_suv1")
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