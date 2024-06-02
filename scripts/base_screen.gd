extends Control

@onready var tree = $Tree
@onready var item_list = $ItemList

var fade_dur = 0.25

func _ready():
	visible = false
	modulate.a = 0.0
	
	get_tree().call_group("buttons", "set_disabled", true)
	
	if tree:
		var root = tree.create_item()
		root.set_selectable(0, false)
		root.set_text(0, "root")
		
		var dropdown = tree.create_item(root)
		dropdown.set_cell_mode(0, TreeItem.CELL_MODE_CHECK)
		dropdown.set_editable(0, true)
		dropdown.set_text(0, "test")

func appear():
	visible = true
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "modulate:a", 1.0, fade_dur)
	return tween

func disappear():
	get_tree().call_group("buttons", "set_disabled", true)
	
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "modulate:a", 0.0, fade_dur)
	return tween

func _on_tree_item_edited():
	var selected = tree.get_selected()
	if selected.is_checked(0):
		item_list.add_item("test")
	else: 
		item_list.remove_item(0)
	
