extends Node2D

@onready var mc = $MC
@onready var bee = $Bee
@onready var game_ui = $PlayerUI

@export var initial_delay: float = 0.15

#sprite movement vars
var current_dir: Vector2i = Vector2i.ZERO
var tile_size: int = 16
var repeat_timer: float = 0.0
var halt: bool = false
#story toggles
var bool_bee_1: bool = false
var bool_bee_2: bool = false
#sprite vars
var mc_sprite: Texture2D = preload("res://Art/png/mc sprite.png")
var mc_sprite_1: Texture2D = preload("res://Art/png/mc sprite 1.png")
var bee_sprite: Texture2D = preload("res://Art/png/bee.png")
#dialogue
var dialogue_bee = preload("res://Dialogue/bee.dialogue")


func _ready():
	pass
	
func _process(delta: float):
	if mc.position == (Vector2(96, 80) + Vector2(8, 8)) and not halt and not bool_bee_1:
		halt = true
		bool_bee_1 = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "start", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false
	if mc.position == (Vector2(16, 80) + Vector2(8, 8)) and not halt and bool_bee_1 and not bool_bee_2:
		halt = true
		bool_bee_2 = true
		DialogueManager.show_example_dialogue_balloon(dialogue_bee, "bee_1_b", [self])
		await DialogueManager.dialogue_ended		
		current_dir = Vector2i.ZERO
		halt = false
	if halt: return
	if current_dir != Vector2i.ZERO:
		repeat_timer -= delta
	if repeat_timer <= 0:
		move_mc(current_dir)
		repeat_timer = initial_delay


func _unhandled_input(event: InputEvent):
	if halt: return
	if event.is_action_pressed("Q"): mc.position = Vector2(112, 80) + Vector2(8, 8)
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
	mc.position += Vector2(dir * tile_size)
	

func reward_bee_1_a():
	mc.texture = mc_sprite_1
	game_ui.update_texture(mc.texture)
	
func move_bee_1():
	bee.position = Vector2(0, 80) + Vector2(8, 8)
