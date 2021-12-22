local conditionalProperty = require(script.Parent.Parent.Utility.conditionalProperty)
local evaluateColorSequence = require(script.Parent.Parent.Utility.Sequences.evaluateColorSequence)
local evaluateNumberSequence = require(script.Parent.Parent.Utility.Sequences.evaluateNumberSequence)
local Types = require(script.Parent.Parent.Utility.Types)

type GooeyParticle = Types.GooeyParticle
type GooeyParticleProps = Types.GooeyParticleProps

local function updateParticle(particle: GooeyParticle, props: GooeyParticleProps, dt: number): ()
	local currentTime = os.clock()
	local alpha = (currentTime - particle.spawnedAt) / particle.lifetime

	if alpha > 1 then
		particle.remove()
		particle.obj:Destroy()
		return
	end

	local acceleration = props.Acceleration * dt * 5
	particle.velocity += acceleration
	particle.position += particle.velocity * dt

	particle.obj.Position = UDim2.fromOffset(particle.position.X, particle.position.Y)
	particle.obj.Rotation += particle.rotation * dt

	if typeof(props.Transparency) ~= "number" then
		particle.obj.ImageTransparency = evaluateNumberSequence(props.Transparency, alpha)
	end

	if typeof(props.Color) ~= "Color3" then
		particle.obj.ImageColor3 = evaluateColorSequence(props.Color, alpha)
	end

	if typeof(props.Size) ~= "number" then
		local size = evaluateNumberSequence(props.Size, alpha)
		particle.obj.Size = UDim2.fromOffset(size, size)
	end
end

return updateParticle
