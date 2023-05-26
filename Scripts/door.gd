extends AnimatableBody2D

enum DoorColor {Blue, Yellow}

@export var door_color : DoorColor = DoorColor.Blue
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
var closed_animation : String

# Called when the node enters the scene tree for the first time.
func _ready():
	set_door_color()
	close()


func set_door_color():
	match door_color:
		DoorColor.Blue:
			closed_animation = "door_closed_blue"
		DoorColor.Yellow:
			closed_animation = "door_closed_yellow"


func open():
	animated_sprite.play("door_open")
	collision_shape.disabled = true

func close():
	animated_sprite.play(closed_animation)
	collision_shape.disabled = false
