extends Node

const SAVE_FILE_PATH = "user://SAVE_FILE.dat" 

var game_data = {}

func _ready():
	load_data()

func load_data():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		game_data = {
			"fullscreen_on": false,
			"display_fps": false,
			"max_fps": 0,
			"brightness": 1,
			"bloom_on": false,
			"vsync_on": false,
			
			"master_vol": -10,
			"music_vol": -10,
			"sfx_vol": -10,
			
			"fov": 70
		}
		
		save_data()
	
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	game_data = file.get_var()
	file.close()

func save_data():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(game_data)
	file.close()
