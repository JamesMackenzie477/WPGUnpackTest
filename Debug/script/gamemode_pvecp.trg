<trigger name='init_dom_a' stand='client' trigger_object='trg_a' type='init' update_time='500' active_type='once' >
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='object' target='team_id' />
	</function>
</trigger>
<trigger name='start_dom_a' stand='server' trigger_object='trg_a' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
	<condition name='is_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
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
<trigger name='start_dom_a' stand='client' trigger_object='trg_a' type='none' update_time='500' active_type='continue'>
	<function name='start_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
		<param type='value'>10000</param>
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_a' stand='server' trigger_object='trg_a' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
	<condition name='check_cancel_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='actor' target='team_id' />
	</condition>
	<function name='cancel_domination' type='lua'>
		<param type='actor' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_a' stand='client' trigger_object='trg_a' type='none' update_time='500' active_type='continue'>
	<function name='cancel_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
	</function>
</trigger>

<trigger name='check_dom_a' stand='server' trigger_object='trg_a' type='object' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='add_domination_score' type='lua'>
		<param type='object' target='user_data' />
		<param type='object' target='name' />
		<param type='object' target='flow_time' />
		<param type='object' target='score' op='add' out='yes' />
	</function>
</trigger>
<trigger name='check_dom_a' stand='client' trigger_object='trg_a' type='zone' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='set_domination_rate' type='lua'>
		<param type='self' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='check_complete_dom_a' stand='server' trigger_object='trg_a'  type='object' send_act_packet='true' update_time='500' active_type='continue'>
	<condition name='check_object_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='score' />
		<param type='value'>10000</param>
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
		<param type='object' target='state' out='yes' />	
	</function>
</trigger>

<trigger name='check_complete_dom_a' stand='client' trigger_object='trg_a'  type='none' update_time='500' active_type='continue'>
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
	</function>
	
	<function name='add_score' type='lua'>
	<param type='object' target='team_id' />
	</function>
	
	<function name='domination_message' type='lua'>
		<param type='owner' target='user_index'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
		<param type='value'>msg0010020</param>
		<param type='value'>msg0010021</param>
	</function>
	<function name='domination' type='native'>
		<param type='owner' target='team_id' />
		<param type='value'>1</param>
		<param type='owner' target='user_index' />
	</function>
	
	
	<function name='check_dom_client' type='lua'>
	</function>
	

	
	<function name='dom_sucess_message' type='lua'>
	</function>
	
	
	
	
</trigger>
<trigger name='do_dom_a' stand='server' trigger_object='trg_a' type='object' update_time='1000' send_act_packet='true' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>
	
	<function name='random_dom' type='lua'>
	</function>
	
	<function name='check_dom' type='lua'>
	</function>
	
	<function name='domination' type='native'>
		<param type='object' target='team_id' />
	</function>
	
	<function name='check_finish_game' type='native' />
	
</trigger>

<trigger name='do_dom_a' stand='client' trigger_object='trg_a'  type='none' update_time='500' active_type='continue'>

</trigger>

<trigger name='finish_game_dom_a' stand='server' trigger_object='trg_a' type='object' update_time='1000' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>
	
</trigger>


<trigger name='init_dom_b' stand='client' trigger_object='trg_b' type='init' update_time='500' active_type='once' >
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='object' target='team_id' />
	</function>
</trigger>
<trigger name='start_dom_b' stand='server' trigger_object='trg_b' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
	<condition name='is_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
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

<trigger name='start_dom_b' stand='client' trigger_object='trg_b' type='none' update_time='500' active_type='continue'>
	<function name='start_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>2</param>
		<param type='value'>10000</param>
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_b' stand='server' trigger_object='trg_b' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
	<condition name='check_cancel_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='actor' target='team_id' />
	</condition>
	<function name='cancel_domination' type='lua'>
		<param type='actor' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_b' stand='client' trigger_object='trg_b' type='none' update_time='500' active_type='continue'>
	<function name='cancel_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>2</param>
	</function>
</trigger>

<trigger name='check_dom_b' stand='server' trigger_object='trg_b' type='object' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='add_domination_score' type='lua'>
		<param type='object' target='user_data' />
		<param type='object' target='name' />
		<param type='object' target='flow_time' />
		<param type='object' target='score' op='add' out='yes' />
	</function>
</trigger>
<trigger name='check_dom_b' stand='client' trigger_object='trg_b' type='zone' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='set_domination_rate' type='lua'>
		<param type='self' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='check_complete_dom_b' stand='server' trigger_object='trg_b'  type='object' send_act_packet='true' update_time='500' active_type='continue'>
	
	
	<condition name='check_object_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='score' />
		<param type='value'>10000</param>
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
		<param type='object' target='state' out='yes' />	
	</function>
	

	
</trigger>

<trigger name='check_complete_dom_b' stand='client' trigger_object='trg_b'  type='none' update_time='500' active_type='continue'>
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
	</function>
		<function name='add_score' type='lua'>
	<param type='object' target='team_id' />
	</function>
	
	<function name='domination_message' type='lua'>
		<param type='owner' target='user_index'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
		<param type='value'>msg0010022</param>
		<param type='value'>msg0010023</param>
	</function>
	<function name='domination' type='native'>
		<param type='owner' target='team_id' />
		<param type='value'>2</param>
		<param type='owner' target='user_index' />
	</function>
	<function name='check_dom_client' type='lua'>
	</function>
	
		<function name='dom_sucess_message' type='lua'>
	</function>
</trigger>
<trigger name='do_dom_b' stand='server' trigger_object='trg_b' type='object' update_time='1000' send_act_packet='true' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>
	<function name='random_dom' type='lua'>
	</function>
	<function name='check_dom' type='lua'>
	</function>
	<function name='domination' type='native'>
		<param type='object' target='team_id' />
	</function>
		<function name='check_finish_game' type='native' />
</trigger>

<trigger name='do_dom_b' stand='client' trigger_object='trg_b'  type='none' update_time='500' active_type='continue'>

</trigger>

<trigger name='finish_game_dom_b' stand='server' trigger_object='trg_b' type='object' update_time='1000' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>

</trigger>

<trigger name='init_dom_c' stand='client' trigger_object='trg_c' type='init' update_time='500' active_type='once' >
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='object' target='team_id' />
	</function>
</trigger>
<trigger name='start_dom_c' stand='server' trigger_object='trg_c' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
	<condition name='is_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
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
<trigger name='start_dom_c' stand='client' trigger_object='trg_c' type='none' update_time='500' active_type='continue'>
	<function name='start_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>3</param>
		<param type='value'>10000</param>
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_c' stand='server' trigger_object='trg_c' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
	<condition name='check_cancel_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='actor' target='team_id' />
	</condition>
	<function name='cancel_domination' type='lua'>
		<param type='actor' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_c' stand='client' trigger_object='trg_c' type='none' update_time='500' active_type='continue'>
	<function name='cancel_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>3</param>
	</function>
</trigger>

<trigger name='check_dom_c' stand='server' trigger_object='trg_c' type='object' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='add_domination_score' type='lua'>
		<param type='object' target='user_data' />
		<param type='object' target='name' />
		<param type='object' target='flow_time' />
		<param type='object' target='score' op='add' out='yes' />
	</function>
</trigger>
<trigger name='check_dom_c' stand='client' trigger_object='trg_c' type='zone' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='set_domination_rate' type='lua'>
		<param type='self' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='check_complete_dom_c' stand='server' trigger_object='trg_c'  type='object' send_act_packet='true' update_time='500' active_type='continue'>
	<condition name='check_object_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='score' />
		<param type='value'>10000</param>
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
		<param type='object' target='state' out='yes' />	
	</function>
</trigger>

<trigger name='check_complete_dom_c' stand='client' trigger_object='trg_c'  type='none' update_time='500' active_type='continue'>
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
	</function>
	
	<function name='add_score' type='lua'>
	<param type='object' target='team_id' />
	</function>
	
	<function name='domination_message' type='lua'>
		<param type='owner' target='user_index'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
		<param type='value'>msg0010024</param>
		<param type='value'>msg0010025</param>
	</function>
	<function name='domination' type='native'>
		<param type='owner' target='team_id' />
		<param type='value'>3</param>
		<param type='owner' target='user_index' />
	</function>
		<function name='check_dom_client' type='lua'>
	</function>

	
		<function name='dom_sucess_message' type='lua'>
	</function>
	
</trigger>
<trigger name='do_dom_c' stand='server' trigger_object='trg_c' type='object' update_time='1000' send_act_packet='true' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>
	
	
	<function name='domination' type='native'>
		<param type='object' target='team_id' />
	</function>
	
		<function name='random_dom' type='lua'>
	</function>

	<function name='check_dom' type='lua'>
	</function>
	
		<function name='check_finish_game' type='native' />
</trigger>

<trigger name='do_dom_c' stand='client' trigger_object='trg_c'  type='none' update_time='500' active_type='continue'>

</trigger>

<trigger name='finish_game_dom_c' stand='server' trigger_object='trg_c' type='object' update_time='1000' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>

</trigger>

<trigger name='init_dom_d' stand='client' trigger_object='trg_d' type='init' update_time='500' active_type='once' >
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='object' target='team_id' />
	</function>
</trigger>
<trigger name='start_dom_d' stand='server' trigger_object='trg_d' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
	<condition name='is_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
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
<trigger name='start_dom_d' stand='client' trigger_object='trg_d' type='none' update_time='500' active_type='continue'>
	<function name='start_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
		<param type='value'>10000</param>
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_d' stand='server' trigger_object='trg_d' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
	<condition name='check_cancel_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='actor' target='team_id' />
	</condition>
	<function name='cancel_domination' type='lua'>
		<param type='actor' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_d' stand='client' trigger_object='trg_d' type='none' update_time='500' active_type='continue'>
	<function name='cancel_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
	</function>
</trigger>

<trigger name='check_dom_d' stand='server' trigger_object='trg_d' type='object' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='add_domination_score' type='lua'>
		<param type='object' target='user_data' />
		<param type='object' target='name' />
		<param type='object' target='flow_time' />
		<param type='object' target='score' op='add' out='yes' />
	</function>
</trigger>
<trigger name='check_dom_d' stand='client' trigger_object='trg_d' type='zone' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='set_domination_rate' type='lua'>
		<param type='self' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='check_complete_dom_d' stand='server' trigger_object='trg_d'  type='object' send_act_packet='true' update_time='500' active_type='continue'>
	<condition name='check_object_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='score' />
		<param type='value'>10000</param>
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
		<param type='object' target='state' out='yes' />	
	</function>
	
	
</trigger>

<trigger name='check_complete_dom_d' stand='client' trigger_object='trg_d'  type='none' update_time='500' active_type='continue'>
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
	</function>
	
		<function name='add_score' type='lua'>
	<param type='object' target='team_id' />
	</function>
	
	<function name='domination_message' type='lua'>
		<param type='owner' target='user_index'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
		<param type='value'>msg0010020</param>
		<param type='value'>msg0010021</param>
	</function>
	<function name='domination' type='native'>
		<param type='owner' target='team_id' />
		<param type='value'>1</param>
		<param type='owner' target='user_index' />
	</function>
	<function name='check_dom_client' type='lua'>
	</function>
		<function name='dom_sucess_message' type='lua'>
	</function>
	
</trigger>
<trigger name='do_dom_d' stand='server' trigger_object='trg_d' type='object' update_time='1000' send_act_packet='true' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>
	
	<function name='random_dom' type='lua'>
	</function>
	
	<function name='check_dom' type='lua'>
	</function>
	<function name='domination' type='native'>
		<param type='object' target='team_id' />
	</function>
		<function name='check_finish_game' type='native' />
</trigger>

<trigger name='do_dom_d' stand='client' trigger_object='trg_d'  type='none' update_time='500' active_type='continue'>

</trigger>

<trigger name='finish_game_dom_d' stand='server' trigger_object='trg_d' type='object' update_time='1000' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>

</trigger>


<trigger name='init_dom_e' stand='client' trigger_object='trg_e' type='init' update_time='500' active_type='once' >
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='object' target='team_id' />
	</function>
</trigger>
<trigger name='start_dom_e' stand='server' trigger_object='trg_e' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
	<condition name='is_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
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

<trigger name='init_dom_e' stand='client' trigger_object='trg_e' type='init' update_time='500' active_type='once' >
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='object' target='team_id' />
	</function>
</trigger>
<trigger name='start_dom_e' stand='server' trigger_object='trg_e' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
	<condition name='is_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
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
<trigger name='start_dom_e' stand='client' trigger_object='trg_e' type='none' update_time='500' active_type='continue'>
	<function name='start_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
		<param type='value'>10000</param>
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_e' stand='server' trigger_object='trg_e' type='leave' update_time='500' send_act_packet='true'  active_type='continue'>
	<condition name='check_cancel_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='actor' target='team_id' />
	</condition>
	<function name='cancel_domination' type='lua'>
		<param type='actor' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='cancel_dom_e' stand='client' trigger_object='trg_e' type='none' update_time='500' active_type='continue'>
	<function name='cancel_domination' type='native'>
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
	</function>
</trigger>

<trigger name='check_dom_e' stand='server' trigger_object='trg_e' type='object' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='add_domination_score' type='lua'>
		<param type='object' target='user_data' />
		<param type='object' target='name' />
		<param type='object' target='flow_time' />
		<param type='object' target='score' op='add' out='yes' />
	</function>
</trigger>
<trigger name='check_dom_e' stand='client' trigger_object='trg_e' type='zone' update_time='500' active_type='continue'>
	<condition name='check_object_state' type='lua'>
		<param type='object' target='state' />
		<param type='value'>1</param>
	</condition>
	<function name='set_domination_rate' type='lua'>
		<param type='self' target='team_id' />
		<param type='object' target='name' />
	</function>
</trigger>

<trigger name='check_complete_dom_e' stand='server' trigger_object='trg_e'  type='object' send_act_packet='true' update_time='500' active_type='continue'>
	<condition name='check_object_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='score' />
		<param type='value'>10000</param>
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
		<param type='object' target='state' out='yes' />	
	</function>
</trigger>

<trigger name='check_complete_dom_e' stand='client' trigger_object='trg_e'  type='none' update_time='500' active_type='continue'>
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
	</function>
	
	<function name='add_score' type='lua'>
	<param type='object' target='team_id' />
	</function>
	
	<function name='domination_message' type='lua'>
		<param type='owner' target='user_index'/>
		<param type='self' target='team_id' />
		<param type='owner' target='team_id' />
		<param type='value'>msg0010020</param>
		<param type='value'>msg0010021</param>
	</function>
	<function name='domination' type='native'>
		<param type='owner' target='team_id' />
		<param type='value'>1</param>
		<param type='owner' target='user_index' />
	</function>
	<function name='check_dom_client' type='lua'>
	</function>
		<function name='dom_sucess_message' type='lua'>
	</function>
	
</trigger>
<trigger name='do_dom_e' stand='server' trigger_object='trg_e' type='object' update_time='1000' send_act_packet='true' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>

	<function name='random_dom' type='lua'>
	</function>
	
	<function name='check_dom' type='lua'>
	</function>
	<function name='domination' type='native'>
		<param type='object' target='team_id' />
	</function>
	<function name='check_finish_game' type='native' />
</trigger>
</trigger>

<trigger name='do_dom_e' stand='client' trigger_object='trg_e'  type='none' update_time='500' active_type='continue'>

</trigger>

<trigger name='finish_game_dom_e' stand='server' trigger_object='trg_e' type='object' update_time='1000' active_type='continue'>
	<condition name='check_object_team_id' type='lua'>
		<param type='object' target='team_id' />
	</condition>
	


<trigger name='init_dom_e' stand='client' trigger_object='trg_e' type='init' update_time='500' active_type='once' >
	<function name='change_domination_icon' type='lua'>
		<param type='object' target='name'/>
		<param type='self' target='team_id' />
		<param type='object' target='team_id' />
	</function>
</trigger>
<trigger name='start_dom_e' stand='server' trigger_object='trg_e' type='enter' update_time='500' send_act_packet='true' active_type='continue'>
	<condition name='is_domination' type='lua'>
		<param type='object' target='state' />
		<param type='object' target='user_data' />
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
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