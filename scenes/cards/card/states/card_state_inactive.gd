class_name CardStateInactive
extends CardState

func _enter_tree() -> void:
	print("%s is now inactive" % _card.name)

	SignalHelper.persist(_interaction.mouse_entered, _on_mouse_entered)

	_card.scale = Vector2.ONE

func _on_mouse_entered() -> void:
	# TODO: only do this transition if either no other card in the hand is
	# currently hovered, or if the currently hovered other card in the hand is
	# layered on top of it in the hand?
	transition_state(Card.State.HOVERED)

func disable() -> void:
	transition_state(Card.State.DISABLED)
