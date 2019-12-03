extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var moveArray = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	var bulletCounter = 0
	

	#var x = get_tree().get_nodes_in_group("Bullet").size()
	#print(x)
	#for child in get_tree().get_root().find_node("Bullet", true, false):
	#	print(child)
		
func getallnodes(node):
    for N in node.get_children():
        if N.get_child_count() > 0:
            print("["+N.get_name()+"]")
            getallnodes(N)
        else:
            # Do something
            print("- "+N.get_name())