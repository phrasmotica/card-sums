class_name CardStateDisabled
extends CardState

func _enter_tree() -> void:
	print("%s is now disabled" % _card.name)

func enable() -> void:
	transition_state(Card.State.INACTIVE)
