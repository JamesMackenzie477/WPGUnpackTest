<trigger name="finish_trigger" stand="both/server" type="none"  trigger_object="trg_99" update_time="1" active_type="once" send_act_packet="true" >
	<function name="finish_game" type="native"/>
</trigger>

<trigger name='ck_complete_spawn_first_trg' stand='server' type='game' update_time='500' send_act_packet='true' active_type='once'>
  <condition name='check_complete_spawn_first_time' type='lua'>
    <param type='game' target='stay_time' />
  </condition>
</trigger>
<trigger name='ck_complete_spawn_first_trg' stand='client' type='none' update_time='500' active_type='once'>
  <function name="sentinel_spawn_first" type="lua"/>
</trigger>

<trigger name="main_t_msg0" stand="both/server" type="none" update_time="500" active_type="continue" send_act_packet="true">
  <function name="sentinel_spawn_b_1" type="lua"/>
  <function name="lua_call_set_enable_trigger" type="lua">
    <param type="value">main_t_msg0_1</param>
    <param type="value">1</param>
  </function>
</trigger>

<trigger name="main_t_msg0_1" stand="both/server" trigger_object="start_take" type="object" update_time="500" active_type="once"  send_act_packet="true" enable="false">
  <condition name="check_play_time" type="lua">
    <param type="self_trigger" target="active_time" />
    <param type="value">14000</param>
  </condition>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">main_t_msg0_2</param>
  </function>
</trigger>

<trigger name="main_t_msg0_2" stand="both/server" trigger_object="start_take"  type="none" update_time="500"  active_type="once" send_act_packet="true">
  <function name="sentinel_spawn_b_2" type="lua"/>
</trigger>

<trigger name="main_t_msg1" stand="both/server" type="none" update_time="500" active_type="continue" send_act_packet="true">
  <function name="sentinel_spawn_c_1" type="lua"/>
  <function name="lua_call_set_enable_trigger" type="lua">
    <param type="value">main_t_msg1_1</param>
    <param type="value">1</param>
  </function>
</trigger>

<trigger name="main_t_msg1_1" stand="both/server" trigger_object="start_take" type="object" update_time="500" active_type="once"  send_act_packet="true" enable="false">
    <condition name="check_play_time" type="lua">
    <param type="self_trigger" target="active_time" />
    <param type="value">14000</param>
  </condition>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">main_t_msg1_2</param>
  </function>
</trigger>

<trigger name="main_t_msg1_2" stand="both/server" trigger_object="start_take"  type="none" update_time="500"  active_type="once" send_act_packet="true">
  <function name="sentinel_spawn_c_2" type="lua"/>
</trigger>

<trigger name="main_t_msg2" stand="both/server" type="none" update_time="500" active_type="continue"  send_act_packet="true">
	<function name="metalreaper_spawn_1" type="lua"/>
	<function name="lua_call_set_enable_trigger" type="lua">
		<param type="value">main_t_msg2_1</param>
		<param type="value">1</param>
	</function>
</trigger>

<trigger name="main_t_msg2_1" stand="both/server" trigger_object="start_take" type="object" update_time="500" active_type="once"  send_act_packet="true" enable="false">
	<condition name="check_play_time" type="lua">
		<param type="self_trigger" target="active_time" />
		<param type="value">14000</param>
	</condition>
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">main_t_msg2_2</param>
	</function>
</trigger>

<trigger name="main_t_msg2_2" stand="both/server" trigger_object="start_take"  type="none" update_time="500"  active_type="once"  send_act_packet="true">
	<function name="metalreaper_spawn_2" type="lua"/>
</trigger>

<trigger name="main_t_msg3" stand="both/server" type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="sentinel_spawn_a_1" type="lua"/>
  <function name="lua_call_set_enable_trigger" type="lua">
    <param type="value">main_t_msg3_1</param>
    <param type="value">1</param>
  </function>
</trigger>

<trigger name="main_t_msg3_1" stand="both/server" trigger_object="start_take" type="object" update_time="500" active_type="once"  send_act_packet="true" enable="false">  
	<condition name="check_play_time" type="lua">
		<param type="self_trigger" target="active_time" />
		<param type="value">14000</param>
	</condition>
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">main_t_msg3_2</param>
	</function>
</trigger>

<trigger name="main_t_msg3_2" stand="both/server" trigger_object="start_take"  type="none" update_time="500"  active_type="once" send_act_packet="true">
	<function name="sentinel_spawn_a_2" type="lua"/>
</trigger>

<trigger name="s_npc_a" stand="server" trigger_object='hud_take_a' type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="spawn_zone_on_off" type="lua">
		<param type="object" target="user_data" />
		<param type="value">1</param>
		<param type="object" target='user_data' out="yes" />
	</function>
</trigger>
<trigger name="s_npc_a" stand="client" trigger_object='hud_take_a' type="init" active_type="continue">
	<function name="spawn_zone_hud_control" type="lua">
		<param type="object" target="user_data" />
		<param type="value">hud_take_a</param>
	</function>
</trigger>

<trigger name="e_npc_a" stand="server" trigger_object='hud_take_a' type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="spawn_zone_on_off" type="lua">
		<param type="object" target="user_data" />
		<param type="value">-1</param>
		<param type="object" target='user_data' out="yes" />
	</function>
</trigger>
<trigger name="e_npc_a" stand="client" trigger_object='hud_take_a' type="none" active_type="continue">
	<function name="spawn_zone_hud_control" type="lua">
		<param type="object" target="user_data" />
		<param type="value">hud_take_a</param>
	</function>
</trigger>

<trigger name="s_npc_b" stand="server" trigger_object='hud_take_b' type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="spawn_zone_on_off" type="lua">
		<param type="object" target="user_data" />
		<param type="value">1</param>
		<param type="object" target='user_data' out="yes" />
	</function>
</trigger>
<trigger name="s_npc_b" stand="client" trigger_object='hud_take_b' type="init" active_type="continue">
	<function name="spawn_zone_hud_control" type="lua">
		<param type="object" target="user_data" />
		<param type="value">hud_take_b</param>
	</function>
</trigger>

<trigger name="e_npc_b" stand="server" trigger_object='hud_take_b' type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="spawn_zone_on_off" type="lua">
		<param type="object" target="user_data" />
		<param type="value">-1</param>
		<param type="object" target='user_data' out="yes" />
	</function>
</trigger>
<trigger name="e_npc_b" stand="client" trigger_object='hud_take_b' type="none" active_type="continue">
	<function name="spawn_zone_hud_control" type="lua">
		<param type="object" target="user_data" />
		<param type="value">hud_take_b</param>
	</function>
</trigger>

<trigger name="s_npc_c" stand="server" trigger_object='hud_take_c' type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="spawn_zone_on_off" type="lua">
		<param type="object" target="user_data" />
		<param type="value">1</param>
		<param type="object" target='user_data' out="yes" />
	</function>
</trigger>
<trigger name="s_npc_c" stand="client" trigger_object='hud_take_c' type="init" active_type="continue">
	<function name="spawn_zone_hud_control" type="lua">
		<param type="object" target="user_data" />
		<param type="value">hud_take_c</param>
	</function>
</trigger>

<trigger name="e_npc_c" stand="server" trigger_object='hud_take_c' type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="spawn_zone_on_off" type="lua">
		<param type="object" target="user_data" />
		<param type="value">-1</param>
		<param type="object" target='user_data' out="yes" />
	</function>
</trigger>
<trigger name="e_npc_c" stand="client" trigger_object='hud_take_c' type="none" active_type="continue">
	<function name="spawn_zone_hud_control" type="lua">
		<param type="object" target="user_data" />
		<param type="value">hud_take_c</param>
	</function>
</trigger>

<trigger name="s_npc_e" stand="server" trigger_object='hud_take_e' type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="spawn_zone_on_off" type="lua">
		<param type="object" target="user_data" />
		<param type="value">1</param>
		<param type="object" target='user_data' out="yes" />
	</function>
</trigger>
<trigger name="s_npc_e" stand="client" trigger_object='hud_take_e' type="init" active_type="continue">
	<function name="spawn_zone_hud_control" type="lua">
		<param type="object" target="user_data" />
		<param type="value">hud_take_e</param>
	</function>
</trigger>

<trigger name="e_npc_e" stand="server" trigger_object='hud_take_e' type="none" update_time="500" active_type="continue" send_act_packet="true">
	<function name="spawn_zone_on_off" type="lua">
		<param type="object" target="user_data" />
		<param type="value">-1</param>
		<param type="object" target='user_data' out="yes" />
	</function>
</trigger>
<trigger name="e_npc_e" stand="client" trigger_object='hud_take_e' type="none" active_type="continue">
	<function name="spawn_zone_hud_control" type="lua">
		<param type="object" target="user_data" />
		<param type="value">hud_take_e</param>
	</function>
</trigger>