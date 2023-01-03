local M = {}

local s = require("switchpanel")
local ops = require("switchpanel").ops

function M.render()
	local lines = {}
	for _, b in pairs(ops.builtin) do
		table.insert(lines, "")
		table.insert(lines, b.icon)
	end
	vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, true, lines)
end

function M.setup()
	M.bufnr = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_buf_set_name(M.bufnr, "SwitchPanelList")
	M.render()

	local bufopts = {
		{ name = "swapfile", val = false },
		{ name = "buftype", val = "nofile" },
		{ name = "modifiable", val = false },
		{ name = "filetype", val = "SidebarNvim" },
		{ name = "bufhidden", val = "hide" },
	}
	for _, opt in ipairs(bufopts) do
		vim.bo[M.bufnr][opt.name] = opt.val
	end

	vim.cmd("vsp")
	local winopts = {
		relativenumber = false,
		number = false,
		list = false,
		winfixwidth = true,
		winfixheight = true,
		foldenable = false,
		spell = false,
		signcolumn = "yes",
		foldmethod = "manual",
		foldcolumn = "0",
		cursorcolumn = false,
		colorcolumn = "0",
	}
	for k, v in pairs(winopts) do
		vim.api.nvim_win_set_option(0, k, v)
	end
end

function M.open()
	if not M.bufnr then
		M.setup()
	end
	vim.cmd("buffer " .. M.bufnr)
	vim.cmd("wincmd H")
	vim.api.nvim_win_set_width(0, 3)

	local hi = vim.api.nvim_buf_add_highlight
	vim.api.nvim_win_set_option(0, "winhighlight", "Normal:NormalPanelList")
	vim.api.nvim_set_hl(0, "NormalPanelList", {
		fg = "none",
		bg = "Blue",
	})

	vim.cmd("wincmd p")
end

function M.close() end

return M
