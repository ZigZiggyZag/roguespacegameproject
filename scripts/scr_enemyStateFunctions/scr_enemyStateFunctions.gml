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

// @function	behavior_calcDestR()
function behavior_calcDestR()
{
	destination = generate_random_valid_coordinates_in_radius(obj_grid.grid, destGenX, destGenY, radius, rCheck)
}

// @function	behavior_calcDestSR(x, y, r);
function behavior_calcDestSR()
{
	destination = generate_random_valid_coordinates_in_specific_radius(obj_grid.grid, destGenX, destGenY, radius, rCheck);
}

// @function	behavior_idle();
function behavior_idle()
{
	phy_linear_damping = 5;
}

// @function	behavior_drift();
function behavior_drift()
{
	phy_linear_damping = 0;	
}

// @function	behavior_move();
function behavior_move()
{
	if path_exists(myPath)
	{
		phy_linear_damping = 2;
		movementDirection = physics_pathfind_direction(myPath, obj_grid.grid, destination[0], destination[1]);
	}
}

// @function	behavior_pursue();
function behavior_pursue()
{
	if path_exists(myPath) && instance_exists(obj_player)
	{
		phy_linear_damping = 2;
		movementDirection = physics_pathfind_direction(myPath, obj_grid.grid, obj_player.phy_position_x, obj_player.phy_position_y);
	}
}

// @function	behavior_attracted()
function behavior_attracted()
{
	phy_linear_damping = 2;
	var theta = point_direction(phy_position_x, phy_position_y, obj_player.phy_position_x, obj_player.phy_position_y);
	movementDirection = theta;
	// physics_apply_force(phy_position_x, phy_position_y, lengthdir_x(enginePower, theta), lengthdir_y(enginePower, theta));
}

// @function	behavior_dash()
function behavior_dash()
{
	
	var projectile = instance_nearest(phy_position_x, phy_position_y, obj_projectileParent)
	if projectile == noone
	{
		projectile = instance_find(obj_player, 0)
	}
	var theta = generate_opposite_direction_avoid_obstacles(obj_grid.grid, phy_position_x, phy_position_y, point_direction(phy_position_x, phy_position_y, projectile.phy_position_x, projectile.phy_position_y));
	
	canDodge = false;
	dodging = true;
	phy_speed_x = 0;
	phy_speed_y = 0;
	phy_linear_damping = 0;
	physics_apply_impulse(phy_position_x, phy_position_y, lengthdir_x(enginePower * 0.9, theta) , lengthdir_y(enginePower * 0.9, theta));
	//image_speed = (phy_speed_x != 0 ? sign(-phy_speed_x) : 1) * 1.2;
	alarm_set(1, room_speed * 1.05)
	alarm_set(2, room_speed * 0.4)
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
	if instance_exists(obj_player)
	{
		phy_linear_damping = 2;
		var theta = generate_opposite_direction_avoid_obstacles(obj_grid.grid, phy_position_x, phy_position_y, point_direction(phy_position_x, phy_position_y, obj_player.phy_position_x, obj_player.phy_position_y));
		movementDirection = theta
	}
	//physics_apply_force(phy_position_x, phy_position_y, lengthdir_x(enginePower, theta), lengthdir_y(enginePower, theta));
}

function behavior_avoid_projectile()
{
	var projectile = instance_nearest(phy_position_x, phy_position_y, obj_projectileParent)
	if projectile == noone
	{
		projectile = instance_find(obj_player, 0)
	}
	phy_linear_damping = 2;
	var theta = generate_opposite_direction_avoid_obstacles(obj_grid.grid, phy_position_x, phy_position_y, point_direction(phy_position_x, phy_position_y, projectile.phy_position_x, projectile.phy_position_y));
	movementDirection = theta
	
	//physics_apply_force(phy_position_x, phy_position_y, lengthdir_x(enginePower, theta), lengthdir_y(enginePower, theta));
}