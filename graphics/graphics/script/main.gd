extends Node2D

@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel
@onready var fade: ColorRect = $HUD/ColorRect

var level: int = 1
var score: int = 0
var current_level_root: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.modulate.a = 1.0
	current_level_root = get_node_or_null("LevelRoot")
	await _load_level(level, true, false)

# Level management 
func _load_level(level_number: int, first_load: bool, reset_score: bool) -> void:
	if not first_load:
		await _fade(1.0)
		
	if reset_score:
		score = 0
		score_label.text = "SCORE: 0"
		
	if current_level_root:
		current_level_root.queue_free()
		current_level_root = null
		
	var level_path = "res://levels/level%s.tscn" % level_number
	
	if ResourceLoader.exists(level_path):
		var level_resource = load(level_path)
		current_level_root = level_resource.instantiate()
		add_child(current_level_root)
		current_level_root.name = "LevelRoot"
		_setup_level(current_level_root)
	else:
		# If level 3 doesn't exist, this part will handle the game exit
		print("Level file not found. Game over.")
		return 

	await _fade(0.0)
	
func _setup_level(level_root: Node) -> void:
	# Connect Exit
	var exit_node = level_root.get_node_or_null("exit")
	if not exit_node:
		exit_node = level_root.get_node_or_null("exite")
		
	if exit_node:
		exit_node.body_entered.connect(_on_exit_body_entered)
		
	# Connect Apples (This fixes the score not increasing)
	var apples = level_root.get_node_or_null("Apples")
	if apples:
		for apple in apples.get_children():
			if apple.has_signal("collected"):
				# Manually connect the signal to the increase_score function
				apple.collected.connect(increase_score)
			
	# Connect Enemies
	var enemies = level_root.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			if enemy.has_signal("player_died"):
				enemy.player_died.connect(_on_player_died)

#-------------------
# Signal Handlers

func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var next_level = level + 1
		var next_path = "res://levels/level%s.tscn" % next_level
		
		if ResourceLoader.exists(next_path):
			level = next_level
			body.can_move = false
			await _load_level(level, false, false)
		else:
			# Logic to quit the run after finishing Level 2
			print("Final Level Finished! Quitting game...")
			body.can_move = false
			await _fade(1.0)
			get_tree().quit()

func _on_player_died(body):
	if body.has_method("die"):
		body.die()
	await _load_level(level, false, true)

func increase_score() -> void:
	score += 1
	score_label.text = "SCORE: %s" % score
 
# Fade logic
func _fade(to_alpha: float) -> void:
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", to_alpha, 1.5)
	await tween.finished
