local M = {}
local panel = require("switchpanel.panel")

function M.get_ops(options)
	local ops = {
		tab_repeat = true,
		
		mappings = {
			{"1", "SwitchPanelSwitch 1" },
			{"2", "SwitchPanelSwitch 2" },
			{"3", "SwitchPanelSwitch 3" },
			{"4", "SwitchPanelSwitch 4" },
			{"5", "SwitchPanelSwitch 5" },
			{"J", "SwitchPanelNext" },
			{"K", "SwitchPanelPrevious" },
		},

		builtin = {
			-- "aerial.nvim",
			"nvim-tree.lua",
			"sidebar.nvim"
		}
	}
	ops = require("switchpanel.utils").tableMerge(ops, options)
	return ops
end

return M
