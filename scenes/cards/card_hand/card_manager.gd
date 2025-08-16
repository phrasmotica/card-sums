@tool
class_name CardManager
extends Node

@export
var cards: Array[Card] = []

@export
var debug_label: Label

var _pivots: Array[Node2D] = []
var _hovered_cards: Array[Card] = []

var _card_factory := CardFactory.new()

signal cleanup_finished(count: int)

func _ready() -> void:
	_pivots = get_pivots()

	if Engine.is_editor_hint():
		return

	for c in cards:
		SignalHelper.persist(c.captured, _on_captured.bind(c))
		SignalHelper.persist(c.hovered, _on_hovered.bind(c))
		SignalHelper.persist(c.unhovered, _on_unhovered.bind(c))

	SignalHelper.persist(CardEvents.card_dropped, _on_card_dropped)

func inject(card_hand: CardHandData, parent: Node2D) -> void:
	# TODO: do this rendering in a separate script
	if card_hand:
		var hand_size := card_hand.cards.size()

		for i in hand_size:
			if i >= cards.size():
				var pivot := Node2D.new()
				pivot.name = "CardPivot%d" % i

				parent.add_child(pivot)
				pivot.owner = parent

				var new_card := _card_factory.create(card_hand.cards[i], "Card%d" % i)
				cards.append(new_card)

				pivot.add_child(new_card)
				new_card.owner = parent
			else:
				cards[i].card_data = card_hand.cards[i]

		for p in get_pivots().slice(hand_size):
			p.queue_free()

		cards = cards.slice(0, hand_size)

	_cleanup()

func get_pivots() -> Array[Node2D]:
	var pivots: Array[Node2D] = []

	for c in cards:
		pivots.append(c.get_parent() as Node2D)

	return pivots

func _on_captured(card: Card) -> void:
	_hovered_cards.erase(card)
	_refresh_hovered_card()

	card.hovered.disconnect(_on_hovered.bind(card))
	card.unhovered.disconnect(_on_unhovered.bind(card))

	cards.erase(card)

	# do cleanup once the captured card has been fully removed from here
	SignalHelper.once_next_frame(_cleanup)

func _cleanup() -> void:
	for p in _pivots:
		if p.get_child_count() <= 0:
			p.queue_free()

	_pivots = get_pivots()

	cleanup_finished.emit(cards.size())

func _on_hovered(card: Card) -> void:
	_hovered_cards.append(card)
	_refresh_hovered_card()

func _on_unhovered(card: Card) -> void:
	_hovered_cards.erase(card)
	_refresh_hovered_card()

func _refresh_hovered_card() -> void:
	_hovered_cards.sort_custom(_sort_top_to_bottom)

	var has_hovered := _hovered_cards.size() > 0

	for c in cards:
		if has_hovered and c == _hovered_cards[0]:
			c.activate()
		else:
			c.deactivate()

	if debug_label:
		if has_hovered:
			debug_label.text = "[%s]" % _compute_debug_text()
		else:
			debug_label.text = "[]"

func _compute_debug_text() -> String:
	return _hovered_cards \
		.map(func(c): return str(cards.find(c))) \
		.reduce(func(s, t): return "%s, %s" % [s, t])

func _sort_top_to_bottom(c1: Card, c2: Card) -> bool:
	# the rightmost card is the topmost one. This implementation is good
	# enough for now...
	return cards.find(c1) > cards.find(c2)

func _on_card_dropped(_card: Card) -> void:
		# TODO: add the card to this hand
# print("%s adding card %s to hand" % [name, card.name])
	pass
