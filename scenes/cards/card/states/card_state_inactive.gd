class_name CardStateInactive
extends CardState

func _enter_tree() -> void:
	print("%s is now inactive" % _card.name)
