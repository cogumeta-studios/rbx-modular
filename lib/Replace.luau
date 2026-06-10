_G.modular = _G.modular or {}
local compiled = _G.modular[script]
if not compiled then
	xpcall(
		function() (require)(script:FindFirstChild("Main")) end,
		function(err) warn(`[Modular]: Failed when loading module: {err}`) end
	)
end
_G.modular[script] = compiled
return compiled
