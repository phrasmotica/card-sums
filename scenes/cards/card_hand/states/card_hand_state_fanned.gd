class_name CardHandStateFanned
extends CardHandState

func _enter_tree() -> void:
	print("%s is now fanned" % _card_hand.name)

	SignalHelper.persist(_card_manager.dragged, _on_dragged)

	for c in _card_manager.cards:
		c.enable()

func _on_dragged(_card: Card) -> void:
	transition_state(CardHand.State.PAUSED)
