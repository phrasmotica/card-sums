class_name CardHandStateFanned
extends CardHandState

func _enter_tree() -> void:
	print("%s is now fanned" % _card_hand.name)

	SignalHelper.persist(CardEvents.card_dropped, _on_dropped)
	SignalHelper.persist(CardEvents.receptacle_opened, _on_receptacle_opened)

	_card_manager.enable_all_cards()

func _on_dropped(card: Card) -> void:
	# recapture the card into this hand. The dropped card might have previously
	# been in a receptacle
	_card_manager.capture_card(card)

func _on_receptacle_opened() -> void:
	transition_state(CardHand.State.PAUSED)
