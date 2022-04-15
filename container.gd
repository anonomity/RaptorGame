extends StaticBody2D

var hit_amount = 0 
var powerup = preload("res://Scene/power_up.tscn")

onready var sprite = get_node("Sprite")
onready var pos = get_node("Position2D")
onready var collider = get_node("CollisionShape2D")
onready var hit_container = get_node("hit_container")
onready var boom_sound = get_node("boom")
onready var boom_sprite = get_node("boom_sprite")
onready var animation_player = get_node("AnimationPlayer")
enum TYPES {RAPID, NUKE, DOUBLE_ANGLE, LASER}
export(TYPES) var powerup_type
func _ready():
	var mat = sprite.get_material()
	mat.set_shader_param("flash_modifier",0.0)
	
func init(type):
	powerup_type = type
			
	
func inc_amount():
	hit_amount +=1
	hit_container.play()
	animation_player.play("shot")
	if(hit_amount == 5):
		boom_sprite.visible = true
		boom_sprite.play("boom")
		boom_sound.play()
		make_power_up()
		collider.disabled = true

func make_power_up():
	sprite.texture = load("res://assets/transparent.png")
	



func _on_boom_sprite_animation_finished():
	var power = powerup.instance()
	self.add_child(power)
	power.init(powerup_type)
	power.global_transform = pos.global_transform
