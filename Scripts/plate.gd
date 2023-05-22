extends Area2D

@export var door_to_open : String
@onready var interact_label = $Label
@onready var animation_player = $AnimationPlayer
var is_player_on_area = false
var is_down : bool = false

signal plate_triggered
signal on_trigger_item_area
signal on_trigger_item_exited

func _ready():
	interact_label.hide()
	
func trigger_action():
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
	is_player_on_area = true
	emit_signal("on_trigger_item_area", self)

func _on_body_exited(body):
	interact_label.hide()
	emit_signal("on_trigger_item_exited", null)
	is_player_on_area = false
