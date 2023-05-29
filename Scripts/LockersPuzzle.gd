extends Node2D

# Condition: Make the 3 lockers of the same color (blue), 
# play an audio sound when player fulfills the condition

@export var audio_stream : AudioStreamPlayer
@export var plate_to_activate : Area2D


var lockers : Array[Locker]
var victory_condition = [
	"blue",
	"yellow",
	"green"
]
var is_puzzle_done = false

signal lockers_puzzle_completed

func _ready():
	var lockers_node = get_children()
	# get all of the lockers scripts in an array
	for l in lockers_node:
		var locker = l as Locker
		lockers.append(locker)
#	plate_to_activate.connect("plate_triggered", on_plate_activated)

func check_puzzle_completion() -> bool:
	var lockers_colors = []
	for l in lockers:
		lockers_colors.append(l.get_current_skin_color())
	victory_condition.sort()
	lockers_colors.sort()
	return victory_condition == lockers_colors

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_puzzle_done:
		var is_puzzle_completed = check_puzzle_completion()
		# If the puzzle is completed
		if is_puzzle_completed:
			is_puzzle_done = true
			if audio_stream:
				audio_stream.play()
			if plate_to_activate != null:
				var p = plate_to_activate as Plate
				p.can_be_activated = true

#func on_plate_activated(door: String):
#	emit_signal("lockers_puzzle_completed")
