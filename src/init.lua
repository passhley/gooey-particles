local reconcileParticleProps = require(script.Utility.ParticleProps.reconcileParticleProps)
local registerEmitter = require(script.GooeyEmitter.registerEmitter)
local registerSingleEmitter = require(script.GooeyEmitter.registerSingleEmitter)
local RoactElement = require(script.RoactElement)
local Types = require(script.Utility.Types)

type GooeyParticleProps = Types.GooeyParticleProps
type GooeyEmitter = Types.GooeyEmitter

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

function GooeyParticles.CreateEmitter(container: GuiObject, pos: UDim2, props: GooeyParticleProps): GooeyEmitter
	reconcileParticleProps(props)

	local frame = Instance.new("Frame")
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundTransparency = 1
	frame.Position = pos
	frame.Size = UDim2.fromOffset(0, 0)
	frame.Parent = container

	local gooeyEmitter = {
		container = frame,
		emitter = nil,
		props = props,
	}

	function gooeyEmitter:SetEnabled(enabled: boolean): ()
		if enabled == true then
			if self.emitter == nil then
				self.emitter = registerEmitter(self.container, self.props)
			end
		elseif enabled == false then
			if self.emitter ~= nil then
				self.emitter()
				self.emitter = nil
			end
		end
	end

	function gooeyEmitter:Destroy(onComplete: () -> () | nil): ()
		if self.emitter ~= nil then
			self.emitter(function()
				self.container:Destroy()

				if onComplete ~= nil then
					onComplete()
				end
			end)
		end
	end

	return gooeyEmitter
end

return GooeyParticles
