-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group.xml'
	wave_group_name = 'sg_pvp_takeover'
	game_limit_time = 600000
	game_pre_loading_countdown = 15000
	no_damage_time = 3000 -- 플레이어가 스폰 시 무적시간
	no_damage_time_npc = 0 -- NPC가 스폰 시 무적시간
	respawn_delay = 3000
	respawn_key_input_delay = 3000
	force_respawn = 3000
	score_per_kill		=	0
	resurrection_on_restart_round = "false" -- 라운드 종료 시, 부활되지 않음.
	resurrection_on_restart_wave = "false" -- 웨이브 종료 시, 부활되지 않음.
	-- show_npc_debug_info = false	
    lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
    lua_call_set_name_tag_by_category("HUD_Enemy_NPC", 1, 1, 1, 15000, 0)
	
	lua_call_load_ui("hudtake")
	
	-- 라스트캠 옵션 lua_call_lastcam_control ( [캠 재생여부],[캠 재생시간], [슬로모션 시작점], [슬로모션 종료점], [슬로모션 재생속도] 
	lua_call_lastcam_control(1, 7000, 6000, 6500, 40)
end

function select_loadout()
end

function prepare_round()
	lua_call_show_metalreaper_hp(false);
end

function prepare_round_server()
	lua_call_set_enable_entity( "hud_take_a", 1 , "start_take")
	lua_call_set_enable_entity( "hud_take_b", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_c", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_e", 0 , "start_take")
end

function countdown()
	lua_call_active_trigger( "main_start_take")
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

function check_complete_spawn_first_time( play_time )
	if play_time > 14000
	then
		return 1
	end
	return 0
end

function sentinel_spawn_first()
	lua_call_show_banner( 30, user_index )
end

function metalreaper_spawn_1()
	lua_call_set_enable_entity( "hud_take_c", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_e", 1 , "start_take")
	lua_call_show_banner( 27, user_index )
	lua_call_show_metalreaper_hp(true);
end

function metalreaper_spawn_2()
	lua_call_show_banner( 29, user_index )	
end

function sentinel_spawn_a_1()
	lua_call_set_enable_entity( "hud_take_e", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_a", 1 , "start_take")
	lua_call_show_banner( 28, user_index )
end

function sentinel_spawn_a_2()
	lua_call_show_banner( 30, user_index )
end

function sentinel_spawn_b_1()
	lua_call_set_enable_entity( "hud_take_a", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_b", 1 , "start_take")
	lua_call_show_banner( 28, user_index )
end

function sentinel_spawn_b_2()
	lua_call_show_banner( 30, user_index )
end

function sentinel_spawn_c_1()
	lua_call_set_enable_entity( "hud_take_b", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_c", 1 , "start_take")
	lua_call_show_banner( 28, user_index )
end

function sentinel_spawn_c_2()
	lua_call_show_banner( 30, user_index )
end

function spawn_zone_hud_control(spawn_zone, name)
	if(spawn_zone > 0) then
		lua_call_show_entity_hud_icon(name, true)
	else
		lua_call_show_entity_hud_icon(name, false)
	end
end

function spawn_zone_on_off(spawn_zone, npc)
	spawn_zone = spawn_zone + npc
	return spawn_zone;
end