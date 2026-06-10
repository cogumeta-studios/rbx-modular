local Replace = script.Replace
local Modular = {}

function Modular.Init(dir: Instance, initFn: string?)
	local modules = {}

	for _, module in dir:GetChildren() do
		if not module:IsA("ModuleScript") then continue end

		local replace = Replace:Clone()
		replace.Name = module.Name
		replace.Parent = module.Parent :: any
		module.Name = "Main"
		module.Parent = replace
		modules[module] = true
	end

	for module in modules do
		local compiled = (require)(module)
		if typeof(compiled) ~= "table" then return end
		if not compiled[initFn or "Init"] then return end
		compiled[initFn or "Init"]()
	end
end

return Modular
