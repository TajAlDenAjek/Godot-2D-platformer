extends Sprite


var dir=false;
var X;
var Y;


# main laptop for bsher function
func _physics_process(_delta):
	if dir :
		position.x-=X;
	else:
		position.x+=X;



# relation between bsher and the laptop
func init(d,x):
	dir=d;
	X=x;




# intialaing some variables
func _ready():
	scale = Vector2(0.5,0.5);


# detecting collision with pejama
func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
