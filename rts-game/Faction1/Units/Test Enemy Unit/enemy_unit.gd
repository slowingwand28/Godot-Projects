extends CharacterBody2D

var health = 5

func _process(delta: float) -> void:
	if health >= 0:
		queue_free()
