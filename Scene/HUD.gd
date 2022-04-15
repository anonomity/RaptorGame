extends CanvasLayer

onready var health_bar = $Control/health_bar
onready var score_ui = $Control/score
onready var score = 0

onready var rapid_pic = preload("res://assets/rapid_fire_powerup.png")
onready var nuke_pic = preload("res://assets/nuke_powerup.png")
onready var double_pic = preload("res://assets/rapid_fire_powerup.png")
onready var laser = preload("res://assets/laser_powerup.png")
onready var laser_pic
onready var double_angle

var pos = []
onready var pos1 = $Control/HBoxContainer/pos1
onready var pos2 = $Control/HBoxContainer/pos2
onready var pos3 = $Control/HBoxContainer/pos3
onready var pos4 = $Control/HBoxContainer/pos4
onready var transparant = preload("res://assets/transparent.png")
enum TYPES {RAPID, NUKE, DOUBLE_ANGLE, LASER}
func decrement_health(amount):
	health_bar.value -= amount
	
func increment_score(amount):
	score += amount
	score_ui.text = "score: " + str(score)

func _input(event):
	if(Input.is_action_just_pressed("esc")):
		get_tree().quit()
		get_tree().quit()

func put_power_up(type):
	match(type):
		TYPES.RAPID:
			fill_pos(rapid_pic)
		TYPES.NUKE:
			fill_pos(nuke_pic)
		TYPES.DOUBLE_ANGLE:
			fill_pos(double_pic)
		TYPES.LASER:
			fill_pos(laser_pic)

func fill_pos(power_pic):
	match(pos.size()):
		0:
			pos1.texture = power_pic
		1:
			pos2.texture = power_pic
		2:
			pos3.texture = power_pic
		3:
			pos4.texture = power_pic
	pos.append(1)

func powerup_timeout():
	pos.pop_back()
	match(pos.size()):
		0:
			pos1.texture = transparant
		1:
			pos2.texture = transparant
		2:
			pos3.texture = transparant
		3:
			pos4.texture = transparant

