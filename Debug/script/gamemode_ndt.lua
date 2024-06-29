function gamemode_set()
	game_limit_time = 600000
	respawn_delay = 1000
	force_respawn = 10000
	no_damage_time = 3000
	drone_timer_decrease_rate = 600
	drone_delay = -1
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

function gamemode_change_test () -- F키를 누르면 게임모드 설정을 다음과 같이 바꾼다.
	drone_timer_decrease_rate = 10
	drone_delay = 0
	respawn_delay = 50000
end

