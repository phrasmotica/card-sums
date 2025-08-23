class_name CardHandStateFanned
extends CardHandState

var _is_dragging := false

func _enter_tree() -> void:
	print("%s is now fanned" % _card_hand.name)

	_interaction.waiting_area.input_pickable = true

	SignalHelper.persist(_card_manager.captured, _on_captured)
	SignalHelper.persist(_card_manager.dragged, _on_dragged)

	SignalHelper.persist(CardEvents.card_dragged, _on_dragged)
	SignalHelper.persist(CardEvents.receptacle_opened, _on_receptacle_opened)

	_card_manager.enable_all_cards()

func _on_captured(card: Card) -> void:
	_card_renderer.add_card(card)

func _on_dragged(_card: Card) -> void:
	_is_dragging = true

	CardEvents.receptacle_opened.disconnect(_on_receptacle_opened)

	_pause()

func _pause() -> void:
	var state_data := CardHandStateData.build() \
		.with_is_dragging(_is_dragging)

	transition_state(CardHand.State.PAUSED, state_data)

func _on_receptacle_opened() -> void:
	_pause()

func refresh_appearance(card_hand_data: CardHandData) -> void:
	_card_renderer.render_hand(card_hand_data)
