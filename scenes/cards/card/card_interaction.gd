class_name CardInteraction
extends Node

@export
var card_area: Area2D

signal mouse_entered
signal mouse_exited

func _ready() -> void:
	if card_area:
		SignalHelper.chain(card_area.mouse_entered, mouse_entered)
		SignalHelper.chain(card_area.mouse_exited, mouse_exited)
