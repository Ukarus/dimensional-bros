extends Node

const Player = preload("res://Scripts/Player.gd")
const DimensionViewport = preload("res://Scripts/DimensionViewport.gd")
const WorldDimension = preload("res://Scripts/WorldDimension.gd")

@onready var subviewport1 : DimensionViewport = $ViewportContainers/SubViewportContainer1/SubViewport
@onready var subviewport2 : DimensionViewport = $ViewportContainers/SubViewportContainer2/SubViewport2
@onready var light_dimension = $ViewportContainers/SubViewportContainer1/SubViewport/WorldLevel1
@onready var dark_dimension = $ViewportContainers/SubViewportContainer2/SubViewport2/DarkDimension
@onready var camera1 = $ViewportContainers/SubViewportContainer1/SubViewport/Camera1
@onready var camera2 = $ViewportContainers/SubViewportContainer2/SubViewport2/Camera2
@onready var p1 : Player = $ViewportContainers/SubViewportContainer1/SubViewport/WorldLevel1/Player
@onready var p2 : Player = $ViewportContainers/SubViewportContainer2/SubViewport2/DarkDimension/Player

var active_player

func set_camera_limits(cam : Camera2D, world: Node2D):
	var map_limits = world.get_node("TileMap2").get_used_rect()
	var map_cellsize = 70
	print(map_limits)
	print(map_cellsize)
	cam.limit_left = map_limits.position.x * map_cellsize
	cam.limit_right = map_limits.end.x * map_cellsize
	cam.limit_top = map_limits.position.y * map_cellsize
	cam.limit_bottom = map_limits.end.y * map_cellsize

func _ready():
	camera1.target = p1
	camera2.target = p2
	p2.is_active_player = false
	# The light dimension will be the first active when entering the scene
	switch_dimensions(subviewport2, subviewport1)
	dark_dimension.is_dimension_active = false
	switch_timers(dark_dimension, light_dimension)
	# Don't autostart timer
#	set_camera_limits(camera1, light_dimension)
#	set_camera_limits(camera2, dark_dimension)
	
	var plates = light_dimension.get_node("Items").get_children()
	for p in plates:
		p.connect("plate_triggered", on_light_dimension_plate_triggered)
	
func _process(delta):
	if Input.is_action_just_pressed("switch_dimension"):
		if p1.is_active_player:
			switch_players(p1, p2)
			switch_dimensions(subviewport1, subviewport2)
			switch_timers(light_dimension, dark_dimension)
			dark_dimension.is_dimension_active = true
		else:
			switch_players(p2, p1)
			switch_dimensions(subviewport2, subviewport1)
			switch_timers(dark_dimension, light_dimension)
			light_dimension.is_dimension_active = true
			
func on_light_dimension_plate_triggered(door_to_open: String):
	dark_dimension.open_door(door_to_open)

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
	
