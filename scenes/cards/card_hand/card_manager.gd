@tool
class_name CardManager
extends Node

@export
var cards: Array[Card] = []

func _ready() -> void:
	for c in cards:
		SignalHelper.persist(c.hovered, _on_hovered.bind(c))

func get_pivots() -> Array[Node2D]:
	var pivots: Array[Node2D] = []

	for c in cards:
		pivots.append(c.get_parent() as Node2D)

	return pivots

func _on_hovered(card: Card) -> void:
	for c in cards:
		if c != card:
			c.deactivate()
