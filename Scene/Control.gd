extends Control

onready var high_score = $high_score

func _ready():
	print("readu")
	Input.set_custom_mouse_cursor(preload("res://assets/epic_cursor.png"))
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	high_score.text = "But you managed to get %s points" %Waves.high_score
	


func _on_Control_visibility_changed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Button_pressed():
	#get_tree().reload_current_scene()
	Waves.increment_high_score(-Waves.high_score)
	Waves.reset()
	get_tree().change_scene("res://Scene/Main.tscn")

