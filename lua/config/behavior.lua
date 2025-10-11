local M = {}

local setup_done = false

function M.setup()
	if setup_done then
		return
	end
	setup_done = true
	vim.api.nvim_create_autocmd("VimLeavePre", {
		callback = function()
			for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[bufnr].buftype == "terminal" then
					local job_id = vim.b[bufnr].terminal_job_id
					if job_id then
						vim.fn.jobstop(job_id)
					end
				end
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
		callback = function(args)
			local bufnr = args.buf
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			-- Skip unnamed or unloaded buffers
			if bufname == "" or not vim.api.nvim_buf_is_loaded(bufnr) then
				return
			end
			-- Use modern Lua API for buffer options
			local buftype = vim.bo[bufnr].buftype
			local modifiable = vim.bo[bufnr].modifiable
			if buftype ~= "" or not modifiable then
				return
			end
			vim.cmd("checktime")
		end,
	})
end

return M
