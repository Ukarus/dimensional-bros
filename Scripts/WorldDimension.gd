extends Node2D

## Maximum time for the dimension to be completed
## The unit is in seconds
@export var time_limit : int = 300

@onready var time_label = $UILayer/Label
@onready var timer = $Timer
@onready var is_dimension_active : bool = true
@onready var items = $Items.get_children()
var current_time : int = 0
var current_plate =  null

# Called when the node enters the scene tree for the first time.
func _ready():
	current_time = time_limit
	update_time_label()
	if is_dimension_active:
		timer.start()

func update_time_label() -> void:
	time_label.text = "{time}".format({"time": current_time})

func start_timer() -> void:
	timer.start()
	
func stop_timer() -> void:
	timer.stop()

func set_current_plate(plate):
	current_plate = plate

func open_door(door_path: String):
	var door = get_node(door_path)
	if door:
		door.open()

func _on_timer_timeout():
	current_time -= 1
	update_time_label()
