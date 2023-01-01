local M = {}
local panel = require("switchpanel.panel")

function M.get_ops(options)
	local ops = {
		tab_repeat = true,
		-- mappings = {
		-- 	n = {
		-- 		{"H", panel.tabnext }
		-- 	}
		-- },
		builtin = {
			"files",
			"outline",
		}
	}
	ops = require("switchpanel.utils").tableMerge(ops, options)
	return ops
end

return M
