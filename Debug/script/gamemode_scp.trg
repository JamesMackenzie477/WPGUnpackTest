<trigger name='calc_domination_point' stand='server'  type='game' update_time='500' active_type='once'>
  <function name='calc_domination_point' type='lua' >
    <param type='value'>1</param>
    <param type='value'>3</param>
  </function>
</trigger>
<trigger name='gen_domination_point' stand='server'  type='game' update_time='500' send_act_packet='true'  active_type='once'>
  <condition name='check_gen_domination_point' type='lua'>
    <param type='game' target='round_time' />
  </condition>
  <function name='get_current_domination_point' type='lua' />
</trigger>
<trigger name='gen_domination_point' stand='client'  type='none' update_time='500' active_type='once'>
  <condition name='check_gen_domination_point' type='lua'>
    <param type='game' target='round_time' />
  </condition>
  <function name='get_current_domination_point_banner' type='lua' />
  <function name='play_simple_sound' type='native'>
    <param type='value'>/voiceover/securepoint/securepoint_activated_02</param>
  </function>  
</trigger>
<trigger name='enemy_taken' stand='client' type='enemy_taken' update_time='500' send_act_packet='false' active_type='continue'>
  <function name='play_sound' type='native'>
    <param type='value'>enemy_taken</param>
    <param type='actor' target='user_data' />
  </function>
</trigger>
<trigger name='enemy_taking' stand='client' type='enemy_taking' update_time='500' send_act_packet='false' active_type='continue'>
  <function name='play_sound' type='native'>
    <param type='value'>enemy_taking</param>
    <param type='actor' target='user_data' />
  </function>
</trigger>
<trigger name='friendly_taking' stand='client' type='friendly_taking' update_time='500' send_act_packet='false' active_type='continue'>
  <function name='play_sound' type='native'>
    <param type='value'>friendly_taking</param>
    <param type='actor' target='user_data' />
  </function>
</trigger>
<trigger name='approach_item' stand='client' type='approach_item' update_time='500' send_act_packet='false' active_type='continue'>
  <function name='play_sound' type='native'>
    <param type='value'>approach_item</param>
    <param type='actor' target='user_data' />
  </function>
</trigger>
<trigger name='ck_gen_time_trigger' stand='client' type='game' update_time='500' active_type='once'>
  <condition name='check_gen_time_domination_point' type='lua'>
    <param type='game' target='round_time' />
  </condition>
  <function name='output_gen_time_domination_ui' type='lua'>
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
<trigger name='intercept_dom_a' stand='server' trigger_object='scp_a' type='stay' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_intercept_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
  </condition>
  <function name='active_trigger' type='lua'>
    <param type='value'>start_dom_a</param>
    <param type='actor' target='user_index' />
  </function>
</trigger>
<trigger name='start_dom_a' stand='server' trigger_object='scp_a' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='value'>1</param>
    <param type='game' target='round_time' />
  </condition>
  <function name='set_domination_user_index' type='value'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
  <function name='change_state' type='value'>
    <param type='value'>1</param>
    <param type='value'>1</param>
    <param type='object' target='state' out='yes' />
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>
<trigger name='start_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='continue'>
  <function name='start_domination' type='native'>
    <param type='actor' target='team_id' />
    <param type='value'>1</param>
    <param type='value'>100000</param>
    <param type='object' target='name' />
    <param type='object' target='score' />
  </function>
</trigger>
<trigger name='conflict_dom_a' stand='server' trigger_object='scp_a' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_comflict_area' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='set_conflict_area' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='user_data' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='conflict_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='continue'>
  <function name='cancel_domination' type='native'>
    <param type='actor' target='team_id' />
    <param type='value'>1</param>
  </function>
</trigger>
<trigger name='cancel_conflict_dom_a' stand='server' trigger_object='scp_a' type='leave' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_cancel_conflict_area' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='cancel_domination' type='lua'>
    <param type='actor' target='team_id' />
    <param type='object' target='name' />
  </function>
  <function name='cancel_conflict_area' type='lua'>
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='cancel_conflict_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='continue'>
  <function name='set_object_score' type='native'>
    <param type='object' target='name' />
    <param type='object' target='user_data' />
    <param type='object' target='score' />
  </function>
</trigger>
<trigger name='leave_user_dom_a' stand='server' trigger_object='scp_a' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">cancel_dom_a</param>
    <param type='actor' target='user_index' />
  </function>
</trigger>
<trigger name='leave_user_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='continue'>
  <function name='leave_user_domination' type='native'>
    <param type='actor' target='user_index' />
    <param type='object' target='user_data' />
    <param type='object' target='score' />
    <param type='value'>100000</param>
  </function>
</trigger>
<trigger name='cancel_dom_a' stand='server' trigger_object='scp_a' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
  <condition name='check_cancel_domination' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='cancel_domination' type='lua'>
    <param type='actor' target='team_id' />
    <param type='object' target='name' />
  </function>
  <function name='reset_object_state' type='value'>
    <param type='value'>1</param>
    <param type='value'>0</param>
    <param type='object' target='reset' out='yes'/>
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>
<trigger name='cancel_dom_a' stand='client' trigger_object='scp_a' type='none' update_time='500' active_type='continue'>
  <function name='cancel_domination' type='native'>
  </function>
</trigger>
<trigger name='check_dom_a' stand='server' trigger_object='scp_a' type='object' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
    <param type='game' target='round_time' />
  </condition>
  <function name='add_domination_score' type='lua'>
    <param type='object' target='user_data' />
    <param type='object' target='name' />
    <param type='object' target='flow_time' />
    <param type='object' target='score' op='add' out='yes' />
  </function>
</trigger>
<trigger name='check_dom_a' stand='client' trigger_object='scp_a' type='zone' update_time='500' active_type='continue'>
  <condition name='check_object_state' type='lua'>
    <param type='object' target='state' />
    <param type='value'>1</param>
  </condition>
  <function name='set_domination_rate' type='lua'>
    <param type='self' target='team_id' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='reward_drone_point_dom_a' stand='server' trigger_object='scp_a' type='object' update_time='1000' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
    <param type='game' target='round_time' />
  </condition>
  <function name='add_drone_point_by_domination' type='lua'>
    <param type='object' target='user_data' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='check_score_a' stand='client' trigger_object='scp_a' type='zone' update_time='500' active_type='continue'>
  <function name='output_domination_ui_and_effect' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='name' />
    <param type='self' target='team_id' />
    <param type='value'>100000</param>
    <param type='value'>a</param>
    <param type='game' target='round_time' />
  </function>
</trigger>
<trigger name='check_complete_dom_a' stand='server' trigger_object='scp_a'  type='object' send_act_packet='true' update_time='500' active_type='continue'>
  <condition name='check_object_domination' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='score' />
    <param type='value'>100000</param>
  </condition>
  <function name='change_team_id' type='value'>
    <param type='object' target='user_data' />
    <param type='object' target='team_id' out='yes'/>
  </function>
  <function name='add_score' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='change_state' type='value'>
    <param type='value'>2</param>
    <param type='value'>2</param>
    <param type='object' target='state' out='yes' />
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>
<trigger name='check_complete_dom_a' stand='client' trigger_object='scp_a'  type='none' update_time='500' active_type='continue'>
  <function name='add_score' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='check_dom_client' type='lua'>
  </function>
  <function name='dom_sucess_message' type='lua'>
  </function>
</trigger>
<trigger name='do_dom_a' stand='server' trigger_object='scp_a' type='object' update_time='1000' send_act_packet='true' active_type='continue'>
  <condition name='check_object_team_id' type='lua'>
    <param type='object' target='team_id' />
  </condition>
  <function name='finish_round' type='native'>
    <param type='object' target='team_id' />
  </function>
  <function name='check_finish_game' type='native' />
</trigger>
<trigger name='do_dom_a' stand='client' trigger_object='scp_a'  type='none' update_time='500' active_type='continue'>
</trigger>
<trigger name='finish_game_dom_a' stand='server' trigger_object='scp_a' type='object' update_time='1000' active_type='continue'>
  <condition name='check_object_team_id' type='lua'>
    <param type='object' target='team_id' />
  </condition>
</trigger>
<trigger name='intercept_dom_b' stand='server' trigger_object='scp_b' type='stay' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_intercept_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
  </condition>
  <function name='active_trigger' type='lua'>
    <param type='value'>start_dom_b</param>
    <param type='actor' target='user_index' />
  </function>
</trigger>
<trigger name='start_dom_b' stand='server' trigger_object='scp_b' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='value'>1</param>
    <param type='game' target='round_time' />
  </condition>
  <function name='set_domination_user_index' type='value'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
  <function name='change_state' type='value'>
    <param type='value'>1</param>
    <param type='value'>1</param>
    <param type='object' target='state' out='yes' />
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>
<trigger name='start_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='continue'>
  <function name='start_domination' type='native'>
    <param type='actor' target='team_id' />
    <param type='value'>2</param>
    <param type='value'>100000</param>
    <param type='object' target='name' />
    <param type='object' target='score' />
  </function>
</trigger>
<trigger name='conflict_dom_b' stand='server' trigger_object='scp_b' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_comflict_area' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='set_conflict_area' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='user_data' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='conflict_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='continue'>
  <function name='cancel_domination' type='native'>
    <param type='actor' target='team_id' />
    <param type='value'>1</param>
  </function>
</trigger>
<trigger name='cancel_conflict_dom_b' stand='server' trigger_object='scp_b' type='leave' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_cancel_conflict_area' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='cancel_domination' type='lua'>
    <param type='actor' target='team_id' />
    <param type='object' target='name' />
  </function>
  <function name='cancel_conflict_area' type='lua'>
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='cancel_conflict_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='continue'>
  <function name='set_object_score' type='native'>
    <param type='object' target='name' />
    <param type='object' target='score' />
  </function>
</trigger>
<trigger name='leave_user_dom_b' stand='server' trigger_object='scp_b' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">cancel_dom_b</param>
    <param type='actor' target='user_index' />
  </function>
</trigger>
<trigger name='leave_user_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='continue'>
  <function name='leave_user_domination' type='native'>
    <param type='actor' target='user_index' />
    <param type='object' target='user_data' />
    <param type='object' target='score' />
    <param type='value'>100000</param>
  </function>
</trigger>
<trigger name='cancel_dom_b' stand='server' trigger_object='scp_b' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
  <condition name='check_cancel_domination' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='cancel_domination' type='lua'>
    <param type='actor' target='team_id' />
    <param type='object' target='name' />
  </function>
  <function name='reset_object_state' type='value'>
    <param type='value'>1</param>
    <param type='value'>0</param>
    <param type='object' target='reset' out='yes'/>
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>
<trigger name='cancel_dom_b' stand='client' trigger_object='scp_b' type='none' update_time='500' active_type='continue'>
  <function name='cancel_domination' type='native'>
  </function>
</trigger>
<trigger name='check_dom_b' stand='server' trigger_object='scp_b' type='object' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
    <param type='game' target='round_time' />
  </condition>
  <function name='add_domination_score' type='lua'>
    <param type='object' target='user_data' />
    <param type='object' target='name' />
    <param type='object' target='flow_time' />
    <param type='object' target='score' op='add' out='yes' />
  </function>
</trigger>
<trigger name='check_dom_b' stand='client' trigger_object='scp_b' type='zone' update_time='500' active_type='continue'>
  <condition name='check_object_state' type='lua'>
    <param type='object' target='state' />
    <param type='value'>1</param>
  </condition>
  <function name='set_domination_rate' type='lua'>
    <param type='self' target='team_id' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='reward_drone_point_dom_b' stand='server' trigger_object='scp_b' type='object' update_time='1000' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
    <param type='game' target='round_time' />
  </condition>
  <function name='add_drone_point_by_domination' type='lua'>
    <param type='object' target='user_data' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='check_score_b' stand='client' trigger_object='scp_b' type='zone' update_time='500' active_type='continue'>
  <function name='output_domination_ui_and_effect' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='name' />
    <param type='self' target='team_id' />
    <param type='value'>100000</param>
    <param type='value'>b</param>
    <param type='game' target='round_time' />
  </function>
</trigger>
<trigger name='check_complete_dom_b' stand='server' trigger_object='scp_b'  type='object' send_act_packet='true' update_time='500' active_type='continue'>
  <condition name='check_object_domination' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='score' />
    <param type='value'>100000</param>
  </condition>
  <function name='change_team_id' type='value'>
    <param type='object' target='user_data' />
    <param type='object' target='team_id' out='yes'/>
  </function>
  <function name='add_score' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='change_state' type='value'>
    <param type='value'>2</param>
    <param type='value'>2</param>
    <param type='object' target='state' out='yes' />
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>

<trigger name='check_complete_dom_b' stand='client' trigger_object='scp_b'  type='none' update_time='500' active_type='continue'>
  <function name='add_score' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='check_dom_client' type='lua'>
  </function>
  <function name='dom_sucess_message' type='lua'>
  </function>
</trigger>
<trigger name='do_dom_b' stand='server' trigger_object='scp_b' type='object' update_time='1000' send_act_packet='true' active_type='continue'>
  <condition name='check_object_team_id' type='lua'>
    <param type='object' target='team_id' />
  </condition>
  <function name='finish_round' type='native'>
    <param type='object' target='team_id' />
  </function>
  <function name='check_finish_game' type='native' />
</trigger>
<trigger name='do_dom_b' stand='client' trigger_object='scp_b'  type='none' update_time='500' active_type='continue'>
</trigger>
<trigger name='finish_game_dom_b' stand='server' trigger_object='scp_b' type='object' update_time='1000' active_type='continue'>
  <condition name='check_object_team_id' type='lua'>
    <param type='object' target='team_id' />
  </condition>
</trigger>
<trigger name='intercept_dom_c' stand='server' trigger_object='scp_c' type='stay' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_intercept_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
  </condition>
  <function name='active_trigger' type='lua'>
    <param type='value'>start_dom_c</param>
    <param type='actor' target='user_index' />
  </function>
</trigger>
<trigger name='start_dom_c' stand='server' trigger_object='scp_c' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='value'>1</param>
    <param type='game' target='round_time' />
  </condition>
  <function name='set_domination_user_index' type='value'>
    <param type='actor' target='user_index' />
    <param type='actor' target='team_id' />
    <param type='object' target='user_index' out='yes' />
    <param type='object' target='user_data' out='yes' />
  </function>
  <function name='change_state' type='value'>
    <param type='value'>1</param>
    <param type='value'>1</param>
    <param type='object' target='state' out='yes' />
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>
<trigger name='start_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='continue'>
  <function name='start_domination' type='native'>
    <param type='actor' target='team_id' />
    <param type='value'>3</param>
    <param type='value'>100000</param>
    <param type='object' target='name' />
    <param type='object' target='score' />
  </function>
</trigger>
<trigger name='conflict_dom_c' stand='server' trigger_object='scp_c' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_comflict_area' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='set_conflict_area' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='user_data' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='conflict_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='continue'>
  <function name='cancel_domination' type='native'>
    <param type='actor' target='team_id' />
    <param type='value'>1</param>
  </function>
</trigger>
<trigger name='cancel_conflict_dom_c' stand='server' trigger_object='scp_c' type='leave' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_cancel_conflict_area' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='cancel_domination' type='lua'>
    <param type='actor' target='team_id' />
    <param type='object' target='name' />
  </function>
  <function name='cancel_conflict_area' type='lua'>
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='cancel_conflict_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='continue'>
  <function name='set_object_score' type='native'>
    <param type='object' target='name' />
    <param type='object' target='score' />
  </function>
</trigger>
<trigger name='leave_user_dom_c' stand='server' trigger_object='scp_c' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
  <function name="lua_call_active_trigger_checked" type="lua">
    <param type="value">cancel_dom_c</param>
    <param type='actor' target='user_index' />
  </function>
</trigger>
<trigger name='leave_user_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='continue'>
  <function name='leave_user_domination' type='native'>
    <param type='actor' target='user_index' />
    <param type='object' target='user_data' />
    <param type='object' target='score' />
    <param type='value'>100000</param>
  </function>
</trigger>
<trigger name='cancel_dom_c' stand='server' trigger_object='scp_c' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
  <condition name='check_cancel_domination' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='name' />
  </condition>
  <function name='cancel_domination' type='lua'>
    <param type='actor' target='team_id' />
    <param type='object' target='name' />
  </function>
  <function name='reset_object_state' type='value'>
    <param type='value'>1</param>
    <param type='value'>0</param>
    <param type='object' target='reset' out='yes'/>
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>
<trigger name='cancel_dom_c' stand='client' trigger_object='scp_c' type='none' update_time='500' active_type='continue'>
  <function name='cancel_domination' type='native'>
  </function>
</trigger>
<trigger name='check_dom_c' stand='server' trigger_object='scp_c' type='object' update_time='500' send_act_packet='true' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
    <param type='game' target='round_time' />
  </condition>
  <function name='add_domination_score' type='lua'>
    <param type='object' target='user_data' />
    <param type='object' target='name' />
    <param type='object' target='flow_time' />
    <param type='object' target='score' op='add' out='yes' />
  </function>
</trigger>
<trigger name='check_dom_c' stand='client' trigger_object='scp_c' type='zone' update_time='500' active_type='continue'>
  <condition name='check_object_state' type='lua'>
    <param type='object' target='state' />
    <param type='value'>1</param>
  </condition>
  <function name='set_domination_rate' type='lua'>
    <param type='self' target='team_id' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='reward_drone_point_dom_c' stand='server' trigger_object='scp_c' type='object' update_time='1000' active_type='continue'>
  <condition name='is_domination' type='lua'>
    <param type='object' target='name' />
    <param type='object' target='state' />
    <param type='game' target='round_time' />
  </condition>
  <function name='add_drone_point_by_domination' type='lua'>
    <param type='object' target='user_data' />
    <param type='object' target='name' />
  </function>
</trigger>
<trigger name='check_score_c' stand='client' trigger_object='scp_c' type='zone' update_time='500' active_type='continue'>
  <function name='output_domination_ui_and_effect' type='lua'>
    <param type='object' target='score' />
    <param type='object' target='name' />
    <param type='self' target='team_id' />
    <param type='value'>100000</param>
    <param type='value'>c</param>
    <param type='game' target='round_time' />
  </function>
</trigger>
<trigger name='check_complete_dom_c' stand='server' trigger_object='scp_c'  type='object' send_act_packet='true' update_time='500' active_type='continue'>
  <condition name='check_object_domination' type='lua'>
    <param type='object' target='state' />
    <param type='object' target='score' />
    <param type='value'>100000</param>
  </condition>
  <function name='change_team_id' type='value'>
    <param type='object' target='user_data' />
    <param type='object' target='team_id' out='yes'/>
  </function>
  <function name='add_score' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='change_state' type='value'>
    <param type='value'>2</param>
    <param type='value'>2</param>
    <param type='object' target='state' out='yes' />
    <param type='object' target='flag' out='yes' />
  </function>
</trigger>
<trigger name='check_complete_dom_c' stand='client' trigger_object='scp_c'  type='none' update_time='500' active_type='continue'>
  <function name='add_score' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='check_dom_client' type='lua'>
  </function>
  <function name='dom_sucess_message' type='lua'>
  </function>
</trigger>
<trigger name='do_dom_c' stand='server' trigger_object='scp_c' type='object' update_time='1000' send_act_packet='true' active_type='continue'>
  <condition name='check_object_team_id' type='lua'>
    <param type='object' target='team_id' />
  </condition>
  <function name='finish_round' type='native'>
    <param type='object' target='team_id' />
  </function>
  <function name='check_finish_game' type='native' />
</trigger>
<trigger name='do_dom_c' stand='client' trigger_object='scp_c'  type='none' update_time='500' active_type='continue'>
</trigger>
<trigger name='finish_game_dom_c' stand='server' trigger_object='scp_c' type='object' update_time='1000' active_type='continue'>
  <condition name='check_object_team_id' type='lua'>
    <param type='object' target='team_id' />
  </condition>
</trigger>
