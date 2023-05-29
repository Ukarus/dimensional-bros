extends Area2D

signal dimension_completed


func _on_body_entered(body):
	emit_signal("dimension_completed")
