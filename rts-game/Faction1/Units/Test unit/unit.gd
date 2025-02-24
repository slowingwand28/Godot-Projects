extends CharacterBody2D

@export var selected = false
@onready var box = $Box
@onready var timer = $Timer
@onready var health_bar = $"Health Bar"
@onready var target = position
@export var speed = 200.0
var follow_cursor = false
var mouseEntered = false
var max_health = 5
var health = 5
var is_attacking = false
var enemies = []

func _ready() -> void:
	health_bar.visible = false
	health_bar.max_value = max_health
	set_selected(selected)
	Game.friendly_pop += 1

func _process(delta: float) -> void:
	if (len(enemies) > 0) and !is_attacking:
		is_attacking = true
		timer.start()
	
	health_bar.value = health
	if health < max_health:
		health_bar.visible = true
	if health <= 0:
		queue_free()

func set_selected(value):
	selected = value
	box.visible = value

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("LeftClick")) and (mouseEntered == true):
		if selected == false:
			set_selected(true)
		else:
			set_selected(false)
	if (event.is_action_pressed("LeftClick")) and (mouseEntered == false):
		if selected == true:
			set_selected(false)
	
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	if event.is_action_released("RightClick"):
		follow_cursor = false

func _physics_process(delta: float) -> void:
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()

func _on_mouse_entered() -> void:
	mouseEntered = true

func _on_mouse_exited() -> void:
	mouseEntered = false

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy Units"):
		enemies.append(body)

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy Units"):
		enemies.erase(body)

func fighting():
	if len(enemies) > 0:
		enemies[0].health -= 1
	is_attacking = false

func _on_timer_timeout() -> void:
	fighting()
