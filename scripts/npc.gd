extends Area2D

@onready var game_manage: Node = %GameManage

@export var status_type = "happy"
@export var is_visited : bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
#
## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play(status_type)



func _on_body_entered(body: Node2D) -> void:
	#print("enter")
	if body.is_in_group("player"):
		#print("enter",status_type)
		#print("enter",status_type)
		if is_visited == true:
			animated_sprite_2d.play(status_type+"_break")
		is_visited = true
		if status_type in game_manage.status_list:
			return
		game_manage.add_player_status(status_type)
		var npc_bubble_status=status_type+"_bubblelog"
		animated_sprite_2d.play(npc_bubble_status)
		#print(game_manage.status_list)
