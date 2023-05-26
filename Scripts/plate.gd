extends Area2D

class_name Plate

@export var door_to_open : String
@export var can_be_activated : bool = true
@onready var interact_label = $Label
@onready var animation_player = $AnimationPlayer
var is_down : bool = false

signal plate_triggered

func _ready():
	interact_label.hide()
	
func trigger_action():
	if can_be_activated:
		interact_label.hide()
		if !is_down:
			animation_player.play("plate_down")
		else:
			animation_player.play("idle")
		is_down = !is_down

func emit_plate_triggered():
	emit_signal("plate_triggered", door_to_open)

func _on_body_entered(body):
	interact_label.show()
	if can_be_activated:
		body.set_current_item(self)

func _on_body_exited(body):
	interact_label.hide()
	body.unset_current_item()
