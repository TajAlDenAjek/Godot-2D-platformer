extends Label



	
func _process(_delta):
		text=("Kills "+String(GlobalScript.enemy_killed));
		text+=("  wave "+String(GlobalScript.wave));
#		text+=("  next wave "+String(Main.getTime()));
