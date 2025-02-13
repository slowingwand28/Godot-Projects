extends StaticBody2D

var mouseEntered = false
@onready var select = $Box
var selected = false
var maxTime = 100

@onready var menu = preload("res://Game/Menus/unit_spawn_menu.tscn")

func _process(delta: float) -> void:
	select.visible = selected

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("LeftClick")) and (mouseEntered == true):
		selected = !selected
		if selected == true:
			spawnUnit()

func _on_mouse_entered() -> void:
	mouseEntered = true

func _on_mouse_exited() -> void:
	mouseEntered = false

func spawnUnit():
	var path = get_tree().get_root().get_node("World/UI")
	if not path.has_node("Unit Spawn Menu"):
		var spawnMenu = menu.instantiate()
		spawnMenu.housePos = position
		path.add_child(spawnMenu)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
