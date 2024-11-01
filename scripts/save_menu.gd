extends FileDialog


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal file_and_dir_selected(selected_path, selected_dir)

func _on_file_selected(path: String) -> void:
	var selected_dir = current_dir # Replace with function body.
	var selected_path = current_path
	file_and_dir_selected.emit(selected_path, selected_dir)
