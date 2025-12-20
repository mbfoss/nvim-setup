return {}
--[[
local class = require('loop.tools.class')
local ItemTreePage = require('loop.pages.ItemTreePage')
local uitools = require('loop.tools.uitools')
local config = require('loop.config')

---@alias loop.pages.CallersTreePage.Item loop.pages.ItemTreePage.Item

---@class loop.pages.CallersTreePage : loop.pages.ItemTreePage
---@field new fun(self: loop.pages.CallersTreePage, name:string): loop.pages.CallersTreePage
local CallersTreePage = class(ItemTreePage)

---@param id any
---@param data any
---@param highlights loop.pages.ItemTreePage.Highlight
---@return string
local function _caller_node_formatter(id, data, highlights)
	if not data then return "" end
	if not data.filename or data.filename == "" then
		table.insert(highlights, { group = "@comment" })
		return data.name or ""
	end
	table.insert(highlights, { group = "@function", start_col = 0, end_col = #data.name })
	table.insert(highlights, { group = "@comment", start_col = #data.name + 1 })
	return string.format("%s (%s:%d)", data.name, data.filename, data.lnum or 0)
end

---@param name string
function CallersTreePage:init(name)
	ItemTreePage.init(self, name, {
		formatter = _caller_node_formatter,
	})
	self:_add_keymaps()
end

function CallersTreePage:_add_keymaps()
	self:add_tracker({
		on_selection = function(id, data)
			if not data or not data.filename or data.filename == "" then return end
			uitools.smart_open_file(data.filename, data.lnum, data.col)
		end
	})
end

---@param win_id any
---@param bufnr any
---@param callback fun(items:loop.pages.ItemTreePage.Item[],retry:boolean|nil)
---@param visited any
function CallersTreePage:_load_callers(win_id, bufnr, item_or_position, callback, visited)
	visited = visited or {}

	-- Two completely different code paths depending on what we got
	local is_raw_item = type(item_or_position) == "table" and item_or_position.uri
	local item, need_prepare

	if is_raw_item and item_or_position.data ~= nil then
		-- Non-clangd path: we have a valid .data token → use it directly
		item = item_or_position
		need_prepare = false
	else
		-- clangd path (or fallback): we only have position info → must prepare again
		local pos = is_raw_item and item_or_position.selectionRange or item_or_position
		item = {
			uri = is_raw_item and item_or_position.uri or vim.uri_from_bufnr(bufnr),
			range = { start = pos.start, ["end"] = pos["end"] or pos.start },
			selectionRange = pos,
		}
		need_prepare = true
	end

	-- Cycle detection: use a stable string key
	local key = string.format("%s:%d:%d",
		vim.uri_to_fname(item.uri),
		item.selectionRange.start.line,
		item.selectionRange.start.character)

	local is_cycle = visited[key]
	local cycle_symbol = ''
	if is_cycle then
		cycle_symbol = config.current.window.symbols.cycle .. ' '
	end

	local function on_prepare(err, prepared_items)
		if err or not prepared_items or #prepared_items == 0 then
			callback({})
			return
		end

		local prepared = prepared_items[1]

		vim.lsp.buf_request(bufnr, "callHierarchy/incomingCalls", { item = prepared }, function(err2, calls)
			if err2 or not calls then
				callback({})
				return
			end

			local children = {}
			for _, call in ipairs(calls) do
				local from = call.from
				local range = call.fromRanges and call.fromRanges[1] or from.selectionRange or from.range

				local filename = vim.uri_to_fname(from.uri)
				local lnum = range.start.line + 1
				local col = range.start.character + 1

				local node = {
					id = {},
					expanded = false,
					data = {
						name = cycle_symbol .. (from.name or "<anonymous>"),
						filename = filename,
						lnum = lnum,
						col = col,
					},
					children_callback = function(cb)
						-- RECURSE: pass the full `from` item (works for everyone)
						-- clangd will hit the "need_prepare = true" branch automatically
						self:_load_callers(win_id, bufnr, from, cb, visited)
					end,
				}
				table.insert(children, node)
			end

			visited[key] = true
			callback(children, false) -- never retry on empty, it's valid
		end)
	end

	if need_prepare then
		local params = {
			textDocument = { uri = item.uri },
			position = item.selectionRange.start,
		}
		vim.lsp.buf_request(bufnr, "textDocument/prepareCallHierarchy", params, on_prepare)
	else
		on_prepare(nil, { item })
	end
end

function CallersTreePage:load()
	self:clear_items()

	local bufnr           = vim.api.nvim_get_current_buf()
	local win_id          = vim.api.nvim_get_current_win()
	local line, col       = unpack(vim.api.nvim_win_get_cursor(win_id))
	local symbol_position = vim.lsp.util.make_position_params(win_id, "utf-8")

	vim.lsp.buf_request(bufnr, "textDocument/prepareCallHierarchy", symbol_position, function(err, items)
		if err or not items or #items == 0 then
			self:upsert_item({
				id = "<root>",
				expanded = true,
				data = { name = "No call hierarchy", filename = "", lnum = 0, col = 0 },
			})
			return
		end

		local target = items[1] -- Root CallHierarchyItem
		local root = {
			id = {},
			expanded = true,
			data = {
				name = target.name or "<symbol>",
				filename = vim.api.nvim_buf_get_name(bufnr),
				lnum = line,
				col = col,
			},
		}

		root.children_callback = function(cb)
			self:_load_callers(win_id, bufnr, target, cb)
		end

		self:upsert_item(root)
	end)
end

local page_manager = nil 
local page = nil

vim.api.nvim_create_user_command(
	'CallTree', -- Command name
	function(opts)
		if not page then
			require("loop").setup()
			page_manager = require('loop.window').create_page_manager()
			page = CallersTreePage:new("Callers")
			local group = page_manager.get_page_group('ct')
			if not group then group = page_manager.add_page_group('ct', 'Call Tree') end
			group.add_page('ct', page)
		end
		page:load()
		require('loop.window').show_window()
		page_manager.get_page_group('ct').activate_page('ct')
	end,
	{} -- Optional options table
)
]]--
