extends Node2D
const SPAWN_RADIUS = 350
@export var basic_enemy_scene: PackedScene
func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player")
	var spawn_position = Vector2.ZERO 	
	if player == null:
		return
	var enemy = basic_enemy_scene.instantiate()
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1 << 0)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		if result.is_empty():
			# we are clear
			enemy.global_position = spawn_position
			break
		else:
			# we hava collision
			random_direction = random_direction.rotated(deg_to_rad(90))
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
