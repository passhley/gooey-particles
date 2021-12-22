local defaultParticleProps = require(script.Parent.defaultParticleProps)
local Llama = require(script.Parent.Parent.Parent.Parent.Llama)
local Types = require(script.Parent.Parent.Types)

type GooeyParticleProps = Types.GooeyParticleProps

local function reconcileParticleProps(props: GooeyParticleProps): ()
	props = Llama.Dictionary.copy(props)

	for propertyName, defaultValue in pairs(defaultParticleProps) do
		if props[propertyName] == nil then
			props[propertyName] = defaultValue
		end
	end

	return props
end

return reconcileParticleProps
