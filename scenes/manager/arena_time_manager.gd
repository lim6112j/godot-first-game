extends Node

@onready var timer = $Timer
@export var end_screen: PackedScene
var end_screen_instance
func get_time_elapsed():
	return timer.wait_time - timer.time_left
func _process(delta):
	if get_time_elapsed() > timer.wait_time:
		print("timer ended")
		end_screen_instance = end_screen.instantiate()
		set_text("You Win", "Conratulation you've won")

func set_text(title: String, description: String):
	end_screen_instance.title.text = title
	end_screen_instance.description.text = description
	
