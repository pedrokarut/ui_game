extends Node

@onready var grass_tilemap = get_node("Grass")
@onready var water_tilemap = get_node("Water")
const FOAM: PackedScene = preload("res://foam.tscn")

var grass_used_cells
var water_used_cells

func _ready():
	var used_grass_rect = grass_tilemap.get_used_rect()
	grass_used_cells = grass_tilemap.get_used_cells(0)
	generate_water_tiles(used_grass_rect)
	generate_foam_tiles()
	
func generate_water_tiles(used_rec):
	for x in range(used_rec.position.x -10, used_rec.size.x +10):
		for y in range(used_rec.position.y -10, used_rec.size.y + 10):
			if grass_used_cells.has(Vector2i(x,y)):
				continue
				
			water_tilemap.set_cell(0,Vector2(x,y),0,Vector2(0,0))
			
	water_used_cells = water_tilemap.get_used_cells(0)
			
func generate_foam_tiles():
	for cell in grass_used_cells:
		if check_grass_neighbors(cell):
			spawn_foam(cell)
		
func check_grass_neighbors(cell: Vector2i):
	var left = Vector2i(cell.x -1, cell.y)
	var right = Vector2i(cell.x +1, cell.y)
	var up = Vector2i(cell.x, cell.y -1)
	var down = Vector2i(cell.x, cell.y + 1)

	var list_nei = [left, right, up, down]
	
	for neighbor in list_nei:
		if water_used_cells.has(neighbor):
			return true
			
func spawn_foam(foam_cell: Vector2):
	var foam = FOAM.instantiate()
	add_child(foam)
	foam.position = (foam_cell * 64.0) + Vector2(32,32)
