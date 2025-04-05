extends CharacterBody2D

@onready var timer = $Timer
@onready var health_bar = $ProgressBar
@export var max_health = 2
@export var bullet_damage = 2
@export var bullet_speed = 1000
@export var reload_time = 4
@onready var bullet = preload("res://Army/Gun/bullet.tscn")
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
		shoot()
	
	health_bar.value = health
	if health < max_health:
		health_bar.visible = true
	if health <= 0:
		queue_free()

func shoot():
	if len(enemies) > 0:
		var aim = self.global_position.direction_to(enemies[0].position)
		var path = get_tree().get_root().get_node("World/Bullets")
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = self.global_position
		new_bullet.aim = aim
		new_bullet.speed = bullet_speed
		new_bullet.attack_damage = bullet_damage
		path.add_child(new_bullet)
		timer.start(reload_time)
	

func _on_timer_timeout() -> void:
	reloading = false
	


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Friendly Units"):
		enemies.append(body)


func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Friendly Units"):
		enemies.erase(body)
