extends Node

@onready var orginal_health:int = 100
@onready var orginal_speed:int = 300
@onready var orginal_score:int = 0

@onready var player_health:int = 100
@onready var player_speed:int = 300
@onready var player_score:int = 0

@onready var requiredscore:int = 500
@onready var rocket_speed_x:int = 500
@onready var rocket_speed_y:int = 500
@onready var weapon_status:int = 0

func get_player_stats():
	return {
		"player_health" =  player_health,
		"player_speed" = player_speed,
		"player_score" = player_score
	}

func set_player_health(new_value):
	player_health = new_value
	Events.PLAYER_HEALTH_CHANGED.emit(player_health)

func set_player_score(new_value):
	player_score += new_value
	if player_score < 0:
		player_score = 0
	Events.PLAYER_SCORE_CHANGED.emit(player_score)
	difficulity_checker()
	#print("player score: ", player_score)
	#print("reqired score: ", requiredscore)

func reset_stats():
	player_health = orginal_health
	player_speed = orginal_speed
	player_score = orginal_score

func difficulity_checker():
	if player_score >= requiredscore:
		requiredscore = requiredscore * 1.8
		Events.DIFFICULTY_CHANGED.emit()

func set_rocket_speed(new_x, new_y):
	rocket_speed_x = new_x
	rocket_speed_y = new_y

func get_rocket_speed():
		return {
		"rocket_speed_x" =  rocket_speed_x,
		"rocket_speed_y" = rocket_speed_y
	}

func set_weapon_status(new_value):
	weapon_status = new_value
	Events.WEAPON_STATUS_CHANGED.emit(weapon_status)

func get_weapon_status():
	return weapon_status
