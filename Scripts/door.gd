extends AnimatableBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func open():
	animated_sprite.play("door_open")
	collision_shape.disabled = true

func close():
	animated_sprite.play("door_closed_blue")
	collision_shape.disabled = false
