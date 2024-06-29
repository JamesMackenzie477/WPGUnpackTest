<!-- COMMON -->
<trigger name='start_gen_domination_trigger' stand='server' type='game' update_time='500' active_type='once'>
  <function name='start_gen_domination_point' type='lua'>
  </function>
</trigger>
<trigger name='ck_complete_gen_trigger' stand='server' type='game' update_time='500' send_act_packet='true' active_type='once'>
  <condition name='check_complete_gen_domination_time' type='lua'>
    <param type='game' target='stay_time' />
  </condition>
  <function name='complete_gen_domination_point' type='lua' />
  <function name='lua_call_active_trigger_checked' type='lua'>
    <param type='value'>init_start_scp_trg</param>
  </function>
  <function name='lua_call_active_trigger_checked' type='lua'>
    <param type='value'>init_dom_a</param>
  </function>
  <function name='lua_call_active_trigger_checked' type='lua'>
    <param type='value'>init_dom_b</param>
  </function>
  <function name='lua_call_active_trigger_checked' type='lua'>
    <param type='value'>init_dom_c</param>
  </function>
  <function name='lua_call_active_trigger_checked' type='lua'>
    <param type='value'>init_dom_d</param>
  </function>
  <function name='lua_call_active_trigger_checked' type='lua'>
    <param type='value'>init_dom_e</param>
  </function>
</trigger>
<trigger name='ck_complete_gen_trigger' stand='client' type='none' update_time='500' active_type='once'>
  <function name='complete_gen_domination_point_banner' type='lua' />
  <function name='play_simple_sound' type='native'>
    <param type='value'>/voiceover/securepoint/securepoint_activated_02</param>
  </function>
</trigger>
<trigger name='play_sound_trigger_scp_my_team' stand='client' type='none' update_time='500' active_type='once'>
  <function name='play_simple_sound' type='native'>
    <param type='value'>/voiceover/securepoint/securepoint_taking_02</param>
  </function>
</trigger>
<trigger name='play_sound_trigger_scp_enemy_team' stand='client' type='none' update_time='500' active_type='once'>
  <function name='play_simple_sound' type='native'>
    <param type='value'>/voiceover/securepoint/securepoint_losing_02</param>
  </function>
</trigger>
<trigger name='finish_game_dom_trigger' stand='server' type='game' update_time='500' active_type='continue'>
  <function name='check_finish_game' type='native' />
</trigger>

<!-- START_SCP -->
<trigger name='init_start_scp_trg' stand='server' trigger_object='start_scp' type='none' update_time='500' send_act_packet='true' active_type='continue'>
  <function name='init_start_scp' type='lua' />
</trigger>
<trigger name='init_start_scp_trg' stand='client' trigger_object='start_scp' type='none' update_time='500' active_type='once'>
</trigger>
<!-- START_SCP / NAF -->
<trigger name='ck_finish_game_trg_naf' stand='server' trigger_object='start_scp' type='object' update_time='250' send_act_packet='true' active_type='once'>
  <condition name='check_finish_game_naf' type='lua'>
  </condition>
  <function name='add_finish_score_naf' type='lua'>
    <param type='game' target='goal_score' />
  </function>
</trigger>
<trigger name='ck_finish_game_trg_naf' stand='client' trigger_object='start_scp' type='none' update_time='250' active_type='once'>
  <function name='add_finish_score_naf' type='lua'>
    <param type='game' target='goal_score' />
  </function>
</trigger>
<!-- START_SCP / EDEN -->
<trigger name='ck_finish_game_trg_eden' stand='server' trigger_object='start_scp' type='object' update_time='250' send_act_packet='true' active_type='once'>
  <condition name='check_finish_game_eden' type='lua'>
  </condition>
  <function name='add_finish_score_eden' type='lua'>
    <param type='game' target='goal_score' />
  </function>
</trigger>
<trigger name='ck_finish_game_trg_eden' stand='client' trigger_object='start_scp' type='none' update_time='250' active_type='once'>
  <function name='add_finish_score_eden' type='lua'>
    <param type='game' target='goal_score' />
  </function>
</trigger>
<!-- START_SCP / OUTPUT -->
<trigger name='output_start_scp_trg' stand='client' trigger_object='start_scp' type='zone' update_time='500' active_type='continue'>
  <function name='output_team_score_ui_info' type='lua'>
    <param type='game' target='stay_time' />
  </function>
</trigger>

<!-- OBJECT A -->
<trigger name='init_dom_a' stand='server' trigger_object='scp_a' type='none' update_time='500' send_act_packet='true' active_type='continue'>
  <function name='init_object_dom' type='lua'>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='hp' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='init_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='init_dom_client_a' stand='client' trigger_object='scp_a' type='init' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='start_dom_a' stand='server' trigger_object='scp_a' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_domination' type='lua'>
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_start_domination_state' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='start_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='restart_user_dom_a' stand='server' trigger_object='scp_a' type='stay' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_restart_user_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='object' target='user_data' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_restart_user_domination' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='restart_user_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='cancel_dom_a' stand='server' trigger_object='scp_a' type='leave' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_cancel_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
  </condition>
  <function name='set_cancel_domination_state' type='lua'>
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='cancel_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_dom_a' stand='server' trigger_object='scp_a' type='object' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_now_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='value'>1</param>
  </condition>
  <function name='proc_domination_score' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='flow_time' />
    <param type='game' target='stay_time' />
    <param type='object' target='score' op='add' out='yes' />
    <param type='object' target='hp' out='yes' />
  </function>
</trigger>
<trigger name='check_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_complete_dom_a' stand='server' trigger_object='scp_a' type='object' send_act_packet='true' update_time='500' active_type='continue'>
  <condition name='is_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='state' />
    <param type='object' target='team_id' />
  </condition>
  <function name='proc_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='value'>1</param>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='state' out='yes' />
  </function>
  <function name='domination' type='native'>
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_complete_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='once'>
  <function name='complete_domination_banner_and_sound' type='lua'>
    <param type='object' target='user_index' />
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_score_a' stand='client' trigger_object='scp_a' type='zone' update_time='500' active_type='continue'>
  <function name='output_domination_ui_info' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='self' target='team_id' />
    <param type='value'>1</param>
    <param type='game' target='goal_score' />
    <param type='game' target='team_score' />
  </function>
</trigger>

<!-- OBJECT B -->
<trigger name='init_dom_b' stand='server' trigger_object='scp_b' type='none' update_time='500' send_act_packet='true' active_type='continue'>
  <function name='init_object_dom' type='lua'>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='hp' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='init_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='init_dom_client_b' stand='client' trigger_object='scp_b' type='init' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='start_dom_b' stand='server' trigger_object='scp_b' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_domination' type='lua'>
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_start_domination_state' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='start_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='restart_user_dom_b' stand='server' trigger_object='scp_b' type='stay' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_restart_user_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='object' target='user_data' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_restart_user_domination' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='restart_user_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='cancel_dom_b' stand='server' trigger_object='scp_b' type='leave' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_cancel_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
  </condition>
  <function name='set_cancel_domination_state' type='lua'>
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='cancel_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_dom_b' stand='server' trigger_object='scp_b' type='object' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_now_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='value'>2</param>
  </condition>
  <function name='proc_domination_score' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='flow_time' />
    <param type='game' target='stay_time' />
    <param type='object' target='score' op='add' out='yes' />
    <param type='object' target='hp' out='yes' />
  </function>
</trigger>
<trigger name='check_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_complete_dom_b' stand='server' trigger_object='scp_b' type='object' send_act_packet='true' update_time='500' active_type='continue'>
  <condition name='is_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='state' />
    <param type='object' target='team_id' />
  </condition>
  <function name='proc_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='value'>2</param>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='state' out='yes' />
  </function>
  <function name='domination' type='native'>
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_complete_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='once'>
  <function name='complete_domination_banner_and_sound' type='lua'>
    <param type='object' target='user_index' />
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_score_b' stand='client' trigger_object='scp_b' type='zone' update_time='500' active_type='continue'>
  <function name='output_domination_ui_info' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='self' target='team_id' />
    <param type='value'>2</param>
    <param type='game' target='goal_score' />
    <param type='game' target='team_score' />
  </function>
</trigger>

<!-- OBJECT C -->
<trigger name='init_dom_c' stand='server' trigger_object='scp_c' type='none' update_time='500' send_act_packet='true' active_type='continue'>
  <function name='init_object_dom' type='lua'>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='hp' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='init_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='init_dom_client_c' stand='client' trigger_object='scp_c' type='init' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='start_dom_c' stand='server' trigger_object='scp_c' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_domination' type='lua'>
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_start_domination_state' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='start_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='restart_user_dom_c' stand='server' trigger_object='scp_c' type='stay' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_restart_user_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='object' target='user_data' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_restart_user_domination' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='restart_user_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='cancel_dom_c' stand='server' trigger_object='scp_c' type='leave' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_cancel_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
  </condition>
  <function name='set_cancel_domination_state' type='lua'>
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='cancel_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_dom_c' stand='server' trigger_object='scp_c' type='object' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_now_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='value'>3</param>
  </condition>
  <function name='proc_domination_score' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='flow_time' />
    <param type='game' target='stay_time' />
    <param type='object' target='score' op='add' out='yes' />
    <param type='object' target='hp' out='yes' />
  </function>
</trigger>
<trigger name='check_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_complete_dom_c' stand='server' trigger_object='scp_c' type='object' send_act_packet='true' update_time='500' active_type='continue'>
  <condition name='is_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='state' />
    <param type='object' target='team_id' />
  </condition>
  <function name='proc_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='value'>3</param>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='state' out='yes' />
  </function>
  <function name='domination' type='native'>
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_complete_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='once'>
  <function name='complete_domination_banner_and_sound' type='lua'>
    <param type='object' target='user_index' />
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_score_c' stand='client' trigger_object='scp_c' type='zone' update_time='500' active_type='continue'>
  <function name='output_domination_ui_info' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='self' target='team_id' />
    <param type='value'>3</param>
    <param type='game' target='goal_score' />
    <param type='game' target='team_score' />
  </function>
</trigger>

<!-- OBJECT D -->
<trigger name='init_dom_d' stand='server' trigger_object='scp_d' type='none' update_time='500' send_act_packet='true' active_type='continue'>
  <function name='init_object_dom' type='lua'>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='hp' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='init_dom_d' stand='client' trigger_object='scp_d' type='none' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='init_dom_client_d' stand='client' trigger_object='scp_d' type='init' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='start_dom_d' stand='server' trigger_object='scp_d' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_domination' type='lua'>
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_start_domination_state' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='start_dom_d' stand='client' trigger_object='scp_d' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='restart_user_dom_d' stand='server' trigger_object='scp_d' type='stay' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_restart_user_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='object' target='user_data' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_restart_user_domination' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='restart_user_dom_d' stand='client' trigger_object='scp_d' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='cancel_dom_d' stand='server' trigger_object='scp_d' type='leave' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_cancel_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
  </condition>
  <function name='set_cancel_domination_state' type='lua'>
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='cancel_dom_d' stand='client' trigger_object='scp_d' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_dom_d' stand='server' trigger_object='scp_d' type='object' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_now_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='value'>4</param>
  </condition>
  <function name='proc_domination_score' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='flow_time' />
    <param type='game' target='stay_time' />
    <param type='object' target='score' op='add' out='yes' />
    <param type='object' target='hp' out='yes' />
  </function>
</trigger>
<trigger name='check_dom_d' stand='client' trigger_object='scp_d' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_complete_dom_d' stand='server' trigger_object='scp_d' type='object' send_act_packet='true' update_time='500' active_type='continue'>
  <condition name='is_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='state' />
    <param type='object' target='team_id' />
  </condition>
  <function name='proc_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='value'>4</param>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='state' out='yes' />
  </function>
  <function name='domination' type='native'>
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_complete_dom_d' stand='client' trigger_object='scp_d' type='none' update_time='500' active_type='once'>
  <function name='complete_domination_banner_and_sound' type='lua'>
    <param type='object' target='user_index' />
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_score_d' stand='client' trigger_object='scp_d' type='zone' update_time='500' active_type='continue'>
  <function name='output_domination_ui_info' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='self' target='team_id' />
    <param type='value'>4</param>
    <param type='game' target='goal_score' />
    <param type='game' target='team_score' />
  </function>
</trigger>

<!-- OBJECT E -->
<trigger name='init_dom_e' stand='server' trigger_object='scp_e' type='none' update_time='500' send_act_packet='true' active_type='continue'>
  <function name='init_object_dom' type='lua'>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='hp' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='init_dom_e' stand='client' trigger_object='scp_e' type='none' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='init_dom_client_e' stand='client' trigger_object='scp_e' type='init' update_time='500' active_type='once'>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='start_dom_e' stand='server' trigger_object='scp_e' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_domination' type='lua'>
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_start_domination_state' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='start_dom_e' stand='client' trigger_object='scp_e' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='restart_user_dom_e' stand='server' trigger_object='scp_e' type='stay' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_restart_user_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='object' target='user_data' />
    <param type='actor' target='team_id' />
  </condition>
  <function name='set_restart_user_domination' type='lua'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='restart_user_dom_e' stand='client' trigger_object='scp_e' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='cancel_dom_e' stand='server' trigger_object='scp_e' type='leave' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_can_cancel_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
  </condition>
  <function name='set_cancel_domination_state' type='lua'>
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='state' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
</trigger>
<trigger name='cancel_dom_e' stand='client' trigger_object='scp_e' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_dom_e' stand='server' trigger_object='scp_e' type='object' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_now_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='value'>5</param>
  </condition>
  <function name='proc_domination_score' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='flow_time' />
    <param type='game' target='stay_time' />
    <param type='object' target='score' op='add' out='yes' />
    <param type='object' target='hp' out='yes' />
  </function>
</trigger>
<trigger name='check_dom_e' stand='client' trigger_object='scp_e' type='none' update_time='500' active_type='once'>
</trigger>
<trigger name='check_complete_dom_e' stand='server' trigger_object='scp_e' type='object' send_act_packet='true' update_time='500' active_type='continue'>
  <condition name='is_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='state' />
    <param type='object' target='team_id' />
  </condition>
  <function name='proc_complete_domination' type='lua'>
    <param type='object' target='score' />
    <param type='value'>5</param>
    <param type='object' target='team_id' out='yes' />
    <param type='object' target='score' out='yes' />
    <param type='object' target='state' out='yes' />
  </function>
  <function name='domination' type='native'>
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_complete_dom_e' stand='client' trigger_object='scp_e' type='none' update_time='500' active_type='once'>
  <function name='complete_domination_banner_and_sound' type='lua'>
    <param type='object' target='user_index' />
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
  <function name='change_domination_icon' type='lua'>
    <param type='object' target='name'/>
    <param type='self' target='team_id' />
    <param type='object' target='team_id' />
  </function>
</trigger>
<trigger name='check_score_e' stand='client' trigger_object='scp_e' type='zone' update_time='500' active_type='continue'>
  <function name='output_domination_ui_info' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='name' />
    <param type='object' target='team_id' />
    <param type='object' target='state' />
    <param type='self' target='team_id' />
    <param type='value'>5</param>
    <param type='game' target='goal_score' />
    <param type='game' target='team_score' />
  </function>
</trigger>