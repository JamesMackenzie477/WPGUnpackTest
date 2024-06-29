-- �̺κ��� �������� ������
--------------------------------------------
-- RewardType ����
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

MissionState_None		= 0
MissionState_Bomb_Installing	= 1
MissionState_Bomb_Defusing	= 2
MissionState_Area_Occupying	= 3

DroneGrade_1	= 11
DroneGrade_2	= 12
DroneGrade_3	= 13

-- kill_info.combo
-- kill_info.weapon_id
-- kill_info.hit_part
-- 	DamagePartRate_Head	=	0,
-- 	DamagePartRate_Chest 	=	1,
-- 	DamagePartRate_Arm	=	2,
-- 	DamagePartRate_Leg	=	3,
-- kill_info.hp hp
-- dead_info �� killed_info �� ������ ��
-- dead_info.combo
-- dead_info.prev_kill_time
-- dead_info.mission_state

-- function check_over_exp( total_get_exp, get_exp )
	-- if total_get_exp > 400
	-- then
		-- get_exp = math.pow( 400 / ( total_get_exp + get_exp ), 3.5 ) * get_exp
	-- end
	
	-- return get_exp
-- end

function kill_character( game_time, total_get_exp, kill_info, killed_info )
local a_point = 100
local o_point = 100
local reward_type = RewardType_Normal_Kill
local exp = 0
local weapon_exp = 0
local coin = 0
	if kill_info.killer_type == 0						--	ĳ���Ͱ� ų
	then
	end

	if kill_info.killer_type == 1						--	����� ų
	then
		a_point = 50
		o_point = 50
		reward_type = RewardType_DroneKill
	end

	if kill_info.killer_type == 2						--	������Ʈ�� ų
	then
		reward_type = RewardType_ObjectKill
	end

	if reward_type == RewardType_Normal_Kill
	then
		if kill_info.hp < 10 
		then
			exp = 0
			reward_type = RewardType_CloseCall_Kill
		end
	end

	if killed_info.mission_state == MissionState_Bomb_Installing
	then
		a_point = 150
		o_point = 150
	end
	if killed_info.mission_state == MissionState_Bomb_Defusing
	then
		a_point = 150
		o_point = 150
	end
	if killed_info.mission_state == MissionState_Area_Occupying
	then
		a_point = 150
		o_point = 150
	end

-- �⺻ ����Ʈ

	if kill_info.combo == 2
	then
--		a_point = a_point + 2		--	2�޺�
		exp = 0
		reward_type = RewardType_2Combo
	end
	if kill_info.combo == 3
	then
--		a_point = a_point + 3		--	3�޺�
		exp = 0
		reward_type = RewardType_3Combo
	end
	if kill_info.combo == 4
	then
--		a_point = a_point + 5		--	4�޺�
		exp = 0
		reward_type = RewardType_4Combo
	end
	if kill_info.combo > 4
	then
--		a_point = a_point + 10		--	5�޺��̻�
		exp = 0
		reward_type = RewardType_MultiCombo
	end

	if killed_info.prev_kill_time ~= nil
	then
		if game_time - killed_info.prev_kill_time < 7000		--	����(�۵� �ȵ�)
		then
			-- a_point = a_point + 10
			-- o_point = o_point + 5
			-- reward_type = RewardType_Revenger
		end
	end

	if kill_info.hit_part == 0						--	��弦
	then
		exp = 0
		reward_type = reward_type + RewardType_HeadShot
	end
	
	if kill_info.shutdown >= 5 then
		a_point = 200
		o_point = 200
		reward_type = RewardType_Shutdown_5
	elseif kill_info.shutdown == 4 then
		a_point = 150
		o_point = 150
		reward_type = RewardType_Shutdown_4
	elseif kill_info.king_slayer == 1 then
		a_point = 150
		o_point = 150
		reward_type = RewardType_KingSlayer
	elseif kill_info.shutdown == 3 then
		a_point = 125
		o_point = 125
		reward_type = RewardType_Shutdown_3
	elseif kill_info.revenger == 1 then
		a_point = 125
		o_point = 125
		reward_type = RewardType_Revenger
	end	
	
	exp = 0
	coin = exp * 0
	weapon_exp = 100
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ���
function dead_character( game_time, total_get_exp, dead_info )
local reward_type = RewardType_Dead
local a_point = 0
local o_point = 0
local weapon_exp = 0
local exp = 0
local coin = 0
	-- exp = check_over_exp( total_get_exp, exp )
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end


-- ����
function assist_character( game_time, total_get_exp )
local reward_type = RewardType_Assist_Damage
local a_point = 50
local o_point = 50
local weapon_exp = 50
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- Ž��(spy, uav)
function detect_character( game_time, total_get_exp )
local reward_type = RewardType_Assist_Detect
local a_point = 0
local o_point = 10
local weapon_exp = 10
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- tag(observer)
function search_character( game_time, total_get_exp )
local reward_type = RewardType_Assist_Search
local a_point = 0
local o_point = 25
local weapon_exp = 25
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- debuff
function debuff_character( game_time, total_get_exp )
local reward_type = RewardType_Assist_Damage_Debuff
local a_point = 10
local o_point = 25
local weapon_exp = 25
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- jamming
function jamming_character( game_time, total_get_exp )
local reward_type = RewardType_Assist_Damage_Debuff
local a_point = 0
local o_point = 10
local weapon_exp = 10
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ����
function domination( game_time, total_get_exp )
local reward_type = RewardType_Mod_Domination
local a_point = 100
local o_point = 100
local weapon_exp = 100
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ��ź ��ġ
function install_bomb( game_time, total_get_exp )
local reward_type = RewardType_Mod_Bomb
local a_point = 50
local o_point = 50
local weapon_exp = 50
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ��ź ����
function demolition( game_time, total_get_exp )
local reward_type = RewardType_Mod_Explosion
local a_point = 100
local o_point = 100
local weapon_exp = 100
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ��ź ��ü
function defuse_bomb( game_time, total_get_exp )
local reward_type = RewardType_Mod_Bomb_Remove
local a_point = 50
local o_point = 50
local weapon_exp = 50
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ����ı�
-- drone_data.index ��� �ε���
-- drone_data.point ��� call point
-- drone_data.grade ��� ���(�ʱ�,�߱�,���)
function drone_destroy( game_time, total_get_exp, drone_data )
local reward_type = RewardType_DronePoint
local a_point = 0
local o_point = 0
local weapon_exp = 0
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	if drone_data.grade == DroneGrade_1	-- �ʱ޵��
	then
		a_point = 50
		o_point = 50
	end
	if drone_data.grade == DroneGrade_2	-- �߱޵��
	then
		a_point = 100		
		o_point = 100
	end
	if drone_data.grade == DroneGrade_3	-- ��޵��
	then
		a_point = 200		
		o_point = 200
	end
	
	weapon_exp = 100
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ��л���
-- drone_data.index ��� �ε���
-- drone_data.point ��� call point
function start_drone( game_time, total_get_exp, drone_data )
local reward_type = RewardType_StartDrone
local a_point = 0
local o_point = 0
local weapon_exp = a_point + o_point
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ���̺� Ŭ����
-- wave_data.clear_wave Ŭ������ ���̺�
function clear_wave( game_time, wave_data )
local reward_type = RewardType_ClearWave
local a_point = 0
local o_point = 0
local weapon_exp = a_point + o_point
local exp = 0
local coin = 0
	exp = 0
	coin = exp * wave_data.clear_wave	
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- NPC Kill
function kill_npc( game_time, total_get_exp, kill_info, dead_info )
	local a_point = 100	
	local o_point = 100
	local reward_type = RewardType_Normal_Kill
	local weapon_exp = 50
	local exp = 0
	local coin = 0	
	coin, exp = get_coin_and_exp_by_npc(dead_info.npc_index)

	if kill_info.combo == 2
	then
--		a_point = a_point + 2		--	2�޺�	    S
		reward_type = RewardType_2Combo
	end
	if kill_info.combo == 3
	then
--		a_point = a_point + 3		--	3�޺�
		reward_type = RewardType_3Combo
	end
	if kill_info.combo == 4
	then
--		a_point = a_point + 5		--	4�޺�
		reward_type = RewardType_4Combo
	end
	if kill_info.combo > 4
	then
--		a_point = a_point + 10		--	5�޺��̻�
		reward_type = RewardType_MultiCombo
	end

	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

-- ��ô�� �ı�
-- throw_data.index ��ô ���� �ε���
function throw_destroy( game_time, total_get_exp, throw_data )
local reward_type = RewardType_ThrowDestroy
local a_point = 0
local o_point = 0
local weapon_exp = 0
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0

	a_point = 10
	o_point = 10

	return a_point, o_point, weapon_exp, exp, coin, reward_type
end

function get_coin_and_exp_by_npc(npc_id)
	local value_coin = 0
	local value_exp = 0
	local npc_list = {10007,10020,10008,10015,10002,10001,10003,10000,10032,10027
					,10036,10028,10031,10029,10033,10037}
	for i=1, table.getn(npc_list) do
    	if npc_id == npc_list[i] then 
			value_coin = 2
			value_exp = 4
    	end
    end
	return value_coin, value_exp
end

-- ��� ��ý�Ʈ
-- drone_data.index ��� �ε���
-- drone_data.point ��� call point
-- drone_data.grade ��� ���(�ʱ�,�߱�,���)
function drone_assist( game_time, total_get_exp, drone_data )
local reward_type = RewardType_Drone_Assist_Damage
local a_point = 0
local o_point = 0
local weapon_exp = 50
local exp = 0
local coin = 0
	exp = 0
	coin = exp * 0
	if drone_data.grade == DroneGrade_1	-- �ʱ޵��
	then
		a_point = 25
		o_point = 25
	end
	if drone_data.grade == DroneGrade_2	-- �߱޵��
	then
		a_point = 50		
		o_point = 50
	end
	if drone_data.grade == DroneGrade_3	-- ��޵��
	then
		a_point = 100		
		o_point = 100
	end
	return a_point, o_point, weapon_exp, exp, coin, reward_type
end
