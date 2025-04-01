local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VoiceChatService = game:GetService("VoiceChatService")
local Players = game:GetService("Players")

local ModuleLoader = require(ReplicatedStorage.ModuleLoader)

local function enableVoiceChatForPlayer(player)
    if VoiceChatService:IsVoiceEnabledForUserIdAsync(player.UserId) then
        print("Voice chat enabled for player:", player.Name)
    else
        warn("Player does not meet the requirements for voice chat:", player.Name)
    end
end

Players.PlayerAdded:Connect(function(player)
    enableVoiceChatForPlayer(player)
end)

ModuleLoader()
