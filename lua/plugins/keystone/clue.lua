local clue = require('keystone.clue')
clue.setup()
clue.add({
	{ "<leader>B",  group = "+Buffer",       mode = { "n" } },
	{ "<leader>c",  group = "+Code",         mode = { "n", "v" } },
	{ "<leader>f",  group = "+Find",         mode = { "n" } },
	{ "<leader>g",  group = "+Git",          mode = { "n" } },
	{ "<leader>d",  group = "+Debug",        mode = { "n" } },
	{ "<leader>dr", group = "+Run in Debug", mode = { "n" } },
	{ "<leader>o",  group = "+Others",       mode = { "n" } },
	{ "<leader>S",  group = "+Sessions",     mode = { "n" } },
	{ "<leader>p",  group = "+Project",      mode = { "n" } },
	{ "<leader>pb", group = "+Build",        mode = { "n" } },
	{ "<leader>pr", group = "+Run",          mode = { "n" } },
})
