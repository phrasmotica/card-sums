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

		card.enable()

		SignalHelper.persist(card.hovered, _on_hovered.bind(card))
		SignalHelper.persist(card.unhovered, _on_unhovered.bind(card))

		# do this after the previous state has been freed
		SignalHelper.once_next_frame(
			func() -> void:
				_card_receptacle.mouse_filter = Control.MOUSE_FILTER_IGNORE
		)

func _on_hovered(card: Card) -> void:
	card.activate()

func _on_unhovered(card: Card) -> void:
	card.deactivate()
