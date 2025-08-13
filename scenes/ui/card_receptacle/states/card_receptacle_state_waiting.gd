class_name CardReceptacleStateWaiting
extends CardReceptacleState

func _enter_tree() -> void:
	print("CardReceptacle is now waiting")

	_card_receptacle.theme_type_variation = "CardReceptacleContainerWaiting"

func cycle() -> void:
	transition_state(CardReceptacle.State.ACCEPTED)
