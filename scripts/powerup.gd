extends Area2D


var poweruptype = {"health": 50,
				"sheild": 25,
				"weapon": 25}
var powerupvalue
var speed:int = 200
@onready var powerup = $Sprite2D
@onready var powerup_health = preload("res://assets/health/tile_0024.png")
@onready var powerup_sheild = preload("res://assets/powerup/powerupGreen_shield.png")
@onready var powerup_weapon = preload("res://assets/powerup/powerupGreen_bolt.png")

func _ready() -> void:
	poweruppicker()

func _physics_process(delta: float) -> void:
	global_position.x -= speed*delta

func poweruppicker():
	var powerupsprite = Random.get_weighted_random(poweruptype)
	if powerupsprite == "health":
		powerup.set_texture(powerup_health)
		powerupvalue = "health"
	elif powerupsprite == "sheild":
		powerup.set_texture(powerup_sheild)
		powerupvalue = "sheild"
	elif powerupsprite == "weapon":
		powerup.set_texture(powerup_weapon)
		powerupvalue = "weapon"
	else:
		print("error")

func _on_visable_notifier_screen_exited() -> void:
	collected()

func collected():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if powerupvalue == "health":
		body.take_damage(34)
	elif powerupvalue == "sheild":
		body.change_sheild(true)
	elif powerupvalue == "weapon":
		body.change_weapon(15)
	collected()
