extends Node2D

onready var u_path = $u_path
onready var eight_path = $"8_Path"
onready var s_path = $S_Path
onready var o_path = $O_Path
onready var l_path = $l_path

onready var enemy_1_follow = preload("res://Scene/phase_1_follow.tscn")
onready var enemy_2_follow = preload("res://Scene/enemies/enemy_2_follow.tscn")
onready var enemy_3_follow = preload("res://Scene/enemies/enemy_3_follow.tscn")
onready var enemy_2 = preload("res://Scene/enemy_2.tscn")
onready var container_scene = preload("res://Scene/container.tscn")
onready var path_movement = $path_movement
onready var raptor = $raptor
onready var phase_ui = $wave_ui/Wave_Control
onready var animation_player = $AnimationPlayer
onready var animation_sprite = $AnimationPlayer/nuke
onready var third_wave_fire_rate = $third_wave_fire_rate
var current_container = null
onready var paths = [eight_path,s_path,o_path]
onready var health_timer = $health_timer
onready var health_spawn = $health_spawn
onready var health_scene = preload("res://Scene/health.tscn")
var move_down
var move_up = false
var timers = 0
var second_wave_enemies = 10
var third_wave_enemies = 5
var enemy_count
enum TYPES {RAPID, NUKE, DOUBLE_ANGLE, LASER}
#u need to kill all    #expire 

func _ready():
	phase_ui.visible = false
	animation_sprite.visible = false

func _physics_process(delta):
	if(Waves.enemy_done == 35 or Input.is_action_pressed("ui_down")):
		print("GAME DONE")
		phase_2()
	if(move_up):
		u_path.translate(Vector2(0,-1))
	elif(move_down):
		u_path.translate(Vector2(0,1))
	if(u_path.global_position.y >= 200):
		move_down = false
		move_up = true
	if(u_path.global_position.y <= 80):
		move_up = false
		move_down = true
	#if(Waves.wave_one_enemy_count == 0):
	#	phase_2()
	if(Input.is_action_just_pressed("nuke") and raptor.nuke):
		raptor.play_nuke_sound()
		raptor.powerup_timeout()
		raptor.turn_off_nuke()
		animation_player.play("nuke")
		wipe_out()
func _input(event):

	if(Input.is_action_just_pressed("esc")):
		get_tree().quit()

func _on_edge_area_body_entered(body):
	body.on_lose()

func first_wave():
	var phase_1 = enemy_1_follow.instance()
	paths[0].add_child(phase_1)
	Waves.enemy_alt(1)

func wipe_out():
	Waves.enemy_nuke()
	for i in range(paths.size()):
		for j in range(paths[i].get_children().size()):
			paths[i].get_children()[j].queue_free()
			

func second_wave():
	var phase_2 = enemy_2_follow.instance()
	paths[1].add_child(phase_2)
	Waves.enemy_alt(1)

	
func _on_first_wave_timeout():
	timers +=1

	if(timers == 10):
		$first_wave.autostart = false
		$first_wave.one_shot =true
	else:
		first_wave()
		

func phase_2():
	phase_ui.next_wave(2)

func _on_path_movement_timeout():
	move_down = true


func _on_second_wave_timeout():
	second_wave_enemies -=1
	if(second_wave_enemies == 0):
		$second_wave.autostart = false
		$second_wave.one_shot = true
	else:
		second_wave()



	
func _on_container_2_timer_timeout():
	spawn_container()
		
func third_wave():
	var phase_three = enemy_3_follow.instance()
	paths[2].add_child(phase_three)
	Waves.enemy_alt(1)

func _on_third_wave_timeout():
	third_wave_fire_rate.start()


func _on_third_wave_fire_rate_timeout():
	third_wave_enemies -=1
	if(second_wave_enemies == 0):
		third_wave_fire_rate.autostart = false
		third_wave_fire_rate.one_shot = true
	else:
		third_wave()

func spawn_container():
	if(current_container != null):
		current_container.queue_free()
	var container = container_scene.instance()
	current_container = container
	randomize()
	var num_type = randi()%4
	if(int(num_type) == 0):
		container.init(TYPES.RAPID)
	elif(int(num_type) == 1):
		container.init(TYPES.NUKE)
	elif(int(num_type) == 2):
		container.init(TYPES.DOUBLE_ANGLE)
	elif(int(num_type) == 3):
		container.init(TYPES.LASER)
	else:
		container.init(TYPES.RAPID)
	
	$con_pos_1.add_child(container)
	var num = randi() %2
	if(int(num) == 0):
		container.global_transform = $con_pos_1.global_transform
	elif(int(num) == 1):
		container.global_transform = $con_pos_2.global_transform




func _on_health_timer_timeout():
	var rand = randi()%4
	if(rand == 0):
		var health_obj = health_scene.instance()
		health_spawn.add_child(health_obj)
		randomize()
		var x = rand_range(162,1176)
		var y = rand_range(50, 730)
		
		health_obj.global_position = Vector2(int(x), int(y))
	
	
