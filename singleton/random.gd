extends Node



var rng = RandomNumberGenerator.new()

func get_random(min:int, max:int):
	rng.randomize()
	return rng.randi_range(min, max)

func get_weighted_random(enemylevel):
	rng.randomize()
	var weighted_sum = 0
	for key in enemylevel:
		weighted_sum += enemylevel[key]
	var randomnumber = rng.randi_range(0,weighted_sum)
	for key in enemylevel:
		if randomnumber <= enemylevel[key]:
			return key
		else:
			randomnumber -= enemylevel[key]
