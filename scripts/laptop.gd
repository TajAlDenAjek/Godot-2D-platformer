extends Sprite


var dir=false;
var X;
var Y;


# main laptop function
func _physics_process(_delta):  # the underscore before delta means i didn't used the variable
	if dir :
		position.x-=X;
	else:
		position.x+=X;



# relation between the player and the laptop
func init(d,x):
	dir=d;
	X=x;



# intilaizing some variables
func _ready():
	scale = Vector2(0.5,0.5);


# detecting collision with other shapes
func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
