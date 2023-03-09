extends KinematicBody2D



onready var bullet = preload("res://scenes/bullet.tscn");
onready var laptop = preload("res://scenes/laptop.tscn");
onready var animations=$AnimatedSprite;
onready var jumping_sound=$jump;
onready var moving_sound=$move;
onready var dying_sound=$dying;
onready var getDamage_sound=$damage;
onready var glasses_sound=$glass;
onready var laptop_sound=$laptop;
var instanceOfBullet;
var instanceOfLaptop;
var gravity = 1200 ;
var speed = 400;
var jump_force=-800;
var direction = Vector2.ZERO  # Vector2(0,0)
var temp;




# _main player function 
func _physics_process(delta):
	move(delta);
	shoot(animations.flip_h);
	direction= move_and_slide(direction,Vector2.UP); #Vector(0,-1)
	if not is_on_floor():
		_animations("j");
		




# shooting function
func shoot(dir):
	if  Input.is_action_just_pressed("attackOne") :
		glasses_sound.play();
		instanceOfBullet=bullet.instance();
		instanceOfBullet.init(dir,11);
		get_parent().add_child(instanceOfBullet);
		instanceOfBullet.global_position=$bull.global_position;
	if Input.is_action_pressed("attackOne"):
		_animations("a1");
	if  Input.is_action_just_pressed("attackTwo"):
		laptop_sound.play();
		instanceOfLaptop=laptop.instance();
		instanceOfLaptop.init(dir,8);
		get_parent().add_child(instanceOfLaptop);
		instanceOfLaptop.global_position=$lap.global_position;
	if Input.is_action_pressed("attackTwo"):
		_animations("a2");




# moving function
func move(delta):
	if Input.is_action_pressed("ui_right"):
		_animations("r");
		direction.x=speed;
		$bull.position.x=42.222;
		$lap.position.x=25;
	elif Input.is_action_pressed("ui_left"):
		_animations("l");
		direction.x=-speed;
		$lap.position.x=-25;
		$bull.position.x=-42.222;
	else :
		_animations("i");
		direction.x=0;
#	if Input.is_action_just_pressed("ui_right")||Input.is_action_just_pressed("ui_left"):
#		moving_sound.play();
	if Input.is_action_just_pressed("ui_up") && is_on_floor():
		jumping_sound.play();
		direction.y=jump_force;
	direction.y+=gravity*delta;





# animations function
func _animations(string):
	if(string=="j"):
		animations.play("jump");
	elif(string=="i" && is_on_floor()):
		animations.play("idle");
	elif(string=="r"||string=="l"):
		animations.play("move");
	elif(string=="a1"):
		animations.play("attackOne");
	elif(string=="a2"):
		animations.play("attackTwo");
	if (string =="r"):
		animations.set_flip_h(false);
	elif(string=="l"):
		animations.set_flip_h(true);
	
	

# detecting damage function
func _on_Area2D_area_entered(area):
	if "enemy" in area.get_parent().name:
		hitedByGlass(area);
	if "batman" in area.get_parent().name:
		hitedByLap(area);
	if "romi" in area.get_parent().name:
		hitedByPerson(area);
	if "oweis" in area.get_parent().name:
		hitedByPerson(area);
func hitedByGlass(a):
	a.get_parent().queue_free();
	$LifeBar.value-=25;
	getDamage_sound.play();
	if($LifeBar.value<=0):
		dying_sound.play();
		if $dying_time_freez.is_stopped():
			$dying_time_freez.start();
func hitedByLap(a):
	a.get_parent().queue_free();
	getDamage_sound.play();
	$LifeBar.value-=50;
	if($LifeBar.value<=0):
		dying_sound.play();
		if $dying_time_freez.is_stopped():
			$dying_time_freez.start();
func hitedByPerson(a):
	getDamage_sound.play();
	$LifeBar.value-=40;
	if($LifeBar.value<=0):
		dying_sound.play();
		if $dying_time_freez.is_stopped():
			$dying_time_freez.start();
	while "oweis" in a.get_parent() || "romi" in a.get_parent():
		hitedByPerson(a);
		





# death function and its freeze time
func _on_dying_time_freez_timeout():
	GlobalScript.restart();
