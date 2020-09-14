// behavior_calcDestG	Enemy will calculate random destination, used for other states
// behavior_calcDestR	Enemy will calculate a random destination in a radius surrounding a center, used for other states
// behavior_calcDestSR	Enemy will calculate a random destination in a specific radius surrounding a center, used for other states
// behavior_idle		Enemy will not move
// behavior_move		Enemy will move to a generated destination (generated by calcDestG or calcDestR)
// behavior_pursue		Enemy will pursue the player
// behavior_attracted	Enemy will move towards the player, will not avoid obstacles
// behavior_dash		Enemy will dash towards a direction
// behavior_teleport	Enemy will teleport to a location
// behavior_avoid		Enemy will move away from the player

// @function	behavior_calcDestG()
function behavior_calcDestG()
{
	destination = generate_random_valid_coordinates(obj_grid.grid, rCheck);
}

// @function	behavior_calcDestR(x, y, r)
function behavior_calcDestR(x, y, r)
{
	destination = generate_random_valid_coordinates_in_radius(obj_grid.grid, x, y, r, rCheck)
}

// @function	behavior_calcDestSR(x, y, r);
function behavior_calcDestSR(x, y, distance)
{
	destination = generate_random_valid_coordinates_in_specific_radius(obj_grid.grid, x, y, distance, rCheck);
}

// @function	behavior_idle();
function behavior_idle()
{
	phy_linear_damping = 5;
}

// @function	behavior_move();
function behavior_move()
{
	phy_linear_damping = 2;
	physics_pathfind_towards(myPath, obj_grid.grid, enginePower, destination[0], destination[1]);
}

// @function	behavior_pursue();
function behavior_pursue()
{
	phy_linear_damping = 2;
	physics_pathfind_towards(myPath, obj_grid.grid, enginePower, obj_player.phy_position_x, obj_player.phy_position_y);
}

// @function	behavior_attracted()
function behavior_attracted()
{
	phy_linear_damping = 2;
	var theta = point_direction(phy_position_x, phy_position_y, obj_player.phy_position_x, obj_player.phy_position_y);
	physics_apply_force(phy_position_x, phy_position_y, lengthdir_x(enginePower, theta), lengthdir_y(enginePower, theta));
}

// @function	behavior_dash()
function behavior_dash()
{
	phy_speed_x = 0;
	phy_speed_y = 0;
	phy_linear_damping = 0;
	physics_apply_impulse(phy_position_x, phy_position_y, lengthdir_x(enginePower, dodgeDirection) , lengthdir_y(enginePower, dodgeDirection));
	image_speed = (phy_speed_x != 0 ? sign(-phy_speed_x) : 1) * 1.2;
	alarm_set(0, room_speed * 0.4)
}

// @function	behavior_teleport()
function behavior_teleport()
{
	phy_speed_x = 0;
	phy_speed_y = 0;
	phy_linear_damping = 0;
	phy_position_x = destination[0];
	phy_position_y = destination[1];
}

// @function	behavior_avoid()
function behavior_avoid()
{
	var theta = generate_opposite_direction_avoid_obstacles(obj_grid.grid, phy_position_x, phy_position_y, point_direction(phy_position_x, phy_position_y, obj_player.phy_position_x, obj_player.phy_position_y));
	physics_apply_force(phy_position_x, phy_position_y, lengthdir_x(enginePower, theta), lengthdir_y(enginePower, theta));
}