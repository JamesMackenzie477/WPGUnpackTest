-- 미션 실패 처리
winning_rule_for_timeout = "eden"
winning_rule_for_death = "eden"

function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group.xml'
	wave_group_name = 'sg_pve_single_airport1'
	respawn = "on"
	respawn_delay = 5000
	respawn_key_input_delay = 5000
	force_respawn = 5000
	no_damage_time = 3000
	-- player_health_regeneration = 500 -- 플레이어 회복량 증가
	game_start_countdown = 0 -- 게임 시작 시 카운트다운 시간
	game_pre_loading_countdown = 120000
	game_limit_time = 300000
	score_per_kill		=	0
	force_team_id = "naf"
	show_npc_debug_info = true
	contribution_point_rate = 2
	finish_game_after_all_die = "false"
	teammatch = "false"
	
	lua_call_lastcam_control(0, 0, 0, 0, 0)
	lua_call_load_resource("ani\\drone\\orcacarrier\\boxm01_entry.bea")
	lua_call_load_resource("ani\\drone\\orcacarrier\\boxm01_return.bea")
	lua_call_load_resource("ani\\drone\\orcacarrier\\boxm01_wait.bea")
	lua_call_load_resource("ani\\drone\\orcacarrier\\orcam01_entry.bea")
	lua_call_load_resource("ani\\drone\\orcacarrier\\orcam01_return.bea")
	lua_call_load_resource("ani\\drone\\orcacarrier\\orcam01_wait.bea")
	
	lua_call_load_ui("hudsingle")
	lua_call_result_score_ui(0)
	
end

function select_loadout()
    start_single_mission_1()
	-- show_start_msg()
end

-- function show_start_msg()
	-- msg_name = "2025-09-05"
	-- message_white = string.format("<font color='#FFFFFF' size='30'>%s</font>", msg_name )
	-- lua_call_show_debug_info ( message_white, 50, 1, 0, 0, 320, 0, 0, 0, 255  )
-- end

function prepare_round()
	start_single_mission_1()
	lua_call_set_observer_cam( "start_cam" )
end

function prepare_round_server()
	-- 미션 성공 처리
	lua_call_add_team_score( 0, 1 )
	start_single_mission_1()
end

function countdown()
	lua_call_active_trigger( "main_start_mis1")
		-- 체크 포인트 켬
	lua_call_set_enable_trigger_object( "t_check1", 1 )
	lua_call_set_enable_trigger_object( "t_check2", 1 )
	lua_call_set_enable_trigger_object( "t_check3", 1 )
	lua_call_set_enable_trigger_object( "t_check4", 1 )
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

function start_single_mission_1() -- 싱글 미션1에 필요한 명령 실행
	lua_call_set_enable_all_spawn_pos( 0 )
	lua_call_set_enable_spawn_pos( "mis1_sp01", 1 )	
	lua_call_set_enable_spawn_pos( "mis1_sp02", 1 )	
	lua_call_set_enable_spawn_pos( "mis1_sp03", 1 )	
	lua_call_set_enable_spawn_pos( "mis1_sp04", 1 )	
	--lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
	lua_call_set_name_tag_by_category("HUD_Enemy_NPC", 1, 1, 1, 15000, 0)
	
	-- PVE 싱글 미션 옵션 오브젝트 켬
	lua_call_set_visible_object( "mis_obj_01", 1 )
	lua_call_set_visible_object( "mis_obj_02", 1 )
	lua_call_set_visible_object( "mis_obj_03", 1 )
	lua_call_set_visible_object( "mis_obj_04", 1 )
	lua_call_set_visible_object( "mis_obj_05", 1 )
	lua_call_set_visible_object( "mis_obj_06", 1 )
	lua_call_set_visible_object( "mis_obj_07", 1 )
	lua_call_set_visible_object( "mis_obj_08", 1 )
	lua_call_set_visible_object( "mis_obj_09", 1 )
	lua_call_set_visible_object( "mis_obj_10", 1 )
	lua_call_set_visible_object( "mis_obj_11", 1 )
	lua_call_set_visible_object( "mis_obj_12", 1 )
	lua_call_set_visible_object( "mis_obj_13", 1 )
	lua_call_set_visible_object( "mis_obj_14", 1 )
	lua_call_set_visible_object( "mis_obj_15", 1 )
	lua_call_set_visible_object( "mis_obj_16", 1 )
	lua_call_set_visible_object( "mis_obj_17", 1 )
	lua_call_set_visible_object( "mis_obj_18", 1 )
	lua_call_set_visible_object( "mis_obj_19", 1 )
	lua_call_set_visible_object( "mis_obj_20", 1 )
	lua_call_set_visible_object( "orca_body", 1 )
	lua_call_set_visible_object( "orca_box", 1 )
	-- PVE 싱글 미션 옵션 엔티티 켬
	lua_call_set_enable_entity( "mis_ent_01", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_02", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_03", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_04", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_05", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_06", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_07", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_08", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_09", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_10", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_11", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_12", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_13", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_14", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_15", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_16", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_17", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_18", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_19", 1 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_20", 1 , "start_mis1")
	

end

