--------------------------------------------
-- 점령지 상태 정의
--------------------------------------------
E_OBJECT_STATE_NORMAL				= 0
E_OBJECT_STATE_DOMINATION			= 1
--------------------------------------------
--------------------------------------------
-- 점령 상태 정의 (클라이언트 연출용)
-- (0:미점령, 1:아군점령중, 2:적군점령중, 3:교전중)
--------------------------------------------
E_C_DOM_STATE_NONE					= 0
E_C_DOM_STATE_MY_TEAM				= 1
E_C_DOM_STATE_ENEMY_TEAM			= 2
E_C_DOM_STATE_CONFLICT				= 3
--------------------------------------------
--------------------------------------------
-- 점령지 진영 정의 (클라이언트 연출용)
-- (0:중립, 1:아군, 2:적군)
--------------------------------------------
E_C_DOM_NONE_TEAM					= 0
E_C_DOM_MY_TEAM						= 1
E_C_DOM_ENEMY_TEAM					= 2
--------------------------------------------
DEF_VALUE_OBJECT_SCORE				= 4000 -- 점령에 필요한 포인트 (단위:1000=1초)
DEF_VALUE_GEN_DOMINATION_TIME		= 10000 -- 점령지 생성 시간 (단위:1000=1초)
DEF_ARY_VALUE_REQ_DOM_PLAYER		= { 1, 1, 2, 1, 1 } -- 점령에 필요한 인원
DEF_VALUE_RESPWAN_TIME				= 7500 -- 부활 시간 (단위:1000=1초)
--------------------------------------------
FIX_DOM_CNT_MAX						= 5 -- 점령지 최대 개수, 어차피 점령지 개수 증가 시 트리거에도 추가해야 되서 의미는 없으나 해당 코드 영역을 찾기 편하도록 정의 상수 추가, 이와 같은 경우 "FIX_" 말머리를 사용

-- 점령지 점령 상태
g_complete_dom_arry = {}

-- 점령 이펙트 연출 관련 전역 변수
g_prev_effect_state = {}
g_prev_effect_name = {}

-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	game_limit_time = 600000
	site_object_prefix="scp_"
	site_icon_prefix="target"
	exist_kill_score="no"
	exist_team_score="yes"
	round_mode="off"
	lua_call_set_team_role( "NAF", "dod_player" )
	lua_call_set_team_role( "EDEN", "dod_player" )
	drone_timer_decrease_rate_attack = 10 -- 공격 계열 획득 점수
	drone_timer_decrease_rate_operation = 10 -- 작전 계열 획득 점수
	respawn_delay = DEF_VALUE_RESPWAN_TIME
	force_respawn = DEF_VALUE_RESPWAN_TIME
	respawn_key_input_delay = DEF_VALUE_RESPWAN_TIME
	no_damage_time = 5000
	respawn="on"
	drone_delay=5000
	game_wait_buffer_time = 20000
	drone_cooltime_cycle_limit = false
	-- 라스트캠 옵션 lua_call_lastcam_control ( [캠 재생여부],[캠 재생시간], [슬로모션 시작점], [슬로모션 종료점], [슬로모션 재생속도] 
	lua_call_lastcam_control(1, 7000, 5000, 6500, 40)
	lua_call_load_ui("")
end

function select_loadout()
end

function prepare_round()
	lua_call_set_enable_entity( "inst_a_bgm", 0, "scp_a")
	lua_call_set_enable_entity( "inst_a_bgm", 0, "scp_b")
	lua_call_set_enable_entity( "inst_a_bgm", 0, "scp_c")
	lua_call_set_enable_entity( "inst_a_bgm", 0, "scp_d")
	lua_call_set_enable_entity( "inst_a_bgm", 0, "scp_e")
	lua_call_show_ui (510)
end

function prepare_round_server()
	disable_all_dom()
	disable_all_entity()
end

function prepare_round_client()
	lua_call_set_observer_cam( "start_cam" )
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

function winner_ceremony()
end

function disable_all_dom()
	lua_call_set_enable_trigger_object( "scp_a", 0 )
	lua_call_set_enable_trigger_object( "scp_b", 0 )
	lua_call_set_enable_trigger_object( "scp_c", 0 )
	lua_call_set_enable_trigger_object( "scp_d", 0 )
	lua_call_set_enable_trigger_object( "scp_e", 0 )
end

function disable_all_entity()
	lua_call_set_enable_entity( "scp_rdy_a", 0, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_b", 0, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_c", 0, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_d", 0, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_e", 0, "start_scp")
	lua_call_set_enable_entity( "scp_eff_a", 0, "scp_a")
	lua_call_set_enable_entity( "scp_eff_b", 0, "scp_b")
	lua_call_set_enable_entity( "scp_eff_c", 0, "scp_c")
	lua_call_set_enable_entity( "scp_eff_d", 0, "scp_d")
	lua_call_set_enable_entity( "scp_eff_e", 0, "scp_e")
	lua_call_set_enable_entity( "scp_eff_a1", 0, "scp_a")
	lua_call_set_enable_entity( "scp_eff_b1", 0, "scp_b")
	lua_call_set_enable_entity( "scp_eff_c1", 0, "scp_c")
	lua_call_set_enable_entity( "scp_eff_d1", 0, "scp_d")
	lua_call_set_enable_entity( "scp_eff_e1", 0, "scp_e")
	lua_call_set_enable_entity( "scp_eff_a2", 0, "scp_a")
	lua_call_set_enable_entity( "scp_eff_b2", 0, "scp_b")
	lua_call_set_enable_entity( "scp_eff_c2", 0, "scp_c")
	lua_call_set_enable_entity( "scp_eff_d2", 0, "scp_d")
	lua_call_set_enable_entity( "scp_eff_e2", 0, "scp_e")
	lua_call_set_enable_entity( "scp_eff_a3", 0, "scp_a")
	lua_call_set_enable_entity( "scp_eff_b3", 0, "scp_b")
	lua_call_set_enable_entity( "scp_eff_c3", 0, "scp_c")
	lua_call_set_enable_entity( "scp_eff_d3", 0, "scp_d")
	lua_call_set_enable_entity( "scp_eff_e3", 0, "scp_e")
end

function start_gen_domination_point()
	lua_call_set_enable_entity( "scp_rdy_a", 1, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_b", 1, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_c", 1, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_d", 1, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_e", 1, "start_scp")
	lua_call_set_enable_trigger_object( "start_scp", 1 )
end

function check_gen_time( play_time )
	if play_time > 0 and play_time <= DEF_VALUE_GEN_DOMINATION_TIME
	then
		return 1
	end
	return 0
end

function check_complete_gen_domination_time( play_time )
	if play_time > DEF_VALUE_GEN_DOMINATION_TIME
	then
		return 1
	end
	return 0
end

function complete_gen_domination_point()
	lua_call_set_enable_entity( "scp_rdy_a", 0, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_b", 0, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_c", 0, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_d", 0, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_e", 0, "start_scp")
	lua_call_set_enable_trigger_object( "scp_a", 1 )
	lua_call_set_enable_trigger_object( "scp_b", 1 )
	lua_call_set_enable_trigger_object( "scp_c", 1 )
	lua_call_set_enable_trigger_object( "scp_d", 1 )
	lua_call_set_enable_trigger_object( "scp_e", 1 )
	lua_call_set_enable_trigger_object( "start_scp", 1 )
end

function complete_gen_domination_point_banner()
	lua_call_show_banner( 24 )
end

function init_start_scp()
	g_complete_dom_arry[1] = E_TEAM_ID_NONE
	g_complete_dom_arry[2] = E_TEAM_ID_NONE
	g_complete_dom_arry[3] = E_TEAM_ID_NONE
	g_complete_dom_arry[4] = E_TEAM_ID_NONE
	g_complete_dom_arry[FIX_DOM_CNT_MAX] = E_TEAM_ID_NONE
end

function init_object_dom()
	local object_team_id = E_TEAM_ID_NONE
	local object_score = 0
	local object_user_index = 0
	local object_state = E_OBJECT_STATE_NORMAL
	local object_touch_time = game_limit_time
	local object_user_team = E_TEAM_ID_NONE
	return object_team_id, object_score, object_user_index, object_state, object_touch_time, object_user_team
end

function get_dom_cnt_by_team_id( arry_dom, team_id )
	local dom_cnt = 0
	for index = 1, FIX_DOM_CNT_MAX, 1 do
		if arry_dom[index] == team_id then
			dom_cnt = dom_cnt + 1
		end
	end
	return dom_cnt
end

function is_complete_all_dom_by_team_id( arry_dom, team_id )
	if get_dom_cnt_by_team_id(g_complete_dom_arry, team_id) == FIX_DOM_CNT_MAX then
		return 1
	end
	return 0
end

function check_finish_game_naf()
	if is_complete_all_dom_by_team_id(g_complete_dom_arry, E_TEAM_ID_NAF) == 1
	then
		return 1
	end
	return 0
end

function check_finish_game_eden()
	if is_complete_all_dom_by_team_id(g_complete_dom_arry, E_TEAM_ID_EDEN) == 1
	then
		return 1
	end
	return 0
end

function add_finish_score_naf( goal_score )
	lua_call_add_team_score( E_TEAM_ID_NAF, goal_score )
end

function add_finish_score_eden( goal_score )
	lua_call_add_team_score( E_TEAM_ID_EDEN, goal_score )
end

function is_can_domination( object_team_id, object_state, actor_team_id )
	if object_team_id == actor_team_id
	then
		return 0
	end
	if object_state ~= E_OBJECT_STATE_NORMAL
	then
		return 0
	end
	return 1
end

function set_start_domination_state( actor_id, actor_team_id )
	return actor_id, E_OBJECT_STATE_DOMINATION, actor_team_id
end

function is_can_restart_user_domination( object_name, object_team_id, object_state, object_user_team, actor_team_id )
	if object_state ~= E_OBJECT_STATE_DOMINATION
	then
		return 0
	end
	if object_team_id == E_TEAM_ID_NONE then
		local naf_stay_count = lua_call_get_stay_count( E_TEAM_ID_NAF, object_name )
		local eden_stay_count = lua_call_get_stay_count( E_TEAM_ID_EDEN, object_name )
		if naf_stay_count > 0 and eden_stay_count == 0 and object_user_team ~= actor_team_id then
			return 1
		elseif naf_stay_count == 0 and eden_stay_count > 0 and object_user_team ~= actor_team_id then
			return 1
		end
	end
	return 0
end

function set_restart_user_domination( actor_id, actor_team_id )
	return actor_id, actor_team_id
end

function get_enemy_team_id( object_team_id )
	local dom_team_id = E_TEAM_ID_NONE
	if object_team_id == E_TEAM_ID_NAF then
		dom_team_id = E_TEAM_ID_EDEN
	elseif object_team_id == E_TEAM_ID_EDEN then
		dom_team_id = E_TEAM_ID_NAF
	end
	return dom_team_id
end

function is_can_cancel_domination( object_name, object_team_id, object_state )
	if object_state ~= E_OBJECT_STATE_DOMINATION
	then
		return 0
	end
	if object_team_id == E_TEAM_ID_NONE then
		local naf_stay_count = lua_call_get_stay_count( E_TEAM_ID_NAF, object_name )
		local eden_stay_count = lua_call_get_stay_count( E_TEAM_ID_EDEN, object_name )
		if naf_stay_count == 0 and eden_stay_count == 0 then 
			return 1
		end
	else
		local attack_team_id = get_enemy_team_id(object_team_id)
		local attack_count = lua_call_get_stay_count( attack_team_id, object_name )
		if attack_count == 0 then
			return 1
		end
	end
	return 0
end

function set_cancel_domination_state()
	return 0, E_OBJECT_STATE_NORMAL, E_TEAM_ID_NONE
end

function is_now_domination( object_name, object_team_id, object_state, ob_idx )
	if object_state ~= E_OBJECT_STATE_DOMINATION
	then
		return 0
	end
	local ob_arry_idx = tonumber(ob_idx)
	local need_dom_player = DEF_ARY_VALUE_REQ_DOM_PLAYER[ob_arry_idx]
	if object_team_id == E_TEAM_ID_NONE then
		local naf_stay_count = lua_call_get_stay_count( E_TEAM_ID_NAF, object_name )
		local eden_stay_count = lua_call_get_stay_count( E_TEAM_ID_EDEN, object_name )
		if naf_stay_count >= need_dom_player and eden_stay_count == 0 then 
			return 1
		elseif naf_stay_count == 0 and eden_stay_count >= need_dom_player then
			return 1
		end
	else
		local attack_team_id = get_enemy_team_id(object_team_id)
		local attack_count = lua_call_get_stay_count( attack_team_id, object_name )
		local defence_team_id = get_enemy_team_id(attack_team_id)
		local defence_count = lua_call_get_stay_count( defence_team_id, object_name )
		if attack_count >= need_dom_player and defence_count == 0 then
			return 1
		end
	end
	return 0
end

function proc_domination_score( object_name, object_team_id, flow_time, play_time )
	local now_attack_team = get_enemy_team_id(object_team_id)
	if object_team_id == E_TEAM_ID_NONE then
		if lua_call_get_stay_count( E_TEAM_ID_NAF, object_name ) > 0 then
			now_attack_team = E_TEAM_ID_NAF
		else
			now_attack_team = E_TEAM_ID_EDEN
		end
	end
	local attack_count = lua_call_get_stay_count( now_attack_team, object_name )
	local domination_rate = calc_domation_time_rate( attack_count )
	if now_attack_team == E_TEAM_ID_EDEN then
		domination_rate = domination_rate * -1
	end
	return flow_time * domination_rate, play_time
end

function calc_domation_time_rate( attack_count )
	return attack_count
end

function is_complete_domination( object_score, object_state, object_team_id )
	if object_state == E_OBJECT_STATE_NORMAL
	then
		return 0
	end
	if object_score >= DEF_VALUE_OBJECT_SCORE and object_team_id ~= E_TEAM_ID_NAF
	then
		return 1
	end
	if object_score <= -DEF_VALUE_OBJECT_SCORE and object_team_id ~= E_TEAM_ID_EDEN
	then
		return 1
	end
	return 0
end

function proc_complete_domination( ob_score, ob_idx )
	local ob_arry_idx = tonumber(ob_idx)
	local object_team_id = E_TEAM_ID_NONE
	local object_score = 0
	local object_state = E_OBJECT_STATE_NORMAL
	if ob_score >= DEF_VALUE_OBJECT_SCORE then
		object_team_id = E_TEAM_ID_NAF
	elseif ob_score <= -DEF_VALUE_OBJECT_SCORE then
		object_team_id = E_TEAM_ID_EDEN
	end
	g_complete_dom_arry[ob_arry_idx] = object_team_id
	return object_team_id, object_score, object_state
end

function complete_domination_banner_and_sound( user_index, self_team_id, object_team_id )
	lua_call_show_banner( 23, user_index )
	if self_team_id == object_team_id then
		lua_call_active_trigger( "play_sound_trigger_scp_my_team" )
	else
		lua_call_active_trigger( "play_sound_trigger_scp_enemy_team" )
	end
end

function change_domination_icon( object_name, self_team_id, object_team_id )
	if object_team_id == E_TEAM_ID_NONE then
		lua_call_change_object_icon( object_name, 0 )
	elseif self_team_id == object_team_id then
		lua_call_change_object_icon( object_name, 2 )
	else
		lua_call_change_object_icon( object_name, 1 )
	end
end

function get_effect_name( dom_team, effect_name_code )
	local add_str_by_state
	if dom_team == E_C_DOM_NONE_TEAM then
		add_str_by_state = ""
	else
		add_str_by_state = dom_team
	end
	local effect_name = "scp_eff_"
	effect_name = string.format("%s%s%s", effect_name, effect_name_code, add_str_by_state)
	return effect_name
end

function set_complete_ary_dom_team_id( ob_arry_idx, ob_team_id )
	g_complete_dom_arry[ob_arry_idx] = ob_team_id
end

function get_remain_gen_time( play_time )
	return DEF_VALUE_GEN_DOMINATION_TIME - play_time
end

-- 색상 정의
COLOR_MY_TEAM = "#00FFFF"
COLOR_ENEMY_TEAM = "#FF0000"
COLOR_WHITE = "#FFFFFF"
COLOR_YELLOW = "#FFFF00"
COLOR_GREEN = "#00FF00"
COLOR_GRAY = "#969696"
-- 폰트 크기 정의
FONT_SMALL = 15
FONT_NORMAL = 20
FONT_NORMAL_UP = 25
FONT_LARGE = 30
FONT_LARGE_UP = 35
-- 출력 라인 좌표
OUTPUT_GAP_X = 50
OUTPUT_LINE_Y = 30
OUTPUT_TIME_LINE_Y = OUTPUT_LINE_Y - 15

function output_team_score_ui_info( play_time )
	local msg_game_info
	-- 점령지 생성 시간
	if check_gen_time(play_time) == 1 and get_remain_gen_time(play_time) > 0 then
		msg_game_info = string.format("<font color='%s' size='%s'>점령지 활성화까지 남은 시간\n</font><font color='%s' size='%s'>%.0f</font><font color='%s' size='%s'> 초</font>", COLOR_WHITE, FONT_SMALL, COLOR_YELLOW, FONT_LARGE, (get_remain_gen_time(play_time))/1000, COLOR_GRAY, FONT_NORMAL)
		lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_TIME_LINE_Y, 0, 0, 0, 255 )
		-- 배경음 off
		lua_call_set_enable_entity( "inst_a_bgm", 0, "scp_a")
	-- 그 외 시간
	elseif play_time > 0 then
		-- 배경음 on
		lua_call_set_enable_entity( "inst_a_bgm", 1, "scp_a")
	end
end

function output_domination_ui_info( object_score, object_name, ob_team_id, ob_state, self_team_id, ob_idx, goal_score, team_score_info )
	-- 점령 중인 각 진영 인원 체크
	local naf_stay_count = lua_call_get_stay_count( E_TEAM_ID_NAF, object_name )
	local eden_stay_count = lua_call_get_stay_count( E_TEAM_ID_EDEN, object_name )

	-- 점령 상태 정의
	local dom_state = E_C_DOM_STATE_NONE;
	if naf_stay_count > 0 and eden_stay_count > 0 then
		dom_state = E_C_DOM_STATE_CONFLICT;
	elseif ob_state == E_OBJECT_STATE_DOMINATION then
		if (naf_stay_count > 0 and self_team_id == E_TEAM_ID_NAF) or (eden_stay_count > 0 and self_team_id == E_TEAM_ID_EDEN) then
			dom_state = E_C_DOM_STATE_MY_TEAM;
		elseif (eden_stay_count > 0 and self_team_id == E_TEAM_ID_NAF) or (naf_stay_count > 0 and self_team_id == E_TEAM_ID_EDEN) then
			dom_state = E_C_DOM_STATE_ENEMY_TEAM;
		end
	end

	-- 점령지 진영
	local dom_team = E_C_DOM_NONE_TEAM
	if (ob_team_id == E_TEAM_ID_NAF and self_team_id == E_TEAM_ID_NAF) or (ob_team_id == E_TEAM_ID_EDEN and self_team_id == E_TEAM_ID_EDEN) then
		dom_team = E_C_DOM_MY_TEAM
	elseif (ob_team_id == E_TEAM_ID_NAF and self_team_id == E_TEAM_ID_EDEN) or (ob_team_id == E_TEAM_ID_EDEN and self_team_id == E_TEAM_ID_NAF) then
		dom_team = E_C_DOM_ENEMY_TEAM
	end

	-- 오브젝트 배열 번호
	local ob_arry_idx = tonumber(ob_idx)

	-- 점령 상태에 따른 장판 이펙트 연출
	local ob_effect_name_code
    local start_pos, end_pos = string.find(object_name, "scp_")
    ob_effect_name_code = string.sub(object_name, end_pos+1, string.len(object_name))
	if dom_team ~= g_prev_effect_state[ob_arry_idx] then
		local effect_name = get_effect_name( dom_team, ob_effect_name_code )
		if g_prev_effect_name[ob_arry_idx] ~= nil then
			lua_call_play_effect( g_prev_effect_name[ob_arry_idx], 0 )
		end
		lua_call_play_effect( effect_name, 1 )
		g_prev_effect_state[ob_arry_idx] = dom_team
		g_prev_effect_name[ob_arry_idx] = effect_name
	end

	-- 점령 중인 지역 값 세팅 (클라이언트 쪽)
	set_complete_ary_dom_team_id(ob_arry_idx, ob_team_id)

	-- <<< 이 아래는 모두 연출 관련 임시 코드 >>>
	local msg_game_info
	local team_color = COLOR_WHITE

	-- 점령지 진영 표시
	if dom_team == E_C_DOM_MY_TEAM then
		team_color = COLOR_MY_TEAM
	elseif dom_team == E_C_DOM_ENEMY_TEAM then
		team_color = COLOR_ENEMY_TEAM
	end
	msg_game_info = string.format("<font color='%s' size='%s'>(%s)</font>", team_color, FONT_NORMAL_UP, string.upper(ob_effect_name_code))
	lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, (ob_arry_idx*OUTPUT_GAP_X)-(OUTPUT_GAP_X*3), OUTPUT_LINE_Y, 0, 0, 0, 255 )

	-- 점령 필요 인원
	if dom_state == E_C_DOM_STATE_MY_TEAM and (naf_stay_count + eden_stay_count) > 0 then
		msg_game_info = string.format("<font color='%s' size='%s'>%s/%s</font>", team_color, FONT_SMALL, naf_stay_count+eden_stay_count, DEF_ARY_VALUE_REQ_DOM_PLAYER[ob_arry_idx])
		lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, (ob_arry_idx*OUTPUT_GAP_X)-(OUTPUT_GAP_X*3), OUTPUT_LINE_Y+FONT_NORMAL_UP+10, 0, 0, 0, 255 )
	end
end
