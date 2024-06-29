function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group_test.xml'
	wave_group_name = 'sg_pve_single_mart2'
	respawn = "off"
	enable_revive = "true"
	revive_distance = 800
	revive_action_time = 3000
	drone_delay = 0
	site_object_prefix = "t_hud_"
	site_icon_prefix = "object"
	game_limit_time = 900000
	game_pre_loading_countdown = 30000
	score_per_kill		=	0
	force_team_id = "naf"
	show_npc_debug_info = true
	contribution_point_rate = 0.1
	finish_game_after_all_die = "true"
	teammatch = "false"
	install_time = 7000
	
	lua_call_load_ui("hudsingle")
	lua_call_result_score_ui(0)
end

function select_loadout()
	start_single_mission_3()
end

function prepare_round()
	start_single_mission_3()
end

function prepare_round_server()
    start_single_mission_3()
end

function countdown()
	lua_call_active_trigger( "main_start_mis3")
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

function start_single_mission_3() -- 싱글 미션2에 필요한 명령 실행
	lua_call_set_enable_all_spawn_pos( 0 )
	lua_call_set_enable_spawn_pos( "mis3_sp01", 1 )	
	lua_call_set_enable_spawn_pos( "mis3_sp02", 1 )	
	lua_call_set_enable_spawn_pos( "mis3_sp03", 1 )	
	lua_call_set_enable_spawn_pos( "mis3_sp04", 1 )	
	lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
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
	-- PVE 싱글 미션 옵션 엔티티 켬
	lua_call_set_enable_entity( "mis_ent_01", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_02", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_03", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_04", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_05", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_06", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_07", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_08", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_09", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_10", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_11", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_12", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_13", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_14", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_15", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_16", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_17", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_18", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_19", 1 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_20", 1 , "start_mis3")
end

function check_object_state( state, check_value )
	if state == tonumber( check_value )
	then
		return 1
	end
	return 0
end

function is_enable_user( owner_index, actor_index )
	if ( owner_index == actor_index )
	then
		return 1
	end
	return 0
end

function check_finish_install_time( stay_time, rate, press_time )
	if ( stay_time < (install_time) )
	then
		return 0
	end

	if ( press_time < ( install_time * rate ) )
	then
		return 0
	end
	
	return 1
end



