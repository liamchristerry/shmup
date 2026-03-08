extends Area2D


var enemylevel = {"level1": 100,
				"level2": 50,
				"level3": 10}
var speed:int = 300: set = set_speed
@onready var explosion = $explosion
@onready var plane = $plane
@onready var planesprite1 = preload("res://assets/Pixel Shmup/Ships/ship_0008.png")
@onready var planesprite2 = preload("res://assets/Pixel Shmup/Ships/ship_0004.png")
@onready var planesprite3 = preload("res://assets/Pixel Shmup/Ships/ship_0000.png")
@onready var collisionshape = $CollisionShape2D

func _ready() -> void:
	enemylevelpicker()

func _physics_process(delta: float) -> void:
	global_position.x -= speed*delta

func set_speed(new_value):
	speed = new_value

func _on_visable_notifier_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#print("hit player")
		body.take_damage(-34)
		#calling the take_damage function in the player script
		body.change_sheild(false)
		#turn off the sheild on the player
		die("player")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("rockets"):
		die("rocket")

func die(collision_object):
	if collision_object == "player":
		Stat.set_player_score(0)
	if collision_object == "rocket":
		Stat.set_player_score(100)
	explosion.visible = true
	plane.visible = false
	set_speed(0)
	call_deferred("disablecollision")
	#doing this since you cant modify a phyisics opbject during a process
	await get_tree().create_timer(1).timeout
	queue_free()

func disablecollision():
	collisionshape.disabled = true

func enemylevelpicker():
	var enemysprite = Random.get_weighted_random(enemylevel)
	if enemysprite == "level3":
		plane.set_texture(planesprite3)
	elif enemysprite == "level2":
		plane.set_texture(planesprite2)
	elif enemysprite == "level1":
		plane.set_texture(planesprite1)
	else:
		print("error")
