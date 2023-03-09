extends Sprite


var dir=false;
var X;
var Y;




# the main enemy bullet (glasses) function
func _physics_process(_delta):
	if dir :
		position.x-=X;
	else:
		position.x+=X;




# realtion between belal and the glasses
func init(d,x):
	dir=d;
	X=x;





# intilazing some variables
func _ready():
	scale = Vector2(0.5,0.5);





# detecting collision with player 
func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
