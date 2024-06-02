extends CharacterBody2D

@export var speed = 150
var owner_id=1
@export var init_position = Vector2(0,0)

func _enter_tree():
    owner_id = name.to_int()
    set_multiplayer_authority(owner_id)
    
    if owner_id != multiplayer.get_unique_id():
        return

func _ready():
    pass
    
        

func _on_timer_timeout() -> void:
    print("%s location %s" % name, position)
    
    

func _physics_process(delta):
    if owner_id != multiplayer.get_unique_id():
        return
        
    get_input()
    move_and_slide()
    
func get_input():
    var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
    velocity = input_direction * speed
    
@rpc("any_peer","call_local","reliable")
func update_position(pos: Vector2):
    print(name+": Setting my position to "+str(pos))
    position=pos
