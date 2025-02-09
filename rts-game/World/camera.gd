extends Camera2D

var zoomTarget:Vector2
@export var zoomSpeed = 10.0
@export var panSpeed = 1000.0

var mousePos = Vector2()
var mousePosGlobal = Vector2()
var start = Vector2()
var startV = Vector2()
var end = Vector2()
var endV = Vector2()
var isDragging = false
signal area_selected
@onready var box = $"../UI/Panel"

func _ready() -> void:
	zoomTarget = zoom

func _process(delta: float) -> void:
	Zoom(delta)
	Pan(delta)
	
	if Input.is_action_just_pressed("LeftClick"):
		start = mousePosGlobal
		startV = mousePos
		isDragging = true
	if isDragging:
		end = mousePosGlobal
		endV = mousePos
		draw_area()
	if Input.is_action_just_released("LeftClick"):
		if startV.distance_to(mousePos) > 20:
			end = mousePosGlobal
			endV = mousePos
			isDragging = false
			draw_area(false)
			area_selected.emit(start, end)
		else:
			end = start
			isDragging = false
			draw_area(false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal = get_global_mouse_position()

func draw_area(s = true):
	box.size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	box.position = pos
	box.size *= int(s)

func Zoom(delta):
	if Input.is_action_just_pressed("Zoom In"):
		zoomTarget *= 1.1
	if Input.is_action_just_pressed("Zoom Out"):
		zoomTarget *= 0.9
	zoom = zoom.slerp(zoomTarget, zoomSpeed * delta)

func Pan(delta):
	var panAmount = Vector2.ZERO
	if Input.is_action_pressed("Camera Right"):
		panAmount.x += 1
		print("D")
	if Input.is_action_pressed("Camera Left"):
		panAmount.x -= 1
		print("A")
	if Input.is_action_pressed("Camera Up"):
		panAmount.y -= 1
		print("W")
	if Input.is_action_pressed("Camera Down"):
		panAmount.y += 1
		print("S")
	panAmount = panAmount.normalized()
	position += panAmount * delta * panSpeed * (1 / zoom.x)
