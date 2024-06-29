----- 비트 플래그 개수 -----
DEF_BIT_FLAG_CNT = 4
----- 목표 점수 -----
DEF_TARGET_SCORE = 2^DEF_BIT_FLAG_CNT-1
----- 색상 정의 -----
COLOR_WHITE = "#FFFFFF"
COLOR_GREEN = "#00FF00"
COLOR_RED = "#FF0000"
COLOR_GREENBLUE = "#00FFFF"

function gamemode_set()
	-- 네임태그 옵션. 모든 네임태그를 보이지 않게 한다
	nametag_appear_enemy_start_time_		= 5000	-- (int) 적 네임태그가 시작될 시간(해당 ms 동안 보고 있어야 네임태그 출력이 시작된다.)
	nametag_appear_enemy_pos_update_time_ 	= 5000	-- (int) 색적정보 공유시 해당 적 좌표 업데이트 시점(ms)
	nametag_scale_min_ 						= 0	-- (float) 네임태그 최소 스케일
	nametag_scale_max_ 						= 0	-- (float) 네임태그 최대 스케일
	nametag_distance_min_ 					= 0	-- (float) 네임태그가 최대 스케일이 되는 거리(cm)
	nametag_distance_max_ 					= 0	-- (float) 네임태그가 최소 스케일이 되는 거리(cm)
	nametag_appear_my_death_time_ 			= 4000	-- (int) 내가 죽었을 경우 무덤 태그 출력 시간.(ms)
	nametag_appear_friend_death_time		= 2000	-- (int) 같은 팀이 죽었을 경우 네임 태그 출력 시간.(ms)
	nametag_visible_range_max_ 				= 0	-- (int) 네임태그 표시 거리 (cm)

	wave_rule_xml = 'script\\npc_spawn_group_test.xml'
	wave_group_name = 'sg_pvp_sentinel_hunt'
	respawn = "off"
	drone_delay = 0
	-- round_time = 240000
	-- exist_team_score="yes"
	game_limit_time = 720000
	score_per_kill		=	0
	round_mode="off"
	force_team_id = "naf"	
	teammatch = "false"
	allow_teamkill = "on"

	lua_call_set_team_role( "NAF", "sentinel_2" )
    -- hud hp bar option. category, visible, mouse_on, hp_bar, distance, disappear in time 
    lua_call_set_name_tag_by_category("HUD_Ally_Character", 0, 0, 0, 5000, 1000)
    lua_call_set_name_tag_by_category("HUD_Ally_Drone", 0, 0, 0, 5000, 1000)
    lua_call_set_name_tag_by_category("HUD_Enemy_Character", 0, 0, 0, 0, 1000)
    lua_call_set_name_tag_by_category("HUD_Enemy_Drone", 0, 0, 0, 0, 1000)
    lua_call_set_name_tag_by_category("HUD_Ally_Throw_Object", 0, 0, 0, 0, 1000)
    lua_call_set_name_tag_by_category("HUD_Enemy_Throw_Object", 0, 0, 0, 0, 1000)
	
end

function select_loadout()
end

function prepare_round()
	lua_call_action_limit (3) -- 무기 교체, 근접 공격을 못하게 한다
	lua_call_show_ui (355) -- 미니맵, 무기 정보를 끈다
	-- 아웃라인. 엔티티이름, 켬/끔(1/0), 거리(cm), 마우스오버(t/f), 타입(0:벽안뚤,1:벽뚫), 컬러(rgba), 깜빡임속도(초)
	lua_call_set_outline( "dopp_m_a", 1, 0, 0, 1, "0.81,0.64,0.14,1.0", 0 )
	lua_call_set_outline( "dopp_m_b", 1, 0, 0, 1, "0.81,0.64,0.14,1.0", 0 )
	lua_call_set_outline( "dopp_m_c", 1, 0, 0, 1, "0.81,0.64,0.14,1.0", 0 )
	lua_call_set_outline( "dopp_m_d", 1, 0, 0, 1, "0.81,0.64,0.14,1.0", 0 )
end

function prepare_round_server()
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

function winner_ceremony()
end

function check_only_one()
	local alive_count = lua_call_alive_user_count()
	if alive_count == 1	then
		return 1
	end
	return 0
end

function check_take_all_intel(mode_point)
	if mode_point >= DEF_TARGET_SCORE then
		return 1
	end
	return 0
end

function output_ui(mode_point)
	local bit_arry = {}
	bit_arry = get_bit_flag(bit_arry, mode_point)

	-- 내용 출력 부분
	local msg
	local message = ""
	local message_back = ""
	local font_color

	for index = 1, DEF_BIT_FLAG_CNT, 1 do
		if bit_arry[index] == 1 then
			msg = "(O)"
			font_color = COLOR_GREEN
		else
			msg = "(-)"
			font_color = COLOR_WHITE
		end
		msg = string.format("<font color='%s' size='50'>%s</font>", font_color, msg)
		if index == 1 then
			message = string.format("%s", msg)
			message_back = string.format(" INTEL %s", index)
		else
			message = string.format("%s   %s", message, msg)
			message_back = string.format("%s          INTEL %s", message_back, index)
		end
	end
	lua_call_show_debug_info( message, 0.5, 1, 0, 0, 80, 0, 0, 0, 255 )
	message_back = string.format("<font color='#969696' size='15'>%s </font>", message_back)
	lua_call_show_debug_info( message_back, 0.5, 1, 0, 0, 135, 0, 0, 0, 255 )
end

function get_bit_flag(output_arry, bit_value)
	local now_bit_num = 0
	for idx = DEF_BIT_FLAG_CNT-1, 0, -1 do
		now_bit_num = 2^idx
    	if bit_value >= now_bit_num then
        	output_arry[idx+1] = 1
        	bit_value = bit_value - now_bit_num
        else
            output_arry[idx+1] = 0
		end
    end
	return output_arry
end

function show_action_info_msg(mode_point, intel_value)
	if check_untake_intel(mode_point, intel_value) == 0 then
		show_action_info( "msg0010224", 100, 16 )
	end
end

function check_untake_intel(mode_point, intel_value)
	local bit_arry = {}
	bit_arry = get_bit_flag(bit_arry, mode_point)
	local idx = tonumber(intel_value)
	if bit_arry[idx] == 0 then
		return 1
	else
		return 0
	end
end

function get_intel_object(mode_point, intel_value)
	local add_bit_val = 0
	local bit_arry = {}
	bit_arry = get_bit_flag(bit_arry, mode_point)
	local idx = tonumber(intel_value)
	if bit_arry[idx] == 0 then
		add_bit_val = 2^(idx-1)
	end
	return add_bit_val
end
