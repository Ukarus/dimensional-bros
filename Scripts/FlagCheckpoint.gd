extends Area2D

@export var start_animation : String
@export var consumed_animation : String
@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_stream = $AudioStreamPlayer
var is_consumed : bool = false

signal checkpoint_consumed

# Called when the node enters the scene tree for the first time.
func _ready():
	if start_animation != null:
		animated_sprite.play(start_animation)

func _on_body_entered(body):
	if !is_consumed:
		animated_sprite.play(consumed_animation)
		audio_stream.play()
		is_consumed = true
		emit_signal("checkpoint_consumed", self)

