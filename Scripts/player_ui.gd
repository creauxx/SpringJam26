extends CanvasLayer

@onready var mc_tex = $Control/TextureRect
@onready var spider = $Control/Spider
@onready var sunflower = $Control/Sunflower
@onready var flower_array: Array = [
	$Control/Flower1, 
	$Control/Flower2,
	$Control/Flower3,
	$Control/Flower4,
	$Control/Flower5,
	$Control/Flower6
]

func update_texture(new_texture: Texture2D):
	mc_tex.texture = new_texture


func unhide_flowers(array_num: int):
	flower_array[array_num].show()


func unhide_spider():
	spider.show()
