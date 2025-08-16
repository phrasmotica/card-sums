class_name CardReceptacleStateWaiting
extends CardReceptacleState

func _enter_tree() -> void:
	print("CardReceptacle is now waiting")

	_appearance.for_waiting()

	SignalHelper.persist(_interaction.mouse_exited, _on_mouse_exited)
	SignalHelper.persist(_interaction.mouse_clicked, _on_mouse_clicked)

	SignalHelper.persist(CardEvents.card_dropped, _on_card_dropped)

func _on_mouse_exited() -> void:
	transition_state(CardReceptacle.State.INACTIVE)

func _on_mouse_clicked() -> void:
	transition_state(CardReceptacle.State.ACCEPTED)

func _on_card_dropped(card: Card) -> void:
	var state_data := CardReceptacleStateData \
		.build() \
		.with_card(card)

	transition_state(CardReceptacle.State.ACCEPTED, state_data)
