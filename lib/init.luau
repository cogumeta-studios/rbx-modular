local Replace = script.Replace
local Modular = {}

function Modular.Init(dir: Instance, initFn: string?)
	local modules: { [ModuleScript]: true } = {}

	for _, module in dir:GetChildren() do
		if not module:IsA("ModuleScript") then continue end

		local replace = Replace:Clone()
		replace.Name = module.Name
		replace.Parent = module.Parent :: any
		module.Name = `MODULAR_{module.Name}`
		modules[module] = true
	end

	for module in modules do
		xpcall(
			function()
				local compiled = (require)(module)
				if typeof(compiled) ~= "table" then return end
				if not compiled[initFn or "Init"] then return end
				compiled[initFn or "Init"]()
			end,
			function(err)
				warn(
					`[Modular] Failed when loading module {module
						:GetFullName()
						:split("MODULAR_")[2]}: {err}`
				)
			end
		)
	end
end

return Modular
