local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VoiceChatService = game:GetService("VoiceChatService")
local Players = game:GetService("Players")
local BadgeService = game:GetService("BadgeService")

local ModuleLoader = require(ReplicatedStorage.ModuleLoader)

local BADGE_ID = 4169582939766568 -- Replace with your actual badge ID

local function enableVoiceChatForPlayer(player)
    local success, isEnabled = pcall(function()
        return VoiceChatService:IsVoiceEnabledForUserIdAsync(player.UserId)
    end)

    if success then
        if isEnabled then
            print("Voice chat enabled for player:", player.Name)
        else
            warn("Player does not meet the requirements for voice chat:", player.Name)
        end
    else
        warn("Failed to check voice chat eligibility for player:", player.Name)
    end
end

local function awardBadge(player)
    local success, result = pcall(function()
        return BadgeService:AwardBadge(player.UserId, BADGE_ID)
    end)

    if success then
        if result then
            print("Badge awarded to player:", player.Name)
        else
            warn("Player already owns the badge or badge could not be awarded:", player.Name)
        end
    else
        warn("Failed to award badge to player:", player.Name, "Error:", result)
    end
end

Players.PlayerAdded:Connect(function(player)
    enableVoiceChatForPlayer(player)
    awardBadge(player)
end)

ModuleLoader()
