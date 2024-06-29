-- 로비의 빠른 시작 - 카운트다운 시간
room_countdown_time = 0

-- 검색 중 상태에서 방 유지 시간(소멸 예정 시간) - 인원 한명당 대기 시간을 의미 ex) 1명=4초, 2명=8초, 3명=12초...
wait_standby_time = 0

-- 다음 등급의 방을 검색하기 시작할 방 소멸 횟수
next_grade_search_count = 1

-- 매칭 포인트 및 계정 레벨 등급 구간 설정 값 - 각 구간 최대 값을 의미 ex) 1 = 30 -> 30 이하는 1등급, 2 = 70 -> 70 이하는 2등급...
match_point_grade_max_1 = 49
match_point_grade_max_2 = 99
match_point_grade_max_3 = 149
match_point_grade_max_4 = 199
match_level_grade_max_1 = 29
match_level_grade_max_2 = 99

-- 단판 모드 및 라운드 모드의 난입 제한 조건 제어 변수 ex) 0.6 = 60% -> 목표 점수의 60% 초과인 경우 난입 불가, 60% 이하인 경우 난입 가능
intrusion_score_mode_limit_score = 1.0
intrusion_score_mode_limit_time = 1.0
intrusion_round_mode_limit_score = 1.0

-- 콤보 킬 유효시간(ms)
Combo_Kill_Time		=	999999999

-- 도움 킬 유효시간(ms)
Assist_Time		=	999999999

-- 색적 정보에서 정보가 남아있는 시간(ms)
-- 기획의도 변경. 기본 색적은 없음 2015-12-13 Victor
Appear_Enemy_Time	=	999999999

-- 색적 정보에서 정보가 공유되는 아군의 거리
Appear_Enemy_Distance	=	999999999

-- 한명을 죽였을 경우 점수
Score_Per_Kill		=	999999999

-- ======== 스폰 포인트 시스템 ========

-- 스폰 포인트 시스템(기본)
spawn_weight_default = { 100, 100 }

-- 스폰 포인트 시스템(진입시)
spawn_weight_enter = { 20, -20 }

-- 스폰 포인트 시스템(나갈때)
spawn_weight_leave = { -20, 20 }

-- 스폰 포인트 시스템(킬)
spawn_weight_kill = { 0, 0 }

-- 스폰 포인트 시스템(데스)
spawn_weight_death = { -100, 0 }

-- 스폰 포인트 리셋을 위해 변동이 없는 타임(ms)
spawn_weight_control_start = 3000

-- 스폰 포인트를 0 으로 돌릴때 초당 사용되는 기본값
spawn_weight_control = 20

-- 스폰 포인트 최대/최소점
max_spawn_weight = 200

-- ==================================

-- 게임 참가자 수에 따라 스폰 포인트를 0 으로 돌릴때 초당 사용되는 값( 아래는 2명일 경우)
-- spawn_weight_control_2 = 20

-- 시체 남아있는 시간
dead_body_time = 10000

-- ===== 살상투척무기가 맵상에 남아있는 시간 gun_info -> weapontype = 9 =====
lethal_remain_time = 4000

-- ===== 보조투척무기가 맵상에 남아있는 시간 gun_info -> weapontype = 10 =====
tactical_remain_time = 4000

-- game_info 에 있던 스크립트

------------------------------------------------------------------------------
-- Game_info.lua
-- 이 파일은 게임클라이언트에서 사용되는 변수들의 초기 설정을 담고 있다. 
-- 설명에는 변수의 타입을 처음오게 하여 같이 기록한다. 

------------------------------------------------------------------------------
-- 무기 및 투척 관련 값들
------------------------------------------------------------------------------
-- (float) 투척무기 투척시 굴리기 적용 카메라 각도값   ( 0보다 작으면 아래쪽, 0보다 크면 윗쪽 )
Throw_Roll_Angle	= 0

-- (float) 투척무기 투척시 굴리기 감쇠값
Throw_Roll_Damping	= 1


------------------------------------------------------------------------------
-- 레벨에 관련된 값
------------------------------------------------------------------------------
-- (int) 레벨에 사리지는 오브젝트 컬링 거리
Level_Cull_Distance = 1000

------------------------------------------------------------------------------
-- 사운드 관련 변수들 
------------------------------------------------------------------------------
-- (float) 적이 피격 당했을때 나는 소리 볼륨
Sound_Volume_Flesh = 1.0

------------------------------------------------------------------------------
-- Death Color Grading 효과
------------------------------------------------------------------------------
--death_cg_texture = "engine\\colorspace_threshold.cds"
--death_cg_texture = "engine\\colorspace_bw.cds"
death_cg_texture = "engine\\cg_blood.cds"
death_cg_sec = 0.5

recover_cg_texture = "engine\\cg_recover.cds"
recover_cg_sec = 0.5

------------------------------------------------------------------------------
-- 그림자 거리
------------------------------------------------------------------------------
shadow_range_1st_x = 150
shadow_range_1st_y = 500
shadow_range_1st_z = 3500
shadow_range_3rd_x = 1000
shadow_range_3rd_y = 3500
shadow_range_3rd_z = 10000

------------------------------------------------------------------------------
-- 아웃라인
------------------------------------------------------------------------------
foe_outline_dist = "999999, 999999"
foe_outline_alpha = "999999, 999999"
foe_outline_color = "220, 0, 5, 255"
nodmg_outline_color = "220, 200, 40, 255"
pickup_outline_color = "49, 113, 192, 255"
killcam_outline_color = "190, 0, 15, 102"
monitor_sight_outline_color = "190, 0, 15, 178"
detect_sight_outline_color = "190, 0, 15, 178"
friend_drone_outline_color = "49, 113, 192, 255"
foe_drone_outline_color = "220, 0, 5, 255"

------------------------------------------------------------------------------
-- 림라이트
------------------------------------------------------------------------------
rimlight_size_min	= 0.05
rimlight_size_max	= 0.10
rimlight_width_min	= 0.7
rimlight_width_max 	= 1.0
rimlight_color_r	= 0.5
rimlight_color_g	= 0.5
rimlight_color_b	= 0.5

------------------------------------------------------------------------------
-- 물리
------------------------------------------------------------------------------
gravity				  = 1700	
damage_to_force       = 2000

-- 담오르기 애니메이션 시간
climb_step1			  = 0.13
climb_step2			  = 0.50

-- 담넘기 애니메이션 시간
climb_over_step1	  = 0.1
climb_over_step2	  = 0.26
climb_over_step3	  = 0.47

------------------------------------------------------------------------------
-- Scope
------------------------------------------------------------------------------
scope_texture		= "ui\\scope.dds"

------------------------------------------------------------------------------
-- Damage
------------------------------------------------------------------------------
damage_texture      = "engine\\damage.dds"
damage_color_r      = 80
damage_color_g      = 30
damage_color_b      = 30
damage_color_a      = 255
damage_sec_0_min    = 0.0
damage_sec_0_max    = 1.0
damage_sec_1_min    = 0.4
damage_sec_1_max    = 2.0
damage_hp_min       = 90.0
damage_hp_max       = 100.0

------------------------------------------------------------------------------
-- Camera
------------------------------------------------------------------------------
-- 폭발시 카메라 흔들어 주는 최대 거리
camera_shake_max_range = 2000
-- 폭발시 카메라 흔들어 주는 최소 시간 ( 동시 진행시 최소 시간내에서는 재실행이 안됨 )
camera_shake_min_time  = 500

-- 피격시 카메라 들리는 최대 각도 (hp 100 일때가 최대 몇인가? 단위:도)
camera_flinch_max_angle = 5

------------------------------------------------------------------------------
-- 클랜전 점수 데이터
------------------------------------------------------------------------------
-- 기본 점수
ranking_base = 0
-- 승리 점수
ranking_winbronze = 20
ranking_winsilver = 20
ranking_wingold = 20
ranking_winplatinum = 20
ranking_windiamond = 20
ranking_winlegend = 20
-- 패배 점수
ranking_losebronze = 0
ranking_losesilver = -4
ranking_losegold = -8
ranking_loseplatinum = -12
ranking_losediamond = -16
ranking_loselegend = -20
-- 등급별 필요 점수
ranking_bronze10 = 0
ranking_bronze9 = 100
ranking_bronze8 = 200
ranking_bronze7 = 300
ranking_bronze6 = 400
ranking_bronze5 = 500
ranking_bronze4 = 600
ranking_bronze3 = 700
ranking_bronze2 = 800
ranking_bronze1 = 900
ranking_silver10 = 1000
ranking_silver9 = 1100
ranking_silver8 = 1200
ranking_silver7 = 1300
ranking_silver6 = 1400
ranking_silver5 = 1500
ranking_silver4 = 1600
ranking_silver3 = 1700
ranking_silver2 = 1800
ranking_silver1 = 1900
ranking_gold10 = 2000
ranking_gold9 = 2100
ranking_gold8 = 2200
ranking_gold7 = 2300
ranking_gold6 = 2400
ranking_gold5 = 2500
ranking_gold4 = 2600
ranking_gold3 = 2700
ranking_gold2 = 2800
ranking_gold1 = 2900
ranking_platinum10 = 3000
ranking_platinum9 = 3100
ranking_platinum8 = 3200
ranking_platinum7 = 3300
ranking_platinum6 = 3400
ranking_platinum5 = 3500
ranking_platinum4 = 3600
ranking_platinum3 = 3700
ranking_platinum2 = 3800
ranking_platinum1 = 3900
ranking_diamond10 = 4000
ranking_diamond9 = 4100
ranking_diamond8 = 4200
ranking_diamond7 = 4300
ranking_diamond6 = 4400
ranking_diamond5 = 4500
ranking_diamond4 = 4600
ranking_diamond3 = 4700
ranking_diamond2 = 4800
ranking_diamond1 = 4900
ranking_legend = 5000
-- 랭킹 DB 저장 시간
ranking_db = 0600
-- 랭킹 DB에 저장 할 대상 등수
ranking_tagetrank = 200
-- 랭킹에서 실제로 표시할 대상 등수
ranking_showrank = 100
-- 랭킹 DB에 저장할 최소 점수
ranking_tagetpoint = 4000

------------------------------------------------------------------------------
-- 개인 랭킹전
------------------------------------------------------------------------------
rank_single_alarm_minute = 0				-- 개인 랭킹전 알림 시간 (단위 = 분)
rank_single_open_cycle_time = 1				-- 개인 랭킹전 오픈 주기 (단위 = 분)
rank_single_grade_max_cnt = 6				-- 개인 랭킹전 리그 등급 개수
rank_single_tier_max_cnt = 5				-- 개인 랭킹전 각 리그 티어 개수
rank_single_tier_gap_point = 100			-- 개인 랭킹전 티어 구간 점수
rank_single_disposition_game = 5			-- 배치 경기 횟수

drone_assist_damage_percent = 0.2
------------------------------------------------------------------------------
-- 핑 
------------------------------------------------------------------------------
ping_grade_max_count = 4 -- 핑 단계 갯수 ( 지연 처리는 불포함 )
ping_grade_gap_point = 100 -- 핑 단계 별 포인트 갭