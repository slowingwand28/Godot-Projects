extends Node

var friendly_pop = 0
var resorces = 0

@onready var spawner = preload("res://Game/Menus/spawn_menu.tscn")


func spawnUnit():
	var path = get_tree().get_root().get_node("World/UI")
	var spawnMenu = spawner.instantiate()
	path.add_child(spawnMenu)
