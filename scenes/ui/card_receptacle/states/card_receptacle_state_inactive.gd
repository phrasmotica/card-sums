class_name CardReceptacleStateInactive
extends CardReceptacleState

func _enter_tree() -> void:
	print("CardReceptacle is now inactive")

	_card_receptacle.theme_type_variation = "CardReceptacleContainer"

func cycle() -> void:
	transition_state(CardReceptacle.State.WAITING)
