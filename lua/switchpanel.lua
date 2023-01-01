local switchpanel = {}


function switchpanel.setup(ops)
	ops = ops or {}
	ops = require("switchpanel.ops").get_ops(ops)
	switchpanel.ops = ops
	require("switchpanel.command")

	local default_builtin = require("switchpanel.builtin")
	for i, builtin in pairs(ops.builtin) do
		if type(builtin) == "string" then
			ops.builtin[i] = default_builtin[builtin]
		end
	end
end

return switchpanel
