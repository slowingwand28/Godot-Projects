extends Camera2D

var mousePos = Vector2()
var globalMousePos = Vector2()
var start = Vector2()
var startV = Vector2()
var end = Vector2()
var endV = Vector2()
var isDragging = false
signal area_selected
signal start_move_selection



func draw_area(s = true):
	$"../Panel".size = Vector2(abs(startV.x - endV.x), abs(startV.y - endV.y))
	var pos = Vector2()
	pos.x = min(startV.x, endV.x)
	pos.y = min(startV.y, endV.y)
	$"../Panel".position = pos
	$"../Panel".size *= int(s)
