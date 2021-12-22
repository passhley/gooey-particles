local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GooeyParticles = require(ReplicatedStorage.Packages.GooeyParticles)

return function(t)
	local button = Instance.new("TextButton")
	button.Size = UDim2.fromOffset(200, 50)
	button.BackgroundColor3 = Color3.new(1, 1, 1)
	button.Position = UDim2.fromScale(0.5, 0.5)
	button.AnchorPoint = Vector2.new(0.5, 0.5)
	button.Text = "Hover over me!"
	button.Font = Enum.Font.Gotham
	button.TextSize = 20
	button.ZIndex = 2
	button.Parent = t

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 4)
	uiCorner.Parent = button

	local emitter = GooeyParticles.CreateEmitter(
		button,
		UDim2.fromScale(0.5, 0.5),
		{
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
		}
	)

	local connections = {}
	table.insert(connections, button.MouseEnter:Connect(function()
		emitter:SetEnabled(true)
	end))
	table.insert(connections, button.MouseLeave:Connect(function()
		emitter:SetEnabled(false)
	end))

	return function()
		emitter:Destroy(function()
			for _, connection in ipairs(connections) do
				connection:Disconnect()
			end

			connections = nil
			button:Destroy()
			button = nil
			emitter = nil
		end)
	end
end
