function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group_test.xml'
	wave_group_name = 'sg_pve_02'
	respawn = "off"
	drone_delay = 0
	enable_revive = "true"
	revive_distance = 800
	revive_action_time = 3000
	force_team_id = "naf"
	weapon_drop = "false"
	contribution_point_rate = 0.2
	finish_game_after_all_die = "true"
	show_npc_debug_info=true
	player_health_regeneration = 0
end

function select_loadout()
end

function prepare_round()
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

function hide_all_hud ( )
	lua_call_set_enable_trigger_object( "t_hud_a", 0 )
	lua_call_set_enable_trigger_object( "t_hud_b", 0 )
	lua_call_set_enable_trigger_object( "t_hud_c", 0 )
	lua_call_set_enable_trigger_object( "t_hud_d", 0 )
	lua_call_set_enable_trigger_object( "t_hud_e", 0 )
	lua_call_set_enable_trigger_object( "t_hud_f", 0 )
	lua_call_set_enable_trigger_object( "t_hud_g", 0 )
	lua_call_set_enable_trigger_object( "t_hud_h", 0 )
	lua_call_set_enable_trigger_object( "t_hud_i", 0 )
	lua_call_set_enable_trigger_object( "t_hud_j", 0 )
end