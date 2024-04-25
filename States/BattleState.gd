extends Node

var current_health = 50
var max_health = 50
var player_damage = 20
var player_defense = 10

var player_level = 1
var exp = 0
var exp_total = 0
var exp_req = get_required_exp(player_level + 1)

func get_required_exp(player_level):
	return round(pow(player_level, 1.8) + player_level * 4)

func gain_exp(amount):
	exp_total += amount
	exp += amount
	while exp >= exp_req:
		exp -= exp_req
		levelup()
		
func levelup():
	player_level += 1
	exp_req = get_required_exp(player_level + 1)
	
	var stats = ['max_health', 'player_damage', 'player_defense']
	var random_stat = stats[randi() % stats.size()]
	set(random_stat, get(random_stat) + randi() % 4 + 2)
