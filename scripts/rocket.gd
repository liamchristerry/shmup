extends Area2D


var speed_x:int
var speed_y:int
@onready var weapon_sprite = $Sprite2D

func _ready() -> void:
	var rocketspeed = Stat.get_rocket_speed()
	speed_x = rocketspeed["rocket_speed_x"]
	speed_y = rocketspeed["rocket_speed_y"]
	if speed_y > 1:
		#no idea why this is 90 when I would think it would need to be 135 (45 + 90) 
		weapon_sprite.set_rotation(90)
	elif speed_y < -1:
		weapon_sprite.set_rotation(45)

func _physics_process(delta: float) -> void:
	global_position.x += speed_x*delta
	global_position.y += speed_y*delta

func _on_visable_notifier_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()
