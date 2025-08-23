class_name CardHandStateWaiting
extends CardHandState

func _enter_tree() -> void:
	print("%s is now waiting" % _card_hand.name)

	_interaction.waiting_area.input_pickable = true

	_card_renderer.cards_up()

	SignalHelper.persist(
		_interaction.waiting_area_exited,
		_on_waiting_area_exited)

	SignalHelper.persist(CardEvents.card_dropped, _on_dropped)

	_card_manager.disable_all_cards()

func _on_waiting_area_exited() -> void:
	transition_state(CardHand.State.PAUSED)

func _on_dropped(card: Card) -> void:
	# notify that the card is changing owners
	CardEvents.emit_card_moved(card)

	# recapture the card into this hand. The dropped card might have previously
	# been in a receptacle
	# TODO: show a gap (empty pivot!) where the card would
	# end up after being dropped
	_card_manager.capture_card(card)
