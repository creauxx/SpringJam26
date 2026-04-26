extends Node2D

@onready var mc = $MC
@onready var bee = $Bee
@onready var sunflower = $Sunflower
@onready var spider = $Spider
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
var bool_bee_met: bool = false
var bool_bee_breath_done: bool = false
var bool_bee_end: bool = false
var bool_sunflower_met: bool = false
var bool_spider_met: bool = false
var bool_spider_2: bool = false
var bool_spider_3: bool = false
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
var dialogue_spider = preload("res://Dialogue/spider.dialogue")


func _ready():
	pass
	
	
func _process(delta: float):
##Batrice the Bee
	if mc.position == (Vector2(96, 80) + offset_pos) and not halt and not bool_bee_met:
		halt = true
		bool_bee_met = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "start", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false
	if mc.position == (Vector2(96, 80) + offset_pos) and not halt and bool_bee_met and not bool_bee_breath_done:
		halt = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "breath", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false		
	if mc.position == (Vector2(16, 80) + offset_pos) and not halt and bool_bee_met and not bool_bee_end and bool_sunflower_met:
		halt = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "bee_sunflower", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false
	if mc.position == (Vector2(16, 80) + offset_pos) and not halt and bool_bee_met and not bool_bee_end and bool_spider_met:
		halt = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "bee_spider", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false
	if mc.position == (Vector2(16, 80) + offset_pos) and not halt and bool_bee_met and not bool_bee_end:
		halt = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "bee_1_b", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false

##Sunny the Sunflower
	if (mc.position == (sunflower.position) + Vector2(-16, 0) or mc.position == (sunflower.position) + Vector2(0, 16) or mc.position == (sunflower.position) + Vector2(0, -16)) and not halt and not bool_sunflower_met:
		halt = true
		bool_sunflower_met = true
		DialogueManager.show_example_dialogue_balloon(dialogue_sunflowers, "start", [self])
		await DialogueManager.dialogue_ended	
		current_dir = Vector2i.ZERO
		halt = false

##Sally the Spider
	if (mc.position == (spider.position) + Vector2(48, 0) or mc.position == (spider.position) + Vector2(32, 16) or mc.position == (spider.position) + Vector2(16, 32) or mc.position == (spider.position) + Vector2(0, -48)) and not halt and not bool_spider_met:
		halt = true
		bool_spider_met = true
		DialogueManager.show_example_dialogue_balloon(dialogue_spider, "start", [self])
		await DialogueManager.dialogue_ended	
		current_dir = Vector2i.ZERO
		halt = false
	if (mc.position == (spider.position) + Vector2(48, 0) or mc.position == (spider.position) + Vector2(32, 16) or mc.position == (spider.position) + Vector2(16, 32)) and not halt and bool_spider_met and not bool_spider_2 and not bool_spider_3:
		halt = true
		bool_spider_3 = true
		DialogueManager.show_example_dialogue_balloon(dialogue_spider, "panic", [self])
		await DialogueManager.dialogue_ended	
		current_dir = Vector2i.ZERO
		halt = false

##Flowers
#Flower_1
	if (mc.position == flower_1.position + Vector2(16, 0) or mc.position == flower_1.position + Vector2(-16, 0) or mc.position == flower_1.position + Vector2(0, -16)) and not bool_flower_1:
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
#Flower_2
	if (mc.position == flower_2.position + Vector2(16, 0) or mc.position == flower_2.position + Vector2(0, 16) or mc.position == flower_2.position + Vector2(0, 16)) and not bool_flower_2:
		halt = true
		bool_flower_2 = true
		if bool_first_flower:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "first", [self])
			await DialogueManager.dialogue_ended
			bool_first_flower = false				
		else:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "flower2", [self])
			await DialogueManager.dialogue_ended	
		flower_2.position = Vector2(bee.position) + Vector2(0, 16) + Vector2(-4, 0)
		#flower_2.rotation = -90
		game_ui.unhide_flowers(1)
		current_dir = Vector2i.ZERO
		halt = false
#Flower_3
	if (mc.position == flower_3.position + Vector2(16, 0) or mc.position == flower_3.position + Vector2(-16, 0) or mc.position == flower_3.position + Vector2(0, 16)) and not bool_flower_3:
		halt = true
		bool_flower_3 = true
		if bool_first_flower:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "first", [self])
			await DialogueManager.dialogue_ended
			bool_first_flower = false				
		else:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "flower3", [self])
			await DialogueManager.dialogue_ended	
		flower_3.position = Vector2(bee.position) + Vector2(0, 32) + Vector2(-4, 0)
		#flower_3.rotation = -90
		game_ui.unhide_flowers(2)
		current_dir = Vector2i.ZERO
		halt = false
#Flower_4
	if (mc.position == flower_4.position + Vector2(0, -32) or mc.position == flower_4.position + Vector2(0, 16)) and not bool_flower_4:
		halt = true
		bool_flower_4 = true
		if bool_first_flower:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "first", [self])
			await DialogueManager.dialogue_ended
			bool_first_flower = false				
		else:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "flower4", [self])
			await DialogueManager.dialogue_ended	
		flower_4.position = Vector2(bee.position) + Vector2(0, -32) + Vector2(-4, 0)
		#flower_4.rotation = -90
		game_ui.unhide_flowers(3)
		current_dir = Vector2i.ZERO
		halt = false
#Flower_5
	if (mc.position == flower_5.position + Vector2(16, 0) or mc.position == flower_5.position + Vector2(0, 16) or mc.position == flower_5.position + Vector2(0, -16)) and not bool_flower_5:
		halt = true
		bool_flower_5 = true
		if bool_first_flower:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "first", [self])
			await DialogueManager.dialogue_ended
			bool_first_flower = false				
		else:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "flower5", [self])
			await DialogueManager.dialogue_ended	
		flower_5.position = Vector2(bee.position) + Vector2(0, 48) + Vector2(-4, 0)
		#flower_5.rotation = -90
		game_ui.unhide_flowers(4)
		current_dir = Vector2i.ZERO
		halt = false
#Flower_6
	if (mc.position == flower_6.position + Vector2(16, 0) or mc.position == flower_6.position + Vector2(-16, 0) or mc.position == flower_6.position + Vector2(0, 16) or mc.position == flower_6.position + Vector2(0, -16)) and not bool_flower_6:
		halt = true
		bool_flower_6 = true
		if bool_first_flower:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "first", [self])
			await DialogueManager.dialogue_ended
			bool_first_flower = false				
		else:
			DialogueManager.show_example_dialogue_balloon(dialogue_flowers, "flower6", [self])
			await DialogueManager.dialogue_ended	
		flower_6.position = Vector2(bee.position) + Vector2(0, -48) + Vector2(-4, 0)
		#flower_6.rotation = -90
		game_ui.unhide_flowers(5)
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
	bool_spider_3 = false


func reward_bee():
	bool_bee_breath_done = true
	bee.position = Vector2(0, 80) + offset_pos
	
	
func spider_reward():
	spider.position = Vector2(48, 16) + offset_pos
	game_ui.unhide_spider()
	bool_spider_2 = true


func sunflower_reward():
	sunflower.position = Vector2(48, 144) + offset_pos
	game_ui.unhide_sunflower()
