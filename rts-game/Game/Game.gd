extends Node

var friendly_pop = 0
var resorces = 0

@onready var spawner = preload("res://Game/Menus/spawn_menu.tscn")


func spawnUnit(position):
	var path = get_tree().get_root().get_node("World/UI")
	if not path.has_node("Spawn Menu"):
		var spawnMenu = spawner.instantiate()
		spawnMenu.housePos = position
		path.add_child(spawnMenu)
