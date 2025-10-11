-- :h lsp-config

-- enable configured language servers
-- you can find server configurations from lsp/*.lua files

local lsp_config_path = vim.fn.stdpath("config") .. "/lsp"
for _, file in ipairs(vim.fn.readdir(lsp_config_path)) do
	if file:match("%.lua$") then
		local name = file:gsub("%.lua$", "")
		-- vim.notify("Enabling lsp config: " .. name)
		vim.lsp.enable(name)
	end
end

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client then
			-- client.server_capabilities.semanticTokensProvider = nil -- disable it
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end
		end
	end,
})

local function toggle_virtual_text()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current })
end

-- Jump to next/previous function using built-in LSP
local function jump_func_lsp(next_func)
	local params = { textDocument = vim.lsp.util.make_text_document_params() }

	vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, function(err, result, ctx, _)
		if err or not result then
			vim.notify("No LSP symbols available", vim.log.levels.WARN)
			return
		end

		-- Normalize symbols (LSPs can return two different formats)
		local function flatten_symbols(symbols, acc)
			acc = acc or {}
			for _, sym in ipairs(symbols) do
				if sym.kind == vim.lsp.protocol.SymbolKind.Function
					or sym.kind == vim.lsp.protocol.SymbolKind.Method
					or sym.kind == vim.lsp.protocol.SymbolKind.Constructor then
					table.insert(acc, sym)
				end
				if sym.children then
					flatten_symbols(sym.children, acc)
				end
			end
			return acc
		end

		local symbols = flatten_symbols(result)
		if #symbols == 0 then
			vim.notify("No functions found via LSP", vim.log.levels.INFO)
			return
		end

		-- Current cursor line (0-indexed)
		local cur_line = vim.api.nvim_win_get_cursor(0)[1] - 1

		-- Sort by start line
		table.sort(symbols, function(a, b)
			return a.range.start.line < b.range.start.line
		end)

		local target = nil
		if next_func then
			for _, sym in ipairs(symbols) do
				if sym.range.start.line > cur_line then
					target = sym
					break
				end
			end
		else
			for i = #symbols, 1, -1 do
				if symbols[i].range["end"].line < cur_line then
					target = symbols[i]
					break
				end
			end
		end

		if target then
			local line = target.range.start.line
			local col  = target.range.start.character
			vim.api.nvim_win_set_cursor(0, { line + 1, col })
		end
	end)
end

-- Keymaps
vim.keymap.set('n', ']f', function() jump_func_lsp(true) end, { desc = 'Next function (LSP)' })
vim.keymap.set('n', '[f', function() jump_func_lsp(false) end, { desc = 'Previous function (LSP)' })

vim.api.nvim_del_keymap('n', 'gO')
vim.api.nvim_del_keymap('n', '<C-w><C-D>')
vim.api.nvim_del_keymap('n', '<C-w>d')

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })

vim.keymap.set({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
vim.keymap.set("n", "<leader>cd", function() vim.lsp.buf.definition() end, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>cD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
vim.keymap.set("n", "<leader>ci", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation" })
vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.references() end, { desc = "Show references" })
vim.keymap.set("n", "<leader>ch", function() vim.lsp.buf.hover() end, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>cs", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })
vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format { async = true } end, { desc = "Format code" })
vim.keymap.set("n", "<leader>ct", function() vim.lsp.buf.type_definition() end, { desc = "Go to type definition" })
vim.keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>cH", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
	{ desc = "Toggle inlay hints" })
vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.open_float() end,
	{ desc = "Diagnostics: Show line diagnostics" })
vim.keymap.set("n", "<leader>ct", toggle_virtual_text, { desc = "Diagnostics: Toggle virtual text" })

vim.keymap.set("n", "<leader>cwa", function() vim.lsp.buf.add_workspace_folder() end, { desc = "Add workspace folder" })
vim.keymap.set("n", "<leader>cwr", function() vim.lsp.buf.remove_workspace_folder() end,
	{ desc = "Remove workspace folder" })
vim.keymap.set("n", "<leader>cwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
	{ desc = "List workspace folders" })
