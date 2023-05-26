extends CharacterBody2D

@export var is_active_player = true
@onready var animation_player = $AnimationPlayer
@onready var sprite2d = $Sprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_item = null


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	if is_active_player:
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		if Input.is_action_just_pressed("trigger_action") and current_item != null:
			current_item.trigger_action()
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
			animation_player.play("walk")
			sprite2d.flip_h = true if direction == -1 else false
		else:
			animation_player.play("idle")
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	var collided = move_and_slide()
	if collided:
		var last_collider = get_last_slide_collision().get_collider()
		if last_collider.get_class() == "StaticBody2D" and last_collider.has_method("change_to_next_color"):
			last_collider.change_to_next_color()

func stop_movement():
	velocity = Vector2.ZERO
	animation_player.play("idle")

func set_current_item(item):
	current_item = item
	
func unset_current_item():
	current_item = null
