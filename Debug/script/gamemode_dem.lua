--------------------------------------------
-- 점령지 상태 정의
--------------------------------------------
E_OBJECT_STATE_NORMAL				= 0
E_OBJECT_STATE_DOMINATION			= 1
--------------------------------------------
--------------------------------------------
-- 게임 진행 상태 정의
--------------------------------------------
E_GAME_PROGRESS_STATE_1ST			= 0
E_GAME_PROGRESS_STATE_2ST			= 1
--------------------------------------------
--------------------------------------------
-- 점령지 스코어 존재 여부 플래그
--------------------------------------------
E_DOM_SCORE_FLAG_ZERO				= 0
E_DOM_SCORE_FLAG_NOT_ZERO			= 1
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
DEF_VALUE_OBJECT_SCORE				= 20000 -- 점령에 필요한 포인트 
DEF_VALUE_GEN_DOMINATION_TIME		= 10000 -- 점령지 생성 시간 (단위:1000=1초)
DEF_VALUE_DELAY_DOM_SCORE_TIME		= 1500 -- 점령지 스코어 회복 딜레이 (단위:1000=1초)
DEF_VALUE_ADD_DOM_SCORE_RATE		= 2 -- 중간 목표 완료 시 점령 속도 증가 배율
DEF_VALUE_AUTO_RECOVERY_DOM_SCORE	= 20000 -- update_time='500'(0.5초) 마다 회복되는 점령지 스코어값
DEF_VALUE_ADD_SCORE					= 3 -- 점령 중일 때 update_time='1000'(1초) 마다 획득 점수
DEF_VALUE_ADD_SCORE_ALL_DOM			= 6 -- 모든 지역 점령 중일 때 update_time='1000'(1초) 마다 획득 점수
DEF_VALUE_ADD_DRONE_POINT			= 20 -- 점령 중인 인원에게 update_time='1000'(1초) 마다 추가되는 배틀 포인트량
DEF_VALUE_RESPAWN_DELAY_PENALTY		= 20000 -- 양팀 모두 중간 목표 도달 시 부활 패널티 시간 (단위:1000=1초)
DEF_VALUE_HALF_GOAL_SCORE_GAP		= 1 -- 중간 목표 점수 갭 (예, 값이 1인 경우 게임 목표 점수 500 - 1 = 499점 도달 시 최종 목표로 변경)
DEF_VALUE_FINAL_GOAL_KEEP_CNT		= 10 -- 최종 목표 완료 후 필요 유지 틱 횟수 (update_time='500' 기준) 
--------------------------------------------
FIX_DOM_CNT_MAX						= 3 -- 점령지 최대 개수, 어차피 점령지 개수 증가 시 트리거에도 추가해야 되서 의미는 없으나 해당 코드 영역을 찾기 편하도록 정의상수 추가, 이와 같은 경우 "FIX_" 말머리를 사용

-- 각 팀별 게임 진행 상태
g_game_state_by_team_arry = {}

-- 점령지 점령 상태 및 점령 스코어 저장
g_complete_dom_arry = {}
g_dom_score_flag_arry = {}

-- 점령 이펙트 연출 관련 전역 변수
g_prev_effect_state = {}
g_prev_effect_name = {}

-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	game_limit_time = 3600000
	site_object_prefix="scp_"
	site_icon_prefix="target"
	exist_kill_score="no"
	exist_team_score="yes"
	round_mode="off"
	respawn_delay = 10000
	force_respawn = 10000
	respawn_key_input_delay = DEF_VALUE_RESPAWN_DELAY_PENALTY
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
end

function disable_all_entity()
	lua_call_set_enable_entity( "scp_rdy_a", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_b", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_c", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_a", 0 , "scp_a")
	lua_call_set_enable_entity( "scp_eff_b", 0 , "scp_b")
	lua_call_set_enable_entity( "scp_eff_c", 0 , "scp_c")
	lua_call_set_enable_entity( "scp_eff_a1", 0 , "scp_a")
	lua_call_set_enable_entity( "scp_eff_b1", 0 , "scp_b")
	lua_call_set_enable_entity( "scp_eff_c1", 0 , "scp_c")
	lua_call_set_enable_entity( "scp_eff_a2", 0 , "scp_a")
	lua_call_set_enable_entity( "scp_eff_b2", 0 , "scp_b")
	lua_call_set_enable_entity( "scp_eff_c2", 0 , "scp_c")
	lua_call_set_enable_entity( "scp_eff_a3", 0 , "scp_a")
	lua_call_set_enable_entity( "scp_eff_b3", 0 , "scp_b")
	lua_call_set_enable_entity( "scp_eff_c3", 0 , "scp_c")
end

function start_gen_domination_point()
	lua_call_set_enable_entity( "scp_rdy_a", 1, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_b", 1, "start_scp")
	lua_call_set_enable_entity( "scp_rdy_c", 1, "start_scp")
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
	lua_call_set_enable_entity( "scp_rdy_a", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_b", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_c", 0 , "start_scp")
	lua_call_set_enable_trigger_object( "scp_a", 1 )
	lua_call_set_enable_trigger_object( "scp_b", 1 )
	lua_call_set_enable_trigger_object( "scp_c", 1 )
	lua_call_set_enable_trigger_object( "start_scp", 1 )
end

function complete_gen_domination_point_banner()
	lua_call_show_banner( 24 )
end

function init_start_scp()
	local object_naf_flag = E_GAME_PROGRESS_STATE_1ST
	local object_eden_flag = E_GAME_PROGRESS_STATE_1ST
	local object_keep_cnt = DEF_VALUE_FINAL_GOAL_KEEP_CNT
	g_game_state_by_team_arry[E_TEAM_ID_NAF] = E_GAME_PROGRESS_STATE_1ST
	g_game_state_by_team_arry[E_TEAM_ID_EDEN] = E_GAME_PROGRESS_STATE_1ST
	g_complete_dom_arry[1] = E_TEAM_ID_NONE
	g_complete_dom_arry[2] = E_TEAM_ID_NONE
	g_complete_dom_arry[FIX_DOM_CNT_MAX] = E_TEAM_ID_NONE
	g_dom_score_flag_arry[1] = E_DOM_SCORE_FLAG_ZERO
	g_dom_score_flag_arry[2] = E_DOM_SCORE_FLAG_ZERO
	g_dom_score_flag_arry[FIX_DOM_CNT_MAX] = E_DOM_SCORE_FLAG_ZERO
	return object_naf_flag, object_eden_flag, object_keep_cnt
end

function init_final_score()
	return DEF_VALUE_FINAL_GOAL_KEEP_CNT
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

function is_complete_all_dom( arry_dom )
	if arry_dom[1] == E_TEAM_ID_NAF and arry_dom[2] == E_TEAM_ID_NAF and arry_dom[FIX_DOM_CNT_MAX] == E_TEAM_ID_NAF then
		return 1
	elseif arry_dom[1] == E_TEAM_ID_EDEN and arry_dom[2] == E_TEAM_ID_EDEN and arry_dom[FIX_DOM_CNT_MAX] == E_TEAM_ID_EDEN then
		return 1
	end
	return 0
end

function is_zero_score_all_dom( arry_dom )
	if arry_dom[1] == E_DOM_SCORE_FLAG_ZERO and arry_dom[2] == E_DOM_SCORE_FLAG_ZERO and arry_dom[FIX_DOM_CNT_MAX] == E_DOM_SCORE_FLAG_ZERO then
		return 1
	end
	return 0
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

function set_respawn_delay_penalty( respawn_team_id )
	lua_call_respawn_delay( respawn_team_id, DEF_VALUE_RESPAWN_DELAY_PENALTY, DEF_VALUE_RESPAWN_DELAY_PENALTY )
end

function check_complete_all_half_goal( object_naf_flag, object_eden_flag )
	if object_naf_flag == E_GAME_PROGRESS_STATE_2ST and object_eden_flag == E_GAME_PROGRESS_STATE_2ST
	then
		return 1
	end
	return 0
end

function proc_complete_all_half_goal()
	set_respawn_delay_penalty(E_TEAM_ID_NAF)
	set_respawn_delay_penalty(E_TEAM_ID_EDEN)
end

function check_sub_final_score( object_naf_flag, object_eden_flag, object_keep_cnt )
	if object_keep_cnt <= 0
	then
		return 0
	end
	if ((object_naf_flag == E_GAME_PROGRESS_STATE_2ST and is_complete_all_dom_by_team_id(g_complete_dom_arry, E_TEAM_ID_NAF) == 1) or (object_eden_flag == E_GAME_PROGRESS_STATE_2ST and is_complete_all_dom_by_team_id(g_complete_dom_arry, E_TEAM_ID_EDEN) == 1)) and is_zero_score_all_dom(g_dom_score_flag_arry) == 1
	then
		return 1
	end
	return 0
end

function proc_sub_final_score( object_keep_cnt )
	local sub_value = -1
	local now_keep_cnt = tonumber(object_keep_cnt)
	if now_keep_cnt <= 0 then
		sub_value = 0
	end
	return sub_value
end

function get_half_goal_score( goal_score )
	return goal_score - DEF_VALUE_HALF_GOAL_SCORE_GAP
end

function check_complete_half_goal_naf( object_naf_flag, goal_score, team_score_info )
	if object_naf_flag ~= E_GAME_PROGRESS_STATE_1ST
	then
		return 0
	end
	if get_half_goal_score(tonumber(goal_score)) == tonumber(team_score_info.naf)
	then
		return 1
	end
	return 0
end

function check_complete_half_goal_eden( object_eden_flag, goal_score, team_score_info )
	if object_eden_flag ~= E_GAME_PROGRESS_STATE_1ST
	then
		return 0
	end
	if get_half_goal_score(tonumber(goal_score)) == tonumber(team_score_info.eden)
	then
		return 1
	end
	return 0
end

function proc_complete_half_goal( object_team_id )
	local ob_team_arry_idx = tonumber(object_team_id)
	g_game_state_by_team_arry[ob_team_arry_idx] = E_GAME_PROGRESS_STATE_2ST
	return E_GAME_PROGRESS_STATE_2ST
end

function check_finish_game_naf( object_naf_flag, object_keep_cnt )
	if object_naf_flag ~= E_GAME_PROGRESS_STATE_2ST
	then
		return 0
	end
	if is_complete_all_dom_by_team_id(g_complete_dom_arry, E_TEAM_ID_NAF) == 1 and object_keep_cnt <= 0
	then
		return 1
	end
	return 0
end

function check_finish_game_eden( object_eden_flag, object_keep_cnt )
	if object_eden_flag ~= E_GAME_PROGRESS_STATE_2ST
	then
		return 0
	end
	if is_complete_all_dom_by_team_id(g_complete_dom_arry, E_TEAM_ID_EDEN) == 1 and object_keep_cnt <= 0
	then
		return 1
	end
	return 0
end

function add_finish_score_naf( goal_score, team_score_info )
	lua_call_add_team_score( E_TEAM_ID_NAF, DEF_VALUE_HALF_GOAL_SCORE_GAP )
end

function add_finish_score_eden( goal_score, team_score_info )
	lua_call_add_team_score( E_TEAM_ID_EDEN, DEF_VALUE_HALF_GOAL_SCORE_GAP )
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

function is_now_domination( object_name, object_team_id, object_state )
	if object_state ~= E_OBJECT_STATE_DOMINATION
	then
		return 0
	end
	if object_team_id == E_TEAM_ID_NONE then
		local naf_stay_count = lua_call_get_stay_count( E_TEAM_ID_NAF, object_name )
		local eden_stay_count = lua_call_get_stay_count( E_TEAM_ID_EDEN, object_name )
		if naf_stay_count > 0 and eden_stay_count == 0 then 
			return 1
		elseif naf_stay_count == 0 and eden_stay_count > 0 then
			return 1
		end
	else
		local attack_team_id = get_enemy_team_id(object_team_id)
		local attack_count = lua_call_get_stay_count( attack_team_id, object_name )
		local defence_team_id = get_enemy_team_id(attack_team_id)
		local defence_count = lua_call_get_stay_count( defence_team_id, object_name )
		if attack_count > 0 and defence_count == 0 then
			return 1
		end
	end
	return 0
end

function proc_domination_score( object_name, object_team_id, flow_time, play_time, ob_idx )
	local ob_arry_idx = tonumber(ob_idx)
	g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_NOT_ZERO
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
	local ob_team_arry_idx = tonumber(now_attack_team)
	if g_game_state_by_team_arry[ob_team_arry_idx] == E_GAME_PROGRESS_STATE_2ST then
		domination_rate = domination_rate * DEF_VALUE_ADD_DOM_SCORE_RATE
	end
	return flow_time * domination_rate, play_time
end

function calc_domation_time_rate( attack_count )
	return attack_count
end

function add_drone_point_by_domination( object_team_id, object_name )
	-- 점령 중인 인원에게 update_time='1000'(1초) 마다 추가되는 배틀 포인트량
	reward_point = DEF_VALUE_ADD_DRONE_POINT
	local now_attack_team = get_enemy_team_id(object_team_id)
	if object_team_id == E_TEAM_ID_NONE then
		if lua_call_get_stay_count( E_TEAM_ID_NAF, object_name ) > 0 then
			now_attack_team = E_TEAM_ID_NAF
		else
			now_attack_team = E_TEAM_ID_EDEN
		end
	end
	lua_call_add_drone_point_by_domination( now_attack_team, object_name, reward_point )
end

function is_can_recovery_score( object_state, object_score, object_touch_time, play_time )
	if object_state ~= E_OBJECT_STATE_NORMAL
	then
		return 0
	end
	if object_score ~= 0 and (play_time - object_touch_time) >= DEF_VALUE_DELAY_DOM_SCORE_TIME then 
		return 1
	end
	return 0
end

function proc_recovery_score( object_score, object_team_id, ob_idx )
	local ob_arry_idx = tonumber(ob_idx)
	local max_recovery_score = 0
	local auto_recovery_score = 0
	if object_score < 0 then
		auto_recovery_score = DEF_VALUE_AUTO_RECOVERY_DOM_SCORE
		if (object_score + auto_recovery_score) >= max_recovery_score then
			auto_recovery_score = max_recovery_score - object_score
			g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_ZERO
		end
	else
		auto_recovery_score = -DEF_VALUE_AUTO_RECOVERY_DOM_SCORE
		if (object_score + auto_recovery_score) <= max_recovery_score then
			auto_recovery_score = max_recovery_score - object_score
			g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_ZERO
		end
	end
	return auto_recovery_score
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
	g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_ZERO
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
                
function is_can_add_score( object_name, object_team_id, object_state, goal_score, team_score_info )
	if object_team_id == E_TEAM_ID_NONE
	then
		return 0
	end
	if object_state == E_OBJECT_STATE_DOMINATION
	then
		return 0
	end
	local now_team_score = tonumber(team_score_info.naf)
	if object_team_id == E_TEAM_ID_EDEN then
		now_team_score = tonumber(team_score_info.eden)
	end
	if get_half_goal_score(tonumber(goal_score)) <= now_team_score then
		return 0
	end
	local attack_team_id = get_enemy_team_id(object_team_id)
	local attack_count = lua_call_get_stay_count( attack_team_id, object_name )
	if attack_count > 0 then
		return 0
	end
	return 1
end

function add_score( team_id, goal_score, team_score_info )
	local add_value = DEF_VALUE_ADD_SCORE
	if is_complete_all_dom(g_complete_dom_arry) == 1 then
		add_value = DEF_VALUE_ADD_SCORE_ALL_DOM
	end
	-- 중간 목표 점수를 초과하지 않도록 처리
	local now_team_score = tonumber(team_score_info.naf)
	if team_id == E_TEAM_ID_EDEN then
		now_team_score = tonumber(team_score_info.eden)
	end
	if get_half_goal_score(tonumber(goal_score)) <= now_team_score + add_value then
		add_value = get_half_goal_score(tonumber(goal_score)) - now_team_score
	end
	lua_call_add_team_score( team_id, add_value )
end

function get_effect_name( dom_state, effect_name_code )
	local add_str_by_state
	if dom_state == E_C_DOM_STATE_NONE then
		add_str_by_state = ""
	else
		add_str_by_state = dom_state
	end
	local effect_name = "scp_eff_"
	effect_name = string.format("%s%s%s", effect_name, effect_name_code, add_str_by_state)
	return effect_name
end

function set_complete_ary_dom_team_id( ob_arry_idx, ob_team_id )
	g_complete_dom_arry[ob_arry_idx] = ob_team_id
end

function set_score_ary_dom_team_id( ob_arry_idx, object_score )
	if object_score == 0 then
		g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_ZERO
	else
		g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_NOT_ZERO
	end
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
OUTPUT_GAP_X = 60
OUTPUT_LINE_Y = 40
OUTPUT_TIME_LINE_Y = OUTPUT_LINE_Y - 15
-- 최종 목표 좌표
OUTPUT_LAST_GOAL_TIME_LINE_Y = OUTPUT_LINE_Y + 85
-- 팀 스코어 좌표
OUTPUT_TEAM_SCORE_GAP_X = 150
OUTPUT_TEAM_SCORE_TITLE_LINE_Y = OUTPUT_LINE_Y - 25
OUTPUT_TEAM_SCORE_LINE_Y = OUTPUT_TEAM_SCORE_TITLE_LINE_Y + 35
-- 팁 메시지 좌표
OUTPUT_SHOW_TIP_LINE_Y = OUTPUT_LINE_Y + 70
OUTPUT_SHOW_TIP_GAP_X = -150
OUTPUT_SHOW_TIP_DOM_GAP_X = 180
-- 중간 목표 달성 안내 좌표
OUTPUT_HALF_GOAL_ALARM_GAP_Y = -150

function show_complete_half_goal( self_team_id, object_team_id )
	local msg_game_info
	if self_team_id == tonumber(object_team_id) then
		msg_game_info = string.format("<font color='%s' size='%s'>아군 점령 100％ 달성\n\n</font><font color='%s' size='%s'>아군 점령 속도 증가</font>", COLOR_MY_TEAM, FONT_NORMAL, COLOR_YELLOW, FONT_NORMAL_UP)
		lua_call_show_debug_info( msg_game_info, 5, 1, 1, 0, OUTPUT_HALF_GOAL_ALARM_GAP_Y, 0, 0, 0, 255 )
	else
		msg_game_info = string.format("<font color='%s' size='%s'>적군 점령 100％ 달성\n\n</font><font color='%s' size='%s'>적군 점령 속도 증가</font>", COLOR_ENEMY_TEAM, FONT_NORMAL, COLOR_YELLOW, FONT_NORMAL_UP)
		lua_call_show_debug_info( msg_game_info, 5, 1, 1, 0, OUTPUT_HALF_GOAL_ALARM_GAP_Y, 0, 0, 0, 255 )
	end
end

function show_tip_msg_when_regen_time()
	local msg_game_info
	msg_game_info = string.format("<font color='%s' size='%s'>중간 목표\n</font><font color='%s' size='%s'>점령 점수 </font><font color='%s' size='%s'>100％ 달성</font>", COLOR_GRAY, FONT_SMALL, COLOR_WHITE, FONT_SMALL, COLOR_GREEN, FONT_NORMAL)
	lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, OUTPUT_SHOW_TIP_GAP_X, OUTPUT_SHOW_TIP_LINE_Y, 0, 0, 0, 255 )
	msg_game_info = string.format("<font color='%s' size='%s'>▶▷▶▷▶</font>", COLOR_WHITE, FONT_NORMAL)
	lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_SHOW_TIP_LINE_Y+10, 0, 0, 0, 255 )
	msg_game_info = string.format("<font color='%s' size='%s'>최종 목표\n</font><font color='%s' size='%s'>3개 점령지 </font><font color='%s' size='%s'>완전 점령 후 유지</font>", COLOR_GRAY, FONT_SMALL, COLOR_WHITE, FONT_SMALL, COLOR_GREEN, FONT_NORMAL)
	lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, OUTPUT_SHOW_TIP_DOM_GAP_X, OUTPUT_SHOW_TIP_LINE_Y, 0, 0, 0, 255 )
end

function output_team_score_ui_info( play_time, self_team_id, goal_score, team_score_info, object_naf_flag, object_eden_flag, object_keep_cnt )
	local msg_game_info
	-- 아군, 적군 팀 정보 출력을 위한 변수
	local my_team_score
	local enemy_team_score
	local my_team_game_flag = E_GAME_PROGRESS_STATE_1ST
	local enemy_team_game_flag = E_GAME_PROGRESS_STATE_1ST
	if self_team_id == E_TEAM_ID_NAF then
		my_team_score = team_score_info.naf
		enemy_team_score = team_score_info.eden
		my_team_game_flag = object_naf_flag
		enemy_team_game_flag = object_eden_flag
	else
		my_team_score = team_score_info.eden
		enemy_team_score = team_score_info.naf
		my_team_game_flag = object_eden_flag
		enemy_team_game_flag = object_naf_flag
	end
	-- 첫 시작 시 점령지 생성 시간 표시
	if check_gen_time(play_time) == 1 and get_remain_gen_time(play_time) > 0 then
		local msg_font_color = COLOR_MY_TEAM
		if self_team_id == E_TEAM_ID_EDEN then
			msg_font_color = COLOR_ENEMY_TEAM
		end
		msg_game_info = string.format("<font color='%s' size='%s'>점령지 활성화까지 남은 시간\n</font><font color='%s' size='%s'>%.0f</font><font color='%s' size='%s'> 초</font>", COLOR_WHITE, FONT_SMALL, COLOR_YELLOW, FONT_LARGE, (get_remain_gen_time(play_time))/1000, COLOR_GRAY, FONT_NORMAL)
		lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_TIME_LINE_Y, 0, 0, 0, 255 )
		show_tip_msg_when_regen_time()
	-- 팀 스코어 정보 표시
	elseif play_time > 0 then
		local my_team_title
		local enemy_team_title
		if self_team_id == E_TEAM_ID_NAF then
			my_team_title = "NAF"
			enemy_team_title = "EDEN"
		else
			my_team_title = "EDEN"
			enemy_team_title = "NAF"
		end
		-- 아군팀 정보
		msg_game_info = string.format("<font color='%s' size='%s'>%s</font>", COLOR_MY_TEAM, FONT_SMALL, my_team_title)
		lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, -OUTPUT_TEAM_SCORE_GAP_X, OUTPUT_TEAM_SCORE_TITLE_LINE_Y, 0, 0, 0, 255 )
		if my_team_game_flag == E_GAME_PROGRESS_STATE_1ST then
			-- 중간 목표
			msg_game_info = string.format("<font color='%s' size='%s'>%.0f％</font>", COLOR_MY_TEAM, FONT_LARGE, my_team_score/goal_score*100)
			lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, -OUTPUT_TEAM_SCORE_GAP_X, OUTPUT_TEAM_SCORE_LINE_Y, 0, 0, 0, 255 )
		else
			-- 최종 목표
			msg_game_info = string.format("<font color='%s' size='%s'>3개지역\n모두점령</font>", COLOR_MY_TEAM, FONT_SMALL)
			lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, -OUTPUT_TEAM_SCORE_GAP_X, OUTPUT_TEAM_SCORE_LINE_Y, 0, 0, 0, 255 )
		end
		-- 적군팀 정보
		msg_game_info = string.format("<font color='%s' size='%s'>%s</font>", COLOR_ENEMY_TEAM, FONT_SMALL, enemy_team_title)
		lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, OUTPUT_TEAM_SCORE_GAP_X, OUTPUT_TEAM_SCORE_TITLE_LINE_Y, 0, 0, 0, 255 )
		if enemy_team_game_flag == E_GAME_PROGRESS_STATE_1ST then
			-- 중간 목표
			msg_game_info = string.format("<font color='%s' size='%s'>%.0f％</font>", COLOR_ENEMY_TEAM, FONT_LARGE, enemy_team_score/goal_score*100)
			lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, OUTPUT_TEAM_SCORE_GAP_X, OUTPUT_TEAM_SCORE_LINE_Y, 0, 0, 0, 255 )
		else
			-- 최종 목표
			msg_game_info = string.format("<font color='%s' size='%s'>3개지역\n모두점령</font>", COLOR_ENEMY_TEAM, FONT_SMALL)
			lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, OUTPUT_TEAM_SCORE_GAP_X, OUTPUT_TEAM_SCORE_LINE_Y, 0, 0, 0, 255 )
		end
		-- 모든 지역 점령 중 표시
		local is_all_dom_flag = is_complete_all_dom(g_complete_dom_arry)
		-- 최종 목표 게이지 표시
		if (my_team_game_flag == E_GAME_PROGRESS_STATE_2ST and is_complete_all_dom_by_team_id(g_complete_dom_arry, self_team_id) == 1) or (enemy_team_game_flag == E_GAME_PROGRESS_STATE_2ST and is_complete_all_dom_by_team_id(g_complete_dom_arry, get_enemy_team_id(self_team_id)) == 1) then
			if is_zero_score_all_dom(g_dom_score_flag_arry) == 1 then
				msg_game_info = string.format("<font color='%s' size='%s'>모든 지역 점령\n</font><font color='%s' size='%s'>%.0f％</font>", COLOR_WHITE, FONT_SMALL, COLOR_GREEN, FONT_NORMAL_UP, (DEF_VALUE_FINAL_GOAL_KEEP_CNT-object_keep_cnt)/DEF_VALUE_FINAL_GOAL_KEEP_CNT*100)
				lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_LAST_GOAL_TIME_LINE_Y, 0, 0, 0, 255 )
			else
				msg_game_info = string.format("<font color='%s' size='%s'>모든 지역 점령\n</font><font color='%s' size='%s'>%.0f％</font>", COLOR_WHITE, FONT_SMALL, COLOR_GRAY, FONT_NORMAL_UP, (DEF_VALUE_FINAL_GOAL_KEEP_CNT-object_keep_cnt)/DEF_VALUE_FINAL_GOAL_KEEP_CNT*100)
				lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_LAST_GOAL_TIME_LINE_Y, 0, 0, 0, 255 )
			end
		end
		-- 양팀 모두 중간 목표 완료 시 배경음 출력
		if my_team_game_flag == E_GAME_PROGRESS_STATE_2ST and enemy_team_game_flag == E_GAME_PROGRESS_STATE_2ST then
			lua_call_set_enable_entity( "inst_a_bgm", 1, "scp_a")
		end
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

	-- 오브젝트 배열 번호
	local ob_arry_idx = tonumber(ob_idx)

	-- 점령 상태에 따른 장판 이펙트 연출
	local ob_effect_name_code
    local start_pos, end_pos = string.find(object_name, "scp_")
    ob_effect_name_code = string.sub(object_name, end_pos+1, string.len(object_name))
	if dom_state ~= g_prev_effect_state[ob_arry_idx] then
		local effect_name = get_effect_name( dom_state, ob_effect_name_code )
		if g_prev_effect_name[ob_arry_idx] ~= nil then
			lua_call_play_effect( g_prev_effect_name[ob_arry_idx], 0 )
		end
		lua_call_play_effect( effect_name, 1 )
		g_prev_effect_state[ob_arry_idx] = dom_state
		g_prev_effect_name[ob_arry_idx] = effect_name
	end

	-- 점령 중인 지역 값 세팅 (클라이언트 쪽)
	set_complete_ary_dom_team_id(ob_arry_idx, ob_team_id)
	set_score_ary_dom_team_id(ob_arry_idx, object_score)

	-- <<< 이 아래는 모두 연출 관련 임시 코드 >>>
	local msg_game_info
	local team_color = COLOR_WHITE

	-- 점령지 진영 표시
	if (ob_team_id == E_TEAM_ID_NAF and self_team_id == E_TEAM_ID_NAF) or (ob_team_id == E_TEAM_ID_EDEN and self_team_id == E_TEAM_ID_EDEN) then
		team_color = COLOR_MY_TEAM
	elseif (ob_team_id == E_TEAM_ID_NAF and self_team_id == E_TEAM_ID_EDEN) or (ob_team_id == E_TEAM_ID_EDEN and self_team_id == E_TEAM_ID_NAF) then
		team_color = COLOR_ENEMY_TEAM
	end
	msg_game_info = string.format("<font color='%s' size='%s'>(%s)</font>", team_color, FONT_NORMAL_UP, string.upper(ob_effect_name_code))
	lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, (ob_arry_idx*OUTPUT_GAP_X)-(OUTPUT_GAP_X*2), OUTPUT_LINE_Y, 0, 0, 0, 255 )

	-- 점령 퍼센트
	local domination_percent = 0
	if (self_team_id == E_TEAM_ID_NAF and object_score > 0) or (self_team_id == E_TEAM_ID_EDEN and object_score < 0) then
		team_color = COLOR_MY_TEAM
	elseif (self_team_id == E_TEAM_ID_EDEN and object_score > 0) or (self_team_id == E_TEAM_ID_NAF and object_score < 0) then
		team_color = COLOR_ENEMY_TEAM
	else
		team_color = COLOR_WHITE
	end
	domination_percent = math.abs(object_score) / DEF_VALUE_OBJECT_SCORE
	msg_game_info = string.format("<font color='%s' size='%s'>%.0f％</font>", team_color, FONT_SMALL, domination_percent*100)
	lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, (ob_arry_idx*OUTPUT_GAP_X)-(OUTPUT_GAP_X*2), OUTPUT_LINE_Y+FONT_NORMAL_UP+10, 0, 0, 0, 255 )
end
