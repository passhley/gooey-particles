local bindToRenderstep = require(script.Parent.Parent.Utility.bindToRenderstep)
local createParticle = require(script.Parent.Parent.GooeyParticle.createParticle)
local createEmitter = require(script.Parent.createEmitter)
local removeEmitter = require(script.Parent.removeEmitter)
local Types = require(script.Parent.Parent.Utility.Types)
local updateEmitter = require(script.Parent.updateEmitter)

type GooeyParticleProps = Types.GooeyParticleProps

local function registerSingleEmitter(container: GuiObject, props: GooeyParticleProps, emitAmount: number, onComplete: () -> () | nil): ()
	local emitter = createEmitter(container, props)
	for _ = 1, emitAmount do
		createParticle(emitter)
	end

	local disconnectEmitter = bindToRenderstep(function(dt)
		updateEmitter(emitter, dt)
	end)

	removeEmitter(emitter, disconnectEmitter)(function()
		onComplete()
	end)
end

return registerSingleEmitter
