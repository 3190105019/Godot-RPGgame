# Matrix2D.gd
extends Node

static func multiply(a:Vector4, b:Vector2):
	return Vector2(
		a.x * b.x + a.y * b.y,
		a.z * b.x + a.w * b.y
	)
