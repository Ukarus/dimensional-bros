extends Area2D

class_name Plate

@export var door_to_open : String
@export var object_to_animate : String
@export var can_be_activated : bool = true
@onready var interact_label = $Label
@onready var animation_player = $AnimationPlayer
@onready var audio_stream = $AudioStreamPlayer
@onready var fail_sound = $FailSound
var is_down : bool = false

signal plate_triggered

func _ready():
	interact_label.hide()
	
func trigger_action():
	if can_be_activated:
		interact_label.hide()
		if !is_down:
			animation_player.play("plate_down")
			audio_stream.play()
		else:
			animation_player.play("idle")
		is_down = !is_down
	else:
		fail_sound.play()

func emit_plate_triggered():
	emit_signal("plate_triggered", door_to_open, object_to_animate)

func _on_body_entered(body):
	interact_label.show()
	body.set_current_item(self)
#	if can_be_activated:

func _on_body_exited(body):
	interact_label.hide()
	body.unset_current_item()
