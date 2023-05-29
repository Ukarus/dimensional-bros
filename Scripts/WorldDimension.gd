extends Node2D

## Maximum time for the dimension to be completed
## The unit is in seconds
@export var time_limit : int = 300
@export var losing_screen : PackedScene

@onready var time_label = $UILayer/Label
@onready var timer = $Timer
@onready var is_dimension_active : bool = true
@onready var is_dimension_completed : bool = false
@onready var items = $Items.get_children()
@onready var starting_position = $StartingPosition
@onready var player = $Player
@onready var checkpoints = $Checkpoints.get_children()
@onready var death_sound = $DeathSound
var current_time : int = 0
var current_plate =  null
var last_checkpoint : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	current_time = time_limit
	update_time_label()
	last_checkpoint = starting_position.position
	player.connect("reset_player_position", reset_player_position)
	connect_checkpoints()
	if is_dimension_active:
		timer.start()

func connect_checkpoints():
	for c in checkpoints:
		c.connect("checkpoint_consumed", on_checkpoint_consumed)

func update_time_label() -> void:
	time_label.text = "{time}".format({"time": current_time})

func start_timer() -> void:
	timer.start()
	
func stop_timer() -> void:
	timer.stop()

func set_current_plate(plate):
	current_plate = plate

func open_door(door_path: String):
	if door_path == "":
		return
	var door = get_node(door_path)
	if door:
		door.open()

func _on_timer_timeout():
	current_time -= 1
	if current_time <= 0 and losing_screen:
		get_tree().change_scene_to_packed(losing_screen)
	update_time_label()
	
func on_checkpoint_consumed(checkpoint: Area2D):
	last_checkpoint = checkpoint.position

func reset_player_position():
	if is_dimension_active:
		death_sound.play()
		player.position = last_checkpoint
		
func animate_platform(platform_path: String) -> void:
	get_node(platform_path).animate_platform()
