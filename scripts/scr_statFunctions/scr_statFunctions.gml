// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function apply_effect(item)
{
	var currentEffect;
	for (var i = 0; i < array_length(item.effects); i++)
	{
		currentEffect = item.effects[i];
		switch (currentEffect.effectType)
		{
			case effectTypes.multiplier:
				obj_player.modifiers[? currentEffect.stat] += currentEffect.effectValue;
			case effectTypes.modify:
				obj_player.stats[? currentEffect.stat] += currentEffect.effectValue;
		}
	}
}

function remove_effect(item)
{
	var currentEffect;
	for (var i = 0; i < array_length(item.effects); i++)
	{
		currentEffect = item.effects[i];
		switch (currentEffect.effectType)
		{
			case effectTypes.multiplier:
				obj_player.modifiers[? currentEffect.stat] -= currentEffect.effectValue;
			case effectTypes.modify:
				obj_player.stats[? currentEffect.stat] -= currentEffect.effectValue;
		}
	}
}

function equip_item(inventoryIndex, slot)
{
	var item = ds_list_find_value(obj_player.inventory, inventoryIndex)
	ds_list_delete(obj_player.inventory, inventoryIndex)
	
	unequip_item(slot)
	
	obj_player.equipped[? slot] = item;
	
	if item.itemType != itemTypes.weaponItem
	{
		apply_effect(item);
	}
}

function unequip_item(slot)
{
	if is_struct(obj_player.equipped[? slot])
	{
		if obj_player.equipped[? slot].itemType != itemTypes.weaponItem
		{
			remove_effect(obj_player.equipped[? slot])
		}
		ds_list_add(obj_player.inventory, obj_player.equipped[? slot])
		obj_player.equipped[? slot] = 0
	}
}

function is_equipped(slot)
{
	return is_struct(obj_player.equipped[? slot])	
}

function add_item(item)
{
	ds_list_add(obj_player.inventory, item)
	
	if (item.itemType == itemTypes.passiveItem)
	{
		apply_effect(item)
	}
}

function remove_item_index(index)
{
	var item = ds_list_find_value(obj_player.inventory, index)
	if (item.itemType == itemTypes.passiveItem)
	{
		remove_effect(item)
	}
	ds_list_delete(obj_player.inventory, index)
}

function remove_item(item)
{
	if (item.itemType == itemTypes.passiveItem)
	{
		remove_effect(item)
	}
	ds_list_delete(obj_player.inventory, ds_list_find_index(obj_player.inventory, item))
}

function get_stat(statName)
{
	//return (obj_player.stats[? statName] + obj_player.additives[? statName]) * obj_player.modifiers[? statName]
	return obj_player.stats[? statName] * obj_player.modifiers[? statName]
}