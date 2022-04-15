extends Enemy

#non loop - expire

onready var ow_sound = get_node("owie")
onready var sprite_img = get_node("Sprite")
onready var shoot_timer = get_node("shoot_timer")
onready var pos = get_node("Position2D")
enum TYPES {RAPID, NUKE, DOUBLE_ANGLE, LASER}
onready var Projectile = preload("res://Scene/Projectile.tscn")
onready var die_aud = $die
onready var animated_sprite = get_node("AnimatedSprite")
onready var animation_player = $AnimationPlayer
var speed = 500
var path_follow

func _ready():
	path_follow = get_parent()
	animated_sprite.visible = false
	init(40, 200, 40, ow_sound, sprite_img,die_aud, animated_sprite, animation_player)

func _physics_process(_delta):
	path_follow.set_offset(path_follow.get_offset() + speed * _delta)
	if(global_position.x > 1330):
		match(Waves.current_wave):
			1:
				Waves.enemy_kaput()
				
			2:
				pass
		queue_free()
		
func shoot():
	pos.look_at(get_global_mouse_position())
	var b = Projectile.instance()
	b.init(damage_val, self, 1, false)
	pos.add_child(b)
	b.global_transform = pos.global_transform
	b.rotate(-PI/2)

func _on_shoot_timer_timeout():
	shoot()


func _on_die_finished():
	queue_free()



func _on_AnimatedSprite_animation_finished():
	print("destroy")
	match(Waves.current_wave):
			1:
				Waves.enemy_kaput()
			2:
				pass
	queue_free()
