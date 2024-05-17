extends Node2D


@export var player_scene : PackedScene
@export var player_container: Node

func _ready():
    
    if not multiplayer.is_server():
        return
            
    var idx = 0 
    add_player(1,idx)
    idx += 1    
    for id in multiplayer.get_peers():
        add_player(id, idx)    
        idx+=1    
    
func add_player(id, idx):
    var player_instance: CharacterBody2D = player_scene.instantiate()
    player_instance.name = str(id)    
    player_instance.global_position = get_spawn_point(idx)
    player_container.add_child(player_instance)    
    print("Adding child "+str(id)+" at "+str(player_instance.global_position))
    
func get_spawn_point(idx):
    var locs=get_tree().get_nodes_in_group("SpawnLocation")
    return locs[idx].global_position
    
    
    
