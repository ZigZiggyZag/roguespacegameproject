/// @description Insert description here
// You can write your code in this editor

//draw_text(32, 64, "Entity Count = " + string(instance_number(obj_player) + instance_number(obj_defaultEnemyParams) + instance_number(obj_simpleProjectile) + instance_number(obj_obstacleParent) + instance_number(obj_enemyWeapons)));

if not hideUI && instance_exists(obj_player)
{
	draw_sprite(spr_staticUI, -1, 0, 0);
	var subImage = ceil((obj_player.currentHealth * 25) / get_stat("hullStat"))
	if subImage < 0
	{
		subImage = 0	
	}
	draw_sprite(spr_health, subImage, 8, 8)
	
	draw_sprite(spr_jumpFrame, 0, 62, 27)
	
	if !canJump
	{
		var jumpSubImage = ceil((1 - ((obj_universe.alarm[0]) / (room_speed * 10))) * 10)
		if jumpSubImage < 0
		{
			jumpSubImage = 0	
		}
		draw_sprite(spr_jumpBar, jumpSubImage, 64, 29)
	}
	else
	{
		draw_sprite(spr_jumpCharged, 0, 63, 28)	
	}
	
	draw_sprite_part(spr_shieldBar, 0, 0, 0, (obj_player.currentShields / get_stat("shieldStat")) * 149, 10, 8, 8)
	
	if !obj_player.canRecharge
	draw_sprite(spr_shieldBroken, 0, 161, 9)

	draw_text(17, 31, string(obj_player.money));
	
	draw_text(17, 45, string(obj_player.missiles));
	
	draw_sprite(obj_player.currentWeapon.itemSprite, 0, 32, 336)

	draw_radar_blip(obj_defaultEnemyParams, spr_enemyBlip);			// Enemy Blips
	draw_radar_blip(obj_obstacleParent, spr_obstacleBlip);			// Obstacle Blips
	// draw_radar_blip(obj_simpleProjectile, spr_projectileBlip);	// Player Projectile Blips
	// draw_radar_blip(obj_enemyWeapons, spr_projectileBlip);		// Enemy Weapon Blips
	draw_radar_blip(obj_player, spr_playerBlip);					// Player Blip
	draw_radar_blip(obj_mine, spr_mineBlip);
	draw_radar_blip(obj_dumbMissile, spr_missileBlip);
	
	// Menu

	mousex = window_mouse_get_x() / round(view_wport[0]/640);
	mousey = window_mouse_get_y() / round(view_hport[0]/360);

	if mouse_check_button_pressed(mb_left) && !doNotDisable
	{
		infoIndex = 0;
	}
	
	if !obj_weaponController.canFire
	{
		obj_weaponController.canFire = true;
	}
	
	if (keyboard_check(vk_tab))
	{
		menuOpen = true;
		obj_weaponController.canFire = false;
		draw_menu()
	}
	else if (keyboard_check(vk_shift))
	{
		obj_weaponController.canFire = false;
		draw_jump_menu()
		if canJump
		{
			if mouse_check_button_pressed(mb_left)
			{
				audio_play_sound(snd_jumpCharge, 0, false);
				alarm_set(0, room_speed)
			}
			if mouse_check_button_released(mb_left)
			{
				audio_stop_sound(snd_jumpCharge);
				alarm_set(0, -1)
			}
		
			if alarm_get(0) != -1
			{
				part_emitter_region(global.particleSystem, global.jumpChargeEmitter, 
							obj_player.x + 80,
							obj_player.x - 80,
							obj_player.y + 80,
							obj_player.y - 80,
							ps_shape_ellipse, ps_distr_invgaussian);
			
				part_type_direction(global.jumpParticle, (-obj_player.phy_rotation + 180) - 10, (-obj_player.phy_rotation + 180) + 10, 0, 0);
			
				part_emitter_burst(global.particleSystem, global.jumpChargeEmitter, global.jumpParticle, clamp((5 / (alarm_get(0) - 8)) - 0.1, 0, 1) * 20);
			}
		}
	}
	
	if (keyboard_check_released(vk_tab))
	{
		menuOpen = false;
	}
	
	if (keyboard_check_released(vk_shift))
	{
		audio_stop_sound(snd_jumpCharge);
		alarm_set(0, -1)
	}
	
	if menuOpen
	{
		draw_sprite(spr_cursor, 0, mousex, mousey);
	}
	else
	{
		draw_sprite(spr_crosshairCursor, 0, mousex, mousey);
	}
	
	//draw_text(16,64, string(get_stat("projectileSpeedStat")))
	//draw_text(16,72, string(obj_universe.playerSectorY))
	//if not is_undefined(obj_universe.visitedSectors[? get_coordinates_string()])
	//{
	//	draw_text(16,80, string(obj_universe.visitedSectors[? get_coordinates_string()].sectorDanger))
	//}
}

if menuMode == 2 && !instance_exists(obj_spaceStation)
{
	menuMode = 0;	
}

if instance_exists(obj_Boss)
{
	draw_sprite(spr_bossHealthBarFrame, 0, 0, 0)
	
	draw_sprite_part(spr_bossHealthBar, 0, 0, 0, (obj_Boss.currentHealth / obj_Boss.maxHealth) * 429, 12, 106, 332)
}

if obj_gameOver.dead
{
	draw_set_halign(fa_center);
	draw_text_transformed(320, 100, "GAME OVER", 4, 4, 0);
	
	draw_text_transformed(320, 180, "Furthest Gone: " + string(obj_scoreKeeper.furthestDistance), 2, 2, 0);
	
	if obj_gameOver.showReset
	{
		draw_text_transformed(320, 210, "Press Space to Restart", 1, 1, 0);
	}
	draw_set_halign(fa_left);
}