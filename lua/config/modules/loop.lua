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

loop.register_macro('add', function(_, arg1, arg2)
			local n1, n2 = tonumber(arg1),tonumber(arg2)
			if not n1 or not n2 then return nil, "add macro error, invalid argument" end
			return tostring(n1 + n2)
		end)
