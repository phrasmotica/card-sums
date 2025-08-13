class_name CardStateDragging
extends CardState

func _enter_tree() -> void:
	print("%s is now dragging" % _card.name)
