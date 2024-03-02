extends Spatial

func _on_Player_looked_up(player: KinematicBody):
	var player_basis := player.transform.basis
	
	var largest_axis_idx: int = 0
	var largest_axis: float = 0
	for i in 3:
		var axis_magnitude = abs(player_basis.z[i])
		if axis_magnitude > largest_axis:
			largest_axis = axis_magnitude
			largest_axis_idx = i
	
	var look_vector := Vector3.ZERO
	look_vector[largest_axis_idx] = sign(player_basis.z[largest_axis_idx])
	
	var rotation_axis = look_vector.cross(Physics.get_gravity_direction() * -1)
	
	var new_gravity = Physics.get_gravity_direction().rotated(rotation_axis, -deg2rad(90))
	Physics.set_gravity_direction(new_gravity)
	
	player.rotate(rotation_axis, -deg2rad(90))
	player.rotate_camera(Vector2(0, -90))
	