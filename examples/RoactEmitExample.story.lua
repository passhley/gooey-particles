local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local GooeyParticles = require(ReplicatedStorage.Packages.GooeyParticles)

local PARTICLE_PROPS = {
	Rotation = NumberRange.new(-360, 360),
	Lifetime = 1,
	Image = "rbxassetid://241629053",
	Speed = 30,
	Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 100),
		NumberSequenceKeypoint.new(1, 0)
	}),
	Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1)
	}),
}

local TestEmitter = Roact.PureComponent:extend("TestEmitter")

function TestEmitter:init()
	self:setState({
		hovered = false
	})
end

function TestEmitter:render()
	return Roact.createElement("TextButton", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.new(1, 1, 1),
		Font = Enum.Font.Gotham,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(200, 50),
		Text = "Click me!",
		TextSize = 20,
		ZIndex = 2,

		[Roact.Event.MouseButton1Click] = function(rbx)
			GooeyParticles.Emit(rbx, UDim2.fromScale(0.5, 0.5), PARTICLE_PROPS, 20)
		end
	}, {
		UICorner = Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
	})
end

return function(t)
	local handle = Roact.mount(Roact.createElement(TestEmitter), t)
	return function()
		Roact.unmount(handle)
		handle = nil
	end
end

