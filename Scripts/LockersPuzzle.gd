extends Node2D

# Condition: Make the 3 lockers of the same color (blue), 
# play an audio sound when player fulfills the condition

@export var plate_to_activate : Area2D


var lockers : Array[Locker]
var victory_condition = [
	"blue",
	"yellow",
	"green"
]
var is_puzzle_done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var lockers_node = get_children()
	print(lockers.size())
	for l in lockers_node:
		var locker = l as Locker
		lockers.append(locker)

func check_puzzle_completion() -> bool:
	var counter : int = 0
	for i in range(lockers.size()):
		if lockers[i].get_current_skin_color() == victory_condition[i]:
			counter += 1
	print(counter)
	return counter == victory_condition.size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_puzzle_done:
		var is_puzzle_completed = check_puzzle_completion()
		
		if is_puzzle_completed:
			is_puzzle_done = true
			if plate_to_activate != null:
				var p = plate_to_activate as Plate
				p.can_be_activated = true
			print('puzzle completed')
