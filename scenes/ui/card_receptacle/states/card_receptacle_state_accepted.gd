class_name CardReceptacleStateAccepted
extends CardReceptacleState

func _enter_tree() -> void:
	print("CardReceptacle is now accepted")

	_card_receptacle.theme_type_variation = "CardReceptacleContainerAccepted"

func cycle() -> void:
	transition_state(CardReceptacle.State.INACTIVE)
