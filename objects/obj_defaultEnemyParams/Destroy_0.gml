/// @description Insert description here
// You can write your code in this editor

var dropped = irandom(value)

var i, newScrap;
for (i = dropped; i > 50; i -= 50)
{
	dropped -= 50;
	newScrap = instance_create_layer(x, y, "Interactible", obj_scrap)
	newScrap.image_index = 4;
}

for (i = dropped; i > 25; i -= 25)
{
	dropped -= 25;
	newScrap = instance_create_layer(x, y, "Interactible", obj_scrap)
	newScrap.image_index = 3;
}

for (i = dropped; i > 10; i -= 10)
{
	dropped -= 10;
	newScrap = instance_create_layer(x, y, "Interactible", obj_scrap)
	newScrap.image_index = 2;
}

for (i = dropped; i > 5; i -= 5)
{
	dropped -= 5;
	newScrap = instance_create_layer(x, y, "Interactible", obj_scrap)
	newScrap.image_index = 1;
}

for (i = dropped; i > 1; i -= 1)
{
	dropped -= 1;
	newScrap = instance_create_layer(x, y, "Interactible", obj_scrap)
	newScrap.image_index = 0;
}