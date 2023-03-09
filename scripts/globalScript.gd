extends Node


var best_score=0;
var enemy_killed=0;
var wave=0;


func _ready():
	pass 

func restart(x=0):
	enemy_killed=0;
	wave=0;
	if (x==1) :
		best_score=0;
	get_tree().reload_current_scene();
