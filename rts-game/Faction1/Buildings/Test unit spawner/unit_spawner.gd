extends StaticBody2D

var mouseEntered = false
@onready var select = $Box
@onready var bar = $ProgressBar
@onready var timer = $Timer
var selected = false
var maxTime = 100
var currTime = 0 

@onready var menu = preload("res://Game/Menus/unit_spawn_menu.tscn")
@onready var unit = preload("res://Faction1/Units/Test unit/unit.tscn")

func _process(delta: float) -> void:
	select.visible = selected
	if currTime >= maxTime:
		timer.stop()
		spawnUnit()
		bar.visible = false

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
	if not self.has_node("Unit Spawn Menu"):
		var spawnMenu = menu.instantiate()
		spawnMenu.housePos = position
		self.add_child(spawnMenu)


func startTimer():
	currTime = 0
	bar.visible = true
	timer.start()

func _on_timer_timeout() -> void:
	currTime += 1
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", currTime, 0.5).set_trans(Tween.TRANS_LINEAR)

func spawnUnit():
	print("Spawn Unit")
