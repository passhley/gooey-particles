local defaultProps = require(script.Parent.Utility.ParticleProps.defaultParticleProps)
local registerEmitter = require(script.Parent.GooeyEmitter.registerEmitter)
local Roact = require(script.Parent.Parent.Roact)

local RoactElement = Roact.PureComponent:extend("RoactElement")
RoactElement.defaultProps = defaultProps

function RoactElement:init()
	self.frameRef = Roact.createRef()
end

function RoactElement:didMount()
	if self.props.Enabled == true then
		self:createEmitter()
	end
end

function RoactElement:didUpdate(prevProps)
	if prevProps.Enabled ~= self.props.Enabled then
		if self.props.Enabled == true then
			self:createEmitter()
		else
			self:destroyEmitter()
		end
	end
end

function RoactElement:render()
	return Roact.createElement("Frame", {
		AnchorPoint = self.props.AnchorPoint,
		Position = self.props.Position,
		Size = UDim2.fromOffset(0, 0),
		ZIndex = self.props.ZIndex,
		[Roact.Ref] = self.frameRef
	})
end

function RoactElement:willUnmount()
	self:destroyEmitter()
end

function RoactElement:createEmitter()
	if self.particles == nil then
		self.particles = registerEmitter(self.frameRef:getValue(), {
			Acceleration = self.props.Acceleration,
			Color = self.props.Color,
			Image = self.props.Image,
			Lifetime = self.props.Lifetime,
			Rate = self.props.Rate,
			Rotation = self.props.Rotation,
			Size = self.props.Size,
			Speed = self.props.Speed,
			Spread = self.props.Spread,
			Transparency = self.props.Transparency,
			ZIndex = self.props.ZIndex,
		})
	end
end

function RoactElement:destroyEmitter()
	if self.particles ~= nil then
		self.particles()
		self.particles = nil
	end
end

return RoactElement
