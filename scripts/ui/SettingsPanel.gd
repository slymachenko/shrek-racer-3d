extends Control

# Video settings
@onready var display_mode_btn = $TabContainer/Video/ScrollContainer/MarginContainer/VBoxContainer/DisplayMode/DisplayModeBtn
@onready var display_fps_btn = $TabContainer/Video/ScrollContainer/MarginContainer/VBoxContainer/DisplayFps/DisplayFPSBtn
@onready var max_fps_slider = $TabContainer/Video/ScrollContainer/MarginContainer/VBoxContainer/MaxFps/HSlider/MaxFPSSlider
@onready var max_fps_val = $TabContainer/Video/ScrollContainer/MarginContainer/VBoxContainer/MaxFps/HSlider/MaxFPSVal
@onready var brightness_slider = $TabContainer/Video/ScrollContainer/MarginContainer/VBoxContainer/Brightness/HSlider/BrightnessSlider
@onready var brightness_val = $TabContainer/Video/ScrollContainer/MarginContainer/VBoxContainer/Brightness/HSlider/BrightnessVal
@onready var bloom_btn = $TabContainer/Video/ScrollContainer/MarginContainer/VBoxContainer/Bloom/BloomBtn
@onready var vsync_btn = $TabContainer/Video/ScrollContainer/MarginContainer/VBoxContainer/VSync/VSyncBtn

# Audio settings
@onready var master_volume_val = $TabContainer/Audio/ScrollContainer/MarginContainer/VBoxContainer/MasterVolume/HSlider/MasterVolumeVal
@onready var master_volume_slider = $TabContainer/Audio/ScrollContainer/MarginContainer/VBoxContainer/MasterVolume/HSlider/MasterVolumeSlider
@onready var music_volume_val = $TabContainer/Audio/ScrollContainer/MarginContainer/VBoxContainer/MusicVolume/HSlider/MusicVolumeVal
@onready var music_volume_slider = $TabContainer/Audio/ScrollContainer/MarginContainer/VBoxContainer/MusicVolume/HSlider/MusicVolumeSlider
@onready var sfx_volume_val = $TabContainer/Audio/ScrollContainer/MarginContainer/VBoxContainer/SFXVolume/HSlider/SFXVolumeVal
@onready var sfx_volume_slider = $TabContainer/Audio/ScrollContainer/MarginContainer/VBoxContainer/SFXVolume/HSlider/SFXVolumeSlider

# Gameplay settings
@onready var fov_val = $TabContainer/Gameplay/ScrollContainer/MarginContainer/VBoxContainer/FOV/HSlider/FOVVal
@onready var fov_slider = $TabContainer/Gameplay/ScrollContainer/MarginContainer/VBoxContainer/FOV/HSlider/FOVSlider

func _ready():
	# VIDEO SETTINGS
	# DISPLAY MODE
	display_mode_btn.select(1 if Save.game_data.fullscreen_on else 0)
	GlobalSettings.display_mode_set(Save.game_data.fullscreen_on)
	# DISPLAY FPS
	display_fps_btn.button_pressed = Save.game_data.display_fps
	GlobalSettings.display_fps_toggle(Save.game_data.display_fps)
	# MAX FPS
	max_fps_slider.value = Save.game_data.max_fps
	GlobalSettings.max_fps_set(Save.game_data.max_fps)
	# BRIGHTNESS
	
	# BLOOM
	
	# VSYNC
	vsync_btn.button_pressed = Save.game_data.vsync_on
	GlobalSettings.vsync_toggle(Save.game_data.vsync_on)
	
	# AUDIO SETTINGS
	master_volume_val.text = str(Save.game_data.master_vol)
	music_volume_val.text = str(Save.game_data.music_vol)
	sfx_volume_val.text = str(Save.game_data.sfx_vol)
	
	# FOV

# Video settings
func _on_display_mode_btn_item_selected(index):
	GlobalSettings.display_mode_set(true if index == 1 else false)

func _on_display_fps_btn_toggled(button_pressed):
	GlobalSettings.display_fps_toggle(button_pressed)

func _on_max_fps_slider_value_changed(value):
	GlobalSettings.max_fps_set(value)
	max_fps_val.text = str(value) if value < max_fps_slider.max_value else "max"

func _on_brightness_slider_value_changed(value):
	GlobalSettings.brightness_set(value)
	

func _on_bloom_btn_toggled(button_pressed):
	pass

func _on_v_sync_btn_toggled(button_pressed):
	GlobalSettings.vsync_toggle(button_pressed)

# Audio settings
func _on_master_volume_slider_value_changed(value):
	GlobalSettings.master_vol_set(value)
	master_volume_val.text = str(value)

func _on_music_volume_slider_value_changed(value):
	GlobalSettings.music_vol_set(value)
	music_volume_val.text = str(value)

func _on_sfx_volume_slider_value_changed(value):
	GlobalSettings.sfx_vol_set(value)
	sfx_volume_val.text = str(value)

# Gameplay settings
func _on_fov_slider_value_changed(value):
	pass
