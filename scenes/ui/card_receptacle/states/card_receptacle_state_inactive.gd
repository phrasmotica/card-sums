class_name CardReceptacleStateInactive
extends CardReceptacleState

func _enter_tree() -> void:
	print("CardReceptacle is now inactive")

	_appearance.for_inactive()

	SignalHelper.persist(_interaction.mouse_entered, _on_mouse_entered)

func _on_mouse_entered() -> void:
	transition_state(CardReceptacle.State.WAITING)
