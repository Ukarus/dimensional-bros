extends Node

const Player = preload("res://Scripts/Player.gd")
const DimensionViewport = preload("res://Scripts/DimensionViewport.gd")

@onready var subviewport1 : DimensionViewport = $ViewportContainers/SubViewportContainer1/SubViewport
@onready var subviewport2 : DimensionViewport = $ViewportContainers/SubViewportContainer2/SubViewport2
@onready var camera1 = $ViewportContainers/SubViewportContainer1/SubViewport/Camera1
@onready var camera2 = $ViewportContainers/SubViewportContainer2/SubViewport2/Camera2
@onready var p1 : Player = $ViewportContainers/SubViewportContainer1/SubViewport/WorldLevel1/Player
@onready var p2 : Player = $ViewportContainers/SubViewportContainer2/SubViewport2/DarkDimension/Player2

var active_player

func _ready():
	camera1.target = p1
	camera2.target = p2
	p2.is_active_player = false
	switch_dimensions(subviewport2, subviewport1)
	
func _process(delta):
	if Input.is_action_just_pressed("switch_dimension"):
		if p1.is_active_player:
			switch_players(p1, p2)
			switch_dimensions(subviewport1, subviewport2)
		else:
			switch_players(p2, p1)
			switch_dimensions(subviewport2, subviewport1)

func switch_players(from: Player, to: Player) -> void:
	from.is_active_player = false
	to.is_active_player = true
	
func switch_dimensions(from: DimensionViewport, to: DimensionViewport) -> void:
	from.show_shadow()
	to.hide_shadow()

