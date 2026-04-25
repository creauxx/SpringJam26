extends CanvasLayer

@onready var tex = $Control/TextureRect

func update_texture(new_texture: Texture2D):
	tex.texture = new_texture
