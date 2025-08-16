class_name CardHandStatePaused
extends CardHandState

func _enter_tree() -> void:
	print("%s is now paused" % _card_hand.name)

	SignalHelper.persist(CardEvents.card_dropped, _on_dropped)

	for c in _card_manager.cards:
		c.deactivate()
		c.disable()

func _on_dropped(card: Card) -> void:
	_card_manager.capture_card(card)

	transition_state(CardHand.State.FANNED)
