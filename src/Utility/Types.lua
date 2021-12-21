export type GooeyParticleProps = {
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

export type Emitter = {
	container: GuiObject,
	particles: Array<ImageLabel>,
	props: GooeyParticleProps
}

export type GooeyParticleEmitter = Emitter & {
	tick: number
}

export type GooeyParticle = {
	lifetime: number,
	maxTick: number,
	obj: ImageLabel,
	remove: () -> (),
	rotation: number,
	tick: number,
	velocity: UDim2,
}

return {}
