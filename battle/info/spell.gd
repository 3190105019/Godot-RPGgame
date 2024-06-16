extends Node
class_name Spell

@export var spell_name = ""
@export var properties = Vector4(1.0, 0.0, 0.0, 1.0)
@export var speicies:SpellSpecies

var Complex = preload("res://math/complex.gd")
var Matrix = preload("res://math/matrix.gd")

enum SpellSpecies{
	ATTACK,
	DEFENCE
}

func _init():
	properties = Vector4(1.0, 0.0, 0.0, 1.0)

func compute(attack):
	var result = Matrix.multiply(properties, attack)
	return result
