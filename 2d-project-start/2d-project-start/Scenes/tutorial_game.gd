extends Node2D

var score = 0

func spawn_mob():
	var new_mob = preload("res://Scenes/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	new_mob.dead.connect(_on_dead)

func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true

func _on_dead():
	score += 1
	$Player/Camera2D/ScoreBoard.text = "Score: " + str(score)
