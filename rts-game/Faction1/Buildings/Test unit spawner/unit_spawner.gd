extends StaticBody2D

var mouseEntered = false
@onready var select = $Box
@onready var bar = $ProgressBar
@onready var timer = $Timer
var selected = false
var maxTime = 100
var currTime = 0 
var que = 0
var spawning = false

@onready var menu = preload("res://Game/Menus/unit_spawn_menu.tscn")
@onready var unit = preload("res://Faction1/Units/Test unit/unit.tscn")

func _process(delta: float) -> void:
	select.visible = selected
	
	if (que > 0) and (spawning == false):
		spawning = true
		startTimer()
		
	if currTime >= maxTime:
		spawnUnit()
		spawning = false

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("LeftClick")) and (mouseEntered == true):
		selected = !selected
		if selected == true:
			openMenu()

func _on_mouse_entered() -> void:
	mouseEntered = true

func _on_mouse_exited() -> void:
	mouseEntered = false

func openMenu():
	var path = get_tree().get_root().get_node("World/UI")
	if not path.has_node("Unit Spawn Menu"):
		var spawnMenu = menu.instantiate()
		spawnMenu.connect("spawn", signal_recieved)
		path.add_child(spawnMenu)

func signal_recieved():
	que += 1

func startTimer():
	bar.visible = true
	timer.start()

func _on_timer_timeout() -> void:
	currTime += 1
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", currTime, 0.5).set_trans(Tween.TRANS_LINEAR)

func spawnUnit():
	timer.stop()
	currTime = 0
	bar.visible = false
	
	var randomPosX = randi_range(-100, 100)
	var randomPosY = randi_range(-100, 100)
	
	var path = get_tree().get_root().get_node("World/Friendly Units")
	var worldPath = get_tree().get_root().get_node("World")
	var newUnit = unit.instantiate()
	newUnit.position = Vector2((position.x + randomPosX), (position.y + randomPosY)) #housePos + Vector2(randomPosX, randomPosY)
	path.add_child(newUnit)
	worldPath.get_units()
	
	que -= 1
