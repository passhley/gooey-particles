local function evaluateNumberSequence(sequence, value)
	assert(typeof(sequence) == "NumberSequence", "Must pass a valid NumberSequence.")
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
			return (next.Value - this.Value) * alpha + this.Value
		end
	end
end

return evaluateNumberSequence
