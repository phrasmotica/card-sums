@tool
class_name CardHandDesigner
extends Node

@export_range(50.0, 200.0)
var fan_distance := 100.0:
	set(value):
		fan_distance = value

		_refresh()

@export_range(5.0, 20.0)
var separation_angle := 10.0:
	set(value):
		separation_angle = value

		_refresh()

@export_group("Dependencies")

@export
var card_pivots: Array[Node2D] = []

func _refresh() -> void:
	var half_total_angle := (card_pivots.size() - 1) * separation_angle / 2.0

	for i in card_pivots.size():
		card_pivots[i].rotation_degrees = i * separation_angle - half_total_angle

		var card: Card = card_pivots[i].get_child(0)
		card.position.y = -fan_distance
