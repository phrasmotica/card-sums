class_name CardReceptacleStateAccepted
extends CardReceptacleState

func _enter_tree() -> void:
	print("CardReceptacle is now accepted")

	_appearance.for_accepted()

	_capture_card()

func _capture_card() -> void:
	var card := _state_data.get_card()
	if card:
		card.emit_captured()

		card.reparent(_card_receptacle)
		card.position = _card_receptacle.size / 2.0
		card.rotation = 0.0
