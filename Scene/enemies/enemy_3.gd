extends Enemy

var hp = 60
var points_received = 300
var attack_value = 60
onready var ouch_sound = $ouch_sound
onready var sprite_pic = $Sprite
onready var dying_sound = $dying_sound
onready var animation_sprite = $AnimatedSprite
onready var shoot_timer = $shoot_timer
onready var pos = $Position2D
onready var animation_player = $AnimationPlayer
onready var Projectile = preload("res://Scene/Projectile.tscn")
var speed = 250
var path_follow

func _ready():
	path_follow = get_parent()
	init(hp, points_received, attack_value, ouch_sound, sprite_pic, dying_sound, animation_sprite,animation_player)

func _physics_process(_delta):
	path_follow.set_offset(path_follow.get_offset() + speed * _delta)


func shoot():
	pos.look_at(get_global_mouse_position())
	var b = Projectile.instance()
	b.init(damage_val, self, 1, false)
	pos.add_child(b)
	b.global_transform = pos.global_transform
	b.rotate(-PI/2)

func _on_AnimatedSprite_animation_finished():
	
	match(Waves.current_wave):
			1:
				Waves.enemy_kaput()
			2:
				pass
	queue_free()
	


func _on_shoot_timer_timeout():
	shoot()
