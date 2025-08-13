class_name CardHandStateFanned
extends CardHandState

func _enter_tree() -> void:
	print("%s is now fanned" % _card_hand.name)
