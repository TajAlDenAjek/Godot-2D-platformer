extends Node2D


onready var belal = preload("res://scenes/belal.tscn");
onready var bsher = preload("res://scenes/bsher.tscn");
onready var romi = preload("res://scenes/romi.tscn");
onready var oweis=preload("res://scenes/oweis.tscn");

var insOfBel;
var insOfBsh;
var insOfRom;
var insOfOwe;



# making instances of enemies
func respawn_belal():
	insOfBel= belal.instance();
	insOfBel.position=$bel.position;
	resp(insOfBel);
func respawn_bsher():
	insOfBsh= bsher.instance();
	insOfBsh.position=$bsh.position;
	resp(insOfBsh)
func respawn_romi():
	insOfRom= romi.instance();
	insOfRom.position=$rom.position;
	resp(insOfRom);
func respawn_oweis():
	insOfOwe= oweis.instance();
	insOfOwe.position=$owe.position;
	resp(insOfOwe);



# adding the enemy 
func resp(i):
	add_child(i);

#spawning time
func _on_Timer_timeout():
	GlobalScript.wave+=1;
	$Timer.wait_time*=0.95;
	respawn_belal();
	respawn_bsher();
	respawn_oweis();
	respawn_romi();
	


#check Esc button to pause the game
func _physics_process(delta):
	if Input.is_action_pressed("pause"):
		get_tree().change_scene("res://scenes/Pause_menu.tscn");

