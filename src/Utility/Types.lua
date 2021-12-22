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
	spawnNextParticleAt: number
}

export type GooeyParticle = {
	lifetime: number,
	obj: ImageLabel,
	position: Vector2,
	remove: () -> (),
	rotation: number,
	spawnedAt: number,
	velocity: Vector2,
}

export type GooeyEmitter = {
	container: Frame,
	emitter: (onComplete: () -> () | nil) -> () | nil,
	props: GooeyParticleProps
}

return {}
