extends Node



var current_wave = 1
var high_score = 0
var enemy_count =0
var enemy_done =0

func increment_high_score(value):
	high_score += value
	

func enemy_alt(val):
	enemy_count += val
	print("enemy count = ", enemy_count)
	
func reset():
	enemy_count = 0
	enemy_done = 0

func enemy_kaput():
	enemy_done += 1
	print("enemy killed ", enemy_done)

func enemy_nuke():
	enemy_done += (enemy_count - enemy_done)
	print("nuke, new enemy killed ", enemy_done)
