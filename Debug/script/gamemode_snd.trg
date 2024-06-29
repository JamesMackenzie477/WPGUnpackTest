<!-- 이하 폭파 A -->
<!-- 이하 폭파 A -->
<!-- 이하 폭파 A -->
<trigger name='check_enable_start_install_dem_a' trigger_object='bombsite_a' stand='client' type='stay' update_time='1' active_type='continue'>
	<condition name='check_exist_weapon' type='lua'> <!-- 폭탄을 가지고 있는가? -->
		<param type='actor' target='user_index' />
		<param type='value'>248</param>
	</condition>
	<condition name='check_object_state'> <!-- 폭탄이 설치가 안됐는가? -->
		<param type='object' target='state' />
		<param type='value'>0</param>
	</condition>
	<function name='show_action_info' type='lua'> <!-- 폭탄 설치 메시지 -->
		<param type='value'>msg0000013</param>
		<param type='value'>100</param>
		<param type='value'>16</param>
	</function>
</trigger>

<!-- F키 누름 (설치시작) (client) -->
<trigger name='check_start_install_dem_a' trigger_object='bombsite_a' stand='client' type='usekey_down' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_exist_weapon' type='lua'>  <!-- 폭탄을 가지고 있는가? -->
		<param type='actor' target='user_index' />
		<param type='value'>248</param>
	</condition>
	<condition name='check_object_state'> <!-- 폭탄이 설치가 안됐는가? -->
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

<!-- F키 누름 (설치시작) (server) -->
<trigger name='check_start_install_dem_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='set_object_state' type='value'>
		<param type='actor' target='stay_time' out='yes' />		
		<param type='value'>0</param>
	</function>
	<function name='active_trigger' type='lua'>
		<param type='value'>start_install_dem_a</param>
		<param type='object' target='user_index' />
	</function>
	<function name='start_install_bomb_server' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>	
</trigger>

<trigger name='start_install_dem_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
</trigger>
<trigger name='start_install_dem_a' trigger_object='bombsite_a' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='start_install_bomb' type='native'>
		<param type='value'>1</param>
		<param type='lua'>demolition_bomb_install_time</param>
		<param type='object' target='name' />
	</function>
	<function name='play_sound' type='native'>
		<param type='value'>gamemode</param>
		<param type='value'>snd_plant</param>
	</function>
</trigger>

<!-- F키 뗌 (설치중단) -->
<trigger name='check_cancel_install_dem_a' trigger_object='bombsite_a' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
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

<trigger name='check_cancel_install_dem_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_dem_a_final</param>
		<param type='object' target='user_index' />
	</function>
	<function name='end_mission' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>

<trigger name='cancel_install_dem_a_final' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='reset_object_state' type='value'>
		<param type='value'>1</param>
		<param type='object' target='reset' out='yes'/>
	</function>
</trigger>

<trigger name='cancel_install_dem_a_final' trigger_object='bombsite_a' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='cancel_install_bomb' type='native'>
		<param type='value'>1</param>
	</function>
</trigger>

<trigger name='leave_install_dem_a' trigger_object='bombsite_a' stand='client' type='leave' update_time='1' active_type='continue' send_act_packet='true'>
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

<trigger name='leave_install_dem_a' trigger_object='bombsite_a' stand='server' type='none' active_type='continue' update_time='1'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_dem_a_final</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<trigger name='check_finish_install_dem_a' trigger_object='bombsite_a' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_exist_weapon' type='lua'>
		<param type='actor' target='user_index' />
		<param type='value'>248</param>
	</condition>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='check_finish_install_bomb' type='lua'>
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
</trigger>

<trigger name='check_finish_install_dem_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='end_mission' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>

<!-- A 설치 성공 (server) -->
<trigger name='install_dem_a' trigger_object='bombsite_a' stand='server' type='object' update_time='1' active_type='once' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<function name='install_bomb' type='native' />
  <function name='team_add_point_by_install_bomb' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='set_object_touch' type='value'>
		<param type='value'>1</param>
		<param type='object' target='touch' out='yes' />
	</function>
	<function name='visible_object' type='lua'> <!-- 폭탄 가방 보임 -->
		<param type='value'>bombinst_a</param>
		<param type='value'>1</param>
	</function>
	<function name='active_trigger' type='lua'> <!-- A 설치 성공 애니메이션 -->
		<param type='value'>main_inst_a_s</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<!-- A 설치 성공 애니메이션-->
<trigger name="main_inst_a_s" stand="both/server" trigger_object="inst_a_s" type="none" update_time="500" active_type="continue" bind_object="inst_a_s" send_act_packet="true" component_name="" component_type="0">
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">destructible_inst_a_sde1</param>
	</function>
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">act_trg_inst_a_sat1</param>
		<param type="actor" target="user_index" />
	</function>
</trigger>
<trigger name="destructible_inst_a_sde1" stand="both/server" trigger_object="inst_a_s" type="none" update_time="500" active_type="continue" bind_object="snd_tar_a" send_act_packet="true" component_name="de1" component_type="23">
	<function name="lua_call_set_destructible_hp" type="lua">
		<param type="value">snd_tar_a</param>
		<param type="value">300.000000</param>
	</function>
</trigger>
<trigger name="act_trg_inst_a_sat1" stand="both/server" trigger_object="inst_a_s" type="none" update_time="500" active_type="continue" bind_object="inst_a_lp" send_act_packet="true" component_name="at1" component_type="7">
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">start_wait_inst_a_lp</param>
		<param type="actor" target="user_index" />
	</function>
</trigger>
<trigger name="main_inst_a_lp" stand="both/server" trigger_object="inst_a_lp" type="none" update_time="500" active_type="continue" bind_object="inst_a_lp" send_act_packet="true" component_name="" component_type="0">
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">destructible_inst_a_lpde1</param>
	</function>
</trigger>
<trigger name="start_wait_inst_a_lp" stand="both/server" trigger_object="inst_a_lp" type="none" update_time="500" active_type="continue" bind_object="inst_a_lp" send_act_packet="true" component_name="" component_type="0">
	<condition name="lua_call_is_enable_trigger" type="lua" return="false">
		<param type="value">on_wait_inst_a_lp</param>
	</condition>
	<function name="lua_call_set_enable_trigger" type="lua">
		<param type="value">on_wait_inst_a_lp</param>
		<param type="value">1</param>
	</function>
</trigger>
<trigger name="on_wait_inst_a_lp" stand="both/server" trigger_object="inst_a_lp" type="game" update_time="1" active_type="continue" bind_object="inst_a_lp" send_act_packet="true" component_name="" component_type="0" enable="false">
	<condition name="check_play_time" type="lua">
		<param type="self_trigger" target="active_time" />
		<param type="value">4000</param>
	</condition>
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">end_wait_inst_a_lp</param>
	</function>
</trigger>
<trigger name="end_wait_inst_a_lp" stand="both/server" trigger_object="inst_a_lp" type="none" update_time="500" active_type="continue" bind_object="inst_a_lp" send_act_packet="true" component_name="" component_type="0">
	<function name="lua_call_set_enable_trigger" type="lua">
		<param type="value">on_wait_inst_a_lp</param>
		<param type="value">0</param>
	</function>
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">main_inst_a_lp</param>
	</function>
</trigger>
<trigger name="destructible_inst_a_lpde1" stand="both/server" trigger_object="inst_a_lp" type="none" update_time="500" active_type="continue" bind_object="snd_tar_a" send_act_packet="true" component_name="de1" component_type="23">
	<function name="lua_call_set_destructible_hp" type="lua">
		<param type="value">snd_tar_a</param>
		<param type="value">200.000000</param>
	</function>
</trigger>

<!-- A 설치 성공 (client) -->
<trigger name='install_dem_a' trigger_object='bombsite_a' stand='client' type='none' update_time='1' active_type='once'>
	<function name='install_bomb' type='native'>
		<param type='value'>1</param>
		<param type='owner' target='user_index' />
		<param type='lua'>demolition_bomb_act_time</param>
	</function>
	<function name='visible_object' type='lua'> <!-- 폭탄 가방 보임 -->
		<param type='value'>bombinst_a</param>
		<param type='value'>1</param>
	</function>
	<function name='play_simple_sound' type='native'> <!-- 폭탄 설치 효과음 -->
		<param type='value'>/level_common/mode/snd/planted_fx</param> 
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--비프음(삐삑) -->
		<param type="value">inst_a_snd</param>
		<param type="value">1</param>
		<param type="value">bombsite_a</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--설치 후 배경음 -->
		<param type="value">inst_a_bgm</param>
		<param type="value">1</param>
		<param type="value">bombsite_a</param>
	</function>
	<function name="play_effect" type="native"> <!-- 빨간 색 점멸등 이펙트 -->
		<param type="value">bombeff_a</param>
		<param type='play'>1</param>
	</function>
	<function name="lua_call_set_observer_cam" type="lua"> <!-- 옵저버 카메라를 이동 -->
		<param type="value">snd_cam_a</param>
	</function>
  <function name="play_bomb_team_sound" type="lua">
    <param type='object' target='team_id' />
    <param type='self' target='team_id' />
  </function>
</trigger>

<!-- A 폭파 성공 (server) -->
<trigger name='check_demolition_dem_a' trigger_object='bombsite_a' stand='server' type='object' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<condition name='check_demolition' type='lua'>
		<param type='object' target='touch' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>4</param>
		<param type='object' target='state' out='yes' />
	</function>
	<function name='visible_object' type='lua'> <!-- 폭탄 가방  숨김 -->
		<param type='value'>bombinst_a</param>
		<param type='value'>0</param>
	</function>
	<function name='demolition' type='native'>
		<param type='value'>snd_tar_a</param>
	</function>
</trigger>

<!-- A 폭파 성공 (client) -->
<trigger name='check_demolition_dem_a' trigger_object='bombsite_a' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='visible_object' type='lua'> <!-- 폭탄 가방 숨김 -->
		<param type='value'>bombinst_a</param>
		<param type='value'>0</param>
	</function>
	<function name="play_effect" type="native"> <!-- 빨간 색 점멸등 이펙트 숨김 -->
		<param type="value">bombeff_a</param>
		<param type='play'>0</param>
	</function>
	<function name="camera_shake" type="native"> <!-- 카메라 쉐이크 -->
		<param type="value">12</param>
		<param type="value">4000</param>
	</function>
	<function name="lua_call_set_destructible_hp" type="lua"> <!-- 오브젝트 체력 0으로 → 파괴 -->
		<param type="value">snd_tar_a</param>
		<param type="value">0.000000</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--비프음(삐삑) 꺼짐 -->
		<param type="value">inst_a_snd</param>
		<param type="value">0</param>
		<param type="value">bombsite_a</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--설치 후 배경음 꺼짐-->
		<param type="value">inst_a_bgm</param>
		<param type="value">0</param>
		<param type="value">bombsite_a</param>
	</function>
	<function name='demolition' type='native' />
</trigger>

<trigger name='check_enable_start_defuse_bomb_a' trigger_object='bombsite_a' stand='client' type='stay' update_time='1' active_type='continue' >
	<condition name='check_start_defuse_bomb' type='lua'>
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<function name='show_action_info' type='lua'>
		<param type='value'>msg0000014</param>
		<param type='value'>100</param>
    <param type='value'>16</param>
	</function>		
</trigger>

<trigger name='demolition_a' trigger_object='bombsite_a' stand='server' type='object' update_time='1' active_type='continue'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>4</param>
	</condition>
	<function name='finish_round' type='native'>
		<param type='object' target='team_id' />
	</function>
</trigger>

<!-- F키 누름 (해체시작) -->
<trigger name='check_start_defuse_bomb_a' trigger_object='bombsite_a' stand='client' type='usekey_down' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_start_defuse_bomb' type='lua'>
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<function name='set_user_data' type='value'>
		<param type='actor' target='user_index' />
		<param type='object' target='user_data' out='yes' />
	</function>
</trigger>

<trigger name='check_start_defuse_bomb_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>start_defuse_bomb_a</param>
		<param type='object' target='user_data' />		
	</function>
	<function name='start_defuse_bomb_server' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>

<trigger name='start_defuse_bomb_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='start_defuse_bomb' type='native'>
		<param type='value'>1</param>
	</function>
	<function name='visible_object' type='lua'>
		<param type='value'>bombinst_a</param>
		<param type='value'>0</param>
	</function>
</trigger>

<trigger name='start_defuse_bomb_a' trigger_object='bombsite_a' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='start_defuse_bomb' type='native'>
		<param type='value'>1</param>
		<param type='lua'>demolition_defuse_bomb_time</param>
		<param type='object' target='name' />
	</function>
	<function name='visible_object' type='lua'>
		<param type='value'>bombinst_a</param>
		<param type='value'>0</param>
	</function>
	<function name='play_sound' type='native'>
		<param type='value'>gamemode</param>
		<param type='value'>snd_defuse</param>
	</function>
</trigger>

<trigger name='cancel_defuse_bomb_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='cancel_defuse_bomb' type='native'>
		<param type='value'>1</param>
	</function>
	<function name='reset_user_data' type='value'>
		<param type='value'>0</param>
		<param type='object' target='user_data' out='yes' />
	</function>
	<function name='set_object_state' type='value'>
		<param type='value'>3</param>
		<param type='object' target='state' out='yes' />
	</function>
	<function name='visible_object' type='lua'>
		<param type='value'>bombinst_a</param>
		<param type='value'>1</param>
	</function>
</trigger>

<trigger name='cancel_defuse_bomb_a' trigger_object='bombsite_a' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='cancel_defuse_bomb' type='native'>
		<param type='value'>1</param>
	</function>
	<function name='visible_object' type='lua'>
		<param type='value'>bombinst_a</param>
		<param type='value'>1</param>
	</function>
</trigger>

<!-- 폭파 A 지점 해체중단 -->
<trigger name='check_cancel_defuse_bomb_a' trigger_object='bombsite_a' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='lua_call_use_key_press' type='lua' return='false'/>
	<function name='set_object_state' type='value'>
		<param type='value'>12</param>
		<param type='object' target='state' out='yes' />
	</function>
</trigger>

<trigger name='check_cancel_defuse_bomb_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_defuse_bomb_a</param>
		<param type='object' target='user_data' />		
	</function>
	<function name='end_mission' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>
<trigger name='leave_defuse_bomb_a' trigger_object='bombsite_a' stand='client' type='leave' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>12</param>
		<param type='object' target='state' out='yes' />
	</function>
</trigger>

<trigger name='leave_defuse_bomb_a' trigger_object='bombsite_a' stand='server' type='none' active_type='continue' update_time='1'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_defuse_bomb_a</param>
		<param type='object' target='user_data' />		
	</function>
</trigger>

<trigger name='check_defuse_bomb_a' trigger_object='bombsite_a' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<condition name='check_defuse_bomb' type='lua'>
		<param type='actor' target='stay_time' />
		<param type='actor' target='rate' />
		<param type='actor' target='keypress_time' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>5</param>
		<param type='actor' target='user_index' />
		<param type='actor' target='team_id' />
		<param type='object' target='state' out='yes'/>
		<param type='object' target='user_index' out='yes'/>
		<param type='object' target='team_id' out='yes'/>
	</function>
</trigger>

<trigger name='check_defuse_bomb_a' trigger_object='bombsite_a' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='end_mission' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>

<!-- A 해체 성공 (server)-->
<trigger name='defuse_bomb_a' trigger_object='bombsite_a' stand='server' type='object' update_time='1' active_type='continue' send_act_packet='true' >
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>5</param>
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>6</param>
		<param type='object' target='state' out='yes' />
	</function>
	<function name='defuse_bomb' type='native' />
  <function name='team_add_point_by_defuse_bomb' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='finish_round' type='native'>
		<param type='object' target='team_id' />
	</function>
	<function name='active_trigger' type='lua'> 
		<param type='value'>main_defuse_bomb_ani_a</param>
		<param type='object' target='user_data' />		
	</function>
</trigger>

<!-- A 해체 성공 (client) -->
<trigger name='defuse_bomb_a' trigger_object='bombsite_a' stand='client' type='none' update_time='1' >
	<function name='defuse_bomb' type='native'>
		<param type='value'>1</param>
		<param type='object' target='user_data' />
	</function>
	<function name='play_simple_sound' type='native'> <!-- 폭탄 해체 효과음(텅!) -->
		<param type='value'>/level_common/mode/snd/defused_fx</param>
	</function>
	<function name='play_simple_sound' type='native'> <!-- 폭탄이 해체되었다 (목소리) -->
		<param type='value'>voiceover/search_and_destroy/bomb_defused</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--비프음(삐삑) 꺼짐 -->
		<param type="value">inst_a_snd</param>
		<param type="value">0</param>
		<param type="value">bombsite_a</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--설치 후 배경음 꺼짐-->
		<param type="value">inst_a_bgm</param>
		<param type="value">0</param>
		<param type="value">bombsite_a</param>
	</function>
	<function name="play_effect" type="native"> <!-- 빨간 색 점멸등 이펙트 숨김 -->
		<param type="value">bombeff_a</param>
		<param type='play'>0</param>
	</function>
</trigger>

<!-- A 해체 후 종료 애니메이션 -->
<trigger name="main_defuse_bomb_ani_a" stand="both/server" trigger_object="defu_ani_a" type="none" update_time="500" active_type="once" bind_object="defu_ani_a" send_act_packet="true">
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">defuse_bomb_ani_a</param>
	</function>
</trigger>
<trigger name="defuse_bomb_ani_a" stand="both/server" trigger_object="defu_ani_a" type="none" update_time="500" active_type="continue" bind_object="snd_tar_a" send_act_packet="true">
	<function name="lua_call_set_destructible_hp" type="lua"> <!-- 체력을 100으로 만듬(해체 애니메이션 재생) -->
		<param type="value">snd_tar_a</param>
		<param type="value">100.000000</param>
	</function>
</trigger>

<!-- 이하 폭파 B -->
<!-- 이하 폭파 B -->
<!-- 이하 폭파 B -->

<trigger name='check_enable_start_install_dem_b' trigger_object='bombsite_b' stand='client' type='stay' update_time='1' active_type='continue'>
	<condition name='check_exist_weapon' type='lua'> <!-- 폭탄을 가지고 있는가? -->
		<param type='actor' target='user_index' />
		<param type='value'>248</param>
	</condition>
	<condition name='check_object_state'> <!-- 폭탄이 설치가 안됐는가? -->
		<param type='object' target='state' />
		<param type='value'>0</param>
	</condition>
	<function name='show_action_info' type='lua'> <!-- 폭탄 설치 메시지 -->
		<param type='value'>msg0000013</param>
		<param type='value'>100</param>
		<param type='value'>16</param>
	</function>
</trigger>

<!-- F키 누름 (설치시작) (client) -->
<trigger name='check_start_install_dem_b' trigger_object='bombsite_b' stand='client' type='usekey_down' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_exist_weapon' type='lua'>  <!-- 폭탄을 가지고 있는가? -->
		<param type='actor' target='user_index' />
		<param type='value'>248</param>
	</condition>
	<condition name='check_object_state'> <!-- 폭탄이 설치가 안됐는가? -->
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

<!-- F키 누름 (설치시작) (server) -->
<trigger name='check_start_install_dem_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='set_object_state' type='value'>
		<param type='actor' target='stay_time' out='yes' />		
		<param type='value'>0</param>
	</function>
	<function name='active_trigger' type='lua'>
		<param type='value'>start_install_dem_b</param>
		<param type='object' target='user_index' />
	</function>
	<function name='start_install_bomb_server' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>	
</trigger>

<trigger name='start_install_dem_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
</trigger>
<trigger name='start_install_dem_b' trigger_object='bombsite_b' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='start_install_bomb' type='native'>
		<param type='value'>1</param>
		<param type='lua'>demolition_bomb_install_time</param>
		<param type='object' target='name' />
	</function>
	<function name='play_sound' type='native'>
		<param type='value'>gamemode</param>
		<param type='value'>snd_plant</param>
	</function>
</trigger>

<!-- F키 뗌 (설치중단) -->
<trigger name='check_cancel_install_dem_b' trigger_object='bombsite_b' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
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

<trigger name='check_cancel_install_dem_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_dem_b_final</param>
		<param type='object' target='user_index' />
	</function>
	<function name='end_mission' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>

<trigger name='cancel_install_dem_b_final' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='reset_object_state' type='value'>
		<param type='value'>1</param>
		<param type='object' target='reset' out='yes'/>
	</function>
</trigger>

<trigger name='cancel_install_dem_b_final' trigger_object='bombsite_b' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='cancel_install_bomb' type='native'>
		<param type='value'>1</param>
	</function>
</trigger>

<trigger name='leave_install_dem_b' trigger_object='bombsite_b' stand='client' type='leave' update_time='1' active_type='continue' send_act_packet='true'>
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

<trigger name='leave_install_dem_b' trigger_object='bombsite_b' stand='server' type='none' active_type='continue' update_time='1'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_install_dem_b_final</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<trigger name='check_finish_install_dem_b' trigger_object='bombsite_b' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_exist_weapon' type='lua'>
		<param type='actor' target='user_index' />
		<param type='value'>248</param>
	</condition>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>2</param>
	</condition>
	<condition name='check_finish_install_bomb' type='lua'>
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
</trigger>

<trigger name='check_finish_install_dem_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='end_mission' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>

<!-- B 설치 성공 (server) -->
<trigger name='install_dem_b' trigger_object='bombsite_b' stand='server' type='object' update_time='1' active_type='once' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<function name='install_bomb' type='native' />
  <function name='team_add_point_by_install_bomb' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='set_object_touch' type='value'>
		<param type='value'>1</param>
		<param type='object' target='touch' out='yes' />
	</function>
	<function name='visible_object' type='lua'> <!-- 폭탄 가방 보임 -->
		<param type='value'>bombinst_b</param>
		<param type='value'>1</param>
	</function>
	<function name='active_trigger' type='lua'> <!-- B 설치 성공 애니메이션 -->
		<param type='value'>main_inst_b_s</param>
		<param type='object' target='user_index' />
	</function>
</trigger>

<!-- B 설치 성공 애니메이션-->
<trigger name="main_inst_b_s" stand="both/server" trigger_object="inst_b_s" type="none" update_time="500" active_type="continue" bind_object="inst_b_s" send_act_packet="true" component_name="" component_type="0">
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">destructible_inst_b_sde1</param>
	</function>
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">act_trg_inst_b_sat1</param>
		<param type="actor" target="user_index" />
	</function>
</trigger>
<trigger name="destructible_inst_b_sde1" stand="both/server" trigger_object="inst_b_s" type="none" update_time="500" active_type="continue" bind_object="snd_tar_b" send_act_packet="true" component_name="de1" component_type="23">
	<function name="lua_call_set_destructible_hp" type="lua">
		<param type="value">snd_tar_b</param>
		<param type="value">300.000000</param>
	</function>
</trigger>
<trigger name="act_trg_inst_b_sat1" stand="both/server" trigger_object="inst_b_s" type="none" update_time="500" active_type="continue" bind_object="inst_b_lp" send_act_packet="true" component_name="at1" component_type="7">
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">start_wait_inst_b_lp</param>
		<param type="actor" target="user_index" />
	</function>
</trigger>
<trigger name="main_inst_b_lp" stand="both/server" trigger_object="inst_b_lp" type="none" update_time="500" active_type="continue" bind_object="inst_b_lp" send_act_packet="true" component_name="" component_type="0">
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">destructible_inst_b_lpde1</param>
	</function>
</trigger>
<trigger name="start_wait_inst_b_lp" stand="both/server" trigger_object="inst_b_lp" type="none" update_time="500" active_type="continue" bind_object="inst_b_lp" send_act_packet="true" component_name="" component_type="0">
	<condition name="lua_call_is_enable_trigger" type="lua" return="false">
		<param type="value">on_wait_inst_b_lp</param>
	</condition>
	<function name="lua_call_set_enable_trigger" type="lua">
		<param type="value">on_wait_inst_b_lp</param>
		<param type="value">1</param>
	</function>
</trigger>
<trigger name="on_wait_inst_b_lp" stand="both/server" trigger_object="inst_b_lp" type="game" update_time="1" active_type="continue" bind_object="inst_b_lp" send_act_packet="true" component_name="" component_type="0" enable="false">
	<condition name="check_play_time" type="lua">
		<param type="self_trigger" target="active_time" />
		<param type="value">4000</param>
	</condition>
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">end_wait_inst_b_lp</param>
	</function>
</trigger>
<trigger name="end_wait_inst_b_lp" stand="both/server" trigger_object="inst_b_lp" type="none" update_time="500" active_type="continue" bind_object="inst_b_lp" send_act_packet="true" component_name="" component_type="0">
	<function name="lua_call_set_enable_trigger" type="lua">
		<param type="value">on_wait_inst_b_lp</param>
		<param type="value">0</param>
	</function>
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">main_inst_b_lp</param>
	</function>
</trigger>
<trigger name="destructible_inst_b_lpde1" stand="both/server" trigger_object="inst_b_lp" type="none" update_time="500" active_type="continue" bind_object="snd_tar_b" send_act_packet="true" component_name="de1" component_type="23">
	<function name="lua_call_set_destructible_hp" type="lua">
		<param type="value">snd_tar_b</param>
		<param type="value">200.000000</param>
	</function>
</trigger>

<!-- B 설치 성공 (client) -->
<trigger name='install_dem_b' trigger_object='bombsite_b' stand='client' type='none' update_time='1' active_type='once'>
	<function name='install_bomb' type='native'>
		<param type='value'>1</param>
		<param type='owner' target='user_index' />
		<param type='lua'>demolition_bomb_act_time</param>
	</function>
	<function name='visible_object' type='lua'> <!-- 폭탄 가방 보임 -->
		<param type='value'>bombinst_b</param>
		<param type='value'>1</param>
	</function>
	<function name='play_simple_sound' type='native'> <!-- 폭탄 설치 효과음 -->
		<param type='value'>/level_common/mode/snd/planted_fx</param> 
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--비프음(삐삑) -->
		<param type="value">inst_b_snd</param>
		<param type="value">1</param>
		<param type="value">bombsite_b</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--설치 후 배경음 -->
		<param type="value">inst_b_bgm</param>
		<param type="value">1</param>
		<param type="value">bombsite_b</param>
	</function>
	<function name="play_effect" type="native"> <!-- 빨간 색 점멸등 이펙트 -->
		<param type="value">bombeff_b</param>
		<param type='play'>1</param>
	</function>
	<function name="lua_call_set_observer_cam" type="lua"> <!-- 옵저버 카메라를 이동 -->
		<param type="value">snd_cam_b</param>
	</function>
  <function name="play_bomb_team_sound" type="lua">
    <param type='object' target='team_id' />
    <param type='self' target='team_id' />
  </function>
</trigger>

<!-- B 폭파 성공 (server) -->
<trigger name='check_demolition_dem_b' trigger_object='bombsite_b' stand='server' type='object' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<condition name='check_demolition' type='lua'>
		<param type='object' target='touch' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>4</param>
		<param type='object' target='state' out='yes' />
	</function>
	<function name='visible_object' type='lua'> <!-- 폭탄 가방  숨김 -->
		<param type='value'>bombinst_b</param>
		<param type='value'>0</param>
	</function>
	<function name='demolition' type='native'>
		<param type='value'>snd_tar_b</param>
	</function>
</trigger>

<!-- B 폭파 성공 (client) -->
<trigger name='check_demolition_dem_b' trigger_object='bombsite_b' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='visible_object' type='lua'> <!-- 폭탄 가방 숨김 -->
		<param type='value'>bombinst_b</param>
		<param type='value'>0</param>
	</function>
	<function name="play_effect" type="native"> <!-- 빨간 색 점멸등 이펙트 숨김 -->
		<param type="value">bombeff_b</param>
		<param type='play'>0</param>
	</function>
	<function name="camera_shake" type="native"> <!-- 카메라 쉐이크 -->
		<param type="value">12</param>
		<param type="value">4000</param>
	</function>
	<function name="lua_call_set_destructible_hp" type="lua"> <!-- 오브젝트 체력 0으로 → 파괴 -->
		<param type="value">snd_tar_b</param>
		<param type="value">0.000000</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--비프음(삐삑) 꺼짐 -->
		<param type="value">inst_b_snd</param>
		<param type="value">0</param>
		<param type="value">bombsite_b</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--설치 후 배경음 꺼짐-->
		<param type="value">inst_b_bgm</param>
		<param type="value">0</param>
		<param type="value">bombsite_b</param>
	</function>
	<function name='demolition' type='native' />
</trigger>

<trigger name='check_enable_start_defuse_bomb_b' trigger_object='bombsite_b' stand='client' type='stay' update_time='1' active_type='continue' >
	<condition name='check_start_defuse_bomb' type='lua'>
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<function name='show_action_info' type='lua'>
		<param type='value'>msg0000014</param>
		<param type='value'>100</param>
    <param type='value'>16</param>
	</function>		
</trigger>

<trigger name='demolition_b' trigger_object='bombsite_b' stand='server' type='object' update_time='1' active_type='continue'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>4</param>
	</condition>
	<function name='finish_round' type='native'>
		<param type='object' target='team_id' />
	</function>
</trigger>

<!-- F키 누름 (해체시작) -->
<trigger name='check_start_defuse_bomb_b' trigger_object='bombsite_b' stand='client' type='usekey_down' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_start_defuse_bomb' type='lua'>
		<param type='object' target='team_id' />
		<param type='actor' target='team_id' />
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<function name='set_user_data' type='value'>
		<param type='actor' target='user_index' />
		<param type='object' target='user_data' out='yes' />
	</function>
</trigger>

<trigger name='check_start_defuse_bomb_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>start_defuse_bomb_b</param>
		<param type='object' target='user_data' />		
	</function>
	<function name='start_defuse_bomb_server' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>

<trigger name='start_defuse_bomb_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='start_defuse_bomb' type='native'>
		<param type='value'>1</param>
	</function>
	<function name='visible_object' type='lua'>
		<param type='value'>bombinst_b</param>
		<param type='value'>0</param>
	</function>
</trigger>

<trigger name='start_defuse_bomb_b' trigger_object='bombsite_b' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='start_defuse_bomb' type='native'>
		<param type='value'>1</param>
		<param type='lua'>demolition_defuse_bomb_time</param>
		<param type='object' target='name' />
	</function>
	<function name='visible_object' type='lua'>
		<param type='value'>bombinst_b</param>
		<param type='value'>0</param>
	</function>
	<function name='play_sound' type='native'>
		<param type='value'>gamemode</param>
		<param type='value'>snd_defuse</param>
	</function>
</trigger>

<trigger name='cancel_defuse_bomb_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue' send_act_packet='true'>
	<function name='cancel_defuse_bomb' type='native'>
		<param type='value'>1</param>
	</function>
	<function name='reset_user_data' type='value'>
		<param type='value'>0</param>
		<param type='object' target='user_data' out='yes' />
	</function>
	<function name='set_object_state' type='value'>
		<param type='value'>3</param>
		<param type='object' target='state' out='yes' />
	</function>
	<function name='visible_object' type='lua'>
		<param type='value'>bombinst_b</param>
		<param type='value'>1</param>
	</function>
</trigger>

<trigger name='cancel_defuse_bomb_b' trigger_object='bombsite_b' stand='client' type='none' update_time='1' active_type='continue'>
	<function name='cancel_defuse_bomb' type='native'>
		<param type='value'>1</param>
	</function>
	<function name='visible_object' type='lua'>
		<param type='value'>bombinst_b</param>
		<param type='value'>1</param>
	</function>
</trigger>

<!-- 폭파 B 지점 해체중단 -->
<trigger name='check_cancel_defuse_bomb_b' trigger_object='bombsite_b' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='lua_call_use_key_press' type='lua' return='false'/>
	<function name='set_object_state' type='value'>
		<param type='value'>12</param>
		<param type='object' target='state' out='yes' />
	</function>
</trigger>

<trigger name='check_cancel_defuse_bomb_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_defuse_bomb_b</param>
		<param type='object' target='user_data' />		
	</function>
	<function name='end_mission' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>
<trigger name='leave_defuse_bomb_b' trigger_object='bombsite_b' stand='client' type='leave' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>12</param>
		<param type='object' target='state' out='yes' />
	</function>
</trigger>

<trigger name='leave_defuse_bomb_b' trigger_object='bombsite_b' stand='server' type='none' active_type='continue' update_time='1'>
	<function name='active_trigger' type='lua'>
		<param type='value'>cancel_defuse_bomb_b</param>
		<param type='object' target='user_data' />		
	</function>
</trigger>

<trigger name='check_defuse_bomb_b' trigger_object='bombsite_b' stand='client' type='stay' update_time='1' active_type='continue' send_act_packet='true'>
	<condition name='is_enable_user' type='lua'>
		<param type='object' target='user_data' />
		<param type='actor' target='user_index' />
	</condition>
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>3</param>
	</condition>
	<condition name='check_defuse_bomb' type='lua'>
		<param type='actor' target='stay_time' />
		<param type='actor' target='rate' />
		<param type='actor' target='keypress_time' />
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>5</param>
		<param type='actor' target='user_index' />
		<param type='actor' target='team_id' />
		<param type='object' target='state' out='yes'/>
		<param type='object' target='user_index' out='yes'/>
		<param type='object' target='team_id' out='yes'/>
	</function>
</trigger>

<trigger name='check_defuse_bomb_b' trigger_object='bombsite_b' stand='server' type='none' update_time='1' active_type='continue'>
	<function name='end_mission' type='lua'>
		<param type='actor' target='mission_state' out='yes' />
	</function>
</trigger>

<!-- B 해체 성공 (server)-->
<trigger name='defuse_bomb_b' trigger_object='bombsite_b' stand='server' type='object' update_time='1' active_type='continue' send_act_packet='true' >
	<condition name='check_object_state'>
		<param type='object' target='state' />
		<param type='value'>5</param>
	</condition>
	<function name='set_object_state' type='value'>
		<param type='value'>6</param>
		<param type='object' target='state' out='yes' />
	</function>
	<function name='defuse_bomb' type='native' />
  <function name='team_add_point_by_defuse_bomb' type='lua'>
    <param type='object' target='team_id' />
  </function>
  <function name='finish_round' type='native'>
		<param type='object' target='team_id' />
	</function>
	<function name='active_trigger' type='lua'> 
		<param type='value'>main_defuse_bomb_ani_b</param>
		<param type='object' target='user_data' />		
	</function>
</trigger>

<!-- B 해체 성공 (client) -->
<trigger name='defuse_bomb_b' trigger_object='bombsite_b' stand='client' type='none' update_time='1' >
	<function name='defuse_bomb' type='native'>
		<param type='value'>1</param>
		<param type='object' target='user_data' />
	</function>
	<function name='play_simple_sound' type='native'> <!-- 폭탄 해체 효과음(텅!) -->
		<param type='value'>/level_common/mode/snd/defused_fx</param>
	</function>
	<function name='play_simple_sound' type='native'> <!-- 폭탄이 해체되었다 (목소리) -->
		<param type='value'>voiceover/search_and_destroy/bomb_defused</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--비프음(삐삑) 꺼짐 -->
		<param type="value">inst_b_snd</param>
		<param type="value">0</param>
		<param type="value">bombsite_b</param>
	</function>
	<function name="lua_call_set_enable_entity" type="lua"> <!--설치 후 배경음 꺼짐-->
		<param type="value">inst_b_bgm</param>
		<param type="value">0</param>
		<param type="value">bombsite_b</param>
	</function>
	<function name="play_effect" type="native"> <!-- 빨간 색 점멸등 이펙트 숨김 -->
		<param type="value">bombeff_b</param>
		<param type='play'>0</param>
	</function>
</trigger>

<!-- B 해체 후 종료 애니메이션 -->
<trigger name="main_defuse_bomb_ani_b" stand="both/server" trigger_object="defu_ani_b" type="none" update_time="500" active_type="once" bind_object="defu_ani_b" send_act_packet="true">
	<function name="lua_call_active_trigger_checked" type="lua">
		<param type="value">defuse_bomb_ani_b</param>
	</function>
</trigger>
<trigger name="defuse_bomb_ani_b" stand="both/server" trigger_object="defu_ani_b" type="none" update_time="500" active_type="continue" bind_object="snd_tar_b" send_act_packet="true">
	<function name="lua_call_set_destructible_hp" type="lua"> <!-- 체력을 100으로 만듬(해체 애니메이션 재생) -->
		<param type="value">snd_tar_b</param>
		<param type="value">100.000000</param>
	</function>
</trigger>

<!-- 보이스 -->
<trigger name='bomb_secure' stand='client' type='gamemode' update_time='500' send_act_packet='false' active_type='continue'>
	<function name='play_sound' type='native'>
		<param type='value'>gamemode</param>
		<param type='value'>snd_secure</param>
	</function>
</trigger>
<trigger name='bomb_drop' stand='client' type='gamemode' update_time='500' send_act_packet='false' active_type='continue'>
	<condition name="check_alive_team" type="lua">
		<param type="actor" target="team_id"/>
	</condition>
	<function name='play_sound' type='native'>
		<param type='value'>gamemode</param>
		<param type='value'>snd_drop</param>
	</function>
</trigger>

<!-- 사운드 트리거 -->
<trigger name='snd_trg_inst_my_team' stand='client' type='none' update_time='500' active_type='once'>
  <function name='play_simple_sound' type='native'>
    <param type='value'>/voiceover/search_and_destroy/bomb_planted</param>
  </function>
</trigger>
<trigger name='snd_trg_inst_enemy_team' stand='client' type='none' update_time='500' active_type='once'>
  <function name='play_simple_sound' type='native'>
    <param type='value'>/voiceover/search_and_destroy/snd_planted_02</param>
  </function>
</trigger>
