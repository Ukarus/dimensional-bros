extends Node

const Player = preload("res://Scripts/Player.gd")
const DimensionViewport = preload("res://Scripts/DimensionViewport.gd")
const WorldDimension = preload("res://Scripts/WorldDimension.gd")

@export var victory_scene : PackedScene


@onready var pause_container = $PauseContainer
@onready var subviewport1 : DimensionViewport = $ViewportContainers/SubViewportContainer1/SubViewport
@onready var subviewport2 : DimensionViewport = $ViewportContainers/SubViewportContainer2/SubViewport2
@onready var light_dimension = $ViewportContainers/SubViewportContainer1/SubViewport/WorldLevel1
@onready var dark_dimension = $ViewportContainers/SubViewportContainer2/SubViewport2/DarkDimension
@onready var camera1 = $ViewportContainers/SubViewportContainer1/SubViewport/Camera1
@onready var camera2 = $ViewportContainers/SubViewportContainer2/SubViewport2/Camera2
@onready var p1 : Player = $ViewportContainers/SubViewportContainer1/SubViewport/WorldLevel1/Player
@onready var p2 : Player = $ViewportContainers/SubViewportContainer2/SubViewport2/DarkDimension/Player

@onready var light_dimension_victory_zone =  $ViewportContainers/SubViewportContainer1/SubViewport/WorldLevel1/VictoryZone
@onready var dark_dimension_victory_zone =  $ViewportContainers/SubViewportContainer2/SubViewport2/DarkDimension/VictoryZone

var active_player
var dimensions_completed = 0

func _ready():
	pause_container.hide()
	camera1.target = p1
	camera2.target = p2
	p2.is_active_player = false
	# The light dimension will be the first active when entering the scene
	switch_dimensions(subviewport2, subviewport1)
	dark_dimension.is_dimension_active = false
	switch_timers(dark_dimension, light_dimension)
	
	camera1.set_camera_limits(
		-50,
		6000,
		-1800,
		235
	)
	
	camera2.set_camera_limits(
		-4290,
		200,
		-1600,
		140
	)
	# Don't autostart timer
	#var lockers = dark_dimension.get_node("Lockers")
	#lockers.connect("lockers_puzzle_completed", on_lockers_puzzle_completed)
	
	var plates = light_dimension.get_node("Items").get_children()
	for p in plates:
		p.connect("plate_triggered", on_light_dimension_plate_triggered)
	dark_dimension.get_node("Plate").connect("plate_triggered", on_lockers_puzzle_completed)
	light_dimension_victory_zone.connect("dimension_completed", on_light_dimension_completed)
	dark_dimension_victory_zone.connect("dimension_completed", on_dark_dimension_completed)
	
func _process(delta):
	if Input.is_action_just_pressed("switch_dimension") and dimensions_completed == 0:
		if p1.is_active_player:
			switch_to_dark_dimension()
		else:
			switch_to_light_dimension()	
	
	if dimensions_completed == 2 and victory_scene:
		get_tree().change_scene_to_packed(victory_scene)
		
	if Input.is_action_just_pressed("ui_cancel"):
		if pause_container.is_visible_in_tree():
			pause_container.hide()
			get_tree().paused = false
		else:
			pause_container.show()
			get_tree().paused = true
		
func on_light_dimension_plate_triggered(door_to_open: String, object_to_animate: String):
	if object_to_animate == "door":
		dark_dimension.open_door(door_to_open)
	elif object_to_animate == "platform":
		dark_dimension.animate_platform(door_to_open)
		

func switch_players(from: Player, to: Player) -> void:
	from.is_active_player = false
	from.stop_movement()
	to.is_active_player = true
	
func switch_dimensions(from: DimensionViewport, to: DimensionViewport) -> void:
	from.show_shadow()
	to.hide_shadow()

func switch_timers(from: WorldDimension, to: WorldDimension) -> void:
	from.stop_timer()
	to.start_timer()
	
func on_lockers_puzzle_completed(door_to_open: String, object_to_animate: String):
	light_dimension.animate_platform(door_to_open)
#	var platform = light_dimension.get_node("GrassPlatform")
#	if platform:
#		platform.animate_platform()
		
func switch_to_dark_dimension():
	switch_players(p1, p2)
	switch_dimensions(subviewport1, subviewport2)
	switch_timers(light_dimension, dark_dimension)
	dark_dimension.is_dimension_active = true
	
func switch_to_light_dimension():
	switch_players(p2, p1)
	switch_dimensions(subviewport2, subviewport1)
	switch_timers(dark_dimension, light_dimension)
	light_dimension.is_dimension_active = true

func on_light_dimension_completed():
	light_dimension.is_dimension_completed = true
	subviewport1.show_shadow()
	subviewport1.get_node("ShadowLayer/CenterContainer").show()
	switch_to_dark_dimension()
	dimensions_completed += 1

func on_dark_dimension_completed():
	dark_dimension.is_dimension_completed = true
	subviewport2.show_shadow()
	subviewport2.get_node("ShadowLayer/CenterContainer").show()
	switch_to_light_dimension()
	dimensions_completed += 1


func _on_resume_button_pressed():
	pause_container.hide()
	get_tree().paused = false


func _on_quit_button_pressed():
	get_tree().quit()
