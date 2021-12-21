local conditionalProperty = require(script.Parent.Parent.Utility.conditionalProperty)
local evaluateColorSequence = require(script.Parent.Parent.Utility.Sequences.evaluateColorSequence)
local evaluateNumberSequence = require(script.Parent.Parent.Utility.Sequences.evaluateNumberSequence)
local Types = require(script.Parent.Parent.Utility.Types)

type GooeyParticle = Types.GooeyParticle
type GooeyParticleProps = Types.GooeyParticleProps

local function updateParticle(particle: GooeyParticle, props: GooeyParticleProps)
	particle.tick += 1
	local xAccel = 0
	local yAccel = 0

	if props.Acceleration.X ~= 0 then
		xAccel = props.Acceleration.X * (particle.tick / 60)

		if xAccel + particle.velocity.X.Offset == 0 then
			xAccel += 1
		end
	end

	if props.Acceleration.Y ~= 0 then
		yAccel = -props.Acceleration.Y * (particle.tick / 60)

		if yAccel + particle.velocity.Y.Offset == 0 then
			yAccel += 1
		end
	end

	local drag = UDim2.fromOffset(xAccel, yAccel)
	particle.obj.Position += particle.velocity + drag
	particle.obj.Rotation += particle.rotation

	local alpha = (particle.tick / 60) / particle.lifetime

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

	if particle.tick == particle.maxTick then
		particle.remove()
		particle.obj:Destroy()
	end
end

return updateParticle
