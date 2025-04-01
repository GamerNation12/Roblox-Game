local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Debugging for CmdrClient
local CmdrClient = ReplicatedStorage:FindFirstChild("CmdrClient")
if not CmdrClient then
    error("[DEBUG] CmdrClient is missing from ReplicatedStorage! Please ensure it is correctly placed.")
else
    print("[DEBUG] CmdrClient found in ReplicatedStorage.")
end

local Cmdr = require(CmdrClient)

local ACTIVATION_KEYS = {
    Enum.KeyCode.F2,
    Enum.KeyCode.Semicolon
}

Cmdr:SetActivationKeys(ACTIVATION_KEYS)
