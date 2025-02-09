extends Node2D

@onready var friendly_units = get_tree().get_nodes_in_group("Friendly Units")


func _on_camera_area_selected(start, end) -> void:
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var units_in_area = get_units_in_area(area)
	for unit in friendly_units:
		unit.set_selected(false)
	for unit in units_in_area:
		unit.set_selected(true)

func get_units_in_area(area):
	var units = []
	for unit in friendly_units:
		if (unit.position.x > area[0].x) and (unit.position.x < area[1].x) and (unit.position.y > area[0].y) and (unit.position.y < area[1].y):
			units.append(unit)
	return units
