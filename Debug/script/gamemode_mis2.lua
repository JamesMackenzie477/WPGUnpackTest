--bomb_count_max = 3
--bomb_count_now = 0
--mission_ui_start_time = 13500
--mission_end_time = 100000 + mission_ui_start_time
--mission_add_time = 50000
--mission_warning_time = 20000
--COLOR_WHITE = "#FFFFFF"
--COLOR_RED = "#FF0000"
--COLOR_GREEN = "#00FF00"
--COLOR_BLUE = "#0000FF"
--COLOR_GREENBLUE = "#00FFFF"

-- 미션 실패 처리
winning_rule_for_timeout = "eden"
winning_rule_for_death = "eden"

function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group.xml'
	wave_group_name = 'sg_pve_single_mart1'
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
	install_time = 7000
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

--function output_mission_ui( game_time_val )
--	if game_time_val > mission_ui_start_time then
--		local msg
--		local message = ""
--		local message_back = ""
--		local font_color

--		for index = 1, bomb_count_max, 1 do
--			if bomb_count_now >= index then
--				msg = "(O)"
--				font_color = COLOR_GREEN
--			else
--				msg = "(-)"
--				font_color = COLOR_WHITE
--			end
--			msg = string.format("<font color='%s' size='50'>%s</font>", font_color, msg)
--			if index == 1 then
--				message = string.format("%s", msg)
--				message_back = string.format(" Bomb %s", index)
--			else
--				message = string.format("%s   %s", message, msg)
--				message_back = string.format("%s          Bomb %s", message_back, index)
--			end
--		end

--		lua_call_show_debug_info( message, 0.5, 1, 0, 0, 80, 0, 0, 0, 255 )
--		message_back = string.format("<font color='#969696' size='15'>%s </font>", message_back)
--		lua_call_show_debug_info( message_back, 0.5, 1, 0, 0, 135, 0, 0, 0, 255 )

--		local msg_time = mission_end_time - game_time_val
--		if msg_time <= 0 then
--			message = string.format("<font color='#FF00FF' size='100'>Mission Fail~!</font>")
--			lua_call_show_debug_info( message, 0.5, 1, 0, 0, 170, 0, 0, 0, 255 )
--		else			
--			if msg_time <= mission_warning_time then
--				font_color = COLOR_RED
--			else
--				font_color = COLOR_GREENBLUE
--			end
--			msg = string.format("<font color='%s' size='35'>%.1f</font>", font_color, msg_time / 1000)
--			message = string.format("<font color='#FFFFFF' size='25'>Limit Time : </font>%s<font color='#969696' size='15'> (sec)</font>", msg)
--			lua_call_show_debug_info( message, 0.5, 1, 0, 0, 170, 0, 0, 0, 255 )
--		end
--	end
--end

--function install_bomb_add_time( game_time_val )
--	local msg
--	local message

	--msg = string.format("Good Job~ Soldier~!")
	--message = string.format("<font color='#FFFF00' size='35'>%s</font>", msg)
	--lua_call_show_debug_info( message, 2, 1, 1, 0, -100, 0, 0, 0, 255 )

	--msg = string.format("<font color='#FF00FF' size='50'>+%d</font>", mission_add_time / 1000)
	--message = string.format("%s<font color='#969696' size='25'> (sec)</font>", msg)
	--lua_call_show_debug_info( message, 4, 1, 1, 0, -190, 0, 0, 0, 255 )

	--bomb_count_now = bomb_count_now + 1
	--mission_end_time = mission_end_time + mission_add_time
--end

function select_loadout()
    start_single_mission_2()
	-- show_start_msg()
end

-- function show_start_msg()
	-- msg_name = "2025-09-05"
	-- message_white = string.format("<font color='#FFFFFF' size='30'>%s</font>", msg_name )
	-- lua_call_show_debug_info ( message_white, 50, 1, 0, 0, 320, 0, 0, 0, 255  )
-- end

function prepare_round()
	start_single_mission_2()
	lua_call_set_observer_cam( "start_cam" )
end


function prepare_round_server()
	-- 미션 성공 처리
	lua_call_add_team_score( 0, 1 )
    start_single_mission_2()
end

function countdown()
	lua_call_active_trigger( "main_start_mis2")
	-- 체크 포인트 켬
	lua_call_set_enable_trigger_object( "t_check1", 1 )
	lua_call_set_enable_trigger_object( "t_check2", 1 )
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

function start_single_mission_2() -- 싱글 미션2에 필요한 명령 실행
	lua_call_set_enable_all_spawn_pos( 0 )
	lua_call_set_enable_spawn_pos( "mis2_sp01", 1 )	
	lua_call_set_enable_spawn_pos( "mis2_sp02", 1 )	
	lua_call_set_enable_spawn_pos( "mis2_sp03", 1 )	
	lua_call_set_enable_spawn_pos( "mis2_sp04", 1 )	
	-- lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
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
	lua_call_set_visible_object( "mis_obj_21", 1 )
	lua_call_set_visible_object( "mis_obj_22", 1 )
	lua_call_set_visible_object( "mis_obj_23", 1 )
	lua_call_set_visible_object( "mis_obj_24", 1 )
	lua_call_set_visible_object( "mis_obj_25", 1 )
	lua_call_set_visible_object( "mis_obj_26", 1 )
	lua_call_set_visible_object( "mis_obj_27", 1 )
	lua_call_set_visible_object( "mis_obj_28", 1 )
	lua_call_set_visible_object( "mis_obj_29", 1 )
	lua_call_set_visible_object( "mis_obj_30", 1 )
	lua_call_set_visible_object( "mis2_m01", 0 )
	lua_call_set_visible_object( "mis2_m02", 0 )
	lua_call_set_visible_object( "mis2_m03", 0 )
	lua_call_set_visible_object( "mis2_m04", 0 )
	lua_call_set_visible_object( "mis2_m05", 0 )
	lua_call_set_visible_object( "mis2_m06", 0 )
	lua_call_set_visible_object( "mis2_m07", 0 )
	lua_call_set_visible_object( "mis2_m08", 0 )
	lua_call_set_visible_object( "mis2_m09", 0 )
	lua_call_set_visible_object( "mis2_m10", 0 )
	lua_call_set_visible_object( "mis2_m11", 0 )
	lua_call_set_visible_object( "mis2_m12", 0 )
	lua_call_set_visible_object( "mis2_m13", 0 )
	lua_call_set_visible_object( "orca_body", 1 )
	lua_call_set_visible_object( "orca_box", 1 )
	
	
	-- PVE 싱글 미션 옵션 엔티티 켬
	lua_call_set_enable_entity( "mis_ent_01", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_02", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_03", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_04", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_05", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_06", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_07", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_08", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_09", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_10", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_11", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_12", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_13", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_14", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_15", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_16", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_17", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_18", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_19", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_20", 0 , "start_mis2")
	
	
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
	if ( stay_time < (install_time * rate) )
	then
		return 0
	end

	if ( press_time < ( install_time * rate ) )
	then
		return 0
	end
	
	return 1
end