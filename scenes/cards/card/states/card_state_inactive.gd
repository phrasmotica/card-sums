class_name CardStateInactive
extends CardState

func _enter_tree() -> void:
	print("%s is now inactive" % _card.name)

	SignalHelper.persist(_interaction.mouse_entered, _on_mouse_entered)

	_card.scale = Vector2.ONE

func _on_mouse_entered() -> void:
	transition_state(Card.State.HOVERED)
