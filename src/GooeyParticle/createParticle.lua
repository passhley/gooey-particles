local HttpService = game:GetService("HttpService")

local conditionalProperty = require(script.Parent.Parent.Utility.conditionalProperty)
local Types = require(script.Parent.Parent.Utility.Types)

local RNG = Random.new()

type Emitter = Types.Emitter
type GooeyParticleEmitter = Types.GooeyParticleEmitter
type GooeyParticleProps = Types.GooeyParticleProps

local function getParticleLifetime(lifetime: number | NumberRange): number
	if typeof(lifetime) == "number" then
		return lifetime
	end

	return RNG:NextNumber(lifetime.Min, lifetime.Max)
end

local function getParticleVelocity(spread: NumberRange, speed: number): UDim2
	local angle = RNG:NextNumber(spread.Min, spread.Max)
	local run = math.cos(math.rad(angle)) * speed
	local rise = math.sin(math.rad(angle)) * speed

	return Vector2.new(run, rise) * 5
end

local function createParticleObject(container: GuiObject, props: GooeyParticleProps): ImageLabel
	local particle = Instance.new("ImageLabel")
	particle.AnchorPoint = Vector2.new(0.5, 0.5)
	particle.BackgroundTransparency = 1
	particle.Image = props.Image
	particle.ZIndex = props.ZIndex
	conditionalProperty(particle, typeof(props.Size) == "number", "Size", UDim2.fromOffset(props.Size, props.Size))
	conditionalProperty(particle, typeof(props.Transparency) == "number", "ImageTransparency", props.Transparency)
	conditionalProperty(particle, typeof(props.Color) == "Color3", "ImageColor3", props.Color)
	particle.Parent = container

	return particle
end

local function createParticle(emitter: Emitter | GooeyParticleEmitter)
	local id = HttpService:GenerateGUID(false)
	local lifetime = getParticleLifetime(emitter.props.Lifetime)

	local particle = {
		lifetime = lifetime,
		obj = createParticleObject(emitter.container, emitter.props),
		remove = function()
			emitter.particles[id] = nil
		end,
		rotation = RNG:NextNumber(emitter.props.Rotation.Min, emitter.props.Rotation.Max),
		spawnedAt = os.clock(),
		position = Vector2.new(0, 0),
		velocity = getParticleVelocity(emitter.props.Spread, emitter.props.Speed)
	}

	emitter.particles[id] = particle
end

return createParticle
