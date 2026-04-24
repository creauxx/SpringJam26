extends Node2D

@onready var mc = $MC
@onready var bee = $Bee

@export var initial_delay: float = 0.15

#sprite movement vars
var current_dir: Vector2i = Vector2i.ZERO
var tile_size: int = 16
var repeat_timer: float = 0.0
var halt: bool = false
#sprite vars
var mc_sprite: Texture2D = preload("res://Art/png/mc sprite.png")
var bee_sprite: Texture2D = preload("res://Art/png/bee.png")


func _ready():
	pass
	
func _process(delta: float):
	if halt: return
	if current_dir != Vector2i.ZERO:
		repeat_timer -= delta
	if repeat_timer <= 0:
		move_mc(current_dir)
		repeat_timer = initial_delay


func _unhandled_input(event: InputEvent):
	if halt: return
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
