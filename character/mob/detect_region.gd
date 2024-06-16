extends Area2D

@export var detect_size = 10 # Units: pixelvar wait_interact = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent()
	var collision = parent.get_node("Collision")
	var detect_size_vec = Vector2(detect_size * 2, detect_size * 2)
	$DetectRegionShape.shape.size = collision.shape.size\
		 + Vector2(detect_size * 2, detect_size * 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
