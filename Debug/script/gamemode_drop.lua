-- 한 팀이 모두 나갈 시 남아있는 팀이 승리
winning_rule_for_leave = "playercount"

function gamemode_set()
	game_limit_time = 720000
	respawn_delay = 1000
	force_respawn = 5000
	no_damage_time = 5000
	-- drone_timer_decrease_rate = 600
	-- 라스트캠 옵션 lua_call_lastcam_control ( [캠 재생여부],[캠 재생시간], [슬로모션 시작점], [슬로모션 종료점], [슬로모션 재생속도] 
	lua_call_lastcam_control(1, 7000, 6000, 6500, 40)
end

function select_loadout()
end

function prepare_round()
	disable_all_object()
end

function prepare_round_server()
	disable_all_object()
end

function countdown()
end

function game_end()
end

function disable_all_object()	-- 드랍모드 오브젝트 끔
	lua_call_set_visible_object( "dp_s1", 0 )
	lua_call_set_visible_object( "dp_e1", 0 )
	lua_call_set_visible_object( "drop1", 0 )
	lua_call_set_visible_object( "dp_s2", 0 )
	lua_call_set_visible_object( "dp_e2", 0 )
	lua_call_set_visible_object( "drop2", 0 )
	lua_call_set_visible_object( "dp_s3", 0 )
	lua_call_set_visible_object( "dp_e3", 0 )
	lua_call_set_visible_object( "drop3", 0 )
	lua_call_set_visible_object( "dp_s4", 0 )
	lua_call_set_visible_object( "dp_e4", 0 )
	lua_call_set_visible_object( "drop4", 0 )
	lua_call_set_visible_object( "dp_s5", 0 )
	lua_call_set_visible_object( "dp_e5", 0 )
	lua_call_set_visible_object( "drop5", 0 )
	lua_call_set_visible_object( "dp_s6", 0 )
	lua_call_set_visible_object( "dp_e6", 0 )
	lua_call_set_visible_object( "drop6", 0 )
	lua_call_set_visible_object( "dp_s7", 0 )
	lua_call_set_visible_object( "dp_e7", 0 )
	lua_call_set_visible_object( "drop7", 0 )
	lua_call_set_visible_object( "dp_s8", 0 )
	lua_call_set_visible_object( "dp_e8", 0 )
	lua_call_set_visible_object( "drop8", 0 )
	lua_call_set_visible_object( "dp_s9", 0 )
	lua_call_set_visible_object( "dp_e9", 0 )
	lua_call_set_visible_object( "drop9", 0 )
	lua_call_set_visible_object( "dp_s10", 0 )
	lua_call_set_visible_object( "dp_e10", 0 )
	lua_call_set_visible_object( "drop10", 0 )
	lua_call_set_visible_object( "dp_s11", 0 )
	lua_call_set_visible_object( "dp_e11", 0 )
	lua_call_set_visible_object( "drop11", 0 )
	lua_call_set_visible_object( "dp_s12", 0 )
	lua_call_set_visible_object( "dp_e12", 0 )
	lua_call_set_visible_object( "drop12", 0 )
	lua_call_set_visible_object( "dp_s13", 0 )
	lua_call_set_visible_object( "dp_e13", 0 )
	lua_call_set_visible_object( "drop13", 0 )
	lua_call_set_visible_object( "dp_s14", 0 )
	lua_call_set_visible_object( "dp_e14", 0 )
	lua_call_set_visible_object( "drop14", 0 )
	lua_call_set_visible_object( "dp_s15", 0 )
	lua_call_set_visible_object( "dp_e15", 0 )
	lua_call_set_visible_object( "drop15", 0 )
	lua_call_set_visible_object( "dp_s16", 0 )
	lua_call_set_visible_object( "dp_e16", 0 )
	lua_call_set_visible_object( "drop16", 0 )
	lua_call_set_visible_object( "dp_s17", 0 )
	lua_call_set_visible_object( "dp_e17", 0 )
	lua_call_set_visible_object( "drop17", 0 )
	lua_call_set_visible_object( "dp_s18", 0 )
	lua_call_set_visible_object( "dp_e18", 0 )
	lua_call_set_visible_object( "drop18", 0 )
	lua_call_set_visible_object( "dp_s19", 0 )
	lua_call_set_visible_object( "dp_e19", 0 )
	lua_call_set_visible_object( "drop19", 0 )
	lua_call_set_visible_object( "dp_s20", 0 )
	lua_call_set_visible_object( "dp_e20", 0 )
	lua_call_set_visible_object( "drop20", 0 )
	lua_call_set_visible_object( "dp_s21", 0 )
	lua_call_set_visible_object( "dp_e21", 0 )
	lua_call_set_visible_object( "drop21", 0 )
	lua_call_set_visible_object( "dp_s22", 0 )
	lua_call_set_visible_object( "dp_e22", 0 )
	lua_call_set_visible_object( "drop22", 0 )
	lua_call_set_visible_object( "dp_s23", 0 )
	lua_call_set_visible_object( "dp_e23", 0 )
	lua_call_set_visible_object( "drop23", 0 )
	lua_call_set_visible_object( "dp_s24", 0 )
	lua_call_set_visible_object( "dp_e24", 0 )
	lua_call_set_visible_object( "drop24", 0 )
	lua_call_set_visible_object( "dp_s25", 0 )
	lua_call_set_visible_object( "dp_e25", 0 )
	lua_call_set_visible_object( "drop25", 0 )
	lua_call_set_visible_object( "dp_s26", 0 )
	lua_call_set_visible_object( "dp_e26", 0 )
	lua_call_set_visible_object( "drop26", 0 )
	lua_call_set_visible_object( "dp_s27", 0 )
	lua_call_set_visible_object( "dp_e27", 0 )
	lua_call_set_visible_object( "drop27", 0 )
	lua_call_set_visible_object( "dp_s28", 0 )
	lua_call_set_visible_object( "dp_e28", 0 )
	lua_call_set_visible_object( "drop28", 0 )
	lua_call_set_visible_object( "dp_s29", 0 )
	lua_call_set_visible_object( "dp_e29", 0 )
	lua_call_set_visible_object( "drop29", 0 )
	lua_call_set_visible_object( "dp_s30", 0 )
	lua_call_set_visible_object( "dp_e30", 0 )
	lua_call_set_visible_object( "drop30", 0 )
end


function winning_shot()
end

function end_score_board()
end

function half_time()
end

function winner_ceremony()
end
