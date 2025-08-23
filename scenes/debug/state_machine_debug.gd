class_name StateMachineDebug
extends VBoxContainer

@onready
var state_label: Label = %StateLabel

func update_text(state_name: String, state_value: int) -> void:
	if state_label:
		state_label.text = "%s (%d)" % [state_name, state_value]
