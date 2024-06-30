extends Node3D

var coin_count : int = 0
@export var coin_counter : RichTextLabel
@export var win_panel : Panel

var coin_text : String = "Coins: "

func _ready():
	coin_counter = $coin_counter
	coin_counter.text = coin_text + str(coin_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_child_exiting_tree(node):
	if node.is_in_group("coin"):
		print("Updating coin counter...")
		coin_count += 1
		print(str(coin_count))
		coin_counter.text = coin_text + str(coin_count)
		if coin_count == 19:
			win_panel.visible = true
