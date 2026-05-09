class_name SceneManager extends CanvasLayer

signal sceneLoaded

@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var color_rect : ColorRect = $ColorRect

func change_scene(from : Node, toScenePath : String) -> void:
	animation.play("transition")
	await animation.animation_finished
	
	from.get_tree().call_deferred("change_scene_to_file", toScenePath)
	
	animation.play_backwards("transition")
	await animation.animation_finished
	sceneLoaded.emit()
	
