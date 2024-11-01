extends Node2D
@onready var editor: CodeEdit = %Editor
@onready var path_setter: TextEdit = %PathSetter

var work_path := OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#OS.set_use_file_access_save_and_swap(true)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#
	if Input.is_action_just_pressed("Save"):
		save_file(editor.text)

func save_file(content):
	var file = FileAccess.open(work_path, FileAccess.WRITE_READ)
	print(work_path)
	file.store_string(content)

func load_file(path: String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var content = file.get_as_text()
		return content


func _on_path_setter_text_changed() -> void:
	work_path = path_setter.text # Replace with function body.


func _on_file_dialog_file_selected(path: String) -> void:
	print(path) # Replace with function body.
	if FileAccess.file_exists(path):
		editor.text = load_file(path)
	else:
		editor.text = ""
	work_path = path
	path_setter.text = work_path
