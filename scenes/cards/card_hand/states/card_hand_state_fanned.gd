class_name CardHandStateFanned
extends CardHandState

func _enter_tree() -> void:
	print("%s is now fanned" % _card_hand.name)

	_interaction.waiting_area.input_pickable = true

	SignalHelper.persist(_card_manager.captured, _on_captured)
	SignalHelper.persist(_card_manager.dragged, _on_dragged)

	SignalHelper.persist(CardEvents.receptacle_opened, _on_receptacle_opened)

	_card_manager.enable_all_cards()

func _on_captured(card: Card) -> void:
	_card_renderer.add_card(card)

func _on_dragged(_card: Card) -> void:
	transition_state(CardHand.State.PAUSED)

func _on_receptacle_opened() -> void:
	transition_state(CardHand.State.PAUSED)

func refresh_appearance(card_hand_data: CardHandData) -> void:
	_card_renderer.render_hand(card_hand_data)
