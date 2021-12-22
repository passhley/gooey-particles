local bindToRenderstep = require(script.Parent.Parent.Utility.bindToRenderstep)
local createEmitter = require(script.Parent.createEmitter)
local removeEmitter = require(script.Parent.removeEmitter)
local Types = require(script.Parent.Parent.Utility.Types)
local updateEmitter = require(script.Parent.updateEmitter)

type GooeyParticleProps = Types.GooeyParticleProps

local function registerEmitter(container: GuiObject, props: GooeyParticleProps)
	local emitter = createEmitter(container, props)
	emitter.spawnNextParticleAt = os.clock() + (1 / props.Rate)

	local disconnectEmitter = bindToRenderstep(function(dt)
		updateEmitter(emitter, dt)
	end)

	return removeEmitter(emitter, disconnectEmitter)
end

return registerEmitter
