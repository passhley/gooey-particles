local function conditionalProperty(object: GuiObject, condition: boolean, property: string, value: any)
	if condition == true then
		object[property] = value
	end
end

return conditionalProperty
