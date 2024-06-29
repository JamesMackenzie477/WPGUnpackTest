game_limit_time = -1
site_object_prefix="trg_"
site_icon_prefix="dom"

exist_kill_score="no"
exist_team_score="yes"

respawn_delay = 5000
force_respawn = 5000

force_team_id="eden"
-- 아래의 기능은 임시 테스트를 위해 DOM에 적용한 기능
game_pre_loading_countdown = 20000
explosive_delay = 15000 -- 수류탄 투척 모션만 나오고 수류탄은 안나오고 삭제됨

wave_rule_xml='script\\npc_spawn_group_test.xml'
wave_group_name='sg_wave_defense_1'

respawn="on"
drone_delay=10000;

allow_teamkill = "off"
headshot_only = "off"


local rand_dom = 0 -- 점령지역 랜덤 변경
local before_dom = 0 -- 이전 점령지역

function init_mode()
--mysz = string.format("%d<font color='#990000'>%s</font>%s", myhp, "test", "!!!!!");
mysz = string.format("지역 점령전 프로토타입 입니다.");
	lua_call_show_debug_info( mysz, 5 )
end



function init_mode_server()
--	lua_call_set_visible_object( "dom_pos_a", 1 )
--	lua_call_set_visible_object( "dom_pos_b", 1 )
--	lua_call_set_visible_object( "dom_pos_c", 1)
--	random_dom();
	random_dom();
	check_dom(); 
end

function init_mode_client()

	
--	lua_call_set_visible_object( "dom_pos_a", 1 )
--	lua_call_set_visible_object( "dom_pos_b", 1 )
--	lua_call_set_visible_object( "dom_pos_c", 1)
--	check_dom_client(); 
	
--	myhp = 18
	--mysz = string.format("%.2f<font color='#990000'>%s</font>%s", myhp, "test", "!!!!!");
	
end


function random_dom()

while before_dom ==  rand_dom do
rand_dom = math.random(1,4)
end

before_dom = rand_dom
	
end

function check_dom_client()


	
	if lua_call_is_enable_trigger_object( "trg_a" ) == 1
	then random_dom = 1;
	elseif  lua_call_is_enable_trigger_object( "trg_b" ) == 1
	then random_dom = 2;
	elseif  lua_call_is_enable_trigger_object( "trg_c" ) == 1
	then random_dom = 3;
	elseif  lua_call_is_enable_trigger_object( "trg_d" ) == 1
	then random_dom = 4;
	elseif  lua_call_is_enable_trigger_object( "trg_e" ) == 1
	then random_dom = 5;
	end 
	
	check_dom(); 
end

function check_dom()

	lua_call_set_enable_trigger_object( "trg_a", 0 )
	lua_call_set_enable_trigger_object( "trg_b", 0 )
	lua_call_set_enable_trigger_object( "trg_c", 0 )
	lua_call_set_enable_trigger_object( "trg_d", 0 )
	lua_call_set_enable_trigger_object( "trg_e", 0 )
	
	
	
	
		
	 if  rand_dom == 1 then
	lua_call_set_enable_trigger_object( "trg_a", 1 )
	elseif  rand_dom == 2 then
	lua_call_set_enable_trigger_object( "trg_b", 1 )
	elseif  rand_dom == 3 then
	lua_call_set_enable_trigger_object( "trg_c", 1 )
	elseif  rand_dom == 4 then
	lua_call_set_enable_trigger_object( "trg_d", 1 )
	else
	lua_call_set_enable_trigger_object( "trg_e", 1 )
	end 
	
	
	
	
end


function dom_sucess_message()


mymsg = string.format("누군가 점령에 성공했습니다 .점령지가  변경 되었습니다!.");
	lua_call_show_debug_info( mymsg, 3 )
	
end


function is_domination( object_state, try_team_id, owner_team_id, actor_team_id )
	if object_state == 10
	then
		return 0
	end
	if object_state == 1
	then
		if try_team_id ~= actor_team_id
		then	
			return 0
		end
	end
	if owner_team_id ~= actor_team_id
	then
		return 1
	end

	return 0
	

end

function check_cancel_domination( state, owner_team_id, user_team_id )
	if state ~= 1
	then
		return 0
	end
	if owner_team_id == user_team_id
	then
		return 1
	end
	return 0
end 

function cancel_domination( team_id, object_name )
	stay_count = lua_call_get_stay_count( team_id, object_name )
	if stay_count == 0
	then
		lua_call_reset_object_state( object_name );
	end
end 

function check_domination( object_team_id, user_team_id, user_index, hp )
	if object_team_id ~= user_team_id
	then
		return 0
	end
	if hp == 0
	then
		return 0
	end
	return 1
	
end

function calc_domation_time_rate( stay_count )
	if stay_count == 0
	then
		return 0
	elseif stay_count == 2
	then
		return 1.5
	elseif stay_count >= 3
	then
		return 2
	end
	return 1
end

function add_domination_score( owner_team_id, object_name, flow_time )
	stay_count = lua_call_get_stay_count( owner_team_id, object_name )
	domination_rate = calc_domation_time_rate( stay_count )
	return flow_time * domination_rate
end


function set_domination_rate( team_id, object_name )
	stay_count = lua_call_get_stay_count( team_id, object_name )
	domination_rate = calc_domation_time_rate( stay_count )
	lua_call_set_progress_rate( domination_rate, object_name )
 
end





function check_object_domination( state, score , domination_score )
	if state ~= 1
	then
		return 0
	end
	if score > tonumber( domination_score )
	then
		return 1
	end
	return 0
end


function check_object_team_id( object_team_id )
	if object_team_id == 0 or object_team_id == 1
	then
		return 1
	end
	return 0
end

function add_score( team_id )
	lua_call_add_team_score( team_id, 1 )
end



function change_domination_icon( object_id, self_team_id, owner_team_id )



	if ( owner_team_id == 2 )
	then
		return
	end
	if ( self_team_id == owner_team_id )
	then
		lua_call_change_object_icon( object_id, 1 )
	else
		lua_call_change_object_icon( object_id, 2 )
	end
	
	
end



function domination_message( user_index, self_team_id, owner_team_id, team_message_id, enemy_message_id )


	if ( self_team_id == owner_team_id )
	then
		lua_call_chat_message( "아군이 점령했습니다." )
		lua_call_message( team_message_id, user_index )
	else
		lua_call_message( enemy_message_id )
	end
end

function check_object_state( state, check_value )
	if state == tonumber( check_value )
	then
		return 1
	end
	return 0
end