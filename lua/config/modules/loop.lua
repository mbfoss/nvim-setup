local loop = require('loop')

require("loop").setup({
	macros = {
		add = function(_, value1, value2)
			local n1 = tonumber(value1) or 0
			local n2 = tonumber(value2) or 0
			return tostring(n1 + n2)
		end
	},
	use_fd_find = false,
})


loop.register_macro('test_macro', function(_, value1, value2)
			local n1 = tonumber(value1) or 0
			local n2 = tonumber(value2) or 0
			return tostring(n1 + n2)
		end)
