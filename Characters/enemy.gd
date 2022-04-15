extends Enemy

var move_speed = 100
var path_follow


var speed = 500
onready var shooter = $shooter
onready var owie = $ow_sound
onready var sprite_img = $Sprite
onready var Projectile = preload("res://Scene/Projectile.tscn")
onready var animated_sprite = $AnimatedSprite

func _ready():
	
	path_follow = get_parent()
	init(20,100,20,owie, sprite_img, null, animated_sprite, null)
	animated_sprite.visible = false
	
func _physics_process(_delta):
	path_follow.set_offset(path_follow.get_offset() + speed * _delta)


func shoot():
	shooter.look_at(Vector2.DOWN)
	var b = Projectile.instance()
	b.init(damage_val, self, 1, false)
	owner.add_child(b)
	b.global_transform = shooter.global_transform
	
	#b.global_position(-PI+ -PI/4)
	b.global_rotation = 0
	#b.global_rotation(-PI/2)


func _on_shoot_timer_timeout():
	shoot()


func _on_AnimatedSprite_animation_finished():
	match(Waves.current_wave):
			1:
				Waves.enemy_kaput()
			2:
				pass
	queue_free()
