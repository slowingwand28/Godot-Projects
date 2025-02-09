extends Node2D

@onready var unit = preload("res://Faction1/Test unit/unit.tscn")
var housePos = Vector2(300,300)

func _on_yes_pressed() -> void:
	var randomPosX = randi_range(-50, 50)
	var randomPosY = randi_range(-50, 50)
	
	var path = get_tree().get_root().get_node("World/Friendly Units")
	var worldPath = get_tree().get_root().get_node("World")
	var newUnit = unit.instantiate()
	newUnit.position = housePos + Vector2(randomPosX, randomPosY)
	path.add_child(newUnit)
	worldPath.get_units()


func _on_no_pressed() -> void:
	queue_free()
