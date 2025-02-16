extends Node2D

@onready var unit = preload("res://Faction1/Units/Test unit/unit.tscn")
var housePos = Vector2()
@export var unitCost = 10

func _process(delta: float) -> void:
	if Game.resorces < unitCost:
		$Yes.disabled = true
	else:
		$Yes.disabled = false

func _on_yes_pressed() -> void:
	var randomPosX = randi_range(-100, 100)
	var randomPosY = randi_range(-100, 100)
	
	var path = get_tree().get_root().get_node("World/Friendly Units")
	var worldPath = get_tree().get_root().get_node("World")
	var newUnit = unit.instantiate()
	newUnit.position = Vector2((housePos.x + randomPosX), (housePos.y + randomPosY)) #housePos + Vector2(randomPosX, randomPosY)
	path.add_child(newUnit)
	worldPath.get_units()
	Game.resorces -= unitCost


func _on_no_pressed() -> void:
	var buildings = get_tree().get_root().get_node("World/Buildings")
	for i in buildings.get_child_count():
		if buildings.get_child(i).selected == true:
			buildings.get_child(i).selected = false
	queue_free()
