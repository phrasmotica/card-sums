class_name CardReceptacleInteraction
extends Node

@export
var receptacle: CardReceptacle

signal mouse_entered
signal mouse_exited
signal mouse_clicked

func _ready() -> void:
	if receptacle:
		SignalHelper.chain(receptacle.mouse_entered, mouse_entered)
		SignalHelper.chain(receptacle.mouse_exited, mouse_exited)

		SignalHelper.persist(receptacle.gui_input, _on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.is_released() and mouse_event.button_index == MOUSE_BUTTON_LEFT:
			mouse_clicked.emit()
