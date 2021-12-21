local reconcileParticleProps = require(script.Utility.ParticleProps.reconcileParticleProps)
local registerSingleEmitter = require(script.GooeyEmitter.registerSingleEmitter)
local Types = require(script.Utility.Types)
local RoactElement = require(script.RoactElement)

type GooeyParticleProps = Types.GooeyParticleProps

local GooeyParticles = {RoactElement = RoactElement}

function GooeyParticles.Emit(container: GuiObject, pos: UDim2, props: GooeyParticleProps, emitAmount: number): ()
	reconcileParticleProps(props)

	local frame = Instance.new("Frame")
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundTransparency = 1
	frame.Position = pos
	frame.Size = UDim2.fromOffset(0, 0)
	frame.Parent = container

	registerSingleEmitter(frame, props, emitAmount, function()
		frame:Destroy()
		frame = nil
	end)
end

return GooeyParticles
