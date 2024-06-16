extends RigidBody2D

@export var speed = 75
@export var wander_time = 1.5
@export var wander_time_float = 0.5
@export var stand_time = 2
@export var stand_time_float = 0.5

var battle = preload("res://battle/battle.tscn")

var screen_size
var collision_size
var stand # 游走休息状态
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	# 获取变量
	screen_size = get_viewport_rect().size
	collision_size = $Collision.shape.size / 2
	
	# 设置游走时间计时器
	$StandTimer.wait_time = stand_time + 2 * (randf() - 0.5) * stand_time_float
	$StandTimer.start()
	stand = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO + collision_size, screen_size - collision_size)
	if stand:
		$AnimatedSprite2D.play("stand")
	else:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		$AnimatedSprite2D.play("run")
		
func _physics_process(delta):
	# 运动
	# move_toward(velocity.x, velocity.y, speed)
	move_and_collide(speed * velocity * delta)

		

func _on_stand_timer_timeout():
	$StandTimer.stop()
	$WanderTimer.wait_time = wander_time + 2 * (randf() - 0.5) * wander_time_float
	$WanderTimer.start()
	stand = false
	velocity = Vector2(randf() - 0.5, randf() - 0.5)
	velocity = velocity.normalized()



func _on_wander_timer_timeout():
	$WanderTimer.stop()
	$StandTimer.wait_time = stand_time + 2 * (randf() - 0.5) * stand_time_float
	$StandTimer.start()
	stand = true
	velocity = Vector2.ZERO

func _on_detect_region_body_entered(body):
	if body is Player:
		print("Player entered Enemy...")
		var battleTemp = battle.instantiate()
		get_parent().add_child(battleTemp)
		queue_free()

func _on_detect_region_body_exited(body):
	if body is Player:
		print("Player exited Enemy...")
