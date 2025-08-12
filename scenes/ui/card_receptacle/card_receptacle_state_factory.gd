class_name CardReceptacleStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		CardReceptacle.State.INACTIVE: CardReceptacleStateInactive,
		CardReceptacle.State.WAITING: CardReceptacleStateWaiting,
		CardReceptacle.State.ACCEPTED: CardReceptacleStateAccepted,
	}

func get_fresh_state(state: CardReceptacle.State) -> CardReceptacleState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
