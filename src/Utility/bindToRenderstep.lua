local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Llama = require(script.Parent.Parent.Parent.Llama)

local isEmpty = Llama.isEmpty
local renderstepConnection = nil
local renderstepCallbacks = {}

local function destroyConnection(): ()
	if renderstepConnection ~= nil then
		renderstepConnection:Disconnect()
		renderstepConnection = nil
	end
end

local function createConnection(): ()
	if renderstepConnection == nil then
		renderstepConnection = RunService.RenderStepped:Connect(function(dt)
			for _, callback in pairs(renderstepCallbacks) do
				callback(dt)
			end
		end)
	end
end

local function bindToRenderstep(callback: () -> ()): () -> ()
	local id = HttpService:GenerateGUID(false)
	renderstepCallbacks[id] = callback
	createConnection()

	return function()
		renderstepCallbacks[id] = nil

		if isEmpty(renderstepCallbacks) == true then
			destroyConnection()
		end
	end
end

return bindToRenderstep
