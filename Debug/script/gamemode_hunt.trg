<trigger name='mission_ui_trigger' stand='client' type='game' update_time='500' active_type='continue'>
  <function name='output_ui' type='lua'>
    <param type='self' target='game_mode_point' />
  </function>
</trigger>

<trigger name='check_game' stand='both/server'  type='game' update_time='1' send_act_packet='true' active_type='once'>
	<condition name='check_only_one' type='lua'/>
	<function name="finish_game" type="native"/>
</trigger>



<!-- INTEL A -->
<trigger name='check_enable_get_a' trigger_object='dopp_t_a' stand='client' type='stay' update_time='1' active_type='continue'>
  <function name='show_action_info_msg' type='lua'>
    <param type='actor' target='game_mode_point' />
    <param type='value'>1</param>
  </function>
</trigger>

<trigger name='check_input_f_dopp_t_a' trigger_object='dopp_t_a' stand='client' type='usekey' update_time='1' active_type='continue'>
  <condition name='check_untake_intel' type='lua'>
    <param type='actor' target='game_mode_point' />
    <param type='value'>1</param>
  </condition>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">input_f_dopp_t_a</param>
    <param type="actor" target="user_index" />
  </function>
</trigger>

<trigger name="input_f_dopp_t_a" stand="client" trigger_object="dopp_t_a" type="none" update_time="1" active_type="continue" bind_object="dopp_t_a" send_act_packet="true">
  <function name="get_intel_object" type="lua">
    <param type='actor' target='game_mode_point' />
    <param type='value'>1</param>
    <param type='actor' target='game_mode_point' op='add' out='yes' />
  </function>
</trigger>
<trigger name="input_f_dopp_t_a" stand="server" trigger_object="dopp_t_a" type="none" update_time="1" active_type="continue" bind_object="dopp_t_a" send_act_packet="false">
  <function name="get_intel_object" type="lua">
    <param type='actor' target='game_mode_point' />
    <param type='value'>1</param>
    <param type='actor' target='game_mode_point' op='add' out='yes' />
  </function>
  <function name="lua_call_set_game_mode_skill" type="lua">
    <param type='actor' target='user_index' />
    <param type='value'>1</param>
  </function>
  <function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">check_finish_trigger_intel_a</param>
		<param type="actor" target="user_index" />
	</function>
</trigger>

<trigger name="check_finish_trigger_intel_a" stand="both/server" trigger_object="dopp_t_a" type="none" update_time="1" active_type="once" bind_object="dopp_t_a" send_act_packet="true">
  <condition name='check_take_all_intel' type='lua'>
    <param type='actor' target='game_mode_point' />
  </condition>
  <function name="finish_game" type="native"/>
</trigger>



<!-- INTEL B -->
<trigger name='check_enable_get_b' trigger_object='dopp_t_b' stand='client' type='stay' update_time='1' active_type='continue'>
  <function name='show_action_info_msg' type='lua'>
    <param type='actor' target='game_mode_point' />
    <param type='value'>2</param>
  </function>
</trigger>

<trigger name='check_input_f_dopp_t_b' trigger_object='dopp_t_b' stand='client' type='usekey' update_time='1' active_type='continue'>
  <condition name='check_untake_intel' type='lua'>
    <param type='actor' target='game_mode_point' />
    <param type='value'>2</param>
  </condition>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">input_f_dopp_t_b</param>
    <param type="actor" target="user_index" />
  </function>
</trigger>

<trigger name="input_f_dopp_t_b" stand="client" trigger_object="dopp_t_b" type="none" update_time="1" active_type="continue" bind_object="dopp_t_b" send_act_packet="true">
  <function name="get_intel_object" type="lua">
    <param type='actor' target='game_mode_point' />
    <param type='value'>2</param>
    <param type='actor' target='game_mode_point' op='add' out='yes' />
  </function>
</trigger>
<trigger name="input_f_dopp_t_b" stand="server" trigger_object="dopp_t_b" type="none" update_time="1" active_type="continue" bind_object="dopp_t_b" send_act_packet="false">
  <function name="get_intel_object" type="lua">
    <param type='actor' target='game_mode_point' />
    <param type='value'>2</param>
    <param type='actor' target='game_mode_point' op='add' out='yes' />
  </function>
  <function name="lua_call_set_game_mode_skill" type="lua">
    <param type='actor' target='user_index' />
    <param type='value'>2</param>
  </function>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">check_finish_trigger_intel_b</param>
    <param type="actor" target="user_index" />
  </function>
</trigger>

<trigger name="check_finish_trigger_intel_b" stand="both/server" trigger_object="dopp_t_b" type="none" update_time="1" active_type="once" bind_object="dopp_t_b" send_act_packet="true">
  <condition name='check_take_all_intel' type='lua'>
    <param type='actor' target='game_mode_point' />
  </condition>
  <function name="finish_game" type="native"/>
</trigger>



<!-- INTEL C -->
<trigger name='check_enable_get_c' trigger_object='dopp_t_c' stand='client' type='stay' update_time='1' active_type='continue'>
  <function name='show_action_info_msg' type='lua'>
    <param type='actor' target='game_mode_point' />
    <param type='value'>3</param>
  </function>
</trigger>

<trigger name='check_input_f_dopp_t_c' trigger_object='dopp_t_c' stand='client' type='usekey' update_time='1' active_type='continue'>
  <condition name='check_untake_intel' type='lua'>
    <param type='actor' target='game_mode_point' />
    <param type='value'>3</param>
  </condition>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">input_f_dopp_t_c</param>
    <param type="actor" target="user_index" />
  </function>
</trigger>

<trigger name="input_f_dopp_t_c" stand="client" trigger_object="dopp_t_c" type="none" update_time="1" active_type="continue" bind_object="dopp_t_c" send_act_packet="true">
  <function name="get_intel_object" type="lua">
    <param type='actor' target='game_mode_point' />
    <param type='value'>3</param>
    <param type='actor' target='game_mode_point' op='add' out='yes' />
  </function>
</trigger>
<trigger name="input_f_dopp_t_c" stand="server" trigger_object="dopp_t_c" type="none" update_time="1" active_type="continue" bind_object="dopp_t_c" send_act_packet="false">
  <function name="get_intel_object" type="lua">
    <param type='actor' target='game_mode_point' />
    <param type='value'>3</param>
    <param type='actor' target='game_mode_point' op='add' out='yes' />
  </function>
  <function name="lua_call_set_game_mode_skill" type="lua">
    <param type='actor' target='user_index' />
    <param type='value'>3</param>
  </function>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">check_finish_trigger_intel_c</param>
    <param type="actor" target="user_index" />
  </function>
</trigger>

<trigger name="check_finish_trigger_intel_c" stand="both/server" trigger_object="dopp_t_c" type="none" update_time="1" active_type="once" bind_object="dopp_t_c" send_act_packet="true">
  <condition name='check_take_all_intel' type='lua'>
    <param type='actor' target='game_mode_point' />
  </condition>
  <function name="finish_game" type="native"/>
</trigger>


<!-- INTEL D -->
<trigger name='check_enable_get_d' trigger_object='dopp_t_d' stand='client' type='stay' update_time='1' active_type='continue'>
  <function name='show_action_info_msg' type='lua'>
    <param type='actor' target='game_mode_point' />
    <param type='value'>4</param>
  </function>
</trigger>

<trigger name='check_input_f_dopp_t_d' trigger_object='dopp_t_d' stand='client' type='usekey' update_time='1' active_type='continue'>
  <condition name='check_untake_intel' type='lua'>
    <param type='actor' target='game_mode_point' />
    <param type='value'>4</param>
  </condition>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">input_f_dopp_t_d</param>
    <param type="actor" target="user_index" />
  </function>
</trigger>

<trigger name="input_f_dopp_t_d" stand="client" trigger_object="dopp_t_d" type="none" update_time="1" active_type="continue" bind_object="dopp_t_d" send_act_packet="true">
  <function name="get_intel_object" type="lua">
    <param type='actor' target='game_mode_point' />
    <param type='value'>4</param>
    <param type='actor' target='game_mode_point' op='add' out='yes' />
  </function>
</trigger>
<trigger name="input_f_dopp_t_d" stand="server" trigger_object="dopp_t_d" type="none" update_time="1" active_type="continue" bind_object="dopp_t_d" send_act_packet="false">
  <function name="get_intel_object" type="lua">
    <param type='actor' target='game_mode_point' />
    <param type='value'>4</param>
    <param type='actor' target='game_mode_point' op='add' out='yes' />
  </function>
  <function name="lua_call_set_game_mode_skill" type="lua">
    <param type='actor' target='user_index' />
    <param type='value'>4</param>
  </function>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">check_finish_trigger_intel_d</param>
    <param type="actor" target="user_index" />
  </function>
</trigger>

<trigger name="check_finish_trigger_intel_d" stand="both/server" trigger_object="dopp_t_d" type="none" update_time="1" active_type="once" bind_object="dopp_t_d" send_act_packet="true">
  <condition name='check_take_all_intel' type='lua'>
    <param type='actor' target='game_mode_point' />
  </condition>
  <function name="finish_game" type="native"/>
</trigger>