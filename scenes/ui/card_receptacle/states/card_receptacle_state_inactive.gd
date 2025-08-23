class_name CardReceptacleStateInactive
extends CardReceptacleState

func _enter_tree() -> void:
	print("CardReceptacle is now inactive")

	_appearance.for_inactive()

	SignalHelper.persist(_interaction.mouse_entered, _on_mouse_entered)

	SignalHelper.persist(CardEvents.card_dropped, _on_card_dropped)

func _on_mouse_entered() -> void:
	transition_state(CardReceptacle.State.WAITING)

func _on_card_dropped(card: Card) -> void:
	print("%s capturing card %s" % [_card_receptacle.name, card.name])

	var state_data := CardReceptacleStateData \
		.build() \
		.with_card(card)

	transition_state(CardReceptacle.State.ACCEPTED, state_data)
