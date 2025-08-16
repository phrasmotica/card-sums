@tool
class_name CardIcon
extends Sprite2D

var ICONS := {
	Card.CardIcon.ANKH: preload("res://assets/sprites/ankh.png"),
	Card.CardIcon.ANUBIS: preload("res://assets/sprites/anubis.png"),
	Card.CardIcon.BASTET: preload("res://assets/sprites/bastet.png"),
	Card.CardIcon.COBRA: preload("res://assets/sprites/cobra.png"),
	Card.CardIcon.EYE: preload("res://assets/sprites/eye-of-horus.png"),
	Card.CardIcon.HORUS: preload("res://assets/sprites/horus.png"),
	Card.CardIcon.LOTUS: preload("res://assets/sprites/lotus.png"),
	Card.CardIcon.SCARAB: preload("res://assets/sprites/gold-scarab.png"),
}

@export
var icon := Card.CardIcon.ANKH:
	set(value):
		icon = value

		_refresh()

@export
var colour := Color.WHITE:
	set(value):
		colour = value

		_refresh()

var _shader: ShaderUpdater = null

func _ready() -> void:
	_shader = ShaderUpdater.new(material as ShaderMaterial)

	_refresh()

func _refresh() -> void:
	texture = ICONS[icon] as Texture2D

	if _shader:
		_shader.set_color("icon_colour", colour)
