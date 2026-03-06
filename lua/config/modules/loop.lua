require("loop").setup({
	workspace_data_dir = ".nvimloop",
	macros = {
		add = function(_, value1, value2)
			local n1 = tonumber(value1) or 0
			local n2 = tonumber(value2) or 0
			return tostring(n1 + n2)
		end
	},
	isolation = {
		shada = true,
		undo = true,
	}
})
