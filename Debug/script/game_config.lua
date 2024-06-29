-- �κ��� ���� ���� - ī��Ʈ�ٿ� �ð�
room_countdown_time = 0

-- �˻� �� ���¿��� �� ���� �ð�(�Ҹ� ���� �ð�) - �ο� �Ѹ�� ��� �ð��� �ǹ� ex) 1��=4��, 2��=8��, 3��=12��...
wait_standby_time = 0

-- ���� ����� ���� �˻��ϱ� ������ �� �Ҹ� Ƚ��
next_grade_search_count = 1

-- ��Ī ����Ʈ �� ���� ���� ��� ���� ���� �� - �� ���� �ִ� ���� �ǹ� ex) 1 = 30 -> 30 ���ϴ� 1���, 2 = 70 -> 70 ���ϴ� 2���...
match_point_grade_max_1 = 49
match_point_grade_max_2 = 99
match_point_grade_max_3 = 149
match_point_grade_max_4 = 199
match_level_grade_max_1 = 29
match_level_grade_max_2 = 99

-- ���� ��� �� ���� ����� ���� ���� ���� ���� ���� ex) 0.6 = 60% -> ��ǥ ������ 60% �ʰ��� ��� ���� �Ұ�, 60% ������ ��� ���� ����
intrusion_score_mode_limit_score = 1.0
intrusion_score_mode_limit_time = 1.0
intrusion_round_mode_limit_score = 1.0

-- �޺� ų ��ȿ�ð�(ms)
Combo_Kill_Time		=	999999999

-- ���� ų ��ȿ�ð�(ms)
Assist_Time		=	999999999

-- ���� �������� ������ �����ִ� �ð�(ms)
-- ��ȹ�ǵ� ����. �⺻ ������ ���� 2015-12-13 Victor
Appear_Enemy_Time	=	999999999

-- ���� �������� ������ �����Ǵ� �Ʊ��� �Ÿ�
Appear_Enemy_Distance	=	999999999

-- �Ѹ��� �׿��� ��� ����
Score_Per_Kill		=	999999999

-- ======== ���� ����Ʈ �ý��� ========

-- ���� ����Ʈ �ý���(�⺻)
spawn_weight_default = { 100, 100 }

-- ���� ����Ʈ �ý���(���Խ�)
spawn_weight_enter = { 20, -20 }

-- ���� ����Ʈ �ý���(������)
spawn_weight_leave = { -20, 20 }

-- ���� ����Ʈ �ý���(ų)
spawn_weight_kill = { 0, 0 }

-- ���� ����Ʈ �ý���(����)
spawn_weight_death = { -100, 0 }

-- ���� ����Ʈ ������ ���� ������ ���� Ÿ��(ms)
spawn_weight_control_start = 3000

-- ���� ����Ʈ�� 0 ���� ������ �ʴ� ���Ǵ� �⺻��
spawn_weight_control = 20

-- ���� ����Ʈ �ִ�/�ּ���
max_spawn_weight = 200

-- ==================================

-- ���� ������ ���� ���� ���� ����Ʈ�� 0 ���� ������ �ʴ� ���Ǵ� ��( �Ʒ��� 2���� ���)
-- spawn_weight_control_2 = 20

-- ��ü �����ִ� �ð�
dead_body_time = 10000

-- ===== �����ô���Ⱑ �ʻ� �����ִ� �ð� gun_info -> weapontype = 9 =====
lethal_remain_time = 4000

-- ===== ������ô���Ⱑ �ʻ� �����ִ� �ð� gun_info -> weapontype = 10 =====
tactical_remain_time = 4000

-- game_info �� �ִ� ��ũ��Ʈ

------------------------------------------------------------------------------
-- Game_info.lua
-- �� ������ ����Ŭ���̾�Ʈ���� ���Ǵ� �������� �ʱ� ������ ��� �ִ�. 
-- ������ ������ Ÿ���� ó������ �Ͽ� ���� ����Ѵ�. 

------------------------------------------------------------------------------
-- ���� �� ��ô ���� ����
------------------------------------------------------------------------------
-- (float) ��ô���� ��ô�� ������ ���� ī�޶� ������   ( 0���� ������ �Ʒ���, 0���� ũ�� ���� )
Throw_Roll_Angle	= 0

-- (float) ��ô���� ��ô�� ������ ���谪
Throw_Roll_Damping	= 1


------------------------------------------------------------------------------
-- ������ ���õ� ��
------------------------------------------------------------------------------
-- (int) ������ �縮���� ������Ʈ �ø� �Ÿ�
Level_Cull_Distance = 1000

------------------------------------------------------------------------------
-- ���� ���� ������ 
------------------------------------------------------------------------------
-- (float) ���� �ǰ� �������� ���� �Ҹ� ����
Sound_Volume_Flesh = 1.0

------------------------------------------------------------------------------
-- Death Color Grading ȿ��
------------------------------------------------------------------------------
--death_cg_texture = "engine\\colorspace_threshold.cds"
--death_cg_texture = "engine\\colorspace_bw.cds"
death_cg_texture = "engine\\cg_blood.cds"
death_cg_sec = 0.5

recover_cg_texture = "engine\\cg_recover.cds"
recover_cg_sec = 0.5

------------------------------------------------------------------------------
-- �׸��� �Ÿ�
------------------------------------------------------------------------------
shadow_range_1st_x = 150
shadow_range_1st_y = 500
shadow_range_1st_z = 3500
shadow_range_3rd_x = 1000
shadow_range_3rd_y = 3500
shadow_range_3rd_z = 10000

------------------------------------------------------------------------------
-- �ƿ�����
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
-- ������Ʈ
------------------------------------------------------------------------------
rimlight_size_min	= 0.05
rimlight_size_max	= 0.10
rimlight_width_min	= 0.7
rimlight_width_max 	= 1.0
rimlight_color_r	= 0.5
rimlight_color_g	= 0.5
rimlight_color_b	= 0.5

------------------------------------------------------------------------------
-- ����
------------------------------------------------------------------------------
gravity				  = 1700	
damage_to_force       = 2000

-- ������� �ִϸ��̼� �ð�
climb_step1			  = 0.13
climb_step2			  = 0.50

-- ��ѱ� �ִϸ��̼� �ð�
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
-- ���߽� ī�޶� ���� �ִ� �ִ� �Ÿ�
camera_shake_max_range = 2000
-- ���߽� ī�޶� ���� �ִ� �ּ� �ð� ( ���� ����� �ּ� �ð��������� ������� �ȵ� )
camera_shake_min_time  = 500

-- �ǰݽ� ī�޶� �鸮�� �ִ� ���� (hp 100 �϶��� �ִ� ���ΰ�? ����:��)
camera_flinch_max_angle = 5

------------------------------------------------------------------------------
-- Ŭ���� ���� ������
------------------------------------------------------------------------------
-- �⺻ ����
ranking_base = 0
-- �¸� ����
ranking_winbronze = 20
ranking_winsilver = 20
ranking_wingold = 20
ranking_winplatinum = 20
ranking_windiamond = 20
ranking_winlegend = 20
-- �й� ����
ranking_losebronze = 0
ranking_losesilver = -4
ranking_losegold = -8
ranking_loseplatinum = -12
ranking_losediamond = -16
ranking_loselegend = -20
-- ��޺� �ʿ� ����
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
-- ��ŷ DB ���� �ð�
ranking_db = 0600
-- ��ŷ DB�� ���� �� ��� ���
ranking_tagetrank = 200
-- ��ŷ���� ������ ǥ���� ��� ���
ranking_showrank = 100
-- ��ŷ DB�� ������ �ּ� ����
ranking_tagetpoint = 4000

------------------------------------------------------------------------------
-- ���� ��ŷ��
------------------------------------------------------------------------------
rank_single_alarm_minute = 0				-- ���� ��ŷ�� �˸� �ð� (���� = ��)
rank_single_open_cycle_time = 1				-- ���� ��ŷ�� ���� �ֱ� (���� = ��)
rank_single_grade_max_cnt = 6				-- ���� ��ŷ�� ���� ��� ����
rank_single_tier_max_cnt = 5				-- ���� ��ŷ�� �� ���� Ƽ�� ����
rank_single_tier_gap_point = 100			-- ���� ��ŷ�� Ƽ�� ���� ����
rank_single_disposition_game = 5			-- ��ġ ��� Ƚ��

drone_assist_damage_percent = 0.2
------------------------------------------------------------------------------
-- �� 
------------------------------------------------------------------------------
ping_grade_max_count = 4 -- �� �ܰ� ���� ( ���� ó���� ������ )
ping_grade_gap_point = 100 -- �� �ܰ� �� ����Ʈ ��