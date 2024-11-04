extends Node2D
@onready var editor: CodeEdit = %Editor
@onready var path_setter: TextEdit = %PathSetter

var file_selected := false
var work_dir := OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
var work_path := OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
const SAVE_MENU := preload("res://scenes/save_menu.tscn")
const OPEN_MENU := preload("res://scenes/open_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#OS.set_use_file_access_save_and_swap(true)
	path_setter.text = work_path
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_hotkeys()
	

func create_or_save_file(content):
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

func _on_save_button_pressed() -> void:
	open_save_menu()


func _on_open_button_pressed() -> void:
	open_open_menu()

func _savefile_and_dir_selected(path: String, dir: String) -> void:
	work_path = path
	work_dir = dir
	create_or_save_file(editor.text)
	file_selected = true

func _openfile_and_dir_selected(path: String, dir: String) -> void:
	work_path = path
	work_dir = dir
	editor.text = load_file(work_path)
	file_selected = true

	
# Makes Editor ignore certain inputs
func _on_editor_gui_input(event):
	if !Input.is_action_just_pressed("save"): return;
	editor.accept_event()

func open_open_menu() -> void:
	var open_menu = OPEN_MENU.instantiate()
	add_child(open_menu)
	open_menu.connect("file_and_dir_selected", _openfile_and_dir_selected)
	open_menu.current_dir = work_dir
	open_menu.current_file = work_path
	
func open_save_menu() -> void:
	var save_menu = SAVE_MENU.instantiate()
	add_child(save_menu)
	save_menu.connect("file_and_dir_selected", _savefile_and_dir_selected)
	save_menu.current_dir = work_dir
	save_menu.current_file = work_path
	
func process_hotkeys() -> void:
	if Input.is_action_just_pressed("save"):
		if file_selected:
			create_or_save_file(editor.text)
		else:
			open_save_menu()
