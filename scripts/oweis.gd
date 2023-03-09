extends KinematicBody2D

onready var animations=$AnimatedSprite;
onready var player=get_parent().get_node("Player");
var speed = 300;
var jump_force=-800;
var gravity=1200;
var max_grav=3000;
var direction=Vector2(0,0);
var reactTime=400;
var reactTime_jump=400;
var next_dir=0;
var dir=0;
var next_dir_time=0;
var distance=100;
var next_jump_time=-1;


# sitting the process ( main function to true) 
func _ready():
	set_process(true);



# main AI function for rami 
func _process(delta):
	if (player.position.x<position.x - distance):
		_animations("lm");
		set_dir(-1);
	elif player.position.x>position.x+distance:
		_animations("rm");
		set_dir(1);
	else:
		set_dir(0);
		_animations("i");
	if OS.get_ticks_msec() > next_dir_time:
		dir=next_dir;
	if OS.get_ticks_msec() > next_jump_time and next_jump_time!= -1 and is_on_floor():
		if player.position.x < (position.y ) :
			direction.y= -800;
			_animations("j");
		next_jump_time=-1;
	direction.x=dir*speed;
	direction.y+=gravity*delta;
	if player.position.x < (position.y)  and next_jump_time==-1:
		next_jump_time=OS.get_ticks_msec() + reactTime_jump;
	if direction.y>max_grav:
		direction.y=max_grav;
	if is_on_floor() and direction.y>0:
		direction.y=0;
	direction=move_and_slide(direction,Vector2(0,-1));




# direction function for AI
func set_dir(d):
	if next_dir!=d:
		next_dir=d;
		next_dir_time=OS.get_ticks_msec() + reactTime;




# animations function
func _animations(string):
	if(string=="j"):
		animations.play("jump");
	elif(string=="i" and is_on_floor()):
		animations.play("idle");
	elif(string=="rm"||string=="lm"and is_on_floor()):
		animations.play("move");
		if (string =="rm"):
			animations.set_flip_h(false);
		else:
			animations.set_flip_h(true);
	elif(string=="a1"):
		animations.play("attack");
	if (string =="r"):
		animations.set_flip_h(false);
	elif(string=="l"):
		animations.set_flip_h(true);





# detecting damage
func _on_Area2D_area_entered(area):
	if "bullet" in area.get_parent().name:
		hitedByGlass(area);
	if "laptop" in area.get_parent().name:
		hitedByLap(area);
func hitedByGlass(a):
	a.get_parent().queue_free();
	$LifeBar.value-=20;
	if($LifeBar.value<=0):
		GlobalScript.enemy_killed+=1;
		player.get_node("LifeBar").value+=50;
		queue_free();
func hitedByLap(a):
	a.get_parent().queue_free();
	$LifeBar.value-=50;
	if($LifeBar.value<=0):
		GlobalScript.enemy_killed+=1;
		queue_free();
