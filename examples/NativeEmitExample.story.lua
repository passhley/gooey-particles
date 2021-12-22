local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GooeyParticles = require(ReplicatedStorage.Packages.GooeyParticles)

local PARTICLE_PROPS = {
	Rotation = NumberRange.new(-360, 360),
	Lifetime = NumberRange.new(0.3, 0.5),
	Image = "rbxassetid://241629053",
	Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 100),
		NumberSequenceKeypoint.new(1, 0)
	}),
	Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(1, 1)
	}),
}

return function(t)
	local button = Instance.new("TextButton")
	button.Size = UDim2.fromOffset(200, 50)
	button.BackgroundColor3 = Color3.new(1, 1, 1)
	button.Position = UDim2.fromScale(0.5, 0.5)
	button.AnchorPoint = Vector2.new(0.5, 0.5)
	button.Text = "Click me!"
	button.Font = Enum.Font.Gotham
	button.TextSize = 20
	button.ZIndex = 2
	button.Parent = t

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 4)
	uiCorner.Parent = button

	local connection = button.MouseButton1Click:Connect(function()
		GooeyParticles.Emit(button, UDim2.fromScale(0.5, 0.5), PARTICLE_PROPS, 20)
	end)

	return function()
		connection:Disconnect()
		connection = nil
		button:Destroy()
		button = nil
	end
end

