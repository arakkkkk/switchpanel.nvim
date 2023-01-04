local M = {}
local panel_list = require("switchpanel.panel_list")

M.active = nil
M.tabnr = 1
M.resume = nil

function M.switch(number)
	local ops = require("switchpanel").ops
	local builtin = ops.builtin[number]
	--  TODO: change to error and return
	assert(builtin, "Count of panel is less than " .. number)

	if M.active then
		M.close(M.active)
	end
	M.open(builtin)
	M.tabnr = number
end

function M.tabnext()
	local ops = require("switchpanel").ops
	if not M.active then
		return
	end

	local next_tabnr = M.tabnr + 1
	if M.tabnr == #ops.builtin then
		if not ops.builtin then
			return
		end
		next_tabnr = 1
	end

	M.close(M.active)
	M.open(ops.builtin[next_tabnr])
end

function M.tabprevious()
	local ops = require("switchpanel").ops
	if not M.active then
		return
	end

	local previous_tabnr = M.tabnr - 1
	if M.tabnr == #ops.builtin then
		if not ops.tab_repeat then
			return
		end
		previous_tabnr = #ops.builtin
	end

	M.close(M.active)
	M.open(ops.builtin[previous_tabnr])
end

function M.toggle()
	local ops = require("switchpanel").ops
	if not M.active then
		-- open
		M.open(ops.builtin[M.tabnr])
	else
		-- close
		M.close(M.active)
	end
end

function M.close(builtin)
	M.active = nil
	M.resume = builtin
	vim.cmd(builtin.close)
	print("close: ", builtin.close)
end

function M.open(builtin)
	panel_list.close()
	M.active = builtin
	M.resume = nil
	vim.cmd(builtin.open)
	print("open: ", builtin.open)
	panel_list.open()
end

return M
