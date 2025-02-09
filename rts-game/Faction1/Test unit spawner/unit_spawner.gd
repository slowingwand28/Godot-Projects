extends StaticBody2D

var mouseEntered = false
@onready var select = $Box
var selected = false

func _process(delta: float) -> void:
	select.visible = selected

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("LeftClick")) and (mouseEntered == true):
		selected = !selected
		if selected == true:
			Game.spawnUnit()

func _on_mouse_entered() -> void:
	mouseEntered = true

func _on_mouse_exited() -> void:
	mouseEntered = false
