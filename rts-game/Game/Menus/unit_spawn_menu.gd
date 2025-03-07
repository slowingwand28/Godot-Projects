extends Node2D

@onready var costLabel = $Label2
var unitCost = 0
signal spawn
var unitName = ""
@onready var spriteStandard = $"Placeholder Sprite"
@onready var spriteHeavy = $"Heavy Placeholder Sprite"
@onready var spriteFlying = $"Flying Placeholder Sprite"
@onready var spriteSuper = $"Super Placehoder Sprite"

func _ready() -> void:
	costLabel.text = "Costs " + str(unitCost) + " Resources"
	
	if unitName == "Standard":
		spriteStandard.visible = true
	elif unitName == "Heavy":
		spriteHeavy.visible = true
	elif unitName == "Flying":
		spriteFlying.visible = true
	elif unitName == "Super":
		spriteSuper.visible = true

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
