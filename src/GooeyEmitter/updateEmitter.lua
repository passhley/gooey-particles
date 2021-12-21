local createParticle = require(script.Parent.Parent.GooeyParticle.createParticle)
local Types = require(script.Parent.Parent.Utility.Types)
local updateParticle = require(script.Parent.Parent.GooeyParticle.updateParticle)

type Emitter = Types.Emitter
type GooeyParticleEmitter = Types.GooeyParticleEmitter

local function updateEmitter(emitter: Emitter | GooeyParticleEmitter)
	if emitter.tick ~= nil then
		if emitter.props.Rate > 0 then
			emitter.tick += 1

			if emitter.tick % math.floor(60 / math.clamp(emitter.props.Rate, 0, 60)) == 0 then
				createParticle(emitter)
			end
		end
	end

	for _, particle in pairs(emitter.particles) do
		updateParticle(particle, emitter.props)
	end
end

return updateEmitter
