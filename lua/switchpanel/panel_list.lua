local M = {}

M.ft = "SwitchPanelList"

local s = require("switchpanel")

function M.render()
	local ops = require("switchpanel").ops
	local lines = {}
	for _, b in pairs(ops.builtin) do
		table.insert(lines, " ")
		table.insert(lines, " " .. b.icon)
	end
	for _ = 1, 100 do
		table.insert(lines, " ")
	end
	vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, true, lines)
end

function M.autocmd()
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "<buffer=" .. M.bufnr .. ">",
		callback = function()
			local win = vim.fn.winnr()
			if M.nofocus then
				if win == vim.fn.winnr("1h") then
					vim.cmd("wincmd 10l")
				else
					vim.cmd("wincmd p")
				end
			end
		end,
	})
end

function M.setbuf()
	M.bufnr = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_buf_set_name(M.bufnr, M.ft)
	M.render()

	local bufopts = {
		{ name = "swapfile", val = false },
		{ name = "buftype", val = "nofile" },
		{ name = "modifiable", val = false },
		{ name = "filetype", val = M.ft },
		{ name = "bufhidden", val = "hide" },
	}
	for _, opt in ipairs(bufopts) do
		vim.bo[M.bufnr][opt.name] = opt.val
	end
end

function M.setwin()
	vim.cmd("vsp")
	local winopts = {
		relativenumber = false,
		number = false,
		list = false,
		winfixwidth = true,
		winfixheight = true,
		foldenable = false,
		spell = false,
		signcolumn = "no",
		foldmethod = "manual",
		foldcolumn = "0",
		cursorcolumn = false,
		colorcolumn = "0",
	}
	for k, v in pairs(winopts) do
		vim.api.nvim_win_set_option(0, k, v)
	end
end

function M.set_win_hi()
	local ops = require("switchpanel").ops
	local hi = vim.api.nvim_buf_add_highlight
	-- Background
	vim.api.nvim_win_set_option(
		0,
		"winhighlight",
		"Normal:PanelListNormal,EndOfBuffer:PanelList,VertSplit:PanelListVert,SignColumn:PanelList,CursorLine:PanelListSelected"
	)
	vim.api.nvim_set_hl(0, "PanelList", {
		fg = "NONE",
		bg = ops.panel_list.background,
	})
	vim.api.nvim_set_hl(0, "PanelListVert", {
		fg = ops.panel_list.background,
		bg = ops.panel_list.background,
	})
	-- Selected
	vim.api.nvim_set_hl(0, "PanelListSelected", {
		fg = "NONE",
		bg = ops.panel_list.selected,
	})
	-- Icons
	vim.api.nvim_set_hl(0, "PanelListNormal", {
		fg = "none",
		bg = ops.panel_list.background,
	})
end

function M.open()
	if M.isOpen() then
		return
	end
	if not M.bufnr then
		M.setbuf()
	end
	M.setwin()
	vim.cmd("buffer " .. M.bufnr)
	vim.cmd("wincmd H")
	M.winnr = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_width(0, 2)

	M.set_win_hi()

	vim.cmd("wincmd p")
	M.nofocus = true
	M.autocmd()
end

function M.close()
	M.nofocus = false
	local win = M.getWinByFileType(M.ft)
	if not win then
		return
	end
	vim.api.nvim_win_close(win, true)
end

function M.setCursor()
	local ops = require("switchpanel").ops
	local win = M.getWinByFileType(M.ft)
	local active = M.getActive()
	assert(active)
	M.nofocus = false
	vim.api.nvim_win_set_cursor(win, { active.count * 2, 1 })
	vim.api.nvim_win_set_width(active.win, ops.width)
	if ops.focus_on_open then
		--  TODO: 
		vim.cmd("wincmd 10h")
		vim.cmd("wincmd l")
	else
		--  TODO: 
		vim.cmd("wincmd 10h")
		vim.cmd("wincmd 2l")
	end
	M.nofocus = true
end

function M.getActive()
	local ops = require("switchpanel").ops
	local count = 0
	for key, builtin in pairs(ops.builtin) do
		count = count + 1
		local win, bufnr = M.getWinByFileType(builtin.filetype)
		if win then
			return { count = count, builtin = builtin, win=win, bufnr=bufnr }
		end
	end
	return false
end

function M.getWinByFileType(filetype)
	for _, win in pairs(vim.api.nvim_list_wins()) do
		local bufnr = vim.api.nvim_win_get_buf(win)
		local win_filetype = vim.bo[bufnr].filetype
		if filetype == win_filetype then
			return win, bufnr
		end
	end
	return nil
end

function M.isOpen()
	return M.getWinByFileType(M.ft)
end
return M
