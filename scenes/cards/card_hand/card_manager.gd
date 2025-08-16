@tool
class_name CardManager
extends Node

@export
var cards: Array[Card] = []

func get_pivots() -> Array[Node2D]:
	var pivots: Array[Node2D] = []

	for c in cards:
		pivots.append(c.get_parent() as Node2D)

	return pivots
