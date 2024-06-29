wave_rule_xml = 'script\\npc_spawn_group_test.xml'
wave_group_name = 'sg_drone_mission_02'
site_object_prefix = "t_hud_"
site_icon_prefix = "object"
game_limit_time = 600000
game_pre_loading_countdown = 30000
no_damage_time = 3000
respawn_delay = 1000
force_respawn = 10000
show_npc_debug_info=false

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
end