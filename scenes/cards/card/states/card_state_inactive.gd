class_name CardStateInactive
extends CardState

func _enter_tree() -> void:
	print("%s is now inactive" % _card.name)

	SignalHelper.persist(_interaction.mouse_entered, _on_mouse_entered)
	SignalHelper.persist(_interaction.mouse_exited, _on_mouse_exited)

	_card.scale = Vector2.ONE

func _on_mouse_entered() -> void:
	_card.emit_hovered()

func _on_mouse_exited() -> void:
	_card.emit_unhovered()

func activate() -> void:
	transition_state(Card.State.HOVERED)

func disable() -> void:
	transition_state(Card.State.DISABLED)
