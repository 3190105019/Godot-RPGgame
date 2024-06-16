extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	# 获取碰撞体大小
	var parent = get_parent()
	var collision = parent.get_node("Collision")
	size = collision.shape.size
	position = collision.position - size / 2
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
