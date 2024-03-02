extends Node

var space: RID

func _ready():
	space = get_viewport().find_world().space

func set_gravity_direction(new_gravity: Vector3):
	PhysicsServer.area_set_param(space, PhysicsServer.AREA_PARAM_GRAVITY_VECTOR, new_gravity)
	
func get_gravity() -> Vector3:
	return get_gravity_direction() * get_gravity_scale()

func get_gravity_direction() -> Vector3:
	return PhysicsServer.area_get_param(space, PhysicsServer.AREA_PARAM_GRAVITY_VECTOR)

func get_gravity_scale() -> float:
	return PhysicsServer.area_get_param(space, PhysicsServer.AREA_PARAM_GRAVITY)

