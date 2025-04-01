local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VoiceChatService = game:GetService("VoiceChatService")
local Players = game:GetService("Players")
local BadgeService = game:GetService("BadgeService")
local RunService = game:GetService("RunService")

local ModuleLoader = require(ReplicatedStorage.ModuleLoader)

local BADGE_ID = 4169582939766568 -- Replace with your actual badge ID

local function enableVoiceChatForPlayer(player)
    if RunService:IsStudio() then
        print("Voice chat check skipped in Studio for player:", player.Name)
        return
    end

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
    if RunService:IsStudio() then
        print("Badge awarding skipped in Studio for player:", player.Name)
        return
    end

    print("Attempting to award badge with ID:", BADGE_ID, "to player:", player.Name)

    local success, alreadyHasBadge = pcall(function()
        return BadgeService:UserHasBadgeAsync(player.UserId, BADGE_ID)
    end)

    if success then
        if alreadyHasBadge then
            print("Player already owns the badge:", player.Name)
            return
        end
    else
        warn("Failed to check if player owns the badge:", player.Name)
        return
    end

    local awardSuccess, result = pcall(function()
        return BadgeService:AwardBadge(player.UserId, BADGE_ID)
    end)

    if awardSuccess then
        if result then
            print("Badge successfully awarded to player:", player.Name)
        else
            warn("Badge could not be awarded to player:", player.Name)
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
