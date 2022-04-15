extends Control

onready var wave_text = $Wave_Value
onready var animation_player = $AnimationPlayer
var current_wave 

func next_wave(wave):
	current_wave = wave
	if(wave == 2):
		print("going to next wave")
		wave_text.text = "WAVE 2"
		animation_player.play("Next_Wave")
		
		
func change_scene_to():
	print("changing scene....")
	if(current_wave == 2):
		get_tree().change_scene("res://Scene/Wave_2.tscn")


func _on_Button_button_down():
	get_tree().change_scene("res://Scene/Main.tscn")

func win():
	print("you win")
