extends Node2D

@onready var score_label =  $ScoreLabel

var score = 0:
	get:
		return score
	set(value):
		score = value
		score_label.text = "score: " + str(score)
		


func _on_ship_ship_destroyed():
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://GameOverScreen.tscn")
