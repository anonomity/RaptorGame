extends Area2D

var speed = 750

var damage = 20
var body_owner 
var direction
var raptor
var damage_val

func _ready():
	set_as_toplevel(true)
	

func _physics_process(delta):
	if(direction == -1):
		position -= transform.y * speed * delta
	else:
		position += transform.y * speed * delta
	
func init(dmg_val, body, dir, player):
	damage = dmg_val
	body_owner = body
	direction = dir
	raptor = player
	if(!player):
		$AnimatedSprite.play("enemy_fire")
		$AnimatedSprite.flip_h = true
	if(player):
		if(body.get_laser_value()):
			$AnimatedSprite.play("laser")
		else:
			$AnimatedSprite.play("default")
	

func _on_Projectile_body_entered(body):	
	
	if(body.is_in_group("enemy") and raptor):
		if(body.health >= 0):
			body_owner.increment_score(body.value)
			body.take_damage(20)
			if(body.is_in_group("en2") or body.is_in_group("en_3")):
				queue_free()
	if(body.is_in_group("raptor") and !raptor):
		body.decrement_health(damage)
	if(body.is_in_group("container") and raptor):
		body.inc_amount()
		queue_free()
	


		
