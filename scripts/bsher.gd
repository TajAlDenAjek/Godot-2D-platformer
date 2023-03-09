extends KinematicBody2D

onready var laptop = preload("res://scenes/enemyLaptop.tscn");
onready var player=get_parent().get_node("Player");
onready var animations=$AnimatedSprite;
var instanceOflaptop;
var dirOfShooting=true;
var speed = 300;
var jump_force=-800;
var gravity=1200;
var max_grav=3000;
var direction=Vector2(0,0);
var reactTime=400;
var reactTime_jump=600;
var next_dir=0;
var dir=0;
var next_dir_time=0;
var distance=200;
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
#	if OS.get_ticks_msec() > next_jump_time and next_jump_time!= -1 and is_on_floor():
#		if player.position.x < (position.y ) :
#			direction.y= -800;
#			_animations("j");
#		next_jump_time=-1;
	direction.x=dir*speed;
	direction.y+=gravity*delta;
#	if player.position.x < (position.y)  and next_jump_time==-1:
#		next_jump_time=OS.get_ticks_msec() + reactTime_jump;
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






# main shooting function for bsher
func _physics_process(delta):
	if $leftCast.is_colliding()||$rightCast.is_colliding():
		if $Timer.is_stopped():
			$Timer.start();
		if($rightCast.is_colliding()):
			dirOfShooting=false;
			_animations("r");
			$lap.position.x=45;
			$lap.position.y=-30;
		else:
			dirOfShooting=true;
			_animations("l");
			$lap.position.x=-45;
			$lap.position.y=-30;
	else:
		if not $Timer.is_stopped():
			$Timer.stop();





# time to shoot function
func _on_Timer_timeout():
	shoot(dirOfShooting);
# shooting function
func shoot(dir):
	instanceOflaptop=laptop.instance();
	instanceOflaptop.init(dir,10);
	get_parent().add_child(instanceOflaptop);	
	instanceOflaptop.global_position=$lap.global_position;
	_animations("a1");




# animations function
func _animations(string):
	if(string=="j"):
		animations.play("jump");
	elif(string=="i"):
		animations.play("idle");
	elif(string=="rm"||string=="lm"):
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





