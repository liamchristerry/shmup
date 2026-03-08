extends CharacterBody2D


var health:int
var speed:int
var rocketscene = preload("res://scenes/rocket.tscn")
@onready var rocketcontainer = $RocketContainer # = get_node("RocketContainer")
@onready var firelasersound = $FireLaserSound
@onready var sheildsprite = $Sheild
@onready var countdown_timer = $Countdown
@onready var canfire_timer = $CanFire
var sheild_status = false
var weapon_status:int
var canfire:bool = true

func _ready() -> void:
	get_player_stats()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("pause"):
		Events.PAUSE_GAME.emit(true)

func _physics_process(delta: float) -> void:
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2(0,0), screen_size)

func get_player_stats():
	var player_stats = Stat.get_player_stats()
	health = player_stats["player_health"]
	speed = player_stats["player_speed"]

func shoot():
	if canfire == true:
		canfire = false
		canfire_timer.start()
		if Audio.play_sound_efx == true:
			firelasersound.play()
		if weapon_status <= 0:
			Stat.set_rocket_speed(500, 0)
			var rocketinstance = rocketscene.instantiate()
			rocketcontainer.add_child(rocketinstance)
			rocketinstance.global_position = global_position
			rocketinstance.global_position.x += 80
		else:
			Stat.set_rocket_speed(500, 0)
			var rocketinstance1 = rocketscene.instantiate()
			rocketcontainer.add_child(rocketinstance1)
			rocketinstance1.global_position = global_position
			rocketinstance1.global_position.x += 80
			Stat.set_rocket_speed(500, 500)
			var rocketinstance2 = rocketscene.instantiate()
			rocketcontainer.add_child(rocketinstance2)
			rocketinstance2.global_position = global_position
			rocketinstance2.global_position.x += 80
			Stat.set_rocket_speed(500, -500)
			var rocketinstance3 = rocketscene.instantiate()
			rocketcontainer.add_child(rocketinstance3)
			rocketinstance3.global_position = global_position
			rocketinstance3.global_position.x += 80

func take_damage(new_value):
#called from the enemy scene when the physics body of the player enters
	if sheild_status == false:
		health += new_value
		if health >= 100:
			health = 100
		Stat.set_player_health(health)
		if health <= 0:
			die()

func die():
	queue_free()
	Events.GAME_OVER.emit()

func change_sheild(new_value):
	sheildsprite.visible = new_value
	sheild_status = new_value

func change_weapon(new_value):
	weapon_status += new_value
	if weapon_status > 15:
		weapon_status = 15
	elif weapon_status <= 0:
		weapon_status = 0
	Stat.set_weapon_status(weapon_status)

func _on_countdown_timeout() -> void:
	if weapon_status > 0:
		change_weapon(-1)
	else:
		return

func _on_can_fire_timeout() -> void:
	canfire = true
