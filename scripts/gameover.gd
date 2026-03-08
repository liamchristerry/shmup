extends Control


@onready var score: int
@onready var score_label = $Panel/Score

func _ready() -> void:
	set_gameover_score()

func set_gameover_score():
	var player_stats = Stat.get_player_stats()
	score = player_stats["player_score"]
	score_label.text = str("SCORE: ", score)

func _on_retry_button_pressed() -> void:
	Stat.reset_stats()
	get_tree().reload_current_scene()
