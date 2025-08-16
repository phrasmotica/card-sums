class_name CardHandStatePaused
extends CardHandState

func _enter_tree() -> void:
	print("%s is now paused" % _card_hand.name)

	SignalHelper.persist(CardEvents.card_dropped, _on_dropped)
	SignalHelper.persist(CardEvents.receptacle_closed, _on_receptacle_closed)

	for c in _card_manager.cards:
		c.deactivate()
		c.disable()

func _on_dropped(_card: Card) -> void:
	_unpause()

func _on_receptacle_closed() -> void:
	_unpause()

func _unpause() -> void:
	transition_state(CardHand.State.FANNED)
