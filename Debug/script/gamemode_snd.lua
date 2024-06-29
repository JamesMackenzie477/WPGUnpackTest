-- 이부분은 수정하지 마세요. 
MissionState_None		= 0
MissionState_Bomb_Installing	= 1
MissionState_Bomb_Defusing	= 2
MissionState_Area_Occupying	= 3
-- 이부분은 수정하지 마세요. 

DEF_VALUE_TEAM_POINT_INSTALL	= 25 -- 폭탄 설치 시 팀 획득 포인트
DEF_VALUE_TEAM_POINT_DEFUSE		= 25 -- 폭탄 해제 시 팀 획득 포인트

-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	round_time = 120000
	demolition_bomb_install_time = 5000
	demolition_defuse_bomb_time = 7000
	demolition_bomb_act_time = 40000
	site_object_prefix="bombsite_"
	site_icon_prefix="target"
	drone_delay=10000
	round_restart_delay  = 6000
	respawn_key_input_delay = 3000
	game_wait_buffer_time = 20000
	contribution_point_rate = 2

	respawn="off"
	round_mode="on"
	swap_spawn_pos="on"
	tactical_bomb_mode="on"
	exist_team_score="yes"
	-- 라스트캠 옵션 lua_call_lastcam_control ( [캠 재생여부],[캠 재생시간], [슬로모션 시작점], [슬로모션 종료점], [슬로모션 재생속도] 
	lua_call_lastcam_control(1, 7000, 6000, 6500, 40)
	lua_call_load_ui("hudsnd")
end

function select_loadout()
end

function prepare_round()
	lua_call_set_visible_object( "snd_tar_a", 1 )
	lua_call_set_visible_object( "snd_tar_b", 1 )
	lua_call_set_enable_entity( "snd_blo_a", 1 , "bombsite_a")
	lua_call_set_enable_entity( "snd_blo_b", 1 , "bombsite_b")
	lua_call_set_enable_entity( "bombeff_a", 0 , "bombsite_a")
	lua_call_set_enable_entity( "bombeff_b", 0 , "bombsite_b")
	
	lua_call_set_enable_entity( "inst_a_snd", 0 , "bombsite_a")
	lua_call_set_enable_entity( "inst_b_snd", 0 , "bombsite_b")
	lua_call_set_enable_entity( "inst_a_bgm", 0 , "bombsite_a")
	lua_call_set_enable_entity( "inst_b_bgm", 0 , "bombsite_b")
	lua_call_set_visible_object( "bombinst_a", 0 )
	lua_call_set_visible_object( "bombinst_b", 0 )
	lua_call_set_visible_object( "snd_tar_a2", 0 )
	lua_call_set_visible_object( "snd_tar_b2", 0 )
	lua_call_set_outline( "snd_tar_a", 1, 0, 0, 0, "1.0,0.9,0.0,1.0", 0 )	-- 엔티티이름, 켬/끔(1/0), 거리(cm), 마우스오버(t/f), 타입(0:벽안뚤,1:벽뚫), 컬러(rgba), 깜빡임속도(초)
	lua_call_set_outline( "snd_tar_b", 1, 0, 0, 0, "1.0,0.9,0.0,1.0", 0 )
	lua_call_set_enable_entity("timer_a", 0, "bombsite_a")
	lua_call_set_enable_entity("timer_b", 0, "bombsite_b")
	lua_call_set_enable_entity("snd_dea_a", 0, "bombsite_a")
	lua_call_set_enable_entity("snd_dea_b", 0, "bombsite_b")
	lua_call_stop_animation( "snd_tar_a" )
	lua_call_stop_animation( "snd_tar_b" )
end

function prepare_round_server()
	lua_call_create_tactical_weapon( 248, 'snd_bomb' )
end

function prepare_round_client()
	lua_call_set_observer_cam( "start_cam" )
end

function countdown()
end

function game_end()
	bgm_off()
end

function winning_shot()
end

function end_score_board()
	bgm_off()
end

function half_time()
end

function winner_ceremony()
end

function start_install_bomb_server()
	return MissionState_Bomb_Installing
end

function start_defuse_bomb_server()
	return MissionState_Bomb_Defusing
end

function end_mission()
	return MissionState_None
end

function check_object_state( state, check_value )
	if state == tonumber( check_value )
	then
		return 1
	end
	return 0
end

function check_current_weapon( owner_index, index )
	local result = lua_call_check_current_weapon( owner_index, index )
	if ( result == 1 )
	then
		return 1
	end
	return 0
end

function check_exist_weapon( owner_index, index )
	local result = lua_call_exist_weapon( owner_index, index )
	if ( result == 1 )
	then
		return 1
	end
	return 0
end

function is_enable_user( owner_index, actor_index )
	if ( owner_index == actor_index )
	then
		return 1
	end
	return 0
end

function check_finish_install_bomb( stay_time, rate, press_time )
	if ( stay_time < ( demolition_bomb_install_time * rate ) )
	then
		return 0
	end

	if ( press_time < ( demolition_bomb_install_time * rate ) )
	then
		return 0
	end
	
	return 1
end

function team_add_point_by_install_bomb( object_team_id )
	local a_point = DEF_VALUE_TEAM_POINT_INSTALL
	local o_point = DEF_VALUE_TEAM_POINT_INSTALL
	local weapon_exp = 0
	local exp = 0
	local coin = 0
	local reward_type = RewardType_Mod_Bomb
	lua_call_add_team_reward( object_team_id, a_point, o_point, weapon_exp, exp, coin, reward_type )
end

function team_add_point_by_defuse_bomb( object_team_id )
	local a_point = DEF_VALUE_TEAM_POINT_DEFUSE
	local o_point = DEF_VALUE_TEAM_POINT_DEFUSE
	local weapon_exp = 0
	local exp = 0
	local coin = 0
	local reward_type = RewardType_Mod_Bomb_Remove
	lua_call_add_team_reward( object_team_id, a_point, o_point, weapon_exp, exp, coin, reward_type )
end

function check_demolition( install_time )
	if ( demolition_bomb_act_time < install_time )
	then
		return 1
	end
	
	return 0
end

function play_bomb_team_sound( install_team_id, my_team_id  )
		if my_team_id == install_team_id then
			lua_call_active_trigger( "snd_trg_inst_my_team" )
		else
			lua_call_active_trigger( "snd_trg_inst_enemy_team" )
		end
end

function check_start_defuse_bomb( team_id, actor_team_id, destroy_user_index, actor_user_index )
	if ( team_id == actor_team_id )
	then
		return 0
	end
	if ( destroy_user_index == actor_user_index )
	then
		return 0
	end
	if ( destroy_user_index == 0 )
	then
		return 1
	end
	return 0
end

function check_defuse_bomb( stay_time, rate, press_time )
	if ( stay_time < ( demolition_defuse_bomb_time * rate ) )
	then
		return 0
	end

	if ( press_time < ( demolition_defuse_bomb_time * rate ) )
	then
		return 0
	end
	
	return 1
end

function add_score( team_id )
	lua_call_add_team_score( team_id, 1 )
end

function is_attack_team( team_id )
	if ( team_id == 0 ) then
		return 1
	end
	return 0
end

function is_under_30sec( curr_round_time )
	local time_left = round_time - curr_round_time;
	if ( time_left <= 30000 ) then
		return 1
	end
	return 0
end

function is_under_10sec( curr_round_time )
	local time_left = round_time - curr_round_time;
	if ( time_left <= 10000 ) then
		return 1
	end
	return 0
end

-- 폭탄 설치 시 BGM을 끈다
function bgm_off()
	lua_call_set_enable_entity("inst_a_bgm", 0, "bombsite_a")
	lua_call_set_enable_entity("inst_b_bgm", 0, "bombsite_b")
	lua_call_set_enable_entity("inst_a_snd", 0, "bombsite_a")
	lua_call_set_enable_entity("inst_b_snd", 0, "bombsite_b")
end