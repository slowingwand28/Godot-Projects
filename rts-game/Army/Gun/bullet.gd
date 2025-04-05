extends CharacterBody2D

var travelled_distance = 0
var aim = Vector2()
var speed
var attack_damage


func _physics_process(delta):
	const RANGE = 10000
	velocity += aim * speed * delta
	travelled_distance += speed * delta
	move_and_slide()
	if travelled_distance > RANGE: 
		queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Friendly Units"):
		body.health -= attack_damage
	queue_free()
