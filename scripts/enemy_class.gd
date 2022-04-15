extends KinematicBody2D

class_name Enemy

var health
var value
var damage_val
var ow 
var sprite
var die_audio
var explosion
var animation_play

func init(health_val, val, dmg_val, ow_sound, sprite_img, die_sound, anim_sprite, an_player ):
	health = health_val
	value= val
	damage_val = dmg_val
	ow= ow_sound
	sprite = sprite_img
	if(die_sound):
		die_audio = die_sound
	else:
		die_audio = ow_sound
	explosion = anim_sprite
	if(an_player):
		animation_play = an_player
	
	


func take_damage(val):
	if(health > 25):
		animation_play.play("flash")
	ow.play()
	health -= val
	
	if(health <= 0):
		
	
		die_audio.play()
		explosion.visible = true
		explosion.play("default")
		sprite.play("none")
		

		yield(ow,"finished")
		
		#emit signal to inc player val
		


	


