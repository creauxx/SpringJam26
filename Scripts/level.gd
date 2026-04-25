extends Node2D

@onready var mc = $MC
@onready var bee = $Bee
@onready var sunflower = $Sunflower
@onready var game_ui = $PlayerUI
@onready var tile_map = $BaseLayer
@onready var flower_1 = $Flower1
@onready var flower_2 = $Flower2
@onready var flower_3 = $Flower3
@onready var flower_4 = $Flower4
@onready var flower_5 = $Flower5
@onready var flower_6 = $Flower6

@export var initial_delay: float = 0.15

#sprite movement vars
var current_dir: Vector2i = Vector2i.ZERO
var tile_size: int = 16
var repeat_timer: float = 0.0
var halt: bool = false
var offset_pos: Vector2 = Vector2(8, 8)
#story toggles
var bool_bee_1: bool = false
var bool_bee_2: bool = false
var bool_sunflower_1: bool = false
var bool_first_flower: bool = true
var bool_flower_1: bool = false
var bool_flower_2: bool = false
var bool_flower_3: bool = false
var bool_flower_4: bool = false
var bool_flower_5: bool = false
var bool_flower_6: bool = false
#sprite vars
var mc_sprite: Texture2D = preload("res://Art/png/mc sprite.png")
var mc_sprite_1: Texture2D = preload("res://Art/png/mc sprite 1.png")
var bee_sprite: Texture2D = preload("res://Art/png/bee.png")
#dialogue
var dialogue_bee = preload("res://Dialogue/bee.dialogue")
var dialogue_flowers = preload("res://Dialogue/flowers.dialogue")
var dialogue_sunflowers = preload("res://Dialogue/sunflowers.dialogue")


func _ready():
	pass
	
func _process(delta: float):
##Batrice the Bee
	if mc.position == (Vector2(96, 80) + offset_pos) and not halt and not bool_bee_1:
		halt = true
		bool_bee_1 = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "start", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false
	if mc.position == (Vector2(16, 80) + offset_pos) and not halt and bool_bee_1 and not bool_bee_2:
		halt = true
		bool_bee_2 = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "bee_1_b", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false
##Sunny the Sunflower
	if (mc.position == (sunflower.position) + Vector2(-16, 0) or mc.position == (sunflower.position) + Vector2(0, 16) or mc.position == (sunflower.position) + Vector2(0, -16)) and not halt and not bool_sunflower_1:
		halt = true
		bool_sunflower_1 = true
		DialogueManager.show_example_dialogue_balloon(dialogue_sunflowers, "start", [self])
		await DialogueManager.dialogue_ended	
		sunflower.position = Vector2(48, 144) + offset_pos
		current_dir = Vector2i.ZERO
		halt = false
##Flowers
	if (mc.position == flower_1.position + Vector2(16, 0) or mc.position == flower_1.position + Vector2(0, 16) or mc.position == flower_1.position + Vector2(-16, 0) or mc.position == flower_1.position + Vector2(0, -16)) and not bool_flower_1:
		halt = true
		bool_flower_1 = true
		if bool_first_flower:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "first", [self])
			await DialogueManager.dialogue_ended
			bool_first_flower = false				
		else:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "flower1", [self])
			await DialogueManager.dialogue_ended	
		flower_1.position = Vector2(bee.position) + Vector2(0, -16) + Vector2(-4, 0)
		#flower_1.rotation = -90
		game_ui.unhide_flowers(0)
		current_dir = Vector2i.ZERO
		halt = false
##MC movement
	if halt: return
	if current_dir != Vector2i.ZERO:
		repeat_timer -= delta
	if repeat_timer <= 0:
		move_mc(current_dir)
		repeat_timer = initial_delay


func _unhandled_input(event: InputEvent):
	if halt: return
	if event.is_action_pressed("Q"): mc.position = Vector2(112, 80) + offset_pos
	var input_dir = Vector2i.ZERO
	if event.is_action_pressed("ui_right"): input_dir.x = 1 
	elif event.is_action_pressed("ui_left"): input_dir.x = -1
	elif event.is_action_pressed("ui_up"): input_dir.y = -1 
	elif event.is_action_pressed("ui_down"): input_dir.y = 1
	if input_dir != Vector2i.ZERO:
		move_mc(input_dir)
		current_dir = input_dir
		repeat_timer = initial_delay
	elif event.is_action_released("ui_right") and current_dir.x == 1: current_dir = Vector2i.ZERO
	elif event.is_action_released("ui_left") and current_dir.x == -1: current_dir = Vector2i.ZERO
	elif event.is_action_released("ui_up") and current_dir.y == -1: current_dir = Vector2i.ZERO
	elif event.is_action_released("ui_down") and current_dir.y == 1: current_dir = Vector2i.ZERO


func move_mc(dir):
	var cell: Vector2 = Vector2(mc.position) + Vector2(dir * tile_size) - offset_pos
	var data = tile_map.get_cell_tile_data(Vector2i(Vector2(cell) / tile_size))
	if data:
		var is_solid = data.get_custom_data("is_solid")
		if is_solid: return
	mc.position += Vector2(dir * tile_size)
	

func reward_bee_1_a():
	mc.texture = mc_sprite_1
	game_ui.update_texture(mc.texture)
	
func move_bee_1():
	bee.position = Vector2(0, 80) + offset_pos
