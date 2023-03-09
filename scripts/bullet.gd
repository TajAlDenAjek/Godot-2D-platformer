extends Sprite

var dir=false;
var X;
var Y;





# main bullet function (refresh function)
func _physics_process(_delta):
	if dir :
		position.x-=X;
	else:
		position.x+=X;





# relation between player and the bullet
func init(d,x):
	dir=d;
	X=x;




# intilazing some variables 
func _ready():
	scale = Vector2(0.5,0.5);






# detecting collision & destroying the bullet (glass)
func _on_VisibilityNotifier2D_screen_exited():
	queue_free();
