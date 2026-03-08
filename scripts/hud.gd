extends Control


@onready var score_label = $Score
@onready var score:int
@onready var lifebar = $LifeProgressBar
@onready var weaponlifebar = $WeaponProgressBar
var health

func _ready() -> void:
	Events.connect("PLAYER_SCORE_CHANGED", set_ui_score)
	Events.connect("PLAYER_HEALTH_CHANGED", set_ui_lives)
	Events.connect("WEAPON_STATUS_CHANGED", set_ui_weapon)

func set_ui_score(new_value: int):
	score_label.text = str("Score: ", new_value)

func set_ui_lives(new_value: int):
	#still using lives behind the scenes so this is really for UI proposes only.
	# Could change damage to be a value based on the emeny
	print(new_value)
	var player_stats = Stat.get_player_stats()
	health = player_stats["player_health"]
	lifebar.value = health

func set_ui_weapon(new_value):
	weaponlifebar.value = new_value
