extends Node

signal fps_displayed(value)

# Video settings
func display_mode_set(value):
	DisplayServer.window_set_mode(3 if value else 0)
	Save.game_data.fullscreen_on = value
	Save.save_data()

func display_fps_toggle(value):
	emit_signal("fps_displayed", value)
	Save.game_data.display_fps = value
	Save.save_data()

func max_fps_set(value):
	Engine.set_max_fps(value if value < 500 else 0)
	Save.game_data.max_fps = Engine.get_max_fps() if value < 500 else 500
	Save.save_data()

func brightness_set(value):
	pass

func bloom_toggle(value):
	pass

func vsync_toggle(value):
	DisplayServer.window_set_vsync_mode(value)
	Save.game_data.vsync_on = value
	Save.save_data()

# Audio Settings
func master_vol_set(value):
	AudioServer.set_bus_volume_db(0, value)
	Save.game_data.master_vol = value
	Save.save_data()

func music_vol_set(value):
	AudioServer.set_bus_volume_db(1, value)
	Save.game_data.music_vol = value
	Save.save_data()

func sfx_vol_set(value):
	AudioServer.set_bus_volume_db(2, value)
	Save.game_data.sfx_vol = value
	Save.save_data()

# Gameplay Settings
func fov_set(value):
	pass
