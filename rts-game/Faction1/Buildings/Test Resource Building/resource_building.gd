extends StaticBody2D

@onready var bar = $ProgressBar
@onready var timer = $Timer
var maxTime = 100
var currTime

func _ready() -> void:
	currTime = 0
	bar.max_value = maxTime
	timer.start()

func _process(delta: float) -> void:
	if currTime >= maxTime:
		resourceCollected()

func _on_timer_timeout() -> void:
	currTime += 1
	var tween = get_tree().create_tween()
	tween.tween_property(bar, "value", currTime, 0.5).set_trans(Tween.TRANS_LINEAR)

func resourceCollected():
	Game.resorces += 10
	_ready()
