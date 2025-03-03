extends CharacterBody2D

@onready var timer = $Timer
@onready var health_bar = $"Health Bar"
@export var speed = 200
@export var max_health = 4
@export var attack_damage = 1
var health
var is_attacking = false
var enemies = []

func _ready() -> void:
	health_bar.visible = false
	health_bar.max_value = max_health
	health = max_health

func _process(delta: float) -> void:
	if (len(enemies) > 0) and !is_attacking:
		is_attacking = true
		timer.start()
	
	health_bar.value = health
	if health < max_health:
		health_bar.visible = true
	if health <= 0:
		queue_free()

func fighting():
	if len(enemies) > 0:
		enemies[0].health -= attack_damage
	is_attacking = false

func _on_timer_timeout() -> void:
	fighting()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Friendly Units"):
		enemies.append(body)

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Friendly Units"):
		enemies.erase(body)
