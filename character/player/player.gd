class_name Player extends CharacterBody2D

@export var speed = 125
@export var print_debug_collision = true
var screen_size
var collision_size
var active = true # Player是否活动

# new_player使用Charater作为根节点可以碰撞

func _ready():
	# 获取变量值
	screen_size = get_viewport_rect().size
	collision_size = $Collision.shape.size / 2

	# 限制相机在场景内
	$Camera2D.limit_left = 0
	$Camera2D.limit_top = 0
	$Camera2D.limit_right = screen_size[0]
	$Camera2D.limit_bottom = screen_size[1]

func _process(delta):
	if active:
		# 定义角色速度向量
		velocity = Vector2.ZERO

		# 接收输入
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
		if Input.is_action_pressed("ui_down"):
			velocity.y += 1
		if Input.is_action_pressed("ui_up"):
			velocity.y -= 1
			
		# 精灵动画
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			if abs(velocity.x) > abs(velocity.y):
				$AnimatedSprite2D.play("walk")
				$AnimatedSprite2D.flip_h = velocity.x < 0
			else:
				if velocity.y < 0:
					$AnimatedSprite2D.play("walk_up")
				else:
					$AnimatedSprite2D.play("walk_down")
		else:
			$AnimatedSprite2D.play("stand")

func _physics_process(delta):
	# 速度归一化
	velocity = velocity.normalized()
	
	# 打印碰撞信息
	var collision = move_and_collide(speed * velocity * delta)
	if collision and print_debug_collision:
		print("I collided with ", collision.get_collider().name)

	# Using move_and_slide.
	move_and_slide()
	
	for i in get_slide_collision_count():
		collision = get_slide_collision(i)
		print("I collided with ", collision.get_collider().name)
		
	pass

func set_active(is_active):
	active = is_active
