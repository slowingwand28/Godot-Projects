extends CharacterBody2D

@export var selected = false
@onready var box = $Box
@onready var target = position
var follow_cursor = false
var speed = 150.0

func _ready() -> void:
	set_selected(selected)
	Game.friendly_pop += 1

func set_selected(value):
	selected = value
	box.visible = value

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RightClick"):
		follow_cursor = true
	if event.is_action_released("RightClick"):
		follow_cursor = false

func _physics_process(delta: float) -> void:
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 15:
		move_and_slide()
