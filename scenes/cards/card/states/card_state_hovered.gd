class_name CardStateHovered
extends CardState

func _enter_tree() -> void:
	print("%s is now hovered" % _card.name)
