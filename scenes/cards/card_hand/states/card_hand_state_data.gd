class_name CardHandStateData

var _is_dragging := false

static func build() -> CardHandStateData:
	return CardHandStateData.new()

func with_is_dragging(is_dragging: bool) -> CardHandStateData:
	_is_dragging = is_dragging
	return self

func get_is_dragging() -> bool:
	return _is_dragging

