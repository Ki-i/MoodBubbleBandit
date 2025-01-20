extends CharacterBody2D

@onready var player_animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manage: Node = %GameManage
@export var boom_scene:PackedScene
@export var ice_boom_scene:PackedScene
@export var is_hide = false
var speed = 300.0
var jump_velocity = -400.0
var direction = 1
@onready var hide_timer: Timer = $hideTimer
@onready var death_timer: Timer = $deathTimer
var status_info ={}
func _ready():
	game_manage.connect("player_status_changed", _on_status_changed)
	set_player_by_status("normal")

func _on_status_changed(old_status,new_status):
	set_player_by_status(new_status)

func set_player_by_status(status_key):
	print(status_key)
	status_info = game_manage.status_dict[status_key]
	speed = status_info["speed"]
	jump_velocity = status_info["jump_velocity"]
	player_animated_sprite.play(status_info["static_sprite"])

func _physics_process(delta: float) -> void:
	if not is_hide:
		
		## 移动
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = jump_velocity
			

		var curr_direction := Input.get_axis("ui_left", "ui_right")
			
		if curr_direction:
			#player_animated_sprite.play(status_info["walk_sprite"])
			direction = curr_direction
			velocity.x = direction * speed
			player_animated_sprite.flip_h=curr_direction<0
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		
		move_and_slide()
	## show
	
		if Input.is_action_just_pressed("ui_up") or not is_on_floor():
			player_animated_sprite.play(status_info["jump_sprite"])
		elif curr_direction!=0:
			player_animated_sprite.play(status_info["walk_sprite"])
		else:
			player_animated_sprite.play(status_info["static_sprite"])	
		if Input.is_action_just_pressed("ui_accept"):
			game_manage.swift_player_status()
			print("process")
	
	if Input.is_action_just_pressed("skill"):
		if game_manage.status_list[game_manage.status_index]=="angry":
			var boom_node = boom_scene.instantiate()
			get_tree().current_scene.add_child(boom_node)
			boom_node.position = position
			boom_node.direction = direction
			#boom_node
		if game_manage.status_list[game_manage.status_index]=="sad":
			if is_hide:
				is_hide = false
				expose_player()
			else:
				is_hide = true	
				hide_player()
func hide_player():
	player_animated_sprite.play("hide")
	print(collision_layer)
	collision_layer=4
	#print(collision_layer)
func expose_player():
	player_animated_sprite.play("sad")
	collision_layer=2
	#collision_layer=6
			
