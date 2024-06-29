before_dom = 0 -- 이전 점령지역
current_dom = 0 -- 현재 점령지역

is_set_conflict_area = 0
conflict_time_score = 0
conflict_domination_team = 10

now_domination_score = 0

-- 점령 이펙트 연출 관련 전역 변수
prev_effect_state = 0
prev_effect_name = ""

-- 점령 중 사운드 출력 관련 전역 변수
is_dom_snd_flag = 0
is_dom_bgm_flag = 0

VALUE_GEN_DOMINATION_TIME			= 20000		-- 점령지 생성 시간 (단위:1000=1초)
VALUE_LIMIT_TIME_BGM				= 45000		-- 상황별 배경음 출력 되는 라운드 남은 시간 (단위:1000=1초)

-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	-- game_limit_time = 1000000
	site_object_prefix="scp_"
	site_icon_prefix="dom"
	-- show_occupation_effect="true" -- 점령지 이펙트
	exist_kill_score="no"
	exist_team_score="yes"
	round_mode = "on"
	round_time = 180000
	respawn_delay = 5000
	respawn_key_input_delay = 5000
	force_respawn = 5000
	no_damage_time = 5000
	-- resurrection_on_restart_round = "true" -- 라운드 갱신 시, 초기화
	round_restart_delay  = 5000
	respawn="on"
	-- swap_spawn_pos="on"
	drone_delay=5000
	game_wait_buffer_time = 20000

	init_drone_restart_round = "true"
	init_destructible_restart_round = "true"
	-- 라스트캠 옵션 lua_call_lastcam_control ( [캠 재생여부],[캠 재생시간], [슬로모션 시작점], [슬로모션 종료점], [슬로모션 재생속도] 
	lua_call_lastcam_control(1, 7000, 5000, 6500, 40)
	lua_call_load_ui("hudscp")
end

function select_loadout()
end

function prepare_round()
	is_set_conflict_area = 0
	conflict_time_score = 0
	conflict_domination_team = 10
	now_domination_score = 0
	lua_call_set_enable_entity( "inst_a_bgm", 0 , "scp_a")
	lua_call_set_enable_entity( "inst_a_bgm", 0 , "scp_b")
	lua_call_set_enable_entity( "inst_a_bgm", 0 , "scp_c")
end

function prepare_round_server()
	disable_all_dom()
	disable_all_entity()
	lua_call_set_enable_trigger( "gen_domination_point", 1 )
end

function prepare_round_client()
	lua_call_set_observer_cam( "start_cam" )
	prev_effect_state = 0
	prev_effect_name = ""
	is_dom_snd_flag = 0
	is_dom_bgm_flag = 0
end

function countdown()
end

function game_end()
end

function winning_shot()
end

function end_score_board()
end

function half_time()
end

function reset_trigger()
	
end

function round_time_out( team_1, team_2 )
	if now_domination_score > 0
	then
		return 0
	end
	if now_domination_score < 0
	then
		return 1
	end
	return 2
end

function winner_ceremony()
end
------------------------------------------------------------------
-- 지역 점령전용 스크립트
------------------------------------------------------------------
function disable_all_dom()
	lua_call_set_enable_trigger_object( "scp_a", 0 )
	lua_call_set_enable_trigger_object( "scp_b", 0 )
	lua_call_set_enable_trigger_object( "scp_c", 0 )
end

function disable_all_entity()
	lua_call_set_enable_entity( "scp_rdy_a", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_b", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_c", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_a", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_b", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_c", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_a1", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_b1", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_c1", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_a2", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_b2", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_c2", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_a3", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_b3", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_c3", 0 , "start_scp")
end

function check_gen_domination_point( play_time )
	if play_time > VALUE_GEN_DOMINATION_TIME
	then
		return 1
	end
	return 0
end

-- 게임시작 직후 호출되어 점령지역을 미리 계산한다
function calc_domination_point( in_gen_count, in_max_count )
	gen_count = tonumber( in_gen_count );
	check_max_count  = tonumber( in_max_count );
	max_count = check_max_count;
	disable_all_dom();
	local dom_list = {};
	local i = 1;
	for index = 1, check_max_count, 1 do
		if before_dom == index
		then
			max_count = max_count - 1;
		else
			dom_list[ i ] = index;
			i = i + 1;
		end
	end
	
	for index = 1, 10, 1 do
		val_1 = math.random( 1, max_count );
		val_2 = math.random( 1, max_count );
		temp_val = dom_list[val_1];
		dom_list[val_1] = dom_list[val_2];
		dom_list[val_2] = temp_val;
	end

	current_dom = dom_list[ 1 ]

	if  current_dom == 1 then
	lua_call_set_enable_entity( "scp_rdy_a", 1, "start_scp")
	elseif  current_dom == 2 then
	lua_call_set_enable_entity( "scp_rdy_b", 1, "start_scp")
	else
	lua_call_set_enable_entity( "scp_rdy_c", 1, "start_scp")
	end 

	lua_call_set_enable_trigger_object( "start_scp", 1 )
end

function get_current_domination_point()
	-- disable_all_entity();
	if  current_dom == 1 then
		lua_call_set_enable_trigger_object( "scp_a", 1 )
		lua_call_set_enable_entity( "scp_eff_a", 1, "start_scp")
		lua_call_set_enable_entity( "scp_rdy_a", 0 , "start_scp")
	elseif  current_dom == 2 then
		lua_call_set_enable_trigger_object( "scp_b", 1 )
		lua_call_set_enable_entity( "scp_eff_b", 1, "start_scp")
		lua_call_set_enable_entity( "scp_rdy_b", 0 , "start_scp")
	else
		lua_call_set_enable_trigger_object( "scp_c", 1 )
		lua_call_set_enable_entity( "scp_eff_c", 1, "start_scp")
		lua_call_set_enable_entity( "scp_rdy_c", 0 , "start_scp")
	end 

	lua_call_set_enable_trigger_object( "start_scp", 1 )	
	before_dom = current_dom
end

function get_current_domination_point_banner()
	lua_call_show_banner( 24, user_index )
end

function gen_domination_point( in_gen_count, in_max_count )
	gen_count = tonumber( in_gen_count );
	check_max_count  = tonumber( in_max_count );
	max_count = check_max_count;
	disable_all_dom();
	local dom_list = {};
	local i = 1;
	for index = 1, check_max_count, 1 do
		if before_dom == index
		then
			max_count = max_count - 1;
		else
			dom_list[ i ] = index;
			i = i + 1;
		end
	end
	
	for index = 1, 10, 1 do
		val_1 = math.random( 1, max_count );
		val_2 = math.random( 1, max_count );
		temp_val = dom_list[val_1];
		dom_list[val_1] = dom_list[val_2];
		dom_list[val_2] = temp_val;
	end
	
	for i = 1, gen_count, 1 do
		if  dom_list[ i ] == 1 then
		lua_call_set_enable_trigger_object( "scp_a", 1 )
		elseif  dom_list[ i ] == 2 then
		lua_call_set_enable_trigger_object( "scp_b", 1 )
		else
		lua_call_set_enable_trigger_object( "scp_c", 1 )
		end 
	end
	before_dom = dom_list[ 1 ]
end

function is_intercept_domination( object_name, object_state )
	if tonumber( object_state ) ~= 0
	then
		return 0
	end
	naf_team_stay_count = lua_call_get_stay_count( 0, object_name )
	eden_team_stay_count = lua_call_get_stay_count( 1, object_name )

	if naf_team_stay_count > 0 and eden_team_stay_count > 0
	then
		return 0
	elseif naf_team_stay_count > 0 and eden_team_stay_count == 0
	then
		return 1
	elseif naf_team_stay_count == 0 and eden_team_stay_count > 0
	then
		return 1
	end
		
	return 0
end

function is_domination( object_name, object_state, play_time )
	if play_time > round_time
	then
		return 0
	end
	if tonumber( object_state ) ~= 1
	then
		return 0
	end
	naf_team_stay_count = lua_call_get_stay_count( 0, object_name )
	eden_team_stay_count = lua_call_get_stay_count( 1, object_name )

	if naf_team_stay_count > 0 and eden_team_stay_count == 0
	then
		return 1
	elseif naf_team_stay_count == 0 and eden_team_stay_count > 0
	then
		return 1
	end
		
	return 0
end

function check_cancel_domination( state, object_name )
	if state ~= 1
	then
		return 0
	end

	naf_stay_count = lua_call_get_stay_count( 0, object_name )
	eden_stay_count = lua_call_get_stay_count( 1, object_name )

	if naf_stay_count == 0 and eden_stay_count == 0
	then 
		return 1
	end

	return 0
end 

function cancel_domination( team_id, object_name )
	stay_count = lua_call_get_stay_count( team_id, object_name )
	if stay_count == 0
	then
		lua_call_reset_object_state( object_name );
	end
end 

function check_domination( object_team_id, user_team_id, user_index, hp )
	if object_team_id ~= user_team_id
	then
		return 0
	end
	if hp == 0
	then
		return 0
	end
	return 1
	
end

function calc_domation_time_rate( stay_count )
	if stay_count == 0
	then
		return 0
	elseif stay_count == 2
	then
		return 2
	elseif stay_count >= 3
	then
		return 4
	end
	return 1
end

function add_domination_score( owner_team_id, object_name, flow_time )
	stay_count = lua_call_get_stay_count( owner_team_id, object_name )
	domination_rate = calc_domation_time_rate( stay_count )
	
	if owner_team_id == 1
	then
		domination_rate = domination_rate * -1
	end
	
	return flow_time * domination_rate
end


function set_domination_rate( team_id, object_name )
	stay_count = lua_call_get_stay_count( team_id, object_name )
	domination_rate = calc_domation_time_rate( stay_count )
	lua_call_set_progress_rate( domination_rate, object_name )	
end

function check_object_domination( state, score , domination_score )
	if state ~= 1
	then
		return 0
	end
	
	naf_win_score = tonumber( domination_score )
	eden_win_score = naf_win_score * -1
	
	now_domination_score = score

	if score <= eden_win_score or naf_win_score <= score 
	then
		return 1
	end
	return 0
end

function check_object_team_id( object_team_id )
	if object_team_id == 0 or object_team_id == 1
	then
		return 1
	end
	return 0
end

function add_score( team_id )
	lua_call_add_team_score( team_id, 1 )
end

function check_object_state( state, check_value )
	if state == tonumber( check_value )
	then
		return 1
	end
	return 0
end

function is_comflict_area( object_state, object_name )
	if object_state ~= 1
	then
		return 0
	end

	naf_team_stay_count = lua_call_get_stay_count( 0, object_name )
	eden_team_stay_count = lua_call_get_stay_count( 1, object_name )

	if naf_team_stay_count > 0 and eden_team_stay_count > 0
	then
		return 1
	end

	return 0
end

function set_conflict_area( object_score, owner_team , object_name )
	is_set_conflict_area = 1
	conflict_time_score = object_score
	conflict_domination_team = owner_team
end


function is_cancel_conflict_area( object_state, object_name )
	if is_set_conflict_area == 0
	then
		return 0
	end

	naf_team_stay_count = lua_call_get_stay_count( 0, object_name )
	eden_team_stay_count = lua_call_get_stay_count( 1, object_name )

	if naf_team_stay_count == 0 or eden_team_stay_count == 0
	then
		return 1
	end

	return 0
end

function cancel_conflict_area( object_name )
	naf_team_stay_count = lua_call_get_stay_count( 0, object_name )
	eden_team_stay_count = lua_call_get_stay_count( 1, object_name )

	-- 분쟁이 안끝났다면 처리하지 않는다
	if naf_team_stay_count > 0 and eden_team_stay_count > 0
	then
		return 0
	end

	is_set_conflict_area = 0

	-- 분쟁전에 점령했던팀이 계속 점령했다면 점수는 승계된다
	if conflict_domination_team == 0 and naf_team_stay_count > 0
	then
		lua_call_set_user_data( object_name, 0 )
		lua_call_set_object_score( object_name, conflict_time_score )
	elseif conflict_domination_team == 1 and eden_team_stay_count > 0
	then
		lua_call_set_user_data( object_name, 1 )
		lua_call_set_object_score( object_name, conflict_time_score )
	end	
end

-- 점령 상태에 따른 이펙트 이름 가져오기
function get_effect_name_by_domination_state( effect_name_code, state )
	local add_str_by_state
	-- 0:지역생성중 1:미점령, 2:아군점령중, 3:적군점령중, 4:교전중
	if state == 2 then
		add_str_by_state = "1"
	elseif state == 3 then
		add_str_by_state = "2"
	elseif state == 4 then
		add_str_by_state = "3"
	else
		add_str_by_state = ""
	end
	local effect_name = "scp_eff_"
	effect_name = string.format("%s%s%s", effect_name, effect_name_code, add_str_by_state)
	return effect_name
end

-- 점령지 생성 UI 출력 시간 체크
function check_gen_time_domination_point( play_time )
	if play_time > 0 and play_time <= VALUE_GEN_DOMINATION_TIME
	then
		return 1
	end
	return 0
end

-- 점령지 생성 UI 출력
function output_gen_time_domination_ui()
	lua_call_set_scp_waiting_time(VALUE_GEN_DOMINATION_TIME)
end

-- 상황별 배경음 출력 여부 체크
function check_bgm_condition( play_time, domination_percent )
	if domination_percent >= 1.0 or domination_percent <= 0.0
	then
		return 0
	end
	if (round_time - play_time) > 0 and (round_time - play_time) <= VALUE_LIMIT_TIME_BGM
	then
		return 1
	end
	return 0
end

-- 점령 중 HUD ICON
function set_domination_icon( object_id, state )
	local icon_id = 1
	if state == 2 then
		icon_id = 2
	elseif state == 3 then
		icon_id = 3
	end
	lua_call_change_object_icon( object_id, icon_id )
end

-- 지역점령전 UI 및 점령 이펙트 출력
function output_domination_ui_and_effect( object_score, object_name, self_team_id, domination_score, effect_name_code, play_time )
	-- 점령 중인 각 진영 인원 체크
	naf_team_stay_count = lua_call_get_stay_count( 0, object_name )
	eden_team_stay_count = lua_call_get_stay_count( 1, object_name )

	-- 점령 기본 정보 표시
	if object_score >= 0 then
		max_score = domination_score * 2
	else
		max_score = domination_score * 2 * -1
	end
	
	-- 점령 게이지 처리
	domination_percent = object_score / max_score
	if (self_team_id == 0 and object_score > 0) or (self_team_id == 1 and object_score < 0) then
		domination_percent = 0.5 + domination_percent;
	elseif (self_team_id == 0 and object_score < 0) or (self_team_id == 1 and object_score > 0)	then		
		domination_percent = 0.5 - domination_percent;
	else
		domination_percent = 0.5;
	end

	-- 점령 게이지 유효성 검사
	domination_percent = math.min(1.0, domination_percent)
	domination_percent = math.max(0.0, domination_percent)

	-- 점령 상태 표시
	-- 0:지역생성중 1:미점령, 2:아군점령중, 3:적군점령중, 4:교전중
	state = 1;
	if naf_team_stay_count > 0 and eden_team_stay_count > 0	then
		-- 교전중
		state = 4;
	else
		if (self_team_id == 0 and naf_team_stay_count > 0) or (self_team_id == 1 and eden_team_stay_count > 0) then
			-- 아군 점령중 -- 인원수 calc_domation_time_rate(naf_team_stay_count+eden_team_stay_count)
			state = 2;
		elseif (self_team_id == 0 and eden_team_stay_count > 0) or (self_team_id == 1 and naf_team_stay_count > 0) then
			-- 적군 점령중 -- 인원수 calc_domation_time_rate(naf_team_stay_count+eden_team_stay_count)
			state = 3;
		end
	end

	set_domination_icon(object_name, state)
	lua_call_set_scp_info( state, domination_percent, naf_team_stay_count+eden_team_stay_count )

	-- 점령 상태에 따른 이펙트 연출
	if state ~= prev_effect_state then
		if prev_effect_name == "" then
			prev_effect_name = get_effect_name_by_domination_state( effect_name_code, 1 )
		end
		local effect_name = get_effect_name_by_domination_state( effect_name_code, state )
		lua_call_play_effect( prev_effect_name, 0 )
		lua_call_play_effect( effect_name, 1 )
		prev_effect_state = state
		prev_effect_name = effect_name
	end

	-- 점령 시 사운드 출력
	if naf_team_stay_count+eden_team_stay_count >= 3 and (state == 2 or state == 3) then
		if state == 2 and is_dom_snd_flag == 0 then
			lua_call_active_trigger( "play_sound_trigger_scp_my_team" )
			is_dom_snd_flag = 1
		elseif state == 3 and is_dom_snd_flag == 0 then
			lua_call_active_trigger( "play_sound_trigger_scp_enemy_team" )
			is_dom_snd_flag = 1
		end
	else
		is_dom_snd_flag = 0
	end

	-- 상황별 배경음 출력
	if check_bgm_condition( play_time, domination_percent ) == 1 and is_dom_bgm_flag == 0 then
		local bgm_name = "inst_a_bgm"
		local obj_name = string.format("scp_%s", effect_name_code)
		lua_call_set_enable_entity( bgm_name, 1 , obj_name)
		is_dom_bgm_flag = 1
	elseif check_bgm_condition( play_time, domination_percent ) == 0 and is_dom_bgm_flag == 1 then
		local bgm_name = "inst_a_bgm"
		local obj_name = string.format("scp_%s", effect_name_code)
		lua_call_set_enable_entity( bgm_name, 0 , obj_name)
		is_dom_bgm_flag = 0
	end
end

function add_drone_point_by_domination( owner_team_id, object_name )
	-- 점령 중인 인원에게 update_time='1000'(1초) 마다 추가되는 배틀 포인트량
	reward_point = 10
	lua_call_add_drone_point_by_domination( owner_team_id, object_name, reward_point )
end