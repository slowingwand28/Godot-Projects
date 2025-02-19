extends CharacterBody2D

@export var selected = false
@onready var box = $Box
@onready var target = position
@export var speed = 200.0
var follow_cursor = false
var mouseEntered = false
var health = 5

func _ready() -> void:
	set_selected(selected)
	Game.friendly_pop += 1

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
	pass 

func _on_hitbox_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
