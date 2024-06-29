<trigger name='mission_ui_trigger' stand='client' type='game' update_time='100' active_type='continue'>
  <function name='output_mission_ui' type='lua'>
    <param type='game' target='time' />
  </function>
</trigger>

<trigger name="finish_trigger" stand="both/server" type="none"  trigger_object="trg_99" update_time="1" active_type="once" send_act_packet="true" component_name="" component_type="0">
	<function name="finish_game" type="native"/>
</trigger>

<!-- trigger_object : 'f_use1' 값을 알맞게 변경하세요 -->
<!-- F키 설치 --------------------------------------------------------------------------------------->
<trigger name='check_enable_start_install_01' trigger_object='f_use1' stand='client' type='stay' update_time='1' active_type='continue'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>0</param>
	</condition>
	<function name='show_action_info' type='lua'>
		<param type='value'>mis2f01</param> <!-- 로컬라이즈 넣으세요 -->
		<param type='value'>100</param>
		<param type='value'>16</param>
	</function>
</trigger>

<!-- F키 누름 (시작) -->
<trigger name='check_start_install_01' trigger_object='f_use1' stand='client' type='usekey_down' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>0</param>
	</condition>
	<function name='set_object_state' type='value'>
		<param type='actor' target='user_index' />
		<param type='value'>2</param>
		<param type='value'>0</param>
		<param type='object' target='user_index' out='yes'/>
		<param type='object' target='state' out='yes' />
		<param type='actor' target='stay_time' out='yes' />		
	</function>
</trigger>

<trigger name='check_start_install_01' trigger_object='f_use1' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='set_object_state' type='value'>
		<param type='value'>0</param>
		<param type='actor' target='stay_time' out='yes' />		
	</function>
	<function name='active_trigger' type='lua'>
		<param type='value'>start_install_01</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<!-- 게이지 시작 -->
<trigger name='start_install_01' trigger_object='f_use1' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='gage_start' type='native'>
		<param type='lua'>install_time</param>	<!-- lua 변수값 넣으세요 -->
		<param type='value'>mis2f04</param> <!-- 로컬라이즈 넣으세요 -->
		<param type='value'>1</param> <!-- 설치 애니메이션 시작 C4 -->
	</function>
</trigger>

<!-- F키 뗌 (중단) -->
<trigger name='check_cancel_install_01' trigger_object='f_use1' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_index' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='lua_call_use_key_press' type='lua' return='false'/>
	<function name='set_object_state' type='value'>
		<param type='value'>11</param>
		<param type='object' target='state' out='yes' />		
	</function>
</trigger>

<trigger name='check_cancel_install_01' trigger_object='f_use1' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_final_01</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<trigger name='cancel_install_final_01' trigger_object='f_use1' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='reset_object_state' type='value'>
		<param type='value'>1</param>
		<param type='object' target='reset' out='yes'/>
	</function>
</trigger>

<trigger name='cancel_install_final_01' trigger_object='f_use1' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='gage_stop' type='native'>
	<param type='value'>1</param> <!-- 설치 애니메이션 캔슬 -->
	</function>	
</trigger>

<!-- 트리거 범위를 벗어남 -->
<trigger name='leave_install_01' trigger_object='f_use1' stand='client' type='leave' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_index' />
		<param type='actor' target='user_index' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>11</param>
		<param type='object' target='state' out='yes' />		
	</function>
</trigger>

<trigger name='leave_install_01' trigger_object='f_use1' stand='server' type='none' active_type='continue' update_time='1'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_final_01</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<trigger name='check_finish_install_01' trigger_object='f_use1' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='check_finish_install_time' type='lua'>
		<param type='actor' target='stay_time' />
		<param type='actor' target='rate' />
		<param type='actor' target='keypress_time' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>3</param>
		<param type='actor' target='user_index' />
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
		<param type='value'>1</param>
		<param type='object' target='state' out='yes' />
		<param type='object' target='user_index' out='yes' />
		<param type='object' target='team_id' out='yes' />
		<param type='object' target='touch' out='yes' />
		<param type='object' target='flag' out='yes' />
	</function>
	<function name='active_trigger' type='lua'>
		<param type='value'>install_01</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<!-- 설치 (성공) -->
<trigger name='install_01' trigger_object='f_use1' stand='client' type='none' update_time='1' active_type='once' send_act_packet='true'>
  <function name='install_bomb_add_time' type='lua'>
    <param type='game' target='time' />
  </function>

  <function name='play_simple_sound' type='native'>
		<param type='value'>/mode_test/SND/planted_fx</param>
	</function>
	
	<function name='active_trigger' type='lua'>
		<param type='value'>main_f_end1</param>
		<param type='object' target='user_index' />
	</function>
	
	<function name='gage_stop' type='native'>
	<param type='value'>1</param> <!-- 설치 애니메이션 캔슬 -->
	</function>		
</trigger>


<trigger name='install_01' trigger_object='f_use1' stand='server' type='none' update_time='1' active_type='once'>
	<function name='active_trigger' type='lua'>
		<param type='value'>main_f_end1</param>
		<param type='object' target='user_index' />
	</function>
	
</trigger>








<!-- trigger_object : 'f_use2' 값을 알맞게 변경하세요 -->
<!-- F키 설치 --------------------------------------------------------------------------------------->
<trigger name='check_enable_start_install_02' trigger_object='f_use2' stand='client' type='stay' update_time='1' active_type='continue'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>0</param>
	</condition>
	<function name='show_action_info' type='lua'>
		<param type='value'>mis2f01</param> <!-- 로컬라이즈 넣으세요 -->
		<param type='value'>100</param>
		<param type='value'>16</param>
	</function>
</trigger>

<!-- F키 누름 (시작) -->
<trigger name='check_start_install_02' trigger_object='f_use2' stand='client' type='usekey_down' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>0</param>
	</condition>
	<function name='set_object_state' type='value'>
		<param type='actor' target='user_index' />
		<param type='value'>2</param>
		<param type='value'>0</param>
		<param type='object' target='user_index' out='yes'/>
		<param type='object' target='state' out='yes' />
		<param type='actor' target='stay_time' out='yes' />		
	</function>
</trigger>

<trigger name='check_start_install_02' trigger_object='f_use2' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='set_object_state' type='value'>
		<param type='value'>0</param>
		<param type='actor' target='stay_time' out='yes' />		
	</function>
	<function name='active_trigger' type='lua'>
		<param type='value'>start_install_02</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<!-- 게이지 시작 -->
<trigger name='start_install_02' trigger_object='f_use2' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='gage_start' type='native'>
		<param type='lua'>install_time</param>	<!-- lua 변수값 넣으세요 -->
		<param type='value'>mis2f04</param> <!-- 로컬라이즈 넣으세요 -->
		<param type='value'>1</param> <!-- 설치 애니메이션 시작 C4 -->
	</function>
</trigger>

<!-- F키 뗌 (중단) -->
<trigger name='check_cancel_install_02' trigger_object='f_use2' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_index' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='lua_call_use_key_press' type='lua' return='false'/>
	<function name='set_object_state' type='value'>
		<param type='value'>11</param>
		<param type='object' target='state' out='yes' />		
	</function>
</trigger>

<trigger name='check_cancel_install_02' trigger_object='f_use2' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_final_02</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<trigger name='cancel_install_final_02' trigger_object='f_use2' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='reset_object_state' type='value'>
		<param type='value'>1</param>
		<param type='object' target='reset' out='yes'/>
	</function>
</trigger>

<trigger name='cancel_install_final_02' trigger_object='f_use2' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='gage_stop' type='native'>
	<param type='value'>1</param> <!-- 설치 애니메이션 캔슬 -->
	</function>	
</trigger>

<!-- 트리거 범위를 벗어남 -->
<trigger name='leave_install_02' trigger_object='f_use2' stand='client' type='leave' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_index' />
		<param type='actor' target='user_index' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>11</param>
		<param type='object' target='state' out='yes' />		
	</function>
</trigger>

<trigger name='leave_install_02' trigger_object='f_use2' stand='server' type='none' active_type='continue' update_time='1'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_final_02</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<trigger name='check_finish_install_02' trigger_object='f_use2' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='check_finish_install_time' type='lua'>
		<param type='actor' target='stay_time' />
		<param type='actor' target='rate' />
		<param type='actor' target='keypress_time' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>3</param>
		<param type='actor' target='user_index' />
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
		<param type='value'>1</param>
		<param type='object' target='state' out='yes' />
		<param type='object' target='user_index' out='yes' />
		<param type='object' target='team_id' out='yes' />
		<param type='object' target='touch' out='yes' />
		<param type='object' target='flag' out='yes' />
	</function>
	<function name='active_trigger' type='lua'>
		<param type='value'>install_02</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<!-- 설치 (성공) -->
<trigger name='install_02' trigger_object='f_use2' stand='client' type='none' update_time='1' active_type='once' send_act_packet='true'>
  <function name='install_bomb_add_time' type='lua'>
    <param type='game' target='time' />
  </function>

  <function name='play_simple_sound' type='native'>
		<param type='value'>/mode_test/SND/planted_fx</param>
	</function>
	
	<function name='active_trigger' type='lua'>
		<param type='value'>main_f_end2</param>
		<param type='object' target='user_index' />
	</function>
	
	<function name='gage_stop' type='native'>
	<param type='value'>1</param> <!-- 설치 애니메이션 캔슬 -->
	</function>	
</trigger>


<trigger name='install_02' trigger_object='f_use2' stand='server' type='none' update_time='1' active_type='once'>
	<function name='active_trigger' type='lua'>
		<param type='value'>main_f_end2</param>
		<param type='object' target='user_index' />
	</function>
	<function name='gage_stop' type='native'>
	<param type='value'>1</param> <!-- 설치 애니메이션 캔슬 -->
	</function>	
</trigger>













<!-- trigger_object : 'f_use3' 값을 알맞게 변경하세요 -->
<!-- F키 설치 --------------------------------------------------------------------------------------->
<trigger name='check_enable_start_install_03' trigger_object='f_use3' stand='client' type='stay' update_time='1' active_type='continue'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>0</param>
	</condition>
	<function name='show_action_info' type='lua'>
		<param type='value'>mis2f01</param> <!-- 로컬라이즈 넣으세요 -->
		<param type='value'>100</param>
		<param type='value'>16</param>
	</function>
</trigger>

<!-- F키 누름 (시작) -->
<trigger name='check_start_install_03' trigger_object='f_use3' stand='client' type='usekey_down' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>0</param>
	</condition>
	<function name='set_object_state' type='value'>
		<param type='actor' target='user_index' />
		<param type='value'>2</param>
		<param type='value'>0</param>
		<param type='object' target='user_index' out='yes'/>
		<param type='object' target='state' out='yes' />
		<param type='actor' target='stay_time' out='yes' />		
	</function>
</trigger>

<trigger name='check_start_install_03' trigger_object='f_use3' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='set_object_state' type='value'>
		<param type='value'>0</param>
		<param type='actor' target='stay_time' out='yes' />		
	</function>
	<function name='active_trigger' type='lua'>
		<param type='value'>start_install_03</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<!-- 게이지 시작 -->
<trigger name='start_install_03' trigger_object='f_use3' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='gage_start' type='native'>
		<param type='lua'>install_time</param>	<!-- lua 변수값 넣으세요 -->
		<param type='value'>mis2f04</param> <!-- 로컬라이즈 넣으세요 -->
		<param type='value'>1</param> <!-- 설치 애니메이션 시작 C4 -->
	</function>
</trigger>

<!-- F키 뗌 (중단) -->
<trigger name='check_cancel_install_03' trigger_object='f_use3' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_index' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='lua_call_use_key_press' type='lua' return='false'/>
	<function name='set_object_state' type='value'>
		<param type='value'>11</param>
		<param type='object' target='state' out='yes' />		
	</function>
</trigger>

<trigger name='check_cancel_install_03' trigger_object='f_use3' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_final_03</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<trigger name='cancel_install_final_03' trigger_object='f_use3' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='reset_object_state' type='value'>
		<param type='value'>1</param>
		<param type='object' target='reset' out='yes'/>
	</function>
</trigger>

<trigger name='cancel_install_final_03' trigger_object='f_use3' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='gage_stop' type='native'>
	<param type='value'>1</param> <!-- 설치 애니메이션 캔슬 -->
	</function>	
</trigger>

<!-- 트리거 범위를 벗어남 -->
<trigger name='leave_install_03' trigger_object='f_use3' stand='client' type='leave' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_index' />
		<param type='actor' target='user_index' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>11</param>
		<param type='object' target='state' out='yes' />		
	</function>
</trigger>

<trigger name='leave_install_03' trigger_object='f_use3' stand='server' type='none' active_type='continue' update_time='1'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_final_03</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<trigger name='check_finish_install_03' trigger_object='f_use3' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='check_finish_install_time' type='lua'>
		<param type='actor' target='stay_time' />
		<param type='actor' target='rate' />
		<param type='actor' target='keypress_time' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>3</param>
		<param type='actor' target='user_index' />
		<param type='actor' target='team_id' />
		<param type='value'>1</param>
		<param type='value'>1</param>
		<param type='object' target='state' out='yes' />
		<param type='object' target='user_index' out='yes' />
		<param type='object' target='team_id' out='yes' />
		<param type='object' target='touch' out='yes' />
		<param type='object' target='flag' out='yes' />
	</function>
	<function name='active_trigger' type='lua'>
		<param type='value'>install_03</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<!-- 설치 (성공) -->
<trigger name='install_03' trigger_object='f_use3' stand='client' type='none' update_time='1' active_type='once' send_act_packet='true'>
  <function name='install_bomb_add_time' type='lua'>
    <param type='game' target='time' />
  </function>

  <function name='play_simple_sound' type='native'>
		<param type='value'>/mode_test/SND/planted_fx</param>
	</function>
	
	<function name='active_trigger' type='lua'>
		<param type='value'>main_f_end3</param>
		<param type='object' target='user_index' />
	</function>
	
	<function name='gage_stop' type='native'>
	<param type='value'>1</param> <!-- 설치 애니메이션 캔슬 -->
	</function>	
</trigger>


<trigger name='install_03' trigger_object='f_use3' stand='server' type='none' update_time='1' active_type='once'>
	<function name='active_trigger' type='lua'>
		<param type='value'>main_f_end3</param>
		<param type='object' target='user_index' />
	</function>
	
</trigger>