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
var renderer: CardRenderer

func _ready() -> void:
	if renderer:
		SignalHelper.persist(renderer.cleanup_finished, _on_cleanup_finished)

func _refresh() -> void:
	if renderer:
		renderer.fan_hand(fan_distance, separation_angle)

func _on_cleanup_finished(count: int) -> void:
	separation_angle = lerpf(5.0, 40.0, ease((10 - count) / 10.0, 2.0))
