extends CharacterBody2D

@onready var box = $Box
@onready var timer = $Timer
@onready var health_bar = $"Health Bar"
@onready var sprite = $"Unit Sprite"
@onready var collision_box = $CollisionBox
@onready var target = position
@export var pop_count = 1
@export var speed = 200.0
@export var max_health = 4
@export var attack_damage = 1
@export var t_rex = false
var follow_cursor = false
var rallyPoint = Vector2()
var mouseEntered = false
var selected = false
var health
var is_attacking = false
var enemies = []

func _ready() -> void:
	health_bar.visible = false
	health_bar.max_value = max_health
	health = max_health
	set_selected(selected)
	Game.friendly_pop += pop_count

func _process(delta: float) -> void:
	if (len(enemies) > 0) and !is_attacking:
		is_attacking = true
		timer.start()
	
	health_bar.value = health
	if health < max_health:
		health_bar.visible = true
	if health <= 0:
		Game.friendly_pop -= pop_count
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
	
	if position.x > target.x:
		sprite.flip_h = true
		if t_rex == true:
			collision_box.rotation_degrees = 120.0
	else:
		sprite.flip_h = false
		if t_rex == true:
			collision_box.rotation_degrees = 60.0
	
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
		enemies[0].health -= attack_damage
	is_attacking = false

func _on_timer_timeout() -> void:
	fighting()

func first_move():
	target = rallyPoint
