class_name CardInteraction
extends Node

@export
var card_area: Area2D

signal mouse_entered
signal mouse_exited
signal mouse_hold_started
signal mouse_hold_ended

func _ready() -> void:
	if card_area:
		SignalHelper.chain(card_area.mouse_entered, mouse_entered)
		SignalHelper.chain(card_area.mouse_exited, mouse_exited)

		SignalHelper.persist(card_area.input_event, _on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton

		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			if mouse_event.is_released():
				mouse_hold_ended.emit()
			else:
				mouse_hold_started.emit()
