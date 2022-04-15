extends Area2D

enum TYPES {RAPID, NUKE, DOUBLE_ANGLE, LASER}
var powerup_type
onready var sprite = $Sprite

func init(type):
	powerup_type = type
	match(type):
		TYPES.RAPID:
			sprite.texture = load("res://assets/rapid_fire_powerup.png")
		TYPES.NUKE:
			sprite.texture = preload("res://assets/nuke_powerup.png")
		TYPES.DOUBLE_ANGLE:
			sprite.texture = preload("res://assets/rapid_fire_powerup.png")
		TYPES.LASER:
			sprite.texture = preload("res://assets/laser_powerup.png")
			

			
	
	

func _on_power_up_body_entered(body):
	if(body.is_in_group("raptor")):
		body.get_powerup(powerup_type)
		queue_free()
