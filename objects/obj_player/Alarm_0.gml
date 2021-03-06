/// @description Dodging
// You can write your code in this editor

dodge = false;
dodging = false;
dodgeCooldown = room_speed / get_stat("dodgeRechargeStat");
image_speed = 0;
image_index = 0;

physics_remove_fixture(id, myFix);

#region // Return to original fixture values
var oldFix = physics_fixture_create();
physics_fixture_set_polygon_shape(oldFix);
physics_fixture_add_point(oldFix, 12, 0);
physics_fixture_add_point(oldFix, -7, 10);
physics_fixture_add_point(oldFix, -12, 0);
physics_fixture_add_point(oldFix, -7, -10);
physics_fixture_set_density(oldFix,1);
physics_fixture_set_restitution(oldFix,0.2);
physics_fixture_set_linear_damping(oldFix,4);
physics_fixture_set_angular_damping(oldFix,8);
physics_fixture_set_friction(oldFix,0.4);
physics_fixture_set_collision_group(oldFix,1);
myFix = physics_fixture_bind(oldFix,id);
physics_fixture_delete(oldFix);
#endregion