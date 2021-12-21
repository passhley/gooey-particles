local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local GooeyParticles = require(ReplicatedStorage.Packages.GooeyParticles)

local Particles = GooeyParticles.RoactElement

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
		Text = "Hover over me!",
		TextSize = 20,
		ZIndex = 2,

		[Roact.Event.MouseEnter] = function()
			self:setState({
				hovered = true
			})
		end,
		[Roact.Event.MouseLeave] = function()
			self:setState({
				hovered = false
			})
		end,
	}, {
		UICorner = Roact.createElement("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),

		Particles = Roact.createElement(Particles, {
			Enabled = self.state.hovered,
			Rotation = NumberRange.new(-360, 360),
			Lifetime = NumberRange.new(0.3, 0.5),
			Rate = 40,
			Image = "rbxassetid://6319951708",
			Size = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 100)
			}),
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 1)
			}),
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.new(1, 1, 0))
			}),
		})
	})
end

return function(t)
	local handle = Roact.mount(Roact.createElement(TestEmitter), t)
	return function()
		Roact.unmount(handle)
		handle = nil
	end
end
