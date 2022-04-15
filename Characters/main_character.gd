extends KinematicBody2D


var velocity = Vector2.ZERO
var mouse_position = Vector2.ZERO
var new_position
onready var HUD = $HUD
onready var beak = $beak
onready var pew = $pew
onready var poww = $pow
onready var ow = $ow
onready var bsju = $bsju
onready var nuke_sound = $nuke
onready var rapid_fire_duration = $rapid_fire_duration
onready var double_shoot_duration = $double_shoot_duration
onready var laser_shoot_duration = $laser_shoot_duration
onready var laster_shoot = $laser_shoot
onready var dub_shoot_timer = $dub_shoot
var nuke = false
enum TYPES {RAPID, NUKE, DOUBLE_ANGLE, LASER}
var can_shoot = true
var rapid_fire = false
var dub_shoot = false
var can_normal_shoot = true
var health = 100
var laser = false
var can_laser_shoot = true
var dub_can_shoot = true
onready var Projectile = preload("res://Scene/Projectile.tscn")
func _ready():

	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	Input.set_custom_mouse_cursor(preload("res://assets/transparent.png"))
	

func _physics_process(_delta):
	if(health <= 0):
		on_lose()
	new_position =  get_local_mouse_position() -mouse_position
	position += new_position
	mouse_position = get_local_mouse_position()
	if(Input.is_action_just_pressed("ui_right")):
		on_lose()
	if(Input.is_action_just_pressed("ui_left")):
		increment_score(10)
	if(rapid_fire and Input.is_action_pressed("shoot") and can_shoot and !dub_shoot):
		$rapid_fire.start()
		shoot()
		can_shoot = false
	if(Input.is_action_pressed("shoot") and dub_can_shoot and dub_shoot):
		double_shoot()
		dub_can_shoot = false
		dub_shoot_timer.start()
	if(Input.is_action_pressed("shoot") and laser and can_laser_shoot):
		shoot()
		can_laser_shoot = false
		laster_shoot.start()
	if(Input.is_action_just_pressed("shoot") and !rapid_fire and can_normal_shoot and !dub_shoot and !laser):
		shoot()
		can_normal_shoot = false
		$normal_shoot.start()

func play_nuke_sound():
	nuke_sound.play()

func get_laser_value():
	return laser
func shoot():

	beak.look_at(get_global_mouse_position())
	pew.play()
	var b = Projectile.instance()
	b.init(20, self, -1, true)
	owner.add_child(b)

	b.global_transform = beak.global_transform
	b.rotate(-PI/2)
	
	
func double_shoot():

	beak.look_at(get_global_mouse_position())
	poww.play()
	var bullet_one = Projectile.instance()
	var bullet_two = Projectile.instance()
	bullet_one.init(20, self, -1, true)
	bullet_two.init(20, self, -1, true)
	owner.add_child(bullet_one)
	owner.add_child(bullet_two)

	bullet_one.global_transform = beak.global_transform
	bullet_one.translate(Vector2(-25, 0))
	bullet_one.rotate(-PI/2)
	
	bullet_two.global_transform = beak.global_transform
	bullet_two.translate(Vector2(25, 0))
	bullet_two.rotate(-PI/2)
	
func on_lose():

	get_tree().change_scene("res://Scene/lose.tscn")
	

func decrement_health(value):
	if(value == -100):
		health = 100
	elif(value == -50):
		health+=50
	else:
		health -= value
		ow.play()
		

		if(health <= 0):
			#on_lose()
			pass
	HUD.decrement_health(value)

func turn_off_nuke():
	nuke = false

func increment_score(value):
	Waves.increment_high_score(value)
	HUD.increment_score(value)



func get_powerup(type):
	match(type):
		TYPES.RAPID:
			rapid_fire = true
			rapid_fire_duration.start()
			HUD.put_power_up(TYPES.RAPID)
		TYPES.NUKE:
			nuke = true
			HUD.put_power_up(TYPES.NUKE)
		TYPES.DOUBLE_ANGLE:
			dub_shoot = true
			double_shoot_duration.start()
			HUD.put_power_up(TYPES.DOUBLE_ANGLE)
			
		TYPES.LASER:
			laser = true
			can_laser_shoot = true
			laser_shoot_duration.start()
	
	

func _on_rapid_fire_timeout():
	can_shoot = true
	


func _on_normal_shoot_timeout():
	can_normal_shoot = true


func _on_rapid_fire_duration_timeout():
	rapid_fire = false
	HUD.powerup_timeout()
	
func powerup_timeout():
	HUD.powerup_timeout()

func reset():
	get_tree().reload_current_scene()


func _on_double_shoot_duration_timeout():
	dub_shoot = false
	HUD.powerup_timeout()


func _on_laser_shoot_timeout():
	can_laser_shoot =true


func _on_laser_shoot_duration_timeout():
	laser = false
	HUD.powerup_timeout()


func _on_dub_shoot_timeout():
	dub_can_shoot = true
