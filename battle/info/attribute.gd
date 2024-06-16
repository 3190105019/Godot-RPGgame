extends Node

enum Species{
	CREATURE,
	UNDEAD,
	GODS
}

@export var species:Species

@export var hp:Vector2
@export var sp:Vector2
@export var atk:Vector2
@export var def:Vector2

func _is_dead():
	if species == Species.CREATURE:
		return hp.x < 1.
	if species == Species.UNDEAD:
		return abs(hp.y) < 1.
	if species == Species.GODS:
		return %Complex.norm(hp) < 1.
