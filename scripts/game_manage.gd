extends Node

var status_index = 0
var status_list = ["normal"]
var score=0
var total_score = 6
const status_dict = {
	"normal":{
		"speed":90,
		"jump_velocity":-200,
		"static_sprite":"normal",
		"walk_sprite":"walk_normal",
		"jump_sprite":"jump_normal",
		"pannel_sprite":"normal"
	},
	"angry":{
		"speed":90,
		"jump_velocity":-200,
		"static_sprite":"angry",
		"walk_sprite":"walk_angry",
		"jump_sprite":"jump_angry",
		"pannel_sprite":"angry"
	},
	"happy":{
		"speed":90,
		"jump_velocity":-300,
		"static_sprite":"happy",
		"walk_sprite":"walk_happy",
		"jump_sprite":"jump_happy",
		"pannel_sprite":"happy"
	},
	"sad":{
		"speed":50,
		"jump_velocity":-150,
		"static_sprite":"sad",
		"walk_sprite":"walk_sad",
		"jump_sprite":"jump_sad",
		"pannel_sprite":"sad"
	},
	"fear":{
		"speed":200,
		"jump_velocity":-200,
		"static_sprite":"fear",
		"walk_sprite":"walk_fear",
		"jump_sprite":"jump_fear",
		"pannel_sprite":"fear"
	}
}

func _ready() -> void:
	change_to_status("normal")
signal player_status_changed(old_status,new_status)
signal score_changed(score,total_score)
# Called when the node enters the scene tree for the first time.
func swift_player_status():
	var old_index = status_index
	status_index=(status_index+1)%len(status_list)
	emit_signal("player_status_changed",status_list[old_index],status_list[status_index])

func change_to_status(status_name):
	var old_index = status_index
	status_index=status_list.find(status_name)
	emit_signal("player_status_changed",status_list[old_index],status_list[status_index])
 
func add_player_status(status_name):
	status_list.append(status_name)
	
func add_coin():
	score+=1
	emit_signal("score_changed",score,total_score)
	

	
	
	
	
