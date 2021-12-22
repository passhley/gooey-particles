local Types = require(script.Parent.Parent.Utility.Types)
local reconcileParticleProps = require(script.Parent.Parent.Utility.ParticleProps.reconcileParticleProps)

type GooeyParticleProps = Types.GooeyParticleProps
type Emitter = Types.Emitter

local function createEmitter(container: GuiObject, props: GooeyParticleProps): Emitter
	props = reconcileParticleProps(props)
	return {
		container = container,
		particles = {},
		props = props
	}
end

return createEmitter
