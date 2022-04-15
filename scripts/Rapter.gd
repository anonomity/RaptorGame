extends Node

onready var value = 0
onready var health = 100

func _ready():
	pass
 
func inc_value(val):
	value += val
