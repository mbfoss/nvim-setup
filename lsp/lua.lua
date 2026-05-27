
-- Convert filesystem path to URI
local function path_to_uri(path)
    local uri = "file://" .. path
    uri = uri:gsub("\\", "/") -- Windows support
    return uri
end

-- Find nearest Git ancestor using vim.fn
local function find_git_root(path)
    local dir = vim.fn.fnamemodify(path, ":p:h")
    while dir ~= "" and dir ~= "/" do
        if vim.fn.isdirectory(dir .. "/.git") == 1 then
            return dir
        end
        local parent = vim.fn.fnamemodify(dir, ":h")
        if parent == dir then
            break
        end
        dir = parent
    end
    return nil
end

-- Determine root: .git, .vscode, .loop, or current file folder
local function find_project_root(path)
    local markers = { ".git", ".vscode", ".loop" }

    local found = vim.fs.find(markers, {
        upward = true,
        path = vim.fn.fnamemodify(path, ":p:h"),
    })[1]

    if found then
        return vim.fs.dirname(found)
    end

    return nil
end

local function get_project_root()
    local file = vim.api.nvim_buf_get_name(0)
    local root = find_project_root(file)

    if root then
        return root
    else
        return vim.fn.fnamemodify(file, ":p:h")
    end
end


local project_root = get_project_root();

local workspace_library = {
	[project_root .. '/lua'] = true,
	[vim.fn.expand('$VIMRUNTIME/lua')] = true,
	[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
}


return {
	cmd = { "lua-language-server" },
	rootUri = path_to_uri(project_root),
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				globals = { 'vim', 'require' },
			},
			workspace = {
				library = workspace_library,
				maxPreload = 10000,
				preloadFileSize = 1000,
			},
			telemetry = { enable = false },
		},
	},
}

