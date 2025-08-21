@tool
class_name CardRenderer
extends Node

const RAISE_DISTANCE := 100.0

@export
var cards: Array[Card] = []

@export
var card_positions: CardPositions

@export
var pivot_parent: Node2D

@export
var debug_label: Label

var _card_factory := CardFactory.new()

var _hovered_cards: Array[Card] = []
var _pivots: Array[Node2D] = []
var _original_position := Vector2.ZERO

signal cleanup_finished(count: int)

func _ready() -> void:
	assert(pivot_parent)

	_pivots = get_pivots()
	_original_position = pivot_parent.position

func render_hand(card_hand: CardHandData) -> void:
	if card_hand:
		render_cards(card_hand.cards)

func render_cards(cards_data: Array[CardData]) -> void:
	if cards_data.size() > 0:
		var hand_size := cards_data.size()

		for i in hand_size:
			if i >= cards.size():
				create_pivot_with_new_card(cards_data, i)
			else:
				cards[i].card_data = cards_data[i]

		for p in get_pivots().slice(hand_size):
			p.queue_free()

		cards = cards.slice(0, hand_size)

	cleanup()

func create_pivot(index: int) -> Node2D:
	var pivot := Node2D.new()
	pivot.name = "CardPivot%d" % index

	pivot_parent.add_child(pivot)
	pivot_parent.move_child(pivot, index)

	pivot.owner = pivot_parent

	return pivot

func create_pivot_with_new_card(
	cards_data: Array[CardData],
	index: int,
) -> void:
	var pivot := create_pivot(index)

	var new_card := _card_factory.create(cards_data[index], "Card%d" % index)
	cards.append(new_card)

	pivot.add_child(new_card)
	new_card.owner = pivot_parent

func create_pivot_with_existing_card(
	card: Card,
	index: int,
) -> void:
	var pivot := create_pivot(index)

	cards.insert(index, card)

	card.reparent(pivot)
	card.owner = pivot_parent

func fan_hand(fan_distance: float, separation_angle: float) -> void:
	var card_pivots := get_pivots()

	var half_total_angle := (card_pivots.size() - 1) * separation_angle / 2.0

	for i in card_pivots.size():
		card_pivots[i].rotation_degrees = i * separation_angle - half_total_angle

		var card: Card = card_pivots[i].get_child(0)
		card.position = fan_distance * Vector2.UP

func cards_down() -> void:
	pivot_parent.position = _original_position

func cards_up() -> void:
	pivot_parent.position = _original_position + RAISE_DISTANCE * Vector2.UP

func forget_hovered_cards() -> void:
	_hovered_cards.clear()
	_update_hover(_hovered_cards)

func render_hovered(card: Card) -> void:
	_hovered_cards.append(card)
	_update_hover(_hovered_cards)

func render_unhovered(card: Card) -> void:
	_hovered_cards.erase(card)
	_update_hover(_hovered_cards)

func add_card(card: Card) -> void:
	var index := card_positions.get_destination_index(cards, card)
	create_pivot_with_existing_card(card, index)

	cleanup()

func remove_card(card: Card) -> void:
	_hovered_cards.erase(card)
	_update_hover(_hovered_cards)

	cards.erase(card)

	# do cleanup once the card has been fully removed
	SignalHelper.once_next_frame(cleanup)

func _update_hover(hovered_cards: Array[Card]) -> void:
	hovered_cards.sort_custom(_sort_top_to_bottom)

	var has_hovered := hovered_cards.size() > 0

	for c in cards:
		if has_hovered and c == hovered_cards[0]:
			c.activate()
		else:
			c.deactivate()

	if debug_label:
		if has_hovered:
			debug_label.text = "[%s]" % _compute_debug_text(hovered_cards)
		else:
			debug_label.text = "[]"

func _compute_debug_text(hovered_cards: Array[Card]) -> String:
	return hovered_cards \
		.map(func(c): return str(get_card_index(c))) \
		.reduce(func(s, t): return "%s, %s" % [s, t])

func _sort_top_to_bottom(c1: Card, c2: Card) -> bool:
	# the rightmost card is the topmost one. This implementation is good
	# enough for now...
	return get_card_index(c1) > get_card_index(c2)

func get_pivots() -> Array[Node2D]:
	var pivots: Array[Node2D] = []

	for c in cards:
		pivots.append(c.get_parent() as Node2D)

	return pivots

func cleanup() -> void:
	for p in _pivots:
		if p.get_child_count() <= 0:
			p.queue_free()

	_pivots = get_pivots()

	cleanup_finished.emit(cards.size())

func get_card_index(card: Card) -> int:
	return cards.find(card)
