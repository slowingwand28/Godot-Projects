extends CharacterBody2D

@export var selected = false
@onready var box = $Box

func _ready() -> void:
	set_selected(selected)

func set_selected(value):
	box.visible = value
