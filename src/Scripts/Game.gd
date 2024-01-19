extends Node
#var your_scene = preload("res://tree.tscn")
@onready var tilemap 	: TileMap = $TileMap 
@onready var player  	: CharacterBody2D = $NavigationRegion2D/Player 
@onready var navRegion  : NavigationRegion2D = $NavigationRegion2D 

func _ready():
	set_process_input(true)
	#$Timer.start()
	var cell_position = Vector2(10, 15)  # Exemplo de posição da célula
	var data = tilemap.get_cell_tile_data(0, cell_position)
	
	print(tilemap.map_to_local(cell_position))
	
	#var local_position = tilemap.map_to_local(cell_position)
	#var new_object = your_scene.instantiate()
	#new_object.position = local_position
	#add_child(new_object)
	
#func _on_timer_timeout():
	#print("_on_timer_timeout")
	#for i in $Node.get_children():
		##print(i.name)
		#if i.is_in_group("enemy"):
			##print(i.name)
			#i.test()

func _input(event):
	if event.is_action_pressed("ui_action"):
		var character_global_position = Vector2(player.global_position.x, player.global_position.y+16)
		var tile_position = tilemap.local_to_map(character_global_position)
		tilemap.set_cell(0, tile_position, 0, Vector2i(0,0))
		tilemap.set_cell(2, tile_position, 0, Vector2i(2,1))

		var current_navpoly = navRegion.navigation_polygon

		# Se você precisar dos contornos do NavigationPolygon
		var outlines = current_navpoly.get_outline(0)
		
		#var new_navigation_mesh = NavigationPolygon.new()
		var new_navigation_mesh = load("res://NavigationPolygon.tres")
		var NMSGD = NavigationMeshSourceGeometryData2D.new()
		NavigationServer2D.parse_source_geometry_data(new_navigation_mesh, NMSGD, $NavigationRegion2D)
		NavigationServer2D.bake_from_source_geometry_data(new_navigation_mesh, NMSGD);
		$NavigationRegion2D.navigation_polygon = new_navigation_mesh
		
		
	if event.is_action_pressed("ui_accept"):
		
		#var new_navigation_mesh = $Node/NavigationRegion2D.navigation_polygon
		#var bounding_outline = $Node/NavigationRegion2D.outl
		#new_navigation_mesh.add_outline(bounding_outline)
		#NavigationServer2D.bake_from_source_geometry_data(new_navigation_mesh, NavigationMeshSourceGeometryData2D.new());
		#$Node/NavigationRegion2D.navigation_polygon = new_navigation_mesh
		
		#for i in 10:
		createEnemy()
		
		
func createEnemy():
	var scene = load("res://enemy.tscn")
	var node_instance = scene.instantiate()
	node_instance.add_to_group("enemy")
	node_instance.position = Vector2(0, 0)
	$NavigationRegion2D.add_child(node_instance)
