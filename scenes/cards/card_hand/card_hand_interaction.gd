class_name CardHandInteraction
extends Node

@export
var waiting_area: Area2D

signal waiting_area_entered
signal waiting_area_exited

func _ready() -> void:
	if waiting_area:
		SignalHelper.chain(waiting_area.mouse_entered, waiting_area_entered)
		SignalHelper.chain(waiting_area.mouse_exited, waiting_area_exited)
