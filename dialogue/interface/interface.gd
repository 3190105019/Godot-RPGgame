extends Control

var dialogue_node: Node = null
var talking = false

func _ready() -> void:
	visible = false


func show_dialogue(player, dialogue: Node) -> void:
	visible = true
	dialogue_node = dialogue

	for c in dialogue.get_signal_connection_list("dialogue_started"):
		if player == c.callable.get_object():
			dialogue_node.start_dialogue()
			$Name.text = "[center]" + dialogue_node.dialogue_name + "[/center]"
			$Text.text = dialogue_node.dialogue_text
			return

	dialogue_node.dialogue_started.connect(player.set_active.bind(false))
	dialogue_node.dialogue_finished.connect(player.set_active.bind(true))
	dialogue_node.dialogue_finished.connect(hide)
	dialogue_node.dialogue_finished.connect(_on_dialogue_finished.bind(player))
	dialogue_node.start_dialogue()
	$Name.text = "[center]" + dialogue_node.dialogue_name + "[/center]"
	$Text.text = dialogue_node.dialogue_text
	talking = true
	
func next_dialogue() -> void:
	dialogue_node.next_dialogue()
	$Name.text = "[center]" + dialogue_node.dialogue_name + "[/center]"
	$Text.text = dialogue_node.dialogue_text
		
func _process(delta):
	if talking and Input.is_action_just_pressed("ui_accept"):
		next_dialogue()

func _on_dialogue_finished(player) -> void:
	print("Talk end")
	visible = false
	talking = false
	dialogue_node.dialogue_started.disconnect(player.set_active)
	dialogue_node.dialogue_finished.disconnect(player.set_active)
	dialogue_node.dialogue_finished.disconnect(hide)
	dialogue_node.dialogue_finished.disconnect(_on_dialogue_finished)
