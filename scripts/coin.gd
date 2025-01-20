extends Area2D

@onready var game_manage: Node = %GameManage

func _on_body_entered(body: Node2D) -> void:
	print("got coin")
	game_manage.add_coin()
	queue_free()
