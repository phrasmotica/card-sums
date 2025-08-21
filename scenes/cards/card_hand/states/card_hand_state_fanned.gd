class_name CardHandStateFanned
extends CardHandState

func _enter_tree() -> void:
	print("%s is now fanned" % _card_hand.name)

	SignalHelper.persist(_card_manager.captured, _on_captured)
	SignalHelper.persist(_card_manager.dragged, _on_dragged)

	SignalHelper.persist(CardEvents.card_dropped, _on_dropped)
	SignalHelper.persist(CardEvents.receptacle_opened, _on_receptacle_opened)

	_card_manager.enable_all_cards()

func _on_captured(card: Card) -> void:
	_card_renderer.add_card(card)

func _on_dragged(_card: Card) -> void:
	transition_state(CardHand.State.PAUSED)

func _on_dropped(card: Card) -> void:
	# notify that the card is changing owners
	CardEvents.emit_card_moved(card)

	# recapture the card into this hand. The dropped card might have previously
	# been in a receptacle
	# TODO: only do this in a new state, which is entered when the mouse is
	# holding a card nearby... show a gap (empty pivot!) where the card would
	# end up after being dropped
	_card_manager.capture_card(card)

func _on_receptacle_opened() -> void:
	transition_state(CardHand.State.PAUSED)

func refresh_appearance(card_hand_data: CardHandData) -> void:
	_card_renderer.render_hand(card_hand_data)
