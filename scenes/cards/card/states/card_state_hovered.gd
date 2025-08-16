class_name CardStateHovered
extends CardState

func _enter_tree() -> void:
	print("%s is now hovered" % _card.name)

	SignalHelper.persist(_interaction.mouse_exited, _on_mouse_exited)
	SignalHelper.persist(_interaction.mouse_hold_started, _on_mouse_hold_started)

	_card.scale = 1.1 * Vector2.ONE

func _on_mouse_exited() -> void:
	_card.emit_unhovered()

func _on_mouse_hold_started() -> void:
	transition_state(Card.State.DRAGGING)

func deactivate() -> void:
	transition_state(Card.State.INACTIVE)
