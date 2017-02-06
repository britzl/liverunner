return {
	ground = {
		[1] = {
			factory = "level1/level1#groundfactory",
			z = 0,
			y = 0,
			spacing = { min = 0, max = 0 },
			y_variation = { min = 0, max = 0 },
			sprites = { hash("Walking Platforms 1") },
			amount = 2,
		},
		[2] = {
			factory = "level2:/level2#groundfactory",
			z = 0,
			y = 0,
			spacing = { min = 0, max = 0 },
			y_variation = { min = 0, max = 0 },
			sprites = { hash("Walking Platforms 3") },
			amount = 2,
		},
		[3] = {
			factory = "level3:/level3#groundfactory",
			z = 0,
			y = 0,
			spacing = { min = 0, max = 0 },
			y_variation = { min = 0, max = 0 },
			sprites = { hash("Walking Platforms 13") },
			amount = 2,
		},
	},
	clouds = {
		[1] = {
			factory = "level1/level1#factory",
			z = -0.8,
			y = 500,
			spacing = { min = 50, max = 100 },
			y_variation = { min = -150, max = 250 },
			sprites = { hash("Clouds 1"), hash("Clouds 2"), hash("Clouds 7") },
			amount = 8,
		},
		[2] = {
			factory = "level2:/level2#factory",
			z = -0.8,
			y = 500,
			spacing = { min = 50, max = 100 },
			y_variation = { min = -150, max = 250 },
			sprites = { hash("Clouds 2"), hash("Clouds 3"), hash("Clouds 4") },
			amount = 8,
		},
		[3] = {
			factory = "level3:/level3#factory",
			z = -0.8,
			y = 500,
			spacing = { min = 50, max = 100 },
			y_variation = { min = -150, max = 250 },
			sprites = { hash("Clouds 4"), hash("Clouds 5"), hash("Clouds 6") },
			amount = 8,
		},
	},
	foreground = {
		[1] = {
			factory = "level1/level1#factory",
			z = -0.2,
			y = 300,
			spacing = { min = 250, max = 400 },
			y_variation = { min = -30, max = 10 },
			sprites = { hash("Forest Tree 1"), hash("Forest Tree 2"), hash("Forest Tree 3"), },
			amount = 6,
			objects = {}
		},
		[2] = {
			factory = "level2:/level2#factory",
			z = -0.2,
			y = 300,
			spacing = { min = 250, max = 400 },
			y_variation = { min = -30, max = 10 },
			sprites = { hash("Forest Tree 1"), hash("Forest Tree 2"), hash("Forest Tree 3"), hash("Forest Tree 4"), },
			amount = 6,
			objects = {}
		},
		[3] = {
			factory = "level3:/level3#factory",
			z = -0.2,
			y = 300,
			spacing = { min = 250, max = 400 },
			y_variation = { min = -30, max = 10 },
			sprites = { hash("Forest Tree 6"), hash("Forest Tree 7"), },
			amount = 6,
			objects = {}
		},
	},
	background1 = {
		[1] = {
			factory = "level1/level1#factory",
			z = -0.5,
			y = 300,
			spacing = { min = 20, max = 150 },
			y_variation = { min = -150, max = 10 },
			sprites = { hash("Hill 1"), hash("Hill 2"), hash("Hill 3"), hash("Hill 4"), },
			amount = 6,
			objects = {}
		},
		[2] = {
			factory = "level2:/level2#factory",
			z = -0.5,
			y = 300,
			spacing = { min = 20, max = 150 },
			y_variation = { min = -150, max = 10 },
			sprites = { hash("Hill 4"), hash("Hill 5"), hash("Hill 7") },
			amount = 6,
			objects = {}
		},
		[3] = {
			factory = "level3:/level3#factory",
			z = -0.5,
			y = 300,
			spacing = { min = 0, max = 0 },
			y_variation = { min = 0, max = 0 },
			sprites = { hash("layer_03_1920 x 1080") },
			amount = 2,
			objects = {}
		},
	},
}
