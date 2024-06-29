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
-- 공격팀 ID (임시 정의 상수)
--------------------------------------------
E_TEMP_ATTACK_TEAM_ID				= E_TEAM_ID_NAF
E_TEMP_DEFENCE_TEAM_ID				= E_TEAM_ID_EDEN
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
DEF_VALUE_OBJECT_SCORE				= 30000 -- 점령에 필요한 포인트 
DEF_VALUE_GEN_DOMINATION_TIME		= 20000 -- 점령지 생성 시간 (단위:1000=1초)
DEF_VALUE_1ST_TIME_LIMIT			= 300000 -- 전반 제한 시간 (단위:1000=1초)
DEF_VALUE_2ST_TIME_LIMIT			= 300000 -- 후반 제한 시간 (단위:1000=1초)
DEF_VALUE_DELAY_DOM_SCORE_TIME		= 1500 -- 점령지 스코어 회복 딜레이 (단위:1000=1초)
DEF_VALUE_AUTO_RECOVERY_DOM_SCORE	= 250 -- update_time='500'(0.5초) 마다 회복되는 점령지 스코어값
DEF_VALUE_ADD_DRONE_POINT			= 50 -- 점령 중인 인원에게 update_time='1000'(1초) 마다 추가되는 배틀 포인트량
DEF_VALUE_TEAM_POINT_DOMINATION		= 200 -- 점령 시 팀 획득 포인트
DEF_VALUE_RESPAWN_BASE_TIME			= 5000 -- 기본 부활 시간 (단위:1000=1초)
DEF_VALUE_RESPAWN_DELAY_PENALTY		= 10000 -- 양팀 모두 중간 목표 도달 시 부활 패널티 시간 (단위:1000=1초)
DEF_VALUE_FINAL_GOAL_KEEP_CNT		= 0 -- 최종 목표 완료 후 필요 유지 틱 횟수 (update_time='500' 기준) 
DEF_VALUE_LIMIT_TIME_ALARM_TIME		= 90000 -- 제한 시간 알람 시간 (단위:1000=1초)
--------------------------------------------
FIX_GAME_TIME_LIMIT					= DEF_VALUE_1ST_TIME_LIMIT + DEF_VALUE_2ST_TIME_LIMIT -- 게임 제한 시간
FIX_DOM_CNT_MAX						= 2 -- 점령지 최대 개수, 어차피 점령지 개수 증가 시 트리거에도 추가해야 되서 의미는 없으나 해당 코드 영역을 찾기 편하도록 정의상수 추가, 이와 같은 경우 "FIX_" 말머리를 사용

-- 게임 진행 상태
g_game_progress_state = E_GAME_PROGRESS_STATE_1ST

-- 점령지 스코어 저장
g_dom_score_flag_arry = {}

-- 점령 이펙트 연출 관련 전역 변수
g_prev_effect_state = {}
g_prev_effect_name = {}

-- 추가 시간 안내 문구 출력 여부
g_c_is_show_extra_time_tip_flag = 0
-- 전후반 남은 시간 안내 문구 출력 여부
g_c_is_show_limit_time_tip_flag_arry = {}

-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	site_object_prefix="dom_"
	site_icon_prefix="target"
	exist_kill_score="no"
	exist_team_score="yes"
	round_mode="on"
	round_time = FIX_GAME_TIME_LIMIT * 5
	round_restart_delay = 5000
	swap_spawn_pos="on"
	drone_timer_decrease_rate_attack = 150 -- 공격 계열 획득 점수
	drone_timer_decrease_rate_operation = 150 -- 작전 계열 획득 점수
	contribution_point_rate = 0.2
	respawn="on"
	respawn_delay = DEF_VALUE_RESPAWN_BASE_TIME
	force_respawn = DEF_VALUE_RESPAWN_BASE_TIME
	respawn_key_input_delay = DEF_VALUE_RESPAWN_DELAY_PENALTY
	-- 리스폰 설정
	set_spawn_pos_by_game_progress_state()
	no_damage_time = 5000
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
	lua_call_set_enable_entity( "inst_a_bgm", 0, "dom_a" )
	lua_call_set_enable_entity( "inst_a_bgm", 0, "dom_b" )
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
	lua_call_set_enable_trigger_object( "dom_a", 0 )
	lua_call_set_enable_trigger_object( "dom_b", 0 )
	lua_call_set_visible_object( "dom_obj_a", 0 )
	lua_call_set_visible_object( "dom_obj_b", 0 )
end

function disable_all_entity()
	lua_call_set_enable_entity( "scp_rdy_a", 0 , "start_scp" )
	lua_call_set_enable_entity( "scp_rdy_b", 0 , "start_scp" )
	lua_call_set_enable_entity( "dom_eff_a", 0 , "dom_a" )
	lua_call_set_enable_entity( "dom_eff_b", 0 , "dom_b" )
	lua_call_set_enable_entity( "dom_eff_a1", 0 , "dom_a" )
	lua_call_set_enable_entity( "dom_eff_b1", 0 , "dom_b" )
	lua_call_set_enable_entity( "dom_eff_a2", 0 , "dom_a" )
	lua_call_set_enable_entity( "dom_eff_b2", 0 , "dom_b" )
	lua_call_set_enable_entity( "dom_eff_a3", 0 , "dom_a" )
	lua_call_set_enable_entity( "dom_eff_b3", 0 , "dom_b" )
end

function start_gen_domination_point()
	lua_call_set_enable_entity( "scp_rdy_a", 1, "start_scp" )
	lua_call_set_enable_trigger_object( "start_scp", 1 )
end

function check_complete_gen_domination_time( play_time )
	if play_time > DEF_VALUE_GEN_DOMINATION_TIME
	then
		return 1
	end
	return 0
end

function complete_gen_domination_point()
	lua_call_set_enable_entity( "scp_rdy_a", 0 , "start_scp" )
	lua_call_set_enable_trigger_object( "dom_a", 1 )
	lua_call_set_visible_object( "dom_obj_a", 1 )
	lua_call_set_enable_trigger_object( "start_scp", 1 )
end

function complete_gen_domination_point_banner( self_team_id )
	lua_call_show_banner( 24 )
	if self_team_id == E_TEMP_ATTACK_TEAM_ID then
		lua_call_show_caption_ui( 1, "tutorial00", "msg0010125", 10.00000 )
	else
		lua_call_show_caption_ui( 1, "tutorial00", "msg0010128", 10.00000 )
	end
	lua_call_set_visible_object( "dom_obj_a", 1 )
end

function start_regen_domination_point( play_time, object_limit_time )
	disable_all_dom()
	disable_all_entity()
	lua_call_set_enable_entity( "scp_rdy_b", 1, "start_scp" )
	lua_call_set_enable_trigger_object( "start_scp", 1 )
	local set_limit_time = object_limit_time + DEF_VALUE_2ST_TIME_LIMIT
	if play_time >= object_limit_time then
		set_limit_time = play_time + DEF_VALUE_2ST_TIME_LIMIT
	end
	return play_time, set_limit_time
end

function start_regen_dom_all_effect_off()
	lua_call_set_visible_object( "dom_obj_a", 0 )
	lua_call_set_visible_object( "dom_obj_b", 0 )
	lua_call_play_effect( g_prev_effect_name[1], 0 )
	lua_call_play_effect( g_prev_effect_name[FIX_DOM_CNT_MAX], 0 )
	g_prev_effect_state = {}
	g_prev_effect_name = {}
end

function check_complete_regen_domination_time( play_time, object_regen_time )
	if (play_time - object_regen_time) > DEF_VALUE_GEN_DOMINATION_TIME
	then
		return 1
	end
	return 0
end

function complete_regen_domination_point()
	lua_call_set_enable_entity( "scp_rdy_b", 0 , "start_scp" )
	lua_call_set_enable_trigger_object( "dom_b", 1 )
	lua_call_set_visible_object( "dom_obj_b", 1 )
	lua_call_set_enable_trigger_object( "start_scp", 1 )
	g_game_progress_state = E_GAME_PROGRESS_STATE_2ST
	set_spawn_pos_by_game_progress_state()
	return g_game_progress_state
end

function complete_regen_domination_point_banner( self_team_id )
	lua_call_show_banner( 24 )
	if self_team_id == E_TEMP_ATTACK_TEAM_ID then
		lua_call_show_caption_ui( 1, "tutorial00", "msg0010115", 10.00000 )
	else
		lua_call_show_caption_ui( 1, "tutorial00", "msg0010116", 10.00000 )
	end
	lua_call_set_visible_object( "dom_obj_b", 1 )
end

function check_timeout_game( play_time, object_limit_time )
	local dom_score_flag = g_dom_score_flag_arry[1]
	if g_game_progress_state == E_GAME_PROGRESS_STATE_2ST then
		dom_score_flag = g_dom_score_flag_arry[FIX_DOM_CNT_MAX]
	end
	if check_complete_gen_domination_time(play_time) == 1 and play_time >= object_limit_time and dom_score_flag == E_DOM_SCORE_FLAG_ZERO
	then
		return 1
	end
	return 0
end

function init_start_scp()
	local object_regen_time = round_time
	local object_game_state = E_GAME_PROGRESS_STATE_1ST
	local object_limit_time = DEF_VALUE_1ST_TIME_LIMIT
	local object_team_id = E_TEMP_DEFENCE_TEAM_ID
	g_dom_score_flag_arry[1] = E_DOM_SCORE_FLAG_ZERO
	g_dom_score_flag_arry[FIX_DOM_CNT_MAX] = E_DOM_SCORE_FLAG_ZERO
	return object_regen_time, object_game_state, object_limit_time, object_team_id
end

function init_object_dom()
	local object_team_id = E_TEMP_DEFENCE_TEAM_ID
	local object_score = 0
	local object_user_index = 0
	local object_state = E_OBJECT_STATE_NORMAL
	local object_touch_time = round_time
	local object_keep_cnt = DEF_VALUE_FINAL_GOAL_KEEP_CNT
	return object_team_id, object_score, object_user_index, object_state, object_touch_time, object_keep_cnt
end

function set_spawn_pos_by_game_progress_state()
	if g_game_progress_state == E_GAME_PROGRESS_STATE_2ST then
		lua_call_set_enable_spawn_pos( "attack_a1", 0 )
		lua_call_set_enable_spawn_pos( "attack_a2", 0 )
		lua_call_set_enable_spawn_pos( "attack_a3", 0 )
		lua_call_set_enable_spawn_pos( "attack_a4", 0 )
		lua_call_set_enable_spawn_pos( "attack_a5", 0 )
		lua_call_set_enable_spawn_pos( "attack_a6", 0 )
		lua_call_set_enable_spawn_pos( "attack_a7", 0 )
		lua_call_set_enable_spawn_pos( "attack_a8", 0 )
		lua_call_set_enable_spawn_pos( "attack_a9", 0 )
		lua_call_set_enable_spawn_pos( "attack_a10", 0 )
		lua_call_set_enable_spawn_pos( "attack_a11", 0 )
		lua_call_set_enable_spawn_pos( "attack_a12", 0 )
		lua_call_set_enable_spawn_pos( "attack_a13", 0 )
		lua_call_set_enable_spawn_pos( "attack_a14", 0 )
		lua_call_set_enable_spawn_pos( "attack_a15", 0 )
		lua_call_set_enable_spawn_pos( "attack_a16", 0 )
		lua_call_set_enable_spawn_pos( "attack_b1", 1 )
		lua_call_set_enable_spawn_pos( "attack_b2", 1 )
		lua_call_set_enable_spawn_pos( "attack_b3", 1 )
		lua_call_set_enable_spawn_pos( "attack_b4", 1 )
		lua_call_set_enable_spawn_pos( "attack_b5", 1 )
		lua_call_set_enable_spawn_pos( "attack_b6", 1 )
		lua_call_set_enable_spawn_pos( "attack_b7", 1 )
		lua_call_set_enable_spawn_pos( "attack_b8", 1 )
		lua_call_set_enable_spawn_pos( "attack_b9", 1 )
		lua_call_set_enable_spawn_pos( "attack_b10", 1 )
		lua_call_set_enable_spawn_pos( "attack_b11", 1 )
		lua_call_set_enable_spawn_pos( "attack_b12", 1 )
		lua_call_set_enable_spawn_pos( "attack_b13", 1 )
		lua_call_set_enable_spawn_pos( "attack_b14", 1 )
		lua_call_set_enable_spawn_pos( "attack_b15", 1 )
		lua_call_set_enable_spawn_pos( "attack_b16", 1 )
	else
		lua_call_set_enable_spawn_pos( "attack_b1", 0 )
		lua_call_set_enable_spawn_pos( "attack_b2", 0 )
		lua_call_set_enable_spawn_pos( "attack_b3", 0 )
		lua_call_set_enable_spawn_pos( "attack_b4", 0 )
		lua_call_set_enable_spawn_pos( "attack_b5", 0 )
		lua_call_set_enable_spawn_pos( "attack_b6", 0 )
		lua_call_set_enable_spawn_pos( "attack_b7", 0 )
		lua_call_set_enable_spawn_pos( "attack_b8", 0 )
		lua_call_set_enable_spawn_pos( "attack_b9", 0 )
		lua_call_set_enable_spawn_pos( "attack_b10", 0 )
		lua_call_set_enable_spawn_pos( "attack_b11", 0 )
		lua_call_set_enable_spawn_pos( "attack_b12", 0 )
		lua_call_set_enable_spawn_pos( "attack_b13", 0 )
		lua_call_set_enable_spawn_pos( "attack_b14", 0 )
		lua_call_set_enable_spawn_pos( "attack_b15", 0 )
		lua_call_set_enable_spawn_pos( "attack_b16", 0 )
		lua_call_set_enable_spawn_pos( "attack_a1", 1 )
		lua_call_set_enable_spawn_pos( "attack_a2", 1 )
		lua_call_set_enable_spawn_pos( "attack_a3", 1 )
		lua_call_set_enable_spawn_pos( "attack_a4", 1 )
		lua_call_set_enable_spawn_pos( "attack_a5", 1 )
		lua_call_set_enable_spawn_pos( "attack_a6", 1 )
		lua_call_set_enable_spawn_pos( "attack_a7", 1 )
		lua_call_set_enable_spawn_pos( "attack_a8", 1 )
		lua_call_set_enable_spawn_pos( "attack_a9", 1 )
		lua_call_set_enable_spawn_pos( "attack_a10", 1 )
		lua_call_set_enable_spawn_pos( "attack_a11", 1 )
		lua_call_set_enable_spawn_pos( "attack_a12", 1 )
		lua_call_set_enable_spawn_pos( "attack_a13", 1 )
		lua_call_set_enable_spawn_pos( "attack_a14", 1 )
		lua_call_set_enable_spawn_pos( "attack_a15", 1 )
		lua_call_set_enable_spawn_pos( "attack_a16", 1 )
	end
end

function set_respawn_delay_penalty( respawn_team_id )
	lua_call_respawn_delay( respawn_team_id, DEF_VALUE_RESPAWN_DELAY_PENALTY, DEF_VALUE_RESPAWN_DELAY_PENALTY )
end

function proc_respawn_delay_penalty_all_team()
	set_respawn_delay_penalty(E_TEAM_ID_NAF)
	set_respawn_delay_penalty(E_TEAM_ID_EDEN)
end

function is_can_domination( object_state, actor_team_id )
	if object_state ~= E_OBJECT_STATE_NORMAL
	then
		return 0
	end
	if actor_team_id == E_TEMP_ATTACK_TEAM_ID
	then
		return 1
	end
	return 0
end

function set_start_domination_state( actor_id )
	return actor_id, E_OBJECT_STATE_DOMINATION
end

function is_can_cancel_domination( object_name, object_state )
	if object_state ~= E_OBJECT_STATE_DOMINATION
	then
		return 0
	end
	local attack_count = lua_call_get_stay_count( E_TEMP_ATTACK_TEAM_ID, object_name )
	if attack_count == 0 then
		return 1
	end
	return 0
end

function set_cancel_domination_state()
	return 0, E_OBJECT_STATE_NORMAL
end

function is_now_domination( object_name, object_state )
	if object_state ~= E_OBJECT_STATE_DOMINATION
	then
		return 0
	end
	local attack_count = lua_call_get_stay_count( E_TEMP_ATTACK_TEAM_ID, object_name )
	local defence_count = lua_call_get_stay_count( E_TEMP_DEFENCE_TEAM_ID, object_name )
	if attack_count > 0 and defence_count == 0 then
		return 1
	end
	return 0
end

function calc_domation_time_rate( attack_count )
	if attack_count == 0
	then
		return 0
	elseif attack_count == 2
	then
		return 1.5
	elseif attack_count >= 3
	then
		return 2
	end
	return 1
end

function proc_domination_score( object_name, flow_time, play_time, object_score, object_keep_cnt, ob_idx )
	local ob_arry_idx = tonumber(ob_idx)
	g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_NOT_ZERO
	local attack_count = lua_call_get_stay_count( E_TEMP_ATTACK_TEAM_ID, object_name )
	local domination_rate = calc_domation_time_rate( attack_count )
	local add_score = flow_time * domination_rate
	if (object_score + add_score) >= DEF_VALUE_OBJECT_SCORE then
		add_score = DEF_VALUE_OBJECT_SCORE - object_score
	end
	local result_keep_cnt = tonumber(object_keep_cnt)
	if object_score >= DEF_VALUE_OBJECT_SCORE
	then
		if result_keep_cnt ~= 0 then
			result_keep_cnt = result_keep_cnt - 1
		end
	end
	return add_score, play_time, result_keep_cnt
end

function add_drone_point_by_domination( object_name )
	-- 점령 중인 인원에게 update_time='1000'(1초) 마다 추가되는 배틀 포인트량
	local reward_point = DEF_VALUE_ADD_DRONE_POINT
	lua_call_add_drone_point_by_domination( E_TEMP_ATTACK_TEAM_ID, object_name, reward_point )
end

function team_add_point_by_domination()
	local a_point = DEF_VALUE_TEAM_POINT_DOMINATION
	local o_point = DEF_VALUE_TEAM_POINT_DOMINATION
	local weapon_exp = 0
	local exp = 0
	local coin = 0
	local reward_type = RewardType_Mod_Domination
	lua_call_add_team_reward( E_TEMP_ATTACK_TEAM_ID, a_point, o_point, weapon_exp, exp, coin, reward_type )
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

function proc_recovery_score( object_score, ob_idx )
	local ob_arry_idx = tonumber(ob_idx)
	local max_recovery_score = 0
	local auto_recovery_score = -DEF_VALUE_AUTO_RECOVERY_DOM_SCORE
	if (object_score + auto_recovery_score) <= max_recovery_score then
		auto_recovery_score = max_recovery_score - object_score
		g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_ZERO
	end
	return auto_recovery_score
end

function is_complete_domination( object_score, object_state, object_keep_cnt )
	if object_state == E_OBJECT_STATE_NORMAL
	then
		return 0
	end
	if object_score >= DEF_VALUE_OBJECT_SCORE and object_keep_cnt <= 0
	then
		return 1
	end
	return 0
end

function proc_complete_domination()
	return E_TEMP_ATTACK_TEAM_ID
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

function get_effect_name( dom_state, effect_name_code )
	local add_str_by_state
	if dom_state == E_C_DOM_STATE_NONE then
		add_str_by_state = ""
	else
		add_str_by_state = dom_state
	end
	local effect_name = "dom_eff_"
	effect_name = string.format("%s%s%s", effect_name, effect_name_code, add_str_by_state)
	return effect_name
end

function check_gen_start_time( play_time )
	if play_time > 0
	then
		return 1
	end
	return 0
end

function get_remain_gen_time( play_time )
	return DEF_VALUE_GEN_DOMINATION_TIME - play_time
end

function check_regen_start_time( play_time, object_regen_time )
	if play_time > object_regen_time
	then
		return 1
	end
	return 0
end

function get_remain_regen_time( play_time, object_regen_time )
	return (object_regen_time + DEF_VALUE_GEN_DOMINATION_TIME) - play_time
end

function is_now_gameplay_time( play_time, goal_score, team_score_info )
	if play_time <= 0
	then
		return 0
	end
	if team_score_info.naf >= goal_score or team_score_info.eden >= goal_score
	then
		return 0
	end
	return 1
end

function get_time_string( time_value )
	local time_str
	local minute_value = time_value / 60
	local second_value = time_value % 60
	time_str = string.format("%02d:%02d", minute_value, second_value)
	return time_str
end

function set_score_ary_dom( ob_arry_idx, object_score )
	if object_score == 0 then
		g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_ZERO
	else
		g_dom_score_flag_arry[ob_arry_idx] = E_DOM_SCORE_FLAG_NOT_ZERO
	end
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
OUTPUT_GAP_X = 0
OUTPUT_LINE_Y = 80
OUTPUT_LIMIT_LINE_Y = 15
OUTPUT_GEN_TIME_LINE_Y = OUTPUT_LINE_Y - 5
OUTPUT_KEEP_TIME_LINE_Y = OUTPUT_LINE_Y + 75

function output_team_score_ui_info( play_time, self_team_id, object_regen_time, object_game_state, object_limit_time, goal_score, team_score_info )
	-- 경기 진행 중이 아닌 경우 (경기 종료 시점 등)
	if is_now_gameplay_time(play_time, goal_score, team_score_info) == 0 then
		lua_call_set_enable_entity( "inst_a_bgm", 0, "dom_a" )
		return
	end
	local msg_game_info
	local remain_limit_time = object_limit_time-play_time
	-- 남은 시간 또는 추가 시간 표시
	if remain_limit_time >= 0 then
		msg_game_info = string.format("<font color='%s' size='%s'>제한 시간\n</font><font color='%s' size='%s'>%s</font>", COLOR_GRAY, FONT_SMALL, COLOR_WHITE, FONT_NORMAL_UP, get_time_string(remain_limit_time/1000))
	else
		msg_game_info = string.format("<font color='%s' size='%s'>추가 시간\n</font>", COLOR_GREEN, FONT_LARGE_UP)
		if g_c_is_show_extra_time_tip_flag == 0 then
			lua_call_show_caption_ui( 1, "tutorial00", "msg0010114", 10.00000 )
			g_c_is_show_extra_time_tip_flag = 1
		end
	end
	lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_LIMIT_LINE_Y, 0, 0, 0, 255 )
	-- 점령지 생성 시간 표시
	if check_gen_start_time(play_time) == 1 and get_remain_gen_time(play_time) > 0 then
		msg_game_info = string.format("<font color='%s' size='%s'>1/2차 목표 활성화까지 남은 시간\n</font><font color='%s' size='%s'>%.0f</font><font color='%s' size='%s'> 초</font>", COLOR_WHITE, FONT_SMALL, COLOR_YELLOW, FONT_LARGE, (get_remain_gen_time(play_time))/1000, COLOR_GRAY, FONT_NORMAL)
		lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_GEN_TIME_LINE_Y, 0, 0, 0, 255 )
	elseif check_regen_start_time(play_time, object_regen_time) == 1 and get_remain_regen_time(play_time, object_regen_time) > 0 then
		msg_game_info = string.format("<font color='%s' size='%s'>2/2차 목표 활성화까지 남은 시간\n</font><font color='%s' size='%s'>%.0f</font><font color='%s' size='%s'> 초</font>", COLOR_WHITE, FONT_SMALL, COLOR_YELLOW, FONT_LARGE, (get_remain_regen_time(play_time, object_regen_time))/1000, COLOR_GRAY, FONT_NORMAL)
		lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_GEN_TIME_LINE_Y, 0, 0, 0, 255 )
	end
	-- 남은 시간에 따라 배경음 출력
	if remain_limit_time <= DEF_VALUE_LIMIT_TIME_ALARM_TIME then
		lua_call_set_enable_entity( "inst_a_bgm", 1, "dom_a" )
		local ob_arry_idx = tonumber(object_game_state)
		if g_c_is_show_limit_time_tip_flag_arry[ob_arry_idx] == nil then
			if self_team_id == E_TEMP_ATTACK_TEAM_ID then
				lua_call_show_caption_ui( 1, "tutorial00", "msg0010020", 10.00000 )
			else
				lua_call_show_caption_ui( 1, "tutorial00", "msg0010021", 10.00000 )
			end
			g_c_is_show_limit_time_tip_flag_arry[ob_arry_idx] = 1
		end
	else
		lua_call_set_enable_entity( "inst_a_bgm", 0, "dom_a" )
	end
end

function output_domination_ui_info( object_score, object_name, ob_team_id, self_team_id, ob_idx, object_keep_cnt, play_time, goal_score, team_score_info )
	-- 경기 진행 중이 아닌 경우 (경기 종료 시점 등)
	if is_now_gameplay_time(play_time, goal_score, team_score_info) == 0 then
		return
	end

	-- 점령 중인 각 진영 인원 체크
	local attack_stay_count = lua_call_get_stay_count( E_TEMP_ATTACK_TEAM_ID, object_name )
	local defence_stay_count = lua_call_get_stay_count( E_TEMP_DEFENCE_TEAM_ID, object_name )

	-- 점령 상태 정의
	local dom_state = E_C_DOM_STATE_NONE
	if attack_stay_count > 0 and defence_stay_count > 0 then
		dom_state = E_C_DOM_STATE_CONFLICT
	elseif attack_stay_count > 0 then
		if self_team_id == E_TEMP_ATTACK_TEAM_ID then
			dom_state = E_C_DOM_STATE_MY_TEAM
		else
			dom_state = E_C_DOM_STATE_ENEMY_TEAM
		end
	else
		if self_team_id == E_TEMP_ATTACK_TEAM_ID then
			dom_state = E_C_DOM_STATE_ENEMY_TEAM
		else
			dom_state = E_C_DOM_STATE_MY_TEAM
		end
	end

	change_domination_icon(object_name, self_team_id, ob_team_id)

	-- 오브젝트 배열 번호
	local ob_arry_idx = tonumber(ob_idx)

	-- 점령 상태에 따른 장판 이펙트 연출
	local ob_effect_name_code
    local start_pos, end_pos = string.find(object_name, "dom_")
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
	set_score_ary_dom(ob_arry_idx, object_score)

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

	-- 점령 유지 시간 표시
	if object_score == DEF_VALUE_OBJECT_SCORE then
		if dom_state == E_C_DOM_STATE_CONFLICT then
			msg_game_info = string.format("<font color='%s' size='%s'>점령 유지\n</font><font color='%s' size='%s'>%.0f％</font>", COLOR_WHITE, FONT_SMALL, COLOR_GRAY, FONT_NORMAL_UP, (DEF_VALUE_FINAL_GOAL_KEEP_CNT-object_keep_cnt)/DEF_VALUE_FINAL_GOAL_KEEP_CNT*100)
			lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_KEEP_TIME_LINE_Y, 0, 0, 0, 255 )
		else
			msg_game_info = string.format("<font color='%s' size='%s'>점령 유지\n</font><font color='%s' size='%s'>%.0f％</font>", COLOR_WHITE, FONT_SMALL, COLOR_GREEN, FONT_NORMAL_UP, (DEF_VALUE_FINAL_GOAL_KEEP_CNT-object_keep_cnt)/DEF_VALUE_FINAL_GOAL_KEEP_CNT*100)
			lua_call_show_debug_info( msg_game_info, 0.5, 1, 0, 0, OUTPUT_KEEP_TIME_LINE_Y, 0, 0, 0, 255 )
		end
	end
end
