function gamemode_set()
	wave_rule_xml = 'script\\npc_spawn_group.xml'
	wave_group_name = 'sg_pve_tutorial_01'
	site_object_prefix = "t_hud_"
	site_icon_prefix = "object"
	dead_body_time = 50000
	respawn = "on"
	drone_delay = 0	
	force_team_id = "naf"
	weapon_drop = "false"
	unlimited_MaxAmmo = "true"
	show_npc_debug_info= false
	fall_damage_min_height = 40000
	fall_damage_max_height = 50000	
	teammatch = "false"
	fade_in_at_start = "false" -- ���� ���� �� ������� ȿ���� ����
	game_start_countdown = 0				-- ���� �� ī��Ʈ
	game_pre_loading_countdown = 120000
	contribution_point_rate = 0				-- �ڵ� ȹ�� ����Ʈ ����
	drone_timer_decrease_rate_attack = 0 	-- ���� �迭 ȹ�� ����
	drone_timer_decrease_rate_operation = 0 -- ���� �迭 ȹ�� ����
	lua_call_result_score_ui(0)
	
	tab_score_hide = "true"						-- �� ���ھ �Ⱥ��̰� �Ѵ�
	
	force_loadout = 1 -- 1�� �ε�ƿ����� ���� �����Ѵ�

	-- ���� ü�¹� ����� ������, ������ �̻������� ���װ� �ֽ��ϴ� - 2016-02-15 Victor
	-- lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
	-- lua_call_set_name_tag_by_category("HUD_Enemy_NPC", 1, 1, 1, 15000, 0)
end

function countdown()
	lua_call_set_enable_trigger_object( "t_check1", 1 )
	lua_call_set_enable_trigger_object( "t_check2", 1 )
	lua_call_set_enable_trigger_object( "t_check3", 1 )
	lua_call_set_enable_trigger_object( "t_check4", 1 )
	lua_call_set_enable_trigger_object( "t_check5", 1 )

	lua_call_active_trigger( "main_start_trg")
end

function init_server()
	lua_call_set_team_role( "NAF", "tutorial" )
end

function init_mode_alone()
	lua_call_set_team_role( "NAF", "tutorial" )
	lua_call_set_enable_all_spawn_pos( 0 )
	lua_call_set_enable_spawn_pos( "check_0", 1 )	
	lua_call_set_name_tag_by_category("HUD_Ally_NPC", 1, 0, 0, 5000, 0)
	lua_call_set_name_tag_by_category("HUD_Enemy_NPC", 1, 1, 1, 15000, 0)
end

function init_mode()
	disable_hud()
end

function disable_hud()
	lua_call_set_enable_trigger_object( "t_hud_1", 0 )
	lua_call_set_enable_trigger_object( "t_hud_2", 0 )
	lua_call_set_enable_trigger_object( "t_hud_3", 0 )
	lua_call_set_enable_trigger_object( "t_hud_4", 0 )
	lua_call_set_enable_trigger_object( "t_hud_c", 0 )
	lua_call_set_enable_trigger_object( "t_hud_5", 0 )
	lua_call_set_enable_trigger_object( "t_hud_6", 0 )
	lua_call_set_enable_trigger_object( "t_hud_7", 0 )
	lua_call_set_enable_trigger_object( "t_hud_8", 0 )
	lua_call_set_enable_trigger_object( "t_hud_9", 0 )
	lua_call_set_enable_trigger_object( "t_hud_10", 0 )
	lua_call_set_enable_trigger_object( "t_hud_11", 0 )
	lua_call_set_enable_trigger_object( "t_hud_12", 0 )
	lua_call_set_enable_trigger_object( "t_hud_13", 0 )
	lua_call_set_enable_trigger_object( "t_hud_14", 0 )
	lua_call_set_enable_trigger_object( "t_hud_15", 0 )
	lua_call_set_enable_trigger_object( "t_hud_16", 0 )
	lua_call_set_enable_trigger_object( "t_hud_17", 0 )
	lua_call_set_enable_trigger_object( "t_hud_18", 0 )
	lua_call_set_enable_trigger_object( "t_hud_19", 0 )
	lua_call_set_enable_trigger_object( "t_hud_20", 0 )
	lua_call_set_enable_trigger_object( "t_hud_21", 0 )
	lua_call_set_enable_trigger_object( "t_hud_22", 0 )
	lua_call_set_enable_trigger_object( "t_hud_23", 0 )
	lua_call_set_enable_trigger_object( "t_hud_24", 0 )
	
	-- üũ ����Ʈ ��
end