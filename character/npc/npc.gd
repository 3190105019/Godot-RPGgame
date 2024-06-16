extends StaticBody2D

var wait_interact = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# 检测交互
	if wait_interact and !%Player/Node2D/Dialogue.talking:
		if Input.is_action_just_pressed("ui_accept"):
			%Player.active = false # 禁用玩家移动
			# 此处写交互代码
			print("Interacting...")
			
			# 展示对话
			%Player/Node2D/Dialogue.show_dialogue(%Player, $DialoguePlayer)
			await $DialoguePlayer.dialogue_finished
			
			# 结束对话
			wait_interact  = false # 避免重复对话
			%Player.active = true # 恢复玩家移动
			print("Talk finished")
	
	# 精灵动画
	$AnimatedSprite2D.play("idle")

func _on_detect_region_body_entered(body):
	if body is Player:
		wait_interact = true
		print("Player entered...")


func _on_detect_region_body_exited(body):
	if body is Player:
		wait_interact = false
		print("Player exited...")
