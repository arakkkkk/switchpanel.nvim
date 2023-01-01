vim.api.nvim_create_user_command("SwitchPanelSwitch", function(arg)
	require("switchpanel.panel").switch(tonumber(arg.args))
end, { nargs = "?" })

vim.api.nvim_create_user_command("SwitchPanelNext", function(arg)
	require("switchpanel.panel").tabnext()
end, {})

vim.api.nvim_create_user_command("SwitchPanelPrevious", function(arg)
	require("switchpanel.panel").tabprevious()
end, {})

vim.api.nvim_create_user_command("SwitchPanelToggle", function(arg)
	require("switchpanel.panel").toggle()
end, {})
