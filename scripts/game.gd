extends Node2D


var score:int = 0: set = set_score
var gameoverscreen = preload("res://scenes/gameover.tscn")
@onready var uicontainer = $UI
@onready var hitsound = $AudioContainer/HitSound
@onready var playerdiesound = $AudioContainer/PlayerDieSound
@onready var gamemusic = $AudioContainer/GameMusic
@onready var pausemenu = $PauseMenu

func _ready() -> void:
	Events.connect("GAME_OVER", gameover)
	Events.connect("PLAYER_SCORE_CHANGED", set_score)
	Events.connect("PAUSE_GAME", set_game_state)
	play_music()
	var rannum = Random.get_random(0, 989893782732)
	print(rannum)

func set_score(new_value: int):
	if Audio.play_sound_efx == true:
		hitsound.play()

func gameover():
	if Audio.play_sound_efx == true:
		playerdiesound.play()
	await  get_tree().create_timer(1).timeout
	var gameoverinstance = gameoverscreen.instantiate()
	uicontainer.add_child(gameoverinstance)

func set_game_state(new_value):
	var gamestate = new_value
	if gamestate == true:
		pausemenu.visible = true
		get_tree().paused = true
	else:
		pausemenu.visible = false
		get_tree().paused = false
		
func play_music():
	if Audio.play_music == true:
		gamemusic.play()

func _on_resume_pressed() -> void:
	set_game_state(false)

func _on_quit_pressed() -> void:
	set_game_state(false)
	get_tree().change_scene_to_file("res://scenes/mainmenu.tscn")
