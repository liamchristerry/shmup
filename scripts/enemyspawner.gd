extends Node2D


var enemyscene = preload("res://scenes/enemy.tscn")
@onready var spawntop = $"SpawnPos-1"
@onready var spawnbottom = $"SpawnPos-2"
@onready var timer = $Timer
var timeout:float = 1

func _ready() -> void:
	Events.connect("DIFFICULTY_CHANGED", change_spawn_timer)

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy():
	var spawnpos = Random.get_random(spawnbottom.global_position.y, spawntop.global_position.y)
	var enemyinstance = enemyscene.instantiate()
	enemyinstance.global_position = Vector2(spawntop.global_position.x, spawnpos)
	add_child(enemyinstance)

func change_spawn_timer():
	timeout = timeout * .90
	timer.wait_time = timeout
	print("spawn timer: ", timeout)
	
	
