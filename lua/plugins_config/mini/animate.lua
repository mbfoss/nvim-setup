local animate = require('mini.animate')

animate.setup({
	cursor = {
		enable = false,
		timing = animate.gen_timing.cubic({
			-- "unit" must be 'step' or 'total'
			unit = 'total', -- total time for the whole motion
			duration = 200, -- ms; increase for slower/smoother
			easing = "in-out", -- can be "in", "out", "in-out"
		}),
		path = animate.gen_path.line({
			step = 1, -- 1 = smooth, 2+ = more jumpy but lighter
		}),
	},

	scroll = {
		enable = true,
		timing = animate.gen_timing.cubic({
			unit = 'total',
			duration = 100, -- scrolling feels nicer slightly slower
			easing = "in-out",
		}),
		subscroll = animate.gen_subscroll.equal({
			max_output_steps = 80, -- higher = smoother long scrolls
		}),
	},

	resize = {
		enable = false,
		timing = animate.gen_timing.cubic({
			unit = 'total',
			duration = 120,
			easing = "in-out",
		}),
	},

	open = {
		enable = true,
		timing = animate.gen_timing.cubic({
			unit = 'total',
			duration = 100,
			easing = "in-out",
		}),
	},

	close = {
		enable = true,
		timing = animate.gen_timing.cubic({
			unit = 'total',
			duration = 100,
			easing = "in-out",
		}),
	},
})
