extends Node

# audio stuff to adjust individual SFX volumes instead of managing new audio buses
var original_volumes: Dictionary = {}

func _ready() -> void:
	for player in get_children():
		if player is AudioStreamPlayer:
			original_volumes[player] = player.volume_db

func play(audio: AudioStream, single=false) -> void:
	if not audio:
		return
		
	if single:
		stop()
	
	for player in get_children():
		player = player as AudioStreamPlayer
		
		if not player.playing:
			player.stream = audio
			
			# (currently) used for slash.ogg which is louder than others
			var default_volume = original_volumes.get(player, 0.0)
			if audio and audio.resource_path.ends_with("slash.ogg"):
				player.volume_db = default_volume - 10.0
			else:
				player.volume_db = default_volume
				
			player.play()
			break
	
	
func stop() -> void:
	for player in get_children():
		player = player as AudioStreamPlayer
		player.stop()
