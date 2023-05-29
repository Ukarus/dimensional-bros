extends StaticBody2D
class_name Locker

enum SkinColor {Yellow, Blue, Green, Red}
@export var current_color : SkinColor = SkinColor.Blue
@onready var animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.play(get_current_skin_color())

func get_current_skin_color():
	match current_color:
		SkinColor.Blue:
			return "blue"
		SkinColor.Yellow:
			return "yellow"
		SkinColor.Red:
			return "red"
		SkinColor.Green:
			return "green"

func change_to_next_color():
	# blue, green, red, yellow
	if current_color == SkinColor.Blue:
		current_color = SkinColor.Green
	elif current_color == SkinColor.Green:
		current_color = SkinColor.Red
	elif current_color == SkinColor.Red:
		current_color = SkinColor.Yellow
	elif current_color == SkinColor.Yellow:
		current_color = SkinColor.Blue	
	animated_sprite.play(get_current_skin_color())




func _on_area_2d_body_entered(body):
	change_to_next_color()
