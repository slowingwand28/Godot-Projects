extends Node2D

var friendly_units = []
var enemy_units = []
@onready var victory_screen = preload("res://Game/Menus/viscory_screen.tscn")

func _ready() -> void:
	get_units()
	enemy_units = get_tree().get_nodes_in_group("Enemy Units")

func _process(delta: float) -> void:
	if len(enemy_units) == 0:
		var path = get_tree().get_root().get_node("World/UI")
		var win_screen = victory_screen.instantiate()
		path.add_child(win_screen)
		get_tree().paused = true

func get_units():
	friendly_units = []
	friendly_units = get_tree().get_nodes_in_group("Friendly Units")

func _on_camera_area_selected(start, end) -> void:
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var units_in_area = get_units_in_area(area)
	for unit in units_in_area:
		unit.set_selected(true)

func get_units_in_area(area):
	var units = []
	get_units()
	for unit in friendly_units:
		if (unit.position.x > area[0].x) and (unit.position.x < area[1].x) and (unit.position.y > area[0].y) and (unit.position.y < area[1].y):
			units.append(unit)
	return units
