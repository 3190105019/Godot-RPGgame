extends Node

enum Crystal{
	WHITE,
	YELLOW,
	ORANGE,
	BLACK,
	GREEN,
	PINK
}

enum EquipSpecies{
	WAND,
	SHIELD
}

@export var crystal:Crystal
@export var equip:EquipSpecies
@export var quality:float

func compute(attack:Vector2):
	if crystal == Crystal.WHITE:
		if equip == EquipSpecies.WAND:
			return attack + Vector2(100 * quality, 100 * quality)
		else:
			return attack - Vector2(100 * quality, 100 * quality)
	
	if crystal == Crystal.YELLOW:
		if equip == EquipSpecies.WAND:
			return 4 * quality * attack
		else:
			return 1. / (4. * quality) * attack
			
	if crystal == Crystal.ORANGE:
		if equip == EquipSpecies.WAND:
			return %Complex.pow(attack, 1 + quality)
		else:
			return %Complex.pow(attack, 1 - quality)
	
	if crystal == Crystal.BLACK:
		var result = Vector2(quality * attack.y, quality * attack.x)
		return result
		
	if crystal == Crystal.GREEN:
		return  %Complex.num_multiply(attack, -quality)
		
	if crystal == Crystal.PINK:
		return  %Complex.num_multiply(%Complex.pow(attack, 0.5), 10 * quality)
