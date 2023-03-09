extends Label


func _ready():
	text=("best score "+String(GlobalScript.best_score));

func _process(_delta):
	if GlobalScript.enemy_killed > GlobalScript.best_score:
		GlobalScript.best_score=GlobalScript.enemy_killed;
