local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Ensure CmdrClient exists
local CmdrClient = ReplicatedStorage:FindFirstChild("CmdrClient")
if not CmdrClient then
    warn("CmdrClient not found in ReplicatedStorage!")
    return
end

local Cmdr = require(CmdrClient)

local ACTIVATION_KEYS = {
    Enum.KeyCode.F2,
    Enum.KeyCode.Semicolon
}

Cmdr:SetActivationKeys(ACTIVATION_KEYS)
