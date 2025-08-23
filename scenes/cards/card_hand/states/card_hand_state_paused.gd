class_name CardHandStatePaused
extends CardHandState

func _enter_tree() -> void:
	print("%s is now paused, _is_dragging = %s" % [_card_hand.name, _state_data.get_is_dragging()])

	_card_renderer.cards_down()

	SignalHelper.persist(
		_interaction.waiting_area_entered,
		_on_waiting_area_entered)

	SignalHelper.persist(CardEvents.card_dropped, _on_dropped)
	SignalHelper.persist(CardEvents.receptacle_closed, _on_receptacle_closed)

	_card_manager.disable_all_cards()

func _on_waiting_area_entered() -> void:
	if _state_data.get_is_dragging():
		var state_data := CardHandStateData.build() \
			.with_is_dragging(true)

		transition_state(CardHand.State.WAITING, state_data)

func _on_dropped(_card: Card) -> void:
	_unpause()

func _on_receptacle_closed() -> void:
	if not _state_data.get_is_dragging():
		_unpause()

func _unpause() -> void:
	transition_state(CardHand.State.FANNED)
