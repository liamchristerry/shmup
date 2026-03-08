extends Node2D


var powerupscene = preload("res://scenes/powerup.tscn")
@onready var spawntop = $SpawnPOS_Top
@onready var spawnbottom = $SpawnPOS_Bottom
@onready var timer = $Timer
var timeout:float = 1

func _on_timer_timeout() -> void:
	spawn_powerup()

func spawn_powerup():
	var spawnpos = Random.get_random(spawnbottom.global_position.y, spawntop.global_position.y)
	var powerupinstance = powerupscene.instantiate()
	powerupinstance.global_position = Vector2(spawntop.global_position.x, spawnpos)
	add_child(powerupinstance)
