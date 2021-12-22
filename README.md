# GooeyParticles
UI Particle System

## Particle Properties
```lua
type ParticleProperties = {
	Acceleration: Vector2,
	Color: Color3 | ColorSequence,
	Image: string,
	Lifetime: number | NumberRange,
	Rate: number,
	Rotation: NumberRange,
	Size: number | NumberSequence,
	Speed: number,
	Spread: NumberRange,
	Transparency: number | NumberSequence,
	ZIndex: number
}
```

## GooeyEmitter
#### Methods
Set's the emitter to be enabled or not
```lua
emitter:SetEnabled(enabled: boolean): ()
```
Destroy's the emitter, removing all connections. Allows
you to pass in a function that gets called when all particles
are finished running.
```lua
emitter:Destroy(onComplete: () -> () | nil): ()
```


## API
``Emit`` is used for a single burst of particles. Similar to ``ParticleEffect:Emit(number)``
```lua
GooeyParticles.Emit(
	container: GuiObject,
	position: UDim2,
	props: ParticleProperties,
	emitSize: number
): ()
```
``CreateEmitter`` is used to create a ``GooeyEmitter`` which is similar to your normal ``ParticleEmitter``,
you can turn it on or off by using ``emitter:SetEnabled(boolean)``
```lua
GooeyParticles.CreateEmitter(
	container: GuiObject,
	position: UDim2,
	props: ParticleProperties
): GooeyEmitter
```

## Usage
All examples can be found inside the [examples](examples) Folder
as hoarcekat stories.
### Continuous Emission
#### With Roact
```lua
-- RoactEmitterExample.story.lua
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
```
#### Without Roact
```lua
-- NativeEmitterExample.story.lua
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
```
### Single Emission
#### With Roact
```lua
-- RoactEmitExample.story.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
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

```
#### Without Roact
```lua
-- NativeEmitExample.story.lua
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

```
