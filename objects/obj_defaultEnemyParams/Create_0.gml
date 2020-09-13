/// @description Initialize variables
// You can write your code in this editor

flash = 0;
phy_fixed_rotation = true;

rotationSpeed = 20;
enginePower = 200;

myPath = path_add();

enum behaviorStates
{
	calcDestG,	// Enemy will calculate random destination, used for other states
	calcDestR,	// Enemy will calculate a random destination in a radius surrounding the enemy, used for other states
	idle,		// Enemy will not move
	move,		// Enemy will move to a generated destination (generated by calcDestG or calcDestR)
	pursue,		// Enemy will move towards the player
	attracted,	// Enemy will move towards player, will not avoid obstacles
	dash,		// Enemy will dash in a direction
	dashing,	// Enemy will be unable to do anything else
	startTele,	// Enemy will begin Start Teleport Animation
	teleport,	// Enemy will teleport to a location
	endTele,	// Enemy will begin End Teleport Animation
	avoid		// Enemy will move away from the player
}

dodgeCooldown = 0;

state = behaviorStates.idle
previousState = behaviorStates.idle

destination = [-1, -1];		// Modified in the calcDestG or calcDestR state
dodgeDirection = 0			// Direction to dash when dashing

rCheck = 3	// Radius to look for valid coordinates if the random coordinates generated is invalid