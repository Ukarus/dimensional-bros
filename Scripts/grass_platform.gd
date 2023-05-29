extends AnimatableBody2D

@export var animation_player : AnimationPlayer
	
func animate_platform():
	if animation_player:
		animation_player.play("move")
