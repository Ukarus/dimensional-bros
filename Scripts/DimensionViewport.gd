extends SubViewport

@onready var shadow_layer = $ShadowLayer

func show_shadow() -> void:
	shadow_layer.visible = true

func hide_shadow() -> void:
	shadow_layer.visible = false
