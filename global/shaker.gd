extends Node

func shake(sprite: Node2D, strength: float, duration: float = 0.2) -> void:
	if not sprite:
		return
	
	var orig_pos := sprite.position
	var shake_count := 10
	var tween := create_tween()
	
	for i in shake_count:
		var shake_offset := Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
		var target := orig_pos + strength * shake_offset
		if i % 2 == 0:
			target = orig_pos
		tween.tween_property(sprite, "position", target, duration / float(shake_count))
		strength *= 0.75
	
	tween.finished.connect(func(): sprite.position = orig_pos)
