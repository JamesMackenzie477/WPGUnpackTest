function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group_test.xml'
	wave_group_name = 'sg_pve_defense'
	respawn = "off"
	drone_delay = 0
	site_object_prefix = "t_hud_"
	site_icon_prefix = "object"
	enable_revive = "true"
	revive_distance = 800
	revive_action_time = 3000
	force_team_id = "naf"
	weapon_drop = "false"
	contribution_point_rate = 0.2
	finish_game_after_all_die = "true"
	show_npc_debug_info = true
    lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
    lua_call_set_name_tag_by_category("HUD_Enemy_NPC", 1, 1, 1, 15000, 0)
end

function select_loadout()
	disable_hud()
end

function prepare_round()
end

function prepare_round_server()
end

function countdown()
	lua_call_active_trigger( "main_start_def")
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

function disable_hud()
	lua_call_set_enable_trigger_object( "t_hud_a", 0 )
	lua_call_set_enable_trigger_object( "t_hud_b", 0 )
	lua_call_set_enable_trigger_object( "t_hud_c", 0 )
	lua_call_set_enable_trigger_object( "t_hud_d", 0 )
	lua_call_set_enable_trigger_object( "t_hud_e", 0 )
end