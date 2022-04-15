extends Area2D


func _ready():
	pass


func _on_health_body_entered(body):
	if(body.is_in_group("raptor")):
		if(body.health + 50 > 100):
			body.decrement_health(-100)
		else:
			body.decrement_health(-50)
		queue_free()
