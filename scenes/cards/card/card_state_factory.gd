class_name CardStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		Card.State.DISABLED: CardStateDisabled,
		Card.State.INACTIVE: CardStateInactive,
		Card.State.HOVERED: CardStateHovered,
		Card.State.DRAGGING: CardStateDragging,
	}

func get_fresh_state(state: Card.State) -> CardState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
