local function evaluateColorSequence(sequence, value)
	assert(typeof(sequence) == "ColorSequence", "Must pass a valid ColorSequence.")
	assert(typeof(value) == "number", "Must pass a valid number.")

	value = math.clamp(value, 0, 1)

	if value == 0 then
		return sequence.Keypoints[1].Value
	end

	if value == 1 then
		return sequence.Keypoints[#sequence.Keypoints].Value
	end

	for i = 1, #sequence.Keypoints do
		local this = sequence.Keypoints[i]
		local next = sequence.Keypoints[i + 1]

		if value >= this.Time and value < next.Time then
			local alpha = (value - this.Time) / (next.Time - this.Time)

			return Color3.new(
				(next.Value.R - this.Value.R) * alpha + this.Value.R,
				(next.Value.G - this.Value.G) * alpha + this.Value.G,
				(next.Value.B - this.Value.B) * alpha + this.Value.B
			)
		end
	end
end

return evaluateColorSequence
