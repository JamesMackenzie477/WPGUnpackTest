function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group.xml'
	wave_group_name = 'sg_pve_bvp_normal'
	game_limit_time = 600000
	game_pre_loading_countdown = 20000
	no_damage_time = 3000
	respawn_delay = 1000
	force_respawn = 5000
	drone_timer_decrease_rate = 600
	contribution_point_rate = 2
	force_team_id = "naf"
    lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
    lua_call_set_name_tag_by_category("HUD_Enemy_NPC", 1, 1, 0, 15000, 0)
	lua_call_load_ui("hudbvp")
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
