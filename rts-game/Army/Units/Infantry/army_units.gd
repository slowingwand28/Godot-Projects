extends CharacterBody2D

@onready var timer = $Timer
@onready var health_bar = $ProgressBar
@export var max_health = 2
@export var attack_damage = 1
var health
var reloading = false
var enemies = []

func _ready() -> void:
	health_bar.visible = false
	health_bar.max_value = max_health
	health = max_health

func _process(delta: float) -> void:
	if (len(enemies) > 0) and !reloading:
		reloading = true
		timer.start()
	
	health_bar.value = health
	if health < max_health:
		health_bar.visible = true
	if health <= 0:
		queue_free()

func fighting():
	if len(enemies) > 0:
		enemies[0].health -= attack_damage
	reloading = false

func _on_timer_timeout() -> void:
	#fighting()
	pass


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Friendly Units"):
		enemies.append(body)


func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Friendly Units"):
		enemies.erase(body)
