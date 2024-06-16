extends Node

@export var enemy_scene : PackedScene
@export var enemy_amount = 5

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = $SubViewportContainer/SubViewport/World.get_viewport_rect().size
	for i in range(enemy_amount):
		var enemy = enemy_scene.instantiate()
		var spawn_pos = Vector2(randf() * screen_size[0], randf() * screen_size[1])
		enemy.position = spawn_pos
		$SubViewportContainer/SubViewport/World.add_child(enemy)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
