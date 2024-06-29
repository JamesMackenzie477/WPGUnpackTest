wave_rule_xml = 'script\\npc_spawn_group_test.xml'
wave_group_name='sg_test_wave'
respawn = "on"
drone_delay = 0
force_team_id = "naf"
weapon_drop = "false"
contribution_point_rate = 0.0
unlimited_MaxAmmo = "true"

function init_server()
	lua_call_set_team_role( "NAF", "tutorial" );
end
function init_mode_alone()
	lua_call_set_team_role( "NAF", "tutorial" );
end
