@tool
class_name CardHandDesigner
extends Node

@export_range(100.0, 400.0)
var fan_distance := 100.0:
	set(value):
		fan_distance = value

		_refresh()

@export_range(5.0, 40.0)
var separation_angle := 10.0:
	set(value):
		separation_angle = value

		_refresh()

@export_group("Dependencies")

@export
var card_manager: CardManager

func _ready() -> void:
	if card_manager:
		SignalHelper.persist(card_manager.cleanup_finished, _on_cleanup_finished)

func _refresh() -> void:
	var card_pivots: Array[Node2D] = []

	if card_manager:
		card_pivots = card_manager.get_pivots()

	var half_total_angle := (card_pivots.size() - 1) * separation_angle / 2.0

	for i in card_pivots.size():
		card_pivots[i].rotation_degrees = i * separation_angle - half_total_angle

		var card: Card = card_pivots[i].get_child(0)
		card.position.y = -fan_distance

func _on_cleanup_finished(count: int) -> void:
	separation_angle = lerpf(5.0, 40.0, ease((10 - count) / 10.0, 2.0))
