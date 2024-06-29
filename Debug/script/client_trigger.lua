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



-- ������ ���
function use_item( game_time, item_data  )
	if ( item_data.type == 3 )
	then
		lua_call_play_sound( "drone_start", user_data.index, user_data.friendly )
	end
	lua_call_play_sound( "drone_start_nono" )
end

-- ��� �غ�
function ready_item( game_time, item_data )
	
end

-- ���
function kill_character( game_time, reward_info )
	msg_name = "msg0010002";
	if ( reward_info.type == RewardType_2Combo ) -- 2 combo
	then
		msg_name = "msg0010003";
	elseif ( reward_info.type == RewardType_3Combo ) -- 3 combo
	then
		msg_name = "msg0010003";
	elseif ( reward_info.type == RewardType_4Combo ) -- 4 combo
	then
		msg_name = "msg0010003";
    elseif ( reward_info.type == RewardType_MultiCombo ) -- combos
	then
		msg_name = "msg0010003";
    elseif ( reward_info.type == RewardType_Revenger ) -- revenge
	then
		msg_name = "msg0010004";
	elseif ( reward_info.type == RewardType_KingSlayer ) -- KingSlayer
	then
		msg_name = "rwdmsg017";
	elseif ( reward_info.type == RewardType_Shutdown_3 ) -- Shutdown_3
	then
		msg_name = "rwdmsg018";
	elseif ( reward_info.type == RewardType_Shutdown_4 ) -- Shutdown_4
	then
		msg_name = "rwdmsg021";
	elseif ( reward_info.type == RewardType_Shutdown_5 ) -- Shutdown_5
	then
		msg_name = "rwdmsg022";
	elseif ( reward_info.type == RewardType_DroneKill ) -- kill by drone
	then

	end

	lua_call_show_reward_msg( msg_name, reward_info.point );
end

-- NPC ���
function kill_npc( game_time, reward_info )
	msg_name = "msg0010002";
end

-- dead
function dead_character( game_time, reward_info )
end

-- ����
function assist_character( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg001", reward_info.point );
end


-- Ž��
function detect_character( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg002", reward_info.point );
end

-- �±�
function search_character( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg006", reward_info.point );
end

-- debuff
function debuff_character( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg005", reward_info.point );
end

-- jamming
function jamming_character( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg003", reward_info.point );
end

-- ����
function domination( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg009", reward_info.point );
end


-- ���Ĺ� ����
function demolition( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg012", reward_info.point );
end


-- ��ź ��ü
function defuse_bomb( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg013", reward_info.point );
end


-- ���Ĺ� ��ġ
function install_bomb( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg014", reward_info.point );
end


-- ��� �ı�
function drone_destroy( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg008", reward_info.point );
end

-- ������
function dom_stay( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg009", reward_info.point );
end

-- ��ô�� �ı�
function throw_destroy( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg016", reward_info.point );
end

-- ��� ��ý�Ʈ
function drone_assist( game_time, reward_info )
	lua_call_show_reward_msg( "rwdmsg023", reward_info.point );
end

-- �� ���� ����Ʈ
function team_reward( game_time, reward_info )
	local reward_str = "msg0010007";
	if ( reward_info.type == RewardType_Mod_Bomb ) then
		reward_str = "rwdmsg019";
	elseif ( reward_info.type == RewardType_Mod_Bomb_Remove ) then
		reward_str = "rwdmsg020";
	elseif ( reward_info.type == RewardType_Mod_Domination ) then
		reward_str = "gfx0000428";
	end
	lua_call_show_reward_msg( reward_str, reward_info.point );
end
