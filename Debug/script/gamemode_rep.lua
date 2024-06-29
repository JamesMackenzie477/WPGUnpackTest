function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group_test.xml'
	wave_group_name = 'sg_pvp_reaper_escort'
	game_limit_time = 300000
	game_pre_loading_countdown = 30000
	no_damage_time = 3000
	respawn_delay = 1000
	force_respawn = 10000
	score_per_kill = 0
	show_npc_debug_info = false
    -- category, visible, mouse_on, hp_bar, distance, disappear in time 
    lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 1, 15000, 0)
    lua_call_set_name_tag_by_category("HUD_Enemy_NPC", 1, 0, 1, 15000, 0)
	-- allow_teamkill = "on"
	-- round_time = 300000
	-- round_mode="on"
	-- swap_spawn_pos="on"
	-- exist_team_score="yes"
end

function select_loadout()
end

function prepare_round()
end

function prepare_round_server()
	check_change_spawn ()
end

function countdown()
	lua_call_active_trigger( "main_start_rep")
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

function check_change_spawn ( )
	if play_time > 5000
		then
			change_spawn ()
		end
	return 0
end

function change_spawn ()
	lua_call_set_enable_all_spawn_pos( 0 )
	
	lua_call_set_enable_spawn_pos( "rep_naf1", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf2", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf3", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf4", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf5", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf6", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf7", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf8", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf9", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf10", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf11", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf12", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf13", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf14", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf15", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf16", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf17", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf18", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf19", 1 )	
	lua_call_set_enable_spawn_pos( "rep_naf20", 1 )	
	
	lua_call_set_enable_spawn_pos( "rep_eden1", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden2", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden3", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden4", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden5", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden6", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden7", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden8", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden9", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden10", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden11", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden12", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden13", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden14", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden15", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden16", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden17", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden18", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden19", 1 )	
	lua_call_set_enable_spawn_pos( "rep_eden20", 1 )	
end