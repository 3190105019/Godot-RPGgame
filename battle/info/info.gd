extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	# 根据上限赋值状态
	$Attribute.hp = $AttributeLimit.hp
	$Attribute.sp = $AttributeLimit.sp
	$Attribute.atk = $AttributeLimit.atk
	$Attribute.def = $AttributeLimit.def
	
	print()
	
# 判断是否可以施法并扣除法术代价
func chant(spell:Spell):
	# 如果各项施法后均大于零
	if %Complex.check_ge_0($Attribute.hp - spell.get_node("AttributeCost").hp) and\
	%Complex.check_ge_0($Attribute.sp - spell.get_node("AttributeCost").sp) and\
	%Complex.check_ge_0($Attribute.atk - spell.get_node("AttributeCost").atk) and\
	%Complex.check_ge_0($Attribute.def - spell.get_node("AttributeCost").def):
		$Attribute.hp -= spell.get_node("AttributeCost").hp
		$Attribute.sp -= spell.get_node("AttributeCost").sp
		$Attribute.atk -= spell.get_node("AttributeCost").atk
		$Attribute.def -= spell.get_node("AttributeCost").def
		return true
	else:
		return false

func attack(spell:Spell):
	if spell.speicies == spell.SpellSpecies.ATTACK:
		var spell_output = spell.compute($Attribute.atk)
		var damage = $Wand.compute(spell_output)
		return damage
	else:
		return Vector2.ZERO
	
func defence(spell:Spell, damage:Vector2):
	# 防御魔法进行防御计算			
	if spell.speicies == spell.SpellSpecies.DEFENCE:
		damage = spell.compute(damage)
		
	damage = %Complex.clip($Sheild.compute(damage) - $Attribute.def, 0, 10000)
	$Attribute.hp -= damage
	return damage
