extends Control

@onready var main_btns = $MarginContainer/HBoxContainer/PanelContainer/VBoxContainer/MainBtns
@onready var settings_btns = $MarginContainer/HBoxContainer/PanelContainer/VBoxContainer/SettingsBtns
@onready var pause_menu = $"."
@onready var continue_btn = $MarginContainer/HBoxContainer/PanelContainer/VBoxContainer/MainBtns/ContinueBtn
@onready var video_btn = $MarginContainer/HBoxContainer/PanelContainer/VBoxContainer/SettingsBtns/VideoBtn

# Main Menu
func _on_continue_btn_pressed():
	pause_menu.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(2)

func _on_settings_btn_pressed():
	settings_btns.visible = !settings_btns.visible
	main_btns.visible = !main_btns.visible
	video_btn.grab_focus()

func _on_main_menu_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")

func _on_exit_btn_pressed():
	get_tree().quit()

# Settings Menu
func _on_video_btn_pressed():
	$SettingsMenu/TabContainer.current_tab = 0
	$SettingsMenu.visible = true

func _on_audio_btn_pressed():
	$SettingsMenu/TabContainer.current_tab = 1
	$SettingsMenu.visible = true

func _on_gameplay_btn_pressed():
	$SettingsMenu/TabContainer.current_tab = 2
	$SettingsMenu.visible = true

func _on_controls_btn_pressed():
	$SettingsMenu/TabContainer.current_tab = 3
	$SettingsMenu.visible = true

func _on_language_btn_pressed():
	$SettingsMenu/TabContainer.current_tab = 4
	$SettingsMenu.visible = true

func _on_back_btn_pressed():
	$SettingsMenu.visible = false
	settings_btns.visible = !settings_btns.visible
	main_btns.visible = !main_btns.visible
	continue_btn.grab_focus()

# Esc button
func _input(event):
	if Input.is_action_just_pressed("pause"):
		pause_menu.visible = !pause_menu.visible
		get_tree().paused = !get_tree().paused
		Input.set_mouse_mode(2 if Input.mouse_mode == 0 else 0)
		
		if pause_menu.visible:
			continue_btn.grab_focus()
