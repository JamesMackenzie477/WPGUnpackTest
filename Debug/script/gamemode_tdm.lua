-- �� ���� ��� ���� �� �����ִ� ���� �¸�
winning_rule_for_leave = "playercount"

function gamemode_set()
	game_limit_time = 720000
	respawn_delay = 1000
	force_respawn = 5000
	no_damage_time = 3000
	-- drone_timer_decrease_rate = 600
	-- ��Ʈķ �ɼ� lua_call_lastcam_control ( [ķ �������],[ķ ����ð�], [���θ�� ������], [���θ�� ������], [���θ�� ����ӵ�] 
	lua_call_lastcam_control(1, 7000, 6000, 6500, 40)
	lua_call_load_ui("hudtdm")
end

function select_loadout()
end

function prepare_round()
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
