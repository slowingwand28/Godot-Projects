extends Node2D

@export var unitCost = 10
signal spawn

func _process(delta: float) -> void:
	if Game.resorces < unitCost:
		$Yes.disabled = true
	else:
		$Yes.disabled = false

func _on_yes_pressed() -> void:
	spawn.emit()
	Game.resorces -= unitCost

func _on_no_pressed() -> void:
	var buildings = get_tree().get_root().get_node("World/Buildings")
	for i in buildings.get_child_count():
		if buildings.get_child(i).selected == true:
			buildings.get_child(i).selected = false
	queue_free()
