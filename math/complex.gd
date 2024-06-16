# Complex.gd
extends Node

static func multiply(a:Vector2, b:Vector2):
	return Vector2(
		a.x * b.x - a.y * b.y,
		a.x * b.y + a.y * b.x
	)

static func num_multiply(a:Vector2, b:float):
	return Vector2(
		a.x * b , a.y * b
	)

static func norm(a:Vector2):
	return sqrt(a.x * a.x + a.y * a.y)

static func pow(a:Vector2, b:float):
	var r = norm(a)
	var theta = atan2(a.y, a.x)
	var result = Vector2(
		pow(r, b) * cos(b * theta),
		pow(r, b) * sin(b * theta)
	)
	return result
	
static func clip(a: Vector2, min: float, max: float) -> Vector2:
	return Vector2(
		clamp(a.x, min, max),
		clamp(a.y, min, max)
	)
	
static func check_ge_0(a: Vector2):
	return a.x >= 0 and a.y >= 0
