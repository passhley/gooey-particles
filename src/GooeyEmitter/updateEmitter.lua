local createParticle = require(script.Parent.Parent.GooeyParticle.createParticle)
local Types = require(script.Parent.Parent.Utility.Types)
local updateParticle = require(script.Parent.Parent.GooeyParticle.updateParticle)

type Emitter = Types.Emitter
type GooeyParticleEmitter = Types.GooeyParticleEmitter

local function updateEmitter(emitter: Emitter | GooeyParticleEmitter, dt: number): ()
	if emitter.spawnNextParticleAt ~= nil then
		if emitter.props.Rate > 0 then
			local currentTime = os.clock()

			if currentTime >= emitter.spawnNextParticleAt then
				createParticle(emitter)
				emitter.spawnNextParticleAt = currentTime + (1 / emitter.props.Rate)
			end
		end
	end

	for _, particle in pairs(emitter.particles) do
		updateParticle(particle, emitter.props, dt)
	end
end

return updateEmitter
