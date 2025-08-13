class_name CardHandStateFactory

var states: Dictionary

func _init() -> void:
	states = {
		CardHand.State.CLOSED: CardHandStateClosed,
		CardHand.State.FANNED: CardHandStateFanned,
	}

func get_fresh_state(state: CardHand.State) -> CardHandState:
	assert(states.has(state), "State is missing!")
	return states.get(state).new()
