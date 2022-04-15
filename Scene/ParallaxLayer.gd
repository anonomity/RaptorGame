extends ParallaxLayer

export(float) var star_speed  

func _process(delta) -> void:
	self.motion_offset.y -= star_speed
