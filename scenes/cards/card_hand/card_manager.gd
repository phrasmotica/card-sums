@tool
class_name CardManager
extends Node

@export
var renderer: CardRenderer

signal dragged(card: Card)

func _ready() -> void:
	assert(renderer)

	if Engine.is_editor_hint():
		return

	for c in renderer.cards:
		SignalHelper.persist(c.captured, _on_captured.bind(c))
		SignalHelper.persist(c.dragged, _on_dragged.bind(c))
		SignalHelper.persist(c.hovered, _on_hovered.bind(c))
		SignalHelper.persist(c.unhovered, _on_unhovered.bind(c))

func _on_captured(card: Card) -> void:
	renderer.render_captured(card)

	card.hovered.disconnect(_on_hovered.bind(card))
	card.unhovered.disconnect(_on_unhovered.bind(card))

func _on_dragged(card: Card) -> void:
	# TODO: prevent other cards from being activated while a card is being
	# dragged. Also, break this script apart... plenty of stuff in here should
	# be handled by the state machine instead
	dragged.emit(card)

func _on_hovered(card: Card) -> void:
	renderer.render_hovered(card)

func _on_unhovered(card: Card) -> void:
	renderer.render_unhovered(card)

func enable_all_cards() -> void:
	for c in renderer.cards:
		c.enable()

func disable_all_cards() -> void:
	for c in renderer.cards:
		c.deactivate()
		c.disable()

func capture_card(card: Card) -> void:
	print("%s adding card %s to hand" % [name, card.name])

	# TODO: recapture if the card isn't part of this hand
