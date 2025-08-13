class_name CardHandStateClosed
extends CardHandState

func _enter_tree() -> void:
	print("%s is now closed" % _card_hand.name)
