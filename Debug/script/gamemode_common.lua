--------------------------------------------
-- 팀 ID 상태 정의
--------------------------------------------
E_TEAM_ID_NAF						= 0
E_TEAM_ID_EDEN						= 1
E_TEAM_ID_NONE						= 2
--------------------------------------------
--------------------------------------------
-- RewardType 정의
--------------------------------------------
RewardType_Normal_Kill			= 1
RewardType_2Combo				= 3
RewardType_3Combo				= 4
RewardType_4Combo				= 5
RewardType_MultiCombo			= 6
RewardType_CloseCall_Kill		= 7
RewardType_Revenger				= 10
RewardType_DroneKill			= 11
RewardType_ObjectKill			= 12
RewardType_KingSlayer			= 13
RewardType_Shutdown_3			= 14 
RewardType_Shutdown_4			= 15
RewardType_Shutdown_5			= 16
RewardType_Dead					= 21
RewardType_Assist_Damage		= 32
RewardType_Assist_Detect		= 33
RewardType_Assist_Search		= 34
RewardType_DronePoint			= 35
RewardType_Assist_Damage_Debuff = 36
RewardType_Mod_Domination		= 41
RewardType_Mod_Explosion		= 42
RewardType_Mod_Bomb_Remove		= 43
RewardType_Mod_Bomb				= 44
RewardType_StartDrone			= 51
RewardType_DomStay				= 61
RewardType_ClearWave			= 71
RewardType_ThrowDestroy			= 81
RewardType_TeamReward			= 8192
RewardType_FirstKill			= 16384
RewardType_HeadShot				= 32768



function loading()
	Minimap_Sound_Visible_Time = 500	-- 미니맵에 청음 보여줄 시간 (ms)
	Check_Crosshair_Target = 0;	--(int) 크로스헤어에 적중된 타겟을 확인하는 시간(ms)

	-- 네임태그 옵션
	nametag_appear_enemy_start_time_		= 1;	-- (int) 적 네임태그가 시작될 시간(해당 ms 동안 보고 있어야 네임태그 출력이 시작된다.)
	nametag_appear_enemy_pos_update_time_ 	= 1000;	-- (int) 색적정보 공유시 해당 적 좌표 업데이트 시점(ms)
	nametag_scale_min_ 						= 80;	-- (float) 네임태그 최소 스케일
	nametag_scale_max_ 						= 100;	-- (float) 네임태그 최대 스케일
	nametag_distance_min_ 					= 10;	-- (float) 네임태그가 최대 스케일이 되는 거리(cm)
	nametag_distance_max_ 					= 5000;	-- (float) 네임태그가 최소 스케일이 되는 거리(cm)
	nametag_appear_my_death_time_ 			= 4000	-- (int) 내가 죽었을 경우 무덤 태그 출력 시간.(ms)
	nametag_appear_friend_death_time		= 2000	-- (int) 같은 팀이 죽었을 경우 네임 태그 출력 시간.(ms)
	nametag_visible_range_max_ 				= 100000	-- (int) 네임태그 표시 거리 (cm)
	
	game_start_countdown = 4 -- 게임 시작 시 카운트다운 시간
	dead_body_time = 10000 -- 시체가 맵에 남아있는 시간
	game_pre_loading_countdown = 20000 -- 게임 시작 후 다른 플레이어의 로딩을 기다리는 시간
	drop_weapon_remain_time =	30000 -- 사망 후 맵에 떨어진 무기가 남아있는 시간
	fall_damage_min_height = 600 -- 낙하 대미지 적용 시작 높이
	fall_damage_max_height = 800 -- 낙하 대미지 최대 데미지 높이
	explosive_delay = 0 -- 게임 시작 후 투척무기를 사용 가능한 시간
	no_damage_time = 1
	respawn_key_input_delay = 1000
	hit_max_range=15000 -- 해당 수치값의 거리를 넘어가면 데미지가 적용되지 않음.
	damage_for_max_range=5  -- gun_info의 max_range ~ hit_max_range까지는 해당 값으로 데미지가 적용 됨

	-- 라스트캠 옵션 lua_call_lastcam_control ( [캠 재생여부],[캠 재생시간], [슬로모션 시작점], [슬로모션 종료점], [슬로모션 재생속도] 
	--lua_call_lastcam_control(0, 0, 0, 0, 0)

	-- 랜덤 리스폰 위치 제어 변수
	respawn_restrict_drone = false -- 랜덤 리스폰 시 적의 드론 판별 여부, false : 판별하지 않음
	respawn_restrict_throw = false -- 랜덤 리스폰 시 적의 투척 무기 판별 여부, false : 판별하지 않음
	respawn_enemy_most_far_rate = 2.4 -- 랜덤 리스폰 부활 위치 선정 시 적이 가장 멀리 있는 지역의 가중치

	-- battle point
	-- drone_timer_decrease_rate = 600
	drone_timer_decrease_rate_attack = 450 -- 공격 계열 획득 점수
	drone_timer_decrease_rate_operation = 300 -- 작전 계열 획득 점수
	contribution_point_death_attack = 0 -- 남은 배틀 포인트에서 퍼센트 만큼을 차감(1 = 100%)
	contribution_point_death_operation = 0 -- 작전 계열 패널티
	drone_cooltime_cycle_limit = true -- 모든 드론을 한번씩 사용한 후 쿨타임이 진행 되는지 여부
	
	hide_all_entity() 	-- 유리창 가리기
	hide_outpost() -- 아웃포스트 가리기
    battle_point_duration = 1300 -- 배틀포인트 메시지 출력 타이머
end

function start_round_common_mode()
	hide_all_entity()
end

function start_round_common_mode_client()
	-- hud hp bar 옵션. category, visible, mouse_on, hp_bar, distance, disappear in time 
	
    lua_call_set_name_tag_by_category("HUD_Ally_Character", 1, 0, 0, 5000, 1000)
    lua_call_set_name_tag_by_category("HUD_Ally_Drone", 1, 1, 0, 5000, 1000)
    lua_call_set_name_tag_by_category("HUD_Enemy_Character", 1, 1, 0, 15000, 1000)
    lua_call_set_name_tag_by_category("HUD_Enemy_Drone", 1, 1, 1, 15000, 1000)
    lua_call_set_name_tag_by_category("HUD_Ally_Throw_Object", 1, 1, 0, 15000, 1000)
    lua_call_set_name_tag_by_category("HUD_Enemy_Throw_Object", 1, 1, 0, 1500, 1000)
	
end

function hide_all_entity()
	lua_call_set_enable_entity( "obs_01_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_01_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_01_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_01_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_02_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_02_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_02_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_02_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_03_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_03_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_03_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_03_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_04_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_04_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_04_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_04_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_05_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_05_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_06_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_06_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_07_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_07_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_07_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_07_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_08_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_08_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_08_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_08_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_09_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_09_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_09_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_09_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_10_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_10_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_10_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_10_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_11_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_11_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_11_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_11_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_12_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_12_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_12_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_12_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_13_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_13_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_13_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_13_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_14_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_14_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_14_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_14_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_15_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_15_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_15_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_15_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_16_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_16_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_16_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_16_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_17_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_17_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_17_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_17_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_18_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_18_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_18_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_18_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_19_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_19_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_19_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_19_b", 0, "start_trg")
	lua_call_set_enable_entity( "obs_20_a", 0, "start_trg")
	lua_call_set_enable_entity( "obs_20_b", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_20_a", 0, "start_trg")
	lua_call_set_enable_entity( "obsui_20_b", 0, "start_trg")
	
	-- 게임 시작 시 인터렉션 미니맵 숨김
	lua_call_set_enable_entity( "d_inter_4", 0, "start_trg")
	lua_call_set_enable_entity( "d_inter_6", 0, "start_trg")
	lua_call_set_enable_entity( "i_inter_2", 0, "start_trg")
	lua_call_set_enable_entity( "inter_2f", 0, "start_trg")

	
	-- 지역점령전 옵션
	lua_call_set_visible_object( "scp_obj_a", 0 )
	lua_call_set_visible_object( "scp_obj_b", 0 )
	lua_call_set_visible_object( "scp_obj_c", 0 )
	lua_call_set_visible_object( "scp_obj_d", 0 )
	lua_call_set_visible_object( "scp_obj_e", 0 )
	lua_call_set_enable_entity( "scp_rdy_a", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_b", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_c", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_d", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_rdy_e", 0 , "start_scp")
	lua_call_set_enable_entity( "scp_eff_a", 0 , "scp_a")
	lua_call_set_enable_entity( "scp_eff_b", 0 , "scp_b")
	lua_call_set_enable_entity( "scp_eff_c", 0 , "scp_c")
	lua_call_set_enable_entity( "scp_eff_d", 0 , "scp_d")
	lua_call_set_enable_entity( "scp_eff_e", 0 , "scp_e")
	lua_call_set_enable_entity( "scp_eff_a1", 0 , "scp_a")
	lua_call_set_enable_entity( "scp_eff_b1", 0 , "scp_b")
	lua_call_set_enable_entity( "scp_eff_c1", 0 , "scp_c")
	lua_call_set_enable_entity( "scp_eff_d1", 0 , "scp_d")
	lua_call_set_enable_entity( "scp_eff_e1", 0 , "scp_e")
	lua_call_set_enable_entity( "scp_eff_a2", 0 , "scp_a")
	lua_call_set_enable_entity( "scp_eff_b2", 0 , "scp_b")
	lua_call_set_enable_entity( "scp_eff_c2", 0 , "scp_c")
	lua_call_set_enable_entity( "scp_eff_d2", 0 , "scp_d")
	lua_call_set_enable_entity( "scp_eff_e2", 0 , "scp_e")
	lua_call_set_enable_entity( "scp_eff_a3", 0 , "scp_a")
	lua_call_set_enable_entity( "scp_eff_b3", 0 , "scp_b")
	lua_call_set_enable_entity( "scp_eff_c3", 0 , "scp_c")
	lua_call_set_enable_entity( "scp_eff_d3", 0 , "scp_d")
	lua_call_set_enable_entity( "scp_eff_e3", 0 , "scp_e")

	-- 도시 공성전 옵션
	lua_call_set_visible_object( "dom_obj_a", 0 )
	lua_call_set_visible_object( "dom_obj_b", 0 )
	lua_call_set_enable_entity( "scp_rdy_a", 0, "start_scp" )
	lua_call_set_enable_entity( "scp_rdy_b", 0, "start_scp" )
	lua_call_set_enable_entity( "dom_eff_a", 0, "dom_a" )
	lua_call_set_enable_entity( "dom_eff_b", 0, "dom_b" )
	lua_call_set_enable_entity( "dom_eff_a1", 0, "dom_a" )
	lua_call_set_enable_entity( "dom_eff_b1", 0, "dom_b" )
	lua_call_set_enable_entity( "dom_eff_a2", 0, "dom_a" )
	lua_call_set_enable_entity( "dom_eff_b2", 0, "dom_b" )
	lua_call_set_enable_entity( "dom_eff_a3", 0, "dom_a" )
	lua_call_set_enable_entity( "dom_eff_b3", 0, "dom_b" )

	-- 수색 폭파전 옵션
	lua_call_set_visible_object( "snd_tar_a", 0 )
	lua_call_set_visible_object( "snd_tar_b", 0 )
	lua_call_set_visible_object( "bombinst_a", 0 )
	lua_call_set_visible_object( "bombinst_b", 0 )
	lua_call_set_visible_object( "snd_tar_a2", 0 )
	lua_call_set_visible_object( "snd_tar_b2", 0 )
	lua_call_set_enable_entity( "snd_blo_a", 0 , "bombsite_a")
	lua_call_set_enable_entity( "snd_blo_b", 0 , "bombsite_b")
	lua_call_set_enable_entity( "snd_dea_a", 0 , "bombsite_a")
	lua_call_set_enable_entity( "snd_dea_b", 0 , "bombsite_b")
	lua_call_set_enable_entity( "bombeff_a", 0 , "bombsite_a")
	lua_call_set_enable_entity( "bombeff_b", 0 , "bombsite_b")
	lua_call_set_enable_entity( "boom_a", 0 , "bombsite_a")
	lua_call_set_enable_entity( "boom_b", 0 , "bombsite_b")
	
	lua_call_set_visible_object( "dem_tar_a", 0 )
	lua_call_set_visible_object( "dem_tar_b", 0 )
	
	lua_call_set_visible_object( "str_tar_a", 0 )
	
    -- 자원 쟁탈전 옵션
	lua_call_set_enable_entity( "hud_take_a", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_b", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_c", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_d", 0 , "start_take")
	lua_call_set_enable_entity( "hud_take_e", 0 , "start_take")
	
	-- PVE 싱글 미션 옵션 오브젝트 끔
	lua_call_set_visible_object( "mis_obj_01", 0 )
	lua_call_set_visible_object( "mis_obj_02", 0 )
	lua_call_set_visible_object( "mis_obj_03", 0 )
	lua_call_set_visible_object( "mis_obj_04", 0 )
	lua_call_set_visible_object( "mis_obj_05", 0 )
	lua_call_set_visible_object( "mis_obj_06", 0 )
	lua_call_set_visible_object( "mis_obj_07", 0 )
	lua_call_set_visible_object( "mis_obj_08", 0 )
	lua_call_set_visible_object( "mis_obj_09", 0 )
	lua_call_set_visible_object( "mis_obj_10", 0 )
	lua_call_set_visible_object( "mis_obj_11", 0 )
	lua_call_set_visible_object( "mis_obj_12", 0 )
	lua_call_set_visible_object( "mis_obj_13", 0 )
	lua_call_set_visible_object( "mis_obj_14", 0 )
	lua_call_set_visible_object( "mis_obj_15", 0 )
	lua_call_set_visible_object( "mis_obj_16", 0 )
	lua_call_set_visible_object( "mis_obj_17", 0 )
	lua_call_set_visible_object( "mis_obj_18", 0 )
	lua_call_set_visible_object( "mis_obj_19", 0 )
	lua_call_set_visible_object( "mis_obj_20", 0 )
	lua_call_set_visible_object( "mis_obj_21", 0 )
	lua_call_set_visible_object( "mis_obj_22", 0 )
	lua_call_set_visible_object( "mis_obj_23", 0 )
	lua_call_set_visible_object( "mis_obj_24", 0 )
	lua_call_set_visible_object( "mis_obj_25", 0 )
	lua_call_set_visible_object( "mis_obj_26", 0 )
	lua_call_set_visible_object( "mis_obj_27", 0 )
	lua_call_set_visible_object( "mis_obj_28", 0 )
	lua_call_set_visible_object( "mis_obj_29", 0 )
	lua_call_set_visible_object( "mis_obj_30", 0 )
	lua_call_set_visible_object( "orca_body", 0 )
	lua_call_set_visible_object( "orca_box", 0 )
	
	-- PVE 싱글 미션 EMP이펙트 끔
	lua_call_set_enable_entity( "emp_eft_01", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_02", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_03", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_04", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_05", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_06", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_07", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_08", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_09", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_10", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_11", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_12", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_13", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_14", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_15", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_16", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_17", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_18", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_19", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_20", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_21", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_22", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_23", 0 , "start_mis1")
	lua_call_set_enable_entity( "emp_eft_24", 0 , "start_mis1")
	lua_call_set_enable_entity( "hv_eft_01", 0 , "start_mis1")
	lua_call_set_enable_entity( "hv_eft_02", 0 , "start_mis1")
	lua_call_set_enable_entity( "hv_eft_03", 0 , "start_mis1")
	lua_call_set_enable_entity( "hv_eft_04", 0 , "start_mis1")
		
	-- PVE 싱글 미션1 옵션 엔티티 끔
	lua_call_set_enable_entity( "mis_ent_01", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_02", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_03", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_04", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_05", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_06", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_07", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_08", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_09", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_10", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_11", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_12", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_13", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_14", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_15", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_16", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_17", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_18", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_19", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_ent_20", 0 , "start_mis1")
	lua_call_set_enable_entity( "start_stop", 0 , "start_mis1")
	
	-- PVE 싱글 미션1 옵션 허드 끔
	lua_call_set_enable_entity( "mis_hud_01", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_02", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_03", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_04", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_05", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_06", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_07", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_08", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_09", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_10", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_11", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_12", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_13", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_14", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_15", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_16", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_17", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_18", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_19", 0 , "start_mis1")
	lua_call_set_enable_entity( "mis_hud_20", 0 , "start_mis1")
	
	-- PVE 싱글 미션2 옵션 허드 끔
	lua_call_set_enable_entity( "mis_hud_01", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_02", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_03", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_04", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_05", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_06", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_07", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_08", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_09", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_10", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_11", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_12", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_13", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_14", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_15", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_16", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_17", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_18", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_19", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_20", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_21", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_22", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_hud_23", 0 , "start_mis2")
	
	lua_call_set_enable_entity( "mis_ent_01", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_02", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_03", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_04", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_05", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_06", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_07", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_08", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_09", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_10", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_11", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_12", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_13", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_14", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_15", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_16", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_17", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_18", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_19", 0 , "start_mis2")
	lua_call_set_enable_entity( "mis_ent_20", 0 , "start_mis2")
	lua_call_set_enable_entity( "start_stop", 0 , "start_mis2")
	
	-- PVE 싱글 미션2 옵션 AI PATH 블로커 끔
	lua_call_set_enable_entity( "blk_ai1", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai2", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai3", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai4", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai5", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai6", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai7", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai8", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai9", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai10", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai11", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai12", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai13", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai14", 0 , "start_mis2")
	lua_call_set_enable_entity( "blk_ai15", 0 , "start_mis2")
	
	-- PVE 싱글 미션3 옵션 허드 끔
	lua_call_set_enable_entity( "mis_hud_01", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_02", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_03", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_04", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_05", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_06", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_07", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_08", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_09", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_10", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_11", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_12", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_13", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_14", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_15", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_16", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_17", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_18", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_19", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_hud_20", 0 , "start_mis3")
	
	lua_call_set_enable_entity( "mis_ent_01", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_02", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_03", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_04", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_05", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_06", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_07", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_08", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_09", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_10", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_11", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_12", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_13", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_14", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_15", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_16", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_17", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_18", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_19", 0 , "start_mis3")
	lua_call_set_enable_entity( "mis_ent_20", 0 , "start_mis3")
	lua_call_set_enable_entity( "start_stop", 0 , "start_mis3")
	
	-- PVP에서 싱글 스폰지역에서 스폰 끄기
	lua_call_set_enable_spawn_pos( "mis1_sp01", 0 )	
	lua_call_set_enable_spawn_pos( "mis2_sp01", 0 )	
	lua_call_set_enable_spawn_pos( "mis3_sp01", 0 )	

	-- PVP에서 생존 스폰지역에서 스폰 끄기
	lua_call_set_enable_spawn_pos( "suv_sp01", 0 )	
	lua_call_set_enable_spawn_pos( "suv_sp02", 0 )	
	lua_call_set_enable_spawn_pos( "suv_sp03", 0 )
	lua_call_set_enable_spawn_pos( "suv_sp04", 0 )
	
	-- 체크 포인트의 트리거 끄기
	lua_call_set_enable_trigger_object( "t_check1", 0 )
	lua_call_set_enable_trigger_object( "t_check2", 0 )
	lua_call_set_enable_trigger_object( "t_check3", 0 )
	lua_call_set_enable_trigger_object( "t_check4", 0 )
	lua_call_set_enable_trigger_object( "t_check5", 0 )
	lua_call_set_enable_trigger_object( "t_check6", 0 )
	lua_call_set_enable_trigger_object( "t_check7", 0 )
	lua_call_set_enable_trigger_object( "t_check8", 0 )
	lua_call_set_enable_trigger_object( "t_check9", 0 )
	
	-- 체크포인트의 스폰 끄기
	lua_call_set_enable_spawn_pos( "check_1", 0 )	
	lua_call_set_enable_spawn_pos( "check_2", 0 )	
	lua_call_set_enable_spawn_pos( "check_3", 0 )	
	lua_call_set_enable_spawn_pos( "check_4", 0 )	
	lua_call_set_enable_spawn_pos( "check_5", 0 )	
	lua_call_set_enable_spawn_pos( "check_6", 0 )	
	lua_call_set_enable_spawn_pos( "check_7", 0 )	
	lua_call_set_enable_spawn_pos( "check_8", 0 )	
	lua_call_set_enable_spawn_pos( "check_9", 0 )	

	-- 테스트 - 공성전 스폰 끄기
	lua_call_set_enable_spawn_pos( "sie_naf1", 0 )
	lua_call_set_enable_spawn_pos( "sie_naf2", 0 )
	lua_call_set_enable_spawn_pos( "sie_naf3", 0 )
	lua_call_set_enable_spawn_pos( "sie_naf4", 0 )
	lua_call_set_enable_spawn_pos( "sie_naf5", 0 )
	lua_call_set_enable_spawn_pos( "sie_naf6", 0 )
	lua_call_set_enable_spawn_pos( "sie_eden1", 0 )
	lua_call_set_enable_spawn_pos( "sie_eden2", 0 )
	lua_call_set_enable_spawn_pos( "sie_eden3", 0 )
	lua_call_set_enable_spawn_pos( "sie_eden4", 0 )
	lua_call_set_enable_spawn_pos( "sie_eden5", 0 )
	lua_call_set_enable_spawn_pos( "sie_eden6", 0 )
	

end

function hide_outpost()
-- 아웃포스트 대기상태에서 인터랙션 관련된 오브젝트및 엔티티끔
	lua_call_set_visible_object( "break1_1", 0 )
	lua_call_set_visible_object( "break2_1", 0 )
	lua_call_set_visible_object( "suv_obj01", 0 )
	lua_call_set_visible_object( "suv_obj02", 0 )
	lua_call_set_visible_object( "suv_obj03", 0 )
	lua_call_set_visible_object( "suv_obj04", 0 )
	lua_call_set_visible_object( "suv_obj05", 0 )
	lua_call_set_visible_object( "suv_obj06", 0 )
	lua_call_set_visible_object( "suv_obj07", 0 )
	lua_call_set_visible_object( "suv_obj08", 0 )
	lua_call_set_visible_object( "suv_obj09", 0 )
	lua_call_set_visible_object( "suv_obj10", 0 )
	lua_call_set_visible_object( "suv_obj11", 0 )
	lua_call_set_visible_object( "suv_obj12", 0 )
	lua_call_set_visible_object( "suv_obj13", 0 )
	lua_call_set_visible_object( "suv_obj14", 0 )
	lua_call_set_visible_object( "suv_obj15", 0 )
	lua_call_set_visible_object( "suv_obj16", 0 )
	lua_call_set_visible_object( "suv_obj17", 0 )
	lua_call_set_visible_object( "suv_obj18", 0 )
	lua_call_set_visible_object( "suv_obj19", 0 )
	lua_call_set_visible_object( "suv_obj20", 0 )
	lua_call_set_visible_object( "suv_obj21", 0 )
	lua_call_set_visible_object( "suv_obj22", 0 )
	lua_call_set_visible_object( "suv_obj23", 0 )
	lua_call_set_visible_object( "suv_obj24", 0 )
	lua_call_set_visible_object( "suv_obj25", 0 )
	lua_call_set_visible_object( "suv_obj26", 0 )
	lua_call_set_visible_object( "suv_obj27", 0 )
	lua_call_set_visible_object( "suv_obj28", 0 )
	lua_call_set_visible_object( "suv_obj29", 0 )
	lua_call_set_visible_object( "debr1", 0 )
	lua_call_set_enable_entity( "suv_dc01", 0 , "start_trg")
	lua_call_set_enable_entity( "suv_dc02", 0 , "start_trg")
	lua_call_set_enable_entity( "suv_dc03", 0 , "start_trg")
	lua_call_set_enable_entity( "suv_dc04", 0 , "start_trg")
	lua_call_set_enable_entity( "suv_dc05", 0 , "start_trg")
	lua_call_set_enable_entity( "suv_dc06", 0 , "start_trg")
	lua_call_set_enable_entity( "suv_dc07", 0 , "start_trg")
	lua_call_set_enable_entity( "dust_env1", 0 , "start_trg")
	lua_call_set_enable_entity( "dust_env2", 0 , "start_trg")
	lua_call_set_enable_entity( "dust_env3", 0 , "start_trg")
	lua_call_set_enable_entity( "dust_env4", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef1", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef2", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef3", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef4", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef5", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef6", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef7", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef8", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef9", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef10", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef11", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef12", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef13", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef14", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef15", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef16", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef17", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef18", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef19", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef20", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef21", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef22", 0 , "start_trg")
	lua_call_set_enable_entity( "storm_ef23", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_1", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_2", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_3", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_4", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_5", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_6", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_7", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_8", 0 , "start_trg")
	lua_call_set_enable_entity( "op_decal_9", 0 , "start_trg")
	lua_call_set_enable_entity( "siren1", 0 , "start_trg")
	
		
end

function is_alive( hp )
	if ( hp > 0 )
	then
		return 1
	end
	return 0
end

function set_hp_zero( hp )
	return 0
end

function check_play_time( play_time, check_time )
	if ( play_time > tonumber( check_time ) )
	then
		return 1
	end
	return 0
end

function init_animation( state, trigger_name )
	if ( state == 1 )
	then
		lua_call_active_trigger( trigger_name )
	end
end

function init_object_pos( object_index, state, way_point1, way_point2 )
	if ( state == 0 )
	then
		lua_call_set_object_pose( object_index, 0, way_point1 )
	else
		lua_call_set_object_pose( object_index, 1, way_point2 )
	end
end


function start_animation_no_change_state( object_index, state, trigger, ani, loop )
	if ( tonumber( state ) == 0 )
	then
		lua_call_start_animation( object_index, state, trigger, ani, loop )
	else
		lua_call_start_reverse_animation( object_index, state, trigger, ani, loop )
	end
end

function start_animation( object_index, state, trigger, ani, loop )
	if ( state == 0 )
	then
		state = 1
		lua_call_start_animation( object_index, state, trigger, ani, loop )
	else
		state = 0
		lua_call_start_reverse_animation( object_index, state, trigger, ani, loop )
	end
end

function start_multi_animation( object_name, state, trigger )
	if ( state == 0 )
	then
		state = 1
		for object_index in string.gmatch( object_name, "[^, ]+") do
			lua_call_start_animation( object_index, state, trigger )
		end
	else
		state = 0
		for object_index in string.gmatch( object_name, "[^, ]+") do
			lua_call_start_reverse_animation( object_index, state, trigger )
		end
	end
end

function finish_animation( object_index, state )
	lua_call_finish_animation( object_index, state )
end

function stop_animation( object_index, state )
	lua_call_stop_animation( object_index )
end

function move_to_object( object_index, total_time, state, trigger, way_point1, way_point2 )
	if ( state == 0 )
	then
		state = 1
		lua_call_move_to_object( object_index, total_time, state, trigger , way_point2 )
	else
		state = 0
		lua_call_move_to_object( object_index, total_time, state, trigger , way_point1 )
	end

end

function move_to_object_no_change_state( object_index, total_time, state, trigger, way_point1, way_point2 )
	if ( state == 0 )
	then
		lua_call_move_to_object( object_index, total_time, state, trigger , way_point2 )
	else
		lua_call_move_to_object( object_index, total_time, state, trigger , way_point1 )
	end
end


function check_input_f()
	local result = lua_call_use_key_press( )
	if ( result == 1 )
	then
		return 1
	end
	return 0
end

function is_playing_animation( object_name )
	local result = lua_call_is_playing_animation( object_name )
	if ( result == 1 )
	then
		return 0
	end
	return 1
end

function check_leave_trigger( object_name )
	stay_count = lua_call_get_stay_count( 2, object_name )
	if stay_count == 0
	then
		return 1
	end
	return 0
end

function open_door( object_index, total_time, state, trigger, way_point1, way_point2 )
	if ( state == 1 )
	then
		return
	end
	lua_call_move_to_object( object_index, total_time, 1, trigger , way_point2 )
end

function close_door( object_index, total_time, state, trigger, way_point1, way_point2 )
	if ( state == 0 )
	then
		return
	end
	lua_call_move_to_object( object_index, total_time, 0, trigger , way_point2 )
end

function check_enter_first( object_name )
	if 1 == lua_call_get_stay_count( 4, object_name ) then
		return 1
	end
	return 0
end

function check_leave_last( object_name )
	if 0 == lua_call_get_stay_count( 4, object_name ) then
		return 1
	end
	return 0
end

function active_trigger( trigger_name, user_index )
	lua_call_active_trigger( trigger_name, user_index )
end

function visible_object( object_name, is_visible )
	flag = tonumber( is_visible );
	lua_call_set_visible_object( object_name, flag )
end

function set_enable_trigger( trigger_name, is_enable )
	lua_call_set_enable_trigger( trigger_name, is_enable )
end

function set_enable_trigger_object( trigger_name, is_enable )
	lua_call_set_enable_trigger_object( trigger_name, is_enable )
end

function toggle_enable_trigger_object( trigger_name )
	is_enable = lua_call_is_enable_trigger_object( trigger_name )
	set_enable_trigger_object( trigger_name, not is_enable )
end

function check_value( state, check_value )
	if state == tonumber( check_value )
	then
		return 1
	end
	return 0
end

function check_value_ne( state, check_value )
	if state == tonumber( check_value )
	then
		return 0
	end
	return 1
end

-- PVE 에서 주로 사용하는 내용들

function show_action_info( msg_name, show_time, action_id )
	lua_call_show_action_info( msg_name, show_time, action_id )
end

function show_debug_info( msg_name, show_time )
	message_white = string.format("<font color='#FFBF00' size='50'>%s</font>", msg_name )
	lua_call_show_debug_info ( message_white, show_time, 1, 0, 0, 80, 0, 0, 0, 255  )
end

function debug_mission_msg ( msg_mission )
	message_white = string.format("<font color='#FFBF00' size='50'>%s</font>", msg_mission )
	lua_call_show_debug_info ( message_white, 5, 1, 0, 0, 80, 0, 0, 0, 255  )
end

function debug_subtitle ( name, msg_subtitle1, msg_subtitle2 )
	if msg_subtitle2 == nil
	then
		message_white = string.format("<font color='#00BFFF' size='28'>%s: </font><font color='#FFFFFF' size='28'>%s</font>", name, msg_subtitle1 )
		lua_call_show_debug_info ( message_white, 5, 1, 2, 0, -80, 0, 0, 0, 255 )
	else
		message_white = string.format("<font color='#00BFFF' size='28'>%s: </font><font color='#FFFFFF' size='28'>%s<br>%s</font>", name, msg_subtitle1, msg_subtitle2 )
		lua_call_show_debug_info ( message_white, 5, 1, 2, 0, -80, 0, 0, 0, 255   )
	end	
end

function object_pickup ( obj_name )
	lua_call_set_visible_object ( obj_name, 0)
end

--- 체크포인트
function next_checkpoint (spawn_name)
	lua_call_set_enable_all_spawn_pos( 0 )	
	lua_call_set_enable_spawn_pos( spawn_name, 1 )	
end

function check_alive_team()
	local alive_count = lua_call_alive_user_count()
	if alive_count == 0	then
		return 0
	end
	return 1
end
