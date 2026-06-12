_G.modular = _G.modular or {}
local compiled = _G.modular[script]
if not compiled then
	xpcall(
		function()
			compiled = (require)(
				(script :: any).Parent[`MODULAR_{script.Name}`]
			)
		end,
		function(err) warn(`[Modular]: Failed when loading module: {err}`) end
	)
end
_G.modular[script] = compiled
return compiled
