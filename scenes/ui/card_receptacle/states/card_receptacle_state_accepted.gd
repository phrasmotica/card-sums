class_name CardReceptacleStateAccepted
extends CardReceptacleState

func _enter_tree() -> void:
	print("CardReceptacle is now accepted")

	_card_receptacle.theme_type_variation = "CardReceptacleContainerAccepted"

	SignalHelper.persist(_interaction.mouse_clicked, _on_mouse_clicked)

func _on_mouse_clicked() -> void:
	transition_state(CardReceptacle.State.INACTIVE)
